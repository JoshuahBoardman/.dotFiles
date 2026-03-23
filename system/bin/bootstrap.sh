#!/bin/bash
# Main dotfiles bootstrap entry point.
#
# Prerequisites (install manually per README before running):
#   sudo pacman -S git go-yq
#
# Usage:
#   ./bootstrap.sh [--dry-run] [--priority <high|medium|low>]

DOTFILES_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
source "$DOTFILES_ROOT/scripts/lib/log.sh"
source "$DOTFILES_ROOT/scripts/lib/error.sh"

DRY_RUN=false
PRIORITY=""

while [[ $# -gt 0 ]]; do
    case "$1" in
        --dry-run)  DRY_RUN=true ;;
        --priority) PRIORITY="$2"; shift ;;
        *) log_error "Unknown argument: $1"; exit 1 ;;
    esac
    shift
done

SPEC="$DOTFILES_ROOT/system/spec"

# ---------------------------------------------------------------------------
# Step 1: Detect platform
# ---------------------------------------------------------------------------
detect_platform() {
    case "$(uname -s)" in
        Linux)
            if grep -qi microsoft /proc/version 2>/dev/null; then
                PLATFORM="wsl"
            else
                PLATFORM="arch"
            fi ;;
        Darwin)  PLATFORM="mac" ;;
        MINGW*|CYGWIN*|MSYS*) PLATFORM="windows" ;;
        *) log_error "Unsupported platform: $(uname -s)"; exit 1 ;;
    esac
    log_info "Platform: $PLATFORM"
}

# ---------------------------------------------------------------------------
# Step 2: Validate spec files
# ---------------------------------------------------------------------------
validate_specs() {
    local specs=(settings.toml package_managers.toml packages.toml symlinks.toml)
    for spec in "${specs[@]}"; do
        if [[ ! -f "$SPEC/$spec" ]]; then
            log_error "Missing spec file: system/spec/$spec"
            exit 1
        fi
    done
    log_success "Spec files validated"
}

