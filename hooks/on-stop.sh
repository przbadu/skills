#!/bin/bash
# Reads the last assistant message from the transcript and speaks it aloud

export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"

TRANSCRIPT_PATH=$(jq -r '.transcript_path')

SUMMARY=$(
  tail -50 "$TRANSCRIPT_PATH" |
  jq -r 'select(.type == "assistant") |
    .message.content[] | select(.type == "text") | .text' 2>/dev/null |
  tail -1 |
  cut -c1-300
)

if [ -n "$SUMMARY" ]; then
  say "$SUMMARY"
else
  say "Task completed"
fi
