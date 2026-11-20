#!/usr/bin/env bash
set -euo pipefail

FILE="${1:-out/test-5s-final.mp4}"

if [ ! -f "$FILE" ]; then
  echo "ERROR: Video not found: $FILE"
  exit 1
fi

DURATION=$(ffprobe -v error -show_entries format=duration -of csv=p=0 "$FILE")
SIZE=$(stat -c%s "$FILE")
CODEC=$(ffprobe -v error -select_streams v:0 -show_entries stream=codec_name -of csv=p=0 "$FILE")
WIDTH=$(ffprobe -v error -select_streams v:0 -show_entries stream=width -of csv=p=0 "$FILE")
HEIGHT=$(ffprobe -v error -select_streams v:0 -show_entries stream=height -of csv=p=0 "$FILE")
FPS=$(ffprobe -v error -select_streams v:0 -show_entries stream=r_frame_rate -of csv=p=0 "$FILE")
PIX_FMT=$(ffprobe -v error -select_streams v:0 -show_entries stream=pix_fmt -of csv=p=0 "$FILE")

echo "Duration: $DURATION"
echo "Size: $SIZE bytes"
echo "Codec: $CODEC"
echo "Resolution: ${WIDTH}x${HEIGHT}"
echo "FPS: $FPS"
echo "Pixel format: $PIX_FMT"

awk -v d="$DURATION" 'BEGIN {if (d < 4.95 || d > 5.05) exit 1}' || {
  echo "ERROR: Duration outside allowed range"
  exit 1
}

[ "$CODEC" = "h264" ] || { echo "ERROR: Wrong codec"; exit 1; }
[ "$WIDTH" = "1080" ] || { echo "ERROR: Wrong width"; exit 1; }
[ "$HEIGHT" = "1920" ] || { echo "ERROR: Wrong height"; exit 1; }
[ "$FPS" = "30/1" ] || { echo "ERROR: Wrong FPS"; exit 1; }
[ "$PIX_FMT" = "yuv420p" ] || { echo "ERROR: Wrong pixel format"; exit 1; }
[ "$SIZE" -lt 15728640 ] || { echo "ERROR: File exceeds 15 MB"; exit 1; }

echo "SUCCESS: All video checks passed."
