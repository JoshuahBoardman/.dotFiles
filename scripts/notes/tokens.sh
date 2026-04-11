#!/usr/bin/env bash
# Shared token substitution library for notes scripts.
# Source this file; do not execute it directly.

substitute_tokens() {
  local file="$1"
  local title="$2"
  local today week

  today=$(date +%Y_%m_%d)
  week=$(date +%Y_w%V)

  sed -i \
    -e "s/{{uuid}}/$(uuidgen)/g" \
    -e "s/{{date}}/$today/g" \
    -e "s/{{title}}/$title/g" \
    -e "s/{{daily}}/[[$today]]/g" \
    -e "s/{{week}}/[[$week]]/g" \
    -e "s/{{yesterday}}/[[$(date -d yesterday +%Y_%m_%d)]]/g" \
    -e "s/{{tomorrow}}/[[$(date -d tomorrow +%Y_%m_%d)]]/g" \
    -e "s/{{prev_week}}/[[$(date -d 'last monday -7 days' +%Y_w%V)]]/g" \
    -e "s/{{next_week}}/[[$(date -d 'next monday' +%Y_w%V)]]/g" \
    "$file"
}
