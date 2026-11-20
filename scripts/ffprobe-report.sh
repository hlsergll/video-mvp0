#!/usr/bin/env bash
set -euo pipefail

FILE="${1:-out/test-5s.mp4}"

if [ ! -f "$FILE" ]; then
  echo "ERROR: Video file not found: $FILE"
  exit 1
fi

ffprobe -v error \
  -show_entries format=duration,size \
  -show_entries stream=codec_name,width,height,r_frame_rate,pix_fmt \
  -of default=noprint_wrappers=1 \
  "$FILE"
