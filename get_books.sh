#!/bin/bash
set -euo pipefail

BUCKET="$1"
BOOKDIR=$(realpath "$2")

mkdir -p "$BOOKDIR"

aws s3 cp "s3://$BUCKET" "$BOOKDIR" \
    --recursive \
    --exclude "*" \
    --include "*.txt"

echo "File path" > book_list.txt

find "$BOOKDIR" -name "*.txt" | sort >> book_list.txt

COUNT=$(($(wc -l < book_list.txt) - 1))

echo "Wrote $COUNT book files to book_list.txt"
