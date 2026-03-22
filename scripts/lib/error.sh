#!/bin/bash
# Centralized error handling. Source this file — do not execute directly.
#
# Sets strict mode and installs an ERR trap that prints a clear message
# with the file name and line number before exiting.
#
# Usage:
#   source "$(git rev-parse --show-toplevel)/scripts/lib/error.sh"

set -euo pipefail

_DOTFILES_ROOT="$(git rev-parse --show-toplevel)"

_error_handler() {
    local exit_code=$?
    local line_number=$1
    local script="${BASH_SOURCE[1]:-unknown}"
    printf "\033[0;31m[ERROR]\033[0m %s:%s exited with code %s\n" \
        "$script" "$line_number" "$exit_code" >&2
    exit "$exit_code"
}

trap '_error_handler $LINENO' ERR
