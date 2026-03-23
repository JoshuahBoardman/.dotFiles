#!/bin/bash
# Install packages defined in system/spec/packages.toml.
#
# Usage:
#   ./install_packages.sh [--dry-run] [--platform <arch|wsl|mac|windows>]
#                         [--priority <high|medium|low>]
#
# Without --priority, installs all priorities in order: high → medium → low.
# Platform overrides: if [packages.foo.$PLATFORM] exists, its manager/pkg take
# precedence over the top-level values.

DOTFILES_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
source "$DOTFILES_ROOT/scripts/lib/log.sh"
source "$DOTFILES_ROOT/scripts/lib/error.sh"

SPEC="$DOTFILES_ROOT/system/spec"
DRY_RUN=false
PLATFORM=""
PRIORITY_FILTER=""

while [[ $# -gt 0 ]]; do
    case "$1" in
        --dry-run)  DRY_RUN=true ;;
        --platform) PLATFORM="$2"; shift ;;
        --priority) PRIORITY_FILTER="$2"; shift ;;
        *) log_error "Unknown argument: $1"; exit 1 ;;
    esac
    shift
done

# ---------------------------------------------------------------------------
# Resolve install order: pacman first (others may depend_on it)
# ---------------------------------------------------------------------------
_get_managers_in_order() {
    local managers
    managers="$(yq -r '.package_managers | keys | .[]' "$SPEC/package_managers.toml")"

    local no_dep=() with_dep=()
    while IFS= read -r mgr; do
        local dep
        dep="$(yq -r ".package_managers.${mgr}.depends_on // \"\"" "$SPEC/package_managers.toml")"
        if [[ -z "$dep" ]]; then
            no_dep+=("$mgr")
        else
            with_dep+=("$mgr")
        fi
    done <<< "$managers"

    printf '%s\n' "${no_dep[@]}" "${with_dep[@]}"
}

# ---------------------------------------------------------------------------
# Collect packages for a given manager (and optional priority filter).
# Platform overrides: [packages.foo.$PLATFORM].package_manager / .pkg take
# precedence over top-level values when PLATFORM is set.
# ---------------------------------------------------------------------------
_collect_packages() {
    local manager="$1"
    local priority="${2:-}"

    local platform_expr=""
    if [[ -n "$PLATFORM" ]]; then
        platform_expr=".value[\"$PLATFORM\"]"
    fi

    local filter
    filter=".packages | to_entries[] |"

    if [[ -n "$PLATFORM" ]]; then
        filter+=" (${platform_expr}.package_manager // .value.package_manager) as \$mgr |"
        filter+=" (${platform_expr}.pkg // .value.pkg) as \$pkg |"
    else
        filter+=" .value.package_manager as \$mgr |"
        filter+=" .value.pkg as \$pkg |"
    fi

    filter+=" select(\$mgr == \"$manager\")"
    [[ -n "$priority" ]] && filter+=" | select(.value.priority == \"$priority\")"
    filter+=" | \$pkg"

    yq -r "$filter" "$SPEC/packages.toml"
}

# ---------------------------------------------------------------------------
# Install a list of packages with the given manager
# ---------------------------------------------------------------------------
_install_with_manager() {
    local manager="$1"
    shift
    local pkgs=("$@")
    [[ ${#pkgs[@]} -eq 0 ]] && return

    local install_cmd elevated
    install_cmd="$(yq -r ".package_managers.${manager}.install_cmd" "$SPEC/package_managers.toml")"
    elevated="$(yq -r ".package_managers.${manager}.elevated" "$SPEC/package_managers.toml")"

    local cmd=""
    [[ "$elevated" == "true" ]] && cmd="sudo "
    cmd+="$install_cmd ${pkgs[*]}"

    log_info "[$manager] Installing: ${pkgs[*]}"
    if [[ "$DRY_RUN" == true ]]; then
        log_info "[dry-run] Would run: $cmd"
        return
    fi

    eval "$cmd"
    log_success "[$manager] Done"
}

# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------
case "$PRIORITY_FILTER" in
    high)   priorities=(high) ;;
    medium) priorities=(high medium) ;;
    low|"") priorities=(high medium low) ;;
    *) log_error "Invalid priority: $PRIORITY_FILTER (use high, medium, or low)"; exit 1 ;;
esac

while IFS= read -r manager; do
    if ! command -v "$manager" >/dev/null 2>&1; then
        log_warn "Manager '$manager' not found — skipping"
        continue
    fi

    local_dep="$(yq -r ".package_managers.${manager}.depends_on // \"\"" "$SPEC/package_managers.toml")"
    if [[ -n "$local_dep" ]] && ! command -v "$local_dep" >/dev/null 2>&1; then
        log_warn "Manager '$manager' requires '$local_dep' which is not installed — skipping"
        continue
    fi

    for priority in "${priorities[@]}"; do
        mapfile -t pkgs < <(_collect_packages "$manager" "$priority")
        _install_with_manager "$manager" "${pkgs[@]}"
    done

done < <(_get_managers_in_order)
