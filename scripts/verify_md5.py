#!/usr/bin/env python3
"""Verify downloaded FASTQ files against the md5 checksums in a SNPTrait manifest.

    python3 verify_md5.py <manifest.csv> <fastq_dir>

Manifest must have `url` and `fastq_md5` columns (view15/view16 both do).
Reports OK / MISMATCH / MISSING per file and exits non-zero if anything failed.
"""
import csv
import hashlib
import os
import sys


def md5_of(path, chunk=1 << 20):
    h = hashlib.md5()
    with open(path, "rb") as fh:
        for block in iter(lambda: fh.read(chunk), b""):
            h.update(block)
    return h.hexdigest()


def main(manifest, fastq_dir):
    ok = mismatch = missing = 0
    with open(manifest, newline="") as fh:
        for row in csv.DictReader(fh):
            url, want = row.get("url", ""), (row.get("fastq_md5") or "").strip()
            if not url:
                continue
            path = os.path.join(fastq_dir, os.path.basename(url))
            if not os.path.exists(path):
                missing += 1
                print(f"MISSING   {os.path.basename(url)}")
            elif not want:
                print(f"NO-MD5    {os.path.basename(url)}")
            elif md5_of(path) == want:
                ok += 1
            else:
                mismatch += 1
                print(f"MISMATCH  {os.path.basename(url)}")
    print(f"\nok={ok} mismatch={mismatch} missing={missing}")
    return 1 if (mismatch or missing) else 0


if __name__ == "__main__":
    if len(sys.argv) != 3:
        sys.exit(__doc__)
    sys.exit(main(sys.argv[1], sys.argv[2]))
