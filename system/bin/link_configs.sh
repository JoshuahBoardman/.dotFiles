#!/bin/bash
# Apply symlinks defined in system/spec/symlinks.toml.
#
# For each entry, removes any existing file or directory at the destination
# and creates a fresh symlink (or copy for method = "copy").
#
# Usage:
#   ./link_configs.sh [--dry-run] [--platform <arch|wsl|mac|windows>]

DOTFILES_ROOT="$(git rev-parse --show-toplevel)"
source "$DOTFILES_ROOT/scripts/lib/log.sh"
source "$DOTFILES_ROOT/scripts/lib/error.sh"

SPEC="$DOTFILES_ROOT/system/spec"
DRY_RUN=false
PLATFORM=""

while [[ $# -gt 0 ]]; do
    case "$1" in
        --dry-run)  DRY_RUN=true ;;
        --platform) PLATFORM="$2"; shift ;;
        *) log_error "Unknown argument: $1"; exit 1 ;;
    esac
    shift
done

# ---------------------------------------------------------------------------
# Expand ~ and environment variables in a path
# ---------------------------------------------------------------------------
_expand_path() {
    local path="$1"
    path="${path/#\~/$HOME}"
    echo "$(eval echo "$path")"
}

# ---------------------------------------------------------------------------
# Check if a link applies to the current platform
# ---------------------------------------------------------------------------
_platform_matches() {
    local index="$1"
    local platforms
    platforms="$(yq ".symlinks.links[$index].platforms // []" "$SPEC/symlinks.toml")"

    # No platform restriction — applies everywhere
    [[ "$platforms" == "[]" ]] && return 0

    echo "$platforms" | grep -q "\"$PLATFORM\""
}

# ---------------------------------------------------------------------------
# Process a single symlink entry
# ---------------------------------------------------------------------------
_apply_link() {
    local index="$1"
    local src dest method elevated

    src="$(yq ".symlinks.links[$index].src" "$SPEC/symlinks.toml")"
    dest="$(yq ".symlinks.links[$index].dest" "$SPEC/symlinks.toml")"
    method="$(yq ".symlinks.links[$index].method // \"symlink\"" "$SPEC/symlinks.toml")"
    elevated="$(yq ".symlinks.links[$index].elevated // false" "$SPEC/symlinks.toml")"

    local abs_src abs_dest
    abs_src="$DOTFILES_ROOT/$src"
    abs_dest="$(_expand_path "$dest")"

    if [[ ! -e "$abs_src" ]]; then
        log_warn "Source does not exist, skipping: $src"
        return
    fi

    local sudo_prefix=""
    [[ "$elevated" == "true" ]] && sudo_prefix="sudo "

    log_info "Linking $src → $abs_dest"

    if [[ "$DRY_RUN" == true ]]; then
        log_info "[dry-run] Would remove $abs_dest and create $method"
        return
    fi

    # Remove existing file, directory, or symlink at destination
    if [[ -e "$abs_dest" || -L "$abs_dest" ]]; then
        eval "${sudo_prefix}rm -rf \"$abs_dest\""
    fi

    # Ensure parent directory exists
    eval "${sudo_prefix}mkdir -p \"$(dirname "$abs_dest")\""

    if [[ "$method" == "copy" ]]; then
        eval "${sudo_prefix}cp -r \"$abs_src\" \"$abs_dest\""
        log_success "Copied  $src → $abs_dest"
    else
        eval "${sudo_prefix}ln -s \"$abs_src\" \"$abs_dest\""
        log_success "Linked  $src → $abs_dest"
    fi
}

# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------
count="$(yq '.symlinks.links | length' "$SPEC/symlinks.toml")"

for ((i = 0; i < count; i++)); do
    _platform_matches "$i" || continue
    _apply_link "$i"
done

log_success "Config linking complete"
