#!/usr/bin/env bash
input=$(cat)

MODEL=$(echo "$input" | yq -r -p json '.model.display_name')
DIR=$(echo "$input" | yq -r -p json '.workspace.current_dir')
# The "// 0" provides a fallback if the field is null
PCT=$(echo "$input" | yq -r -p json '.context_window.used_percentage // 0' | cut -d. -f1)

IN=$(echo "$input" | yq -r -p json '.context_window.total_input_tokens // 0')
OUT=$(echo "$input" | yq -r -p json '.context_window.total_output_tokens // 0')

RATE_USE=$(echo "$input" | yq -r -p json '.rate_limits.five_hour.used_percentage // 0' | cut -d. -f1)


echo "[$MODEL] 📁 ${DIR##*/} | ${PCT}% context | ${IN} input | ${OUT} output | ${RATE_USE}% used"