# ---------------------------------------------------------------------------
# Step 3: Verify base prerequisites
# ---------------------------------------------------------------------------
verify_prerequisites() {
    local missing=()
    for cmd in git yq; do
        command -v "$cmd" >/dev/null 2>&1 || missing+=("$cmd")
    done

    if [[ ${#missing[@]} -gt 0 ]]; then
        log_error "Missing prerequisites: ${missing[*]}"
        log_error "Install them first: sudo pacman -S git go-yq"
        exit 1
    fi
    log_success "Prerequisites present"
}

# ---------------------------------------------------------------------------
# Step 4: Bootstrap AUR helper (yay)
# ---------------------------------------------------------------------------
bootstrap_aur_helper() {
    local aur_helper
    aur_helper="$(yq -r '.settings.aur_helper' "$SPEC/settings.toml")"

    if command -v "$aur_helper" >/dev/null 2>&1; then
        log_info "AUR helper '$aur_helper' already installed"
        return
    fi

    log_info "Installing AUR helper: $aur_helper"
    if [[ "$DRY_RUN" == true ]]; then
        log_info "[dry-run] Would build $aur_helper from AUR"
        return
    fi

    local build_dir
    build_dir="$(mktemp -d)"
    git clone "https://aur.archlinux.org/${aur_helper}.git" "$build_dir/$aur_helper"
    (cd "$build_dir/$aur_helper" && makepkg -si --noconfirm)
    rm -rf "$build_dir"
    log_success "AUR helper '$aur_helper' installed"
}

# ---------------------------------------------------------------------------
# Steps 5–6: Install packages
# ---------------------------------------------------------------------------
install_packages() {
    local args=(--platform "$PLATFORM")
    [[ "$DRY_RUN" == true ]] && args+=(--dry-run)
    [[ -n "$PRIORITY" ]] && args+=(--priority "$PRIORITY")
    "$DOTFILES_ROOT/system/bin/install_packages.sh" "${args[@]}"
}

# ---------------------------------------------------------------------------
# Step 7: Clone git repos
# ---------------------------------------------------------------------------
clone_repos() {
    local repos
    repos="$(yq -r '.repos | to_entries[] | .key' "$SPEC/packages.toml")"

    while IFS= read -r name; do
        local repo install_dir priority
        repo="$(yq -r ".repos.${name}.repo" "$SPEC/packages.toml")"
        install_dir="$(yq -r ".repos.${name}.install_dir" "$SPEC/packages.toml")"
        priority="$(yq -r ".repos.${name}.priority" "$SPEC/packages.toml")"

        local included=false
        for p in "${priorities[@]}"; do
            [[ "$p" == "$priority" ]] && included=true && break
        done
        [[ "$included" == false ]] && continue
        install_dir="${install_dir/#\~/$HOME}"

        if [[ -d "$install_dir" ]]; then
            log_info "Repo '$name' already present at $install_dir"
            continue
        fi

        log_info "Cloning $name -> $install_dir"
        if [[ "$DRY_RUN" == true ]]; then
            log_info "[dry-run] Would clone $repo into $install_dir"
            continue
        fi

        mkdir -p "$(dirname "$install_dir")"
        git clone "$repo" "$install_dir"
        log_success "Cloned $name"
    done <<< "$repos"
}

# ---------------------------------------------------------------------------
# Step 8: Apply symlinks
# ---------------------------------------------------------------------------
link_configs() {
    local args=(--platform "$PLATFORM")
    [[ "$DRY_RUN" == true ]] && args+=(--dry-run)
    "$DOTFILES_ROOT/system/bin/link_configs.sh" "${args[@]}"
}

# ---------------------------------------------------------------------------
# Step 9: Health check
# ---------------------------------------------------------------------------
health_check() {
    if [[ "$DRY_RUN" == true ]]; then
        log_info "Skipping health check (dry-run)"
        return
    fi

    log_info "Running health check..."
    local errors=0

    local count
    count="$(yq -r '.symlinks.links | length' "$SPEC/symlinks.toml")"
    for ((i = 0; i < count; i++)); do
        local src dest platforms
        src="$(yq -r ".symlinks.links[$i].src" "$SPEC/symlinks.toml")"
        dest="$(yq -r ".symlinks.links[$i].dest" "$SPEC/symlinks.toml")"
        dest="${dest/#\~/$HOME}"
        platforms="$(yq -r ".symlinks.links[$i].platforms // [] | .[]" "$SPEC/symlinks.toml" 2>/dev/null)"

        if [[ -n "$platforms" ]]; then
            echo "$platforms" | grep -qx "$PLATFORM" || continue
        fi

        local abs_src="$DOTFILES_ROOT/$src"

        if [[ -d "$abs_src" ]]; then
            # Check each tracked file individually
            while IFS= read -r -d '' src_file; do
                local rel="${src_file#$abs_src/}"
                local dest_file="$dest/$rel"
                if [[ ! -L "$dest_file" ]]; then
                    log_warn "Not a symlink: $dest_file"
                    errors=$((errors + 1))
                fi
            done < <(find "$abs_src" -type f -print0)
        else
            if [[ ! -L "$dest" ]]; then
                log_warn "Not a symlink: $dest"
                errors=$((errors + 1))
            fi
        fi
    done

    if [[ $errors -eq 0 ]]; then
        log_success "Health check passed"
    else
        log_warn "Health check: $errors issue(s) found"
    fi
}

# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------
case "$PRIORITY" in
    high)   priorities=(high) ;;
    medium) priorities=(high medium) ;;
    low|"") priorities=(high medium low) ;;
    *) log_error "Invalid priority: $PRIORITY (use high, medium, or low)"; exit 1 ;;
esac

[[ "$DRY_RUN" == true ]] && log_info "Running in dry-run mode — no changes will be made"

detect_platform
validate_specs
verify_prerequisites
bootstrap_aur_helper
install_packages
clone_repos
link_configs
health_check

log_success "Bootstrap complete"
