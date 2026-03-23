#!/bin/bash
# Centralized error handling. Source this file — do not execute directly.
#
# Sets strict mode and installs an ERR trap that prints a clear message
# with the file name and line number before exiting.
#
# Sourcing this file also sources log.sh, so scripts only need to source
# error.sh to get both.
#
# Usage:
#   source "$DOTFILES_ROOT/scripts/lib/error.sh"

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/log.sh"

set -euo pipefail

_error_handler() {
    local exit_code=$?
    local line_number=$1
    local script="${BASH_SOURCE[1]:-unknown}"
    log_error "$script:$line_number exited with code $exit_code"
    exit "$exit_code"
}

trap '_error_handler $LINENO' ERR
