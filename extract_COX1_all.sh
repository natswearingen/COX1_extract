#!/usr/bin/env bash
set -euo pipefail

OUT="all_COX1_sequences.fasta"
: > "$OUT"   # truncate output file at start

for file in "$@"; do
  echo "Processing $file..."

  awk -v RS=">" -v ORS="" '
    NR==1 { next }
    {
      header = $0
      sub(/\n.*/, "", header)

      if (header ~ /\[gene=COX1\]/) {
        print ">" $0
        if (substr($0, length($0), 1) != "\n") print "\n"
      }
    }
  ' "$file" >> "$OUT"

done

echo "Done. All COX1 sequences saved in $OUT"
