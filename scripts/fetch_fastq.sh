#!/usr/bin/env bash
# Download FASTQ files for the SNPTrait priority variant-calling build.
#
#   ./fetch_fastq.sh <url_list.txt> <outdir> [parallel_jobs]
#
# Default list: data/fastq_urls_priority_build.txt  (2,076 files / ~20.3 TB)
# Per-project lists: data/fastq_urls_by_project/<PRJ*>.txt  — start with one project.
#
# URLs are ENA FTP paths. aria2c is preferred (parallel, resumable, checksummed);
# falls back to wget. Verify with data/view16_fastq_manifest_priority_build.csv,
# which carries the fastq_md5 for every file.

set -euo pipefail
LIST="${1:-data/fastq_urls_priority_build.txt}"
OUT="${2:-fastq}"
JOBS="${3:-4}"

[[ -f "$LIST" ]] || { echo "url list not found: $LIST" >&2; exit 1; }
mkdir -p "$OUT"
echo "$(wc -l < "$LIST") files -> $OUT (parallel=$JOBS)"

if command -v aria2c >/dev/null 2>&1; then
  aria2c --input-file="$LIST" --dir="$OUT" \
         --max-concurrent-downloads="$JOBS" --max-connection-per-server=4 \
         --split=4 --continue=true --auto-file-renaming=false \
         --retry-wait=10 --max-tries=5 --console-log-level=warn
else
  echo "aria2c not found, using wget (slower, serial)" >&2
  wget --continue --no-verbose --tries=5 --waitretry=10 \
       --directory-prefix="$OUT" --input-file="$LIST"
fi

echo "done. verify checksums with:"
echo "  python3 scripts/verify_md5.py data/view16_fastq_manifest_priority_build.csv $OUT"
