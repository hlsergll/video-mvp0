#!/usr/bin/env bash
set -euo pipefail

INPUT="${1:-out/test-5s.mp4}"
OUTPUT="${2:-out/test-5s-final.mp4}"

mkdir -p "$(dirname "$OUTPUT")"

ffmpeg -y -i "$INPUT" \
  -t 5 \
  -c:v libx264 \
  -preset veryfast \
  -crf 23 \
  -pix_fmt yuv420p \
  -movflags +faststart \
  -an \
  "$OUTPUT"

echo "Created: $OUTPUT"
