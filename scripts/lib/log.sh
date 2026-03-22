#!/bin/bash
# Shared logging utilities. Source this file — do not execute directly.
#
# Usage:
#   source "$(git rev-parse --show-toplevel)/scripts/lib/log.sh"
#   log_info "Starting bootstrap..."
#   log_success "Done."

_LOG_RESET="\033[0m"
_LOG_RED="\033[0;31m"
_LOG_GREEN="\033[0;32m"
_LOG_YELLOW="\033[0;33m"
_LOG_CYAN="\033[0;36m"

log_info() {
    printf "${_LOG_CYAN}[INFO]${_LOG_RESET}  %s\n" "$*"
}

log_success() {
    printf "${_LOG_GREEN}[OK]${_LOG_RESET}    %s\n" "$*"
}

log_warn() {
    printf "${_LOG_YELLOW}[WARN]${_LOG_RESET}  %s\n" "$*" >&2
}

log_error() {
    printf "${_LOG_RED}[ERROR]${_LOG_RESET} %s\n" "$*" >&2
}
