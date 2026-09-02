#!/usr/bin/env python3
"""Quantize scoped runtime enemy art to the project's hard-edge alpha contract.

Generated source art is never modified by this tool.  Only PNGs under
``assets/enemies`` are considered, and projectile subdirectories are excluded
because their translucent glow is intentional.  The operation is idempotent:
files that already contain only alpha 0/255 are left byte-for-byte unchanged.
"""

from __future__ import annotations

import argparse
import os
import tempfile
from pathlib import Path

from PIL import Image


def iter_targets(root: Path):
    assets_root = root / "assets" / "enemies"
    for path in sorted(assets_root.rglob("*.png")):
        if "projectiles" in path.parts:
            continue
        yield path


def alpha_stats(image: Image.Image) -> tuple[int, int, int]:
    histogram = image.getchannel("A").histogram()
    return histogram[0], sum(histogram[1:255]), histogram[255]


def quantize(path: Path, threshold: int, dry_run: bool) -> tuple[bool, int, int]:
    with Image.open(path) as source:
        image = source.convert("RGBA")
        before = alpha_stats(image)
        if before[1] == 0:
            return False, before[1], before[1]

        alpha = image.getchannel("A").point(lambda value: 0 if value < threshold else 255)
        image.putalpha(alpha)
        after = alpha_stats(image)
        if not dry_run:
            fd, temp_name = tempfile.mkstemp(prefix=path.stem + ".", suffix=".png", dir=path.parent)
            os.close(fd)
            temp_path = Path(temp_name)
            try:
                image.save(temp_path, format="PNG", optimize=True, compress_level=9)
                os.replace(temp_path, path)
            finally:
                temp_path.unlink(missing_ok=True)
        return True, before[1], after[1]


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--project-root", type=Path, default=Path(__file__).resolve().parents[1])
    parser.add_argument("--threshold", type=int, default=128)
    parser.add_argument("--dry-run", action="store_true", help="report candidates without writing")
    parser.add_argument("--check", action="store_true", help="fail if any scoped file still has semi-transparent alpha")
    args = parser.parse_args()
    if not 1 <= args.threshold <= 254:
        parser.error("--threshold must be between 1 and 254")
    if args.check and args.dry_run:
        parser.error("--check and --dry-run cannot be combined")

    targets = list(iter_targets(args.project_root.resolve()))
    changed = 0
    before_semi = 0
    after_semi = 0
    for path in targets:
        did_change, before, after = quantize(path, args.threshold, args.dry_run)
        if did_change:
            changed += 1
            before_semi += before
            after_semi += after
            action = "would quantize" if args.dry_run else "quantized"
            print(f"{action}: {path.relative_to(args.project_root)} ({before:,} -> {after:,} semi-alpha pixels)")

    mode = "check" if args.check else ("dry-run" if args.dry_run else "write")
    print(f"RUNTIME ALPHA {mode.upper()}: {changed} files require quantization; threshold={args.threshold}.")
    if not args.dry_run and not args.check:
        print(f"Semi-alpha pixels: {before_semi:,} -> {after_semi:,} across changed files.")
    return 2 if args.check and changed else 0


if __name__ == "__main__":
    raise SystemExit(main())
