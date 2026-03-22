#!/bin/bash
# Apply symlinks defined in system/spec/symlinks.toml.
#
# For directory entries: each file inside src is linked individually into
# dest, preserving relative paths. Existing untracked files in dest are
# left untouched.
#
# For file entries: the file is symlinked directly to dest.
#
# Existing symlinks or files at a destination are replaced. Untracked files
# in destination directories are never touched.
#
# Usage:
#   ./link_configs.sh [--dry-run] [--platform <arch|wsl|mac|windows>]

DOTFILES_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
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
    eval echo "$path"
}

# ---------------------------------------------------------------------------
# Check if a link entry applies to the current platform
# ---------------------------------------------------------------------------
_platform_matches() {
    local index="$1"
    local platforms
    platforms="$(yq -r ".symlinks.links[$index].platforms // [] | .[]" "$SPEC/symlinks.toml" 2>/dev/null)"
    [[ -z "$platforms" ]] && return 0
    echo "$platforms" | grep -qx "$PLATFORM"
}

# ---------------------------------------------------------------------------
# Link a single file src -> dest, replacing any existing file or symlink
# ---------------------------------------------------------------------------
_link_file() {
    local src="$1"
    local dest="$2"
    local method="$3"
    local sudo_prefix="$4"

    if [[ "$DRY_RUN" == true ]]; then
        log_info "[dry-run] $method $src -> $dest"
        return
    fi

    # Remove existing file or symlink (not directories)
    if [[ -L "$dest" || -f "$dest" ]]; then
        eval "${sudo_prefix}rm -f \"$dest\""
    fi

    eval "${sudo_prefix}mkdir -p \"$(dirname "$dest")\""

    if [[ "$method" == "copy" ]]; then
        eval "${sudo_prefix}cp \"$src\" \"$dest\""
    else
        eval "${sudo_prefix}ln -s \"$src\" \"$dest\""
    fi

    log_success "$method: $(basename "$src") -> $dest"
}

# ---------------------------------------------------------------------------
# Recurse into a src directory, linking each file into the dest directory
# ---------------------------------------------------------------------------
_link_directory() {
    local src_dir="$1"
    local dest_dir="$2"
    local method="$3"
    local sudo_prefix="$4"

    if [[ "$DRY_RUN" == true ]]; then
        log_info "[dry-run] mkdir -p $dest_dir"
    else
        # Remove if it's a symlink (e.g. leftover from stow) before creating the dir
        if [[ -L "$dest_dir" ]]; then
            eval "${sudo_prefix}rm -f \"$dest_dir\""
        fi
        eval "${sudo_prefix}mkdir -p \"$dest_dir\""
    fi

    while IFS= read -r -d '' src_file; do
        local rel="${src_file#$src_dir/}"
        local dest_file="$dest_dir/$rel"
        _link_file "$src_file" "$dest_file" "$method" "$sudo_prefix"
    done < <(find "$src_dir" -type f -print0)
}

# ---------------------------------------------------------------------------
# Process a single symlink entry
# ---------------------------------------------------------------------------
_apply_link() {
    local index="$1"
    local src dest method elevated

    src="$(yq -r ".symlinks.links[$index].src" "$SPEC/symlinks.toml")"
    dest="$(yq -r ".symlinks.links[$index].dest" "$SPEC/symlinks.toml")"
    method="$(yq -r ".symlinks.links[$index].method // \"symlink\"" "$SPEC/symlinks.toml")"
    elevated="$(yq -r ".symlinks.links[$index].elevated // false" "$SPEC/symlinks.toml")"

    local abs_src abs_dest sudo_prefix
    abs_src="$DOTFILES_ROOT/$src"
    abs_dest="$(_expand_path "$dest")"
    sudo_prefix=""
    [[ "$elevated" == "true" ]] && sudo_prefix="sudo "

    if [[ ! -e "$abs_src" ]]; then
        log_warn "Source does not exist, skipping: $src"
        return
    fi

    if [[ -d "$abs_src" ]]; then
        log_info "Linking directory $src -> $abs_dest"
        _link_directory "$abs_src" "$abs_dest" "$method" "$sudo_prefix"
    else
        log_info "Linking file $src -> $abs_dest"
        _link_file "$abs_src" "$abs_dest" "$method" "$sudo_prefix"
    fi
}

# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------
count="$(yq -r '.symlinks.links | length' "$SPEC/symlinks.toml")"

for ((i = 0; i < count; i++)); do
    _platform_matches "$i" || continue
    _apply_link "$i"
done

log_success "Config linking complete"
