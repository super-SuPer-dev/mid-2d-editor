#!/usr/bin/env python3
"""Losslessly re-encode runtime PNGs without changing decoded pixels.

The generated-source library is intentionally excluded. Each candidate is
decoded to RGBA, re-encoded with maximum PNG compression, reopened, and
compared byte-for-byte at the decoded-pixel level before replacement. This
reduces package size without resizing, filtering, alpha quantization, or
changing any sprite grid.
"""

from __future__ import annotations

import argparse
import hashlib
import os
import tempfile
from pathlib import Path

from PIL import Image


def pixel_digest(image: Image.Image) -> tuple[tuple[int, int], str]:
    rgba = image.convert("RGBA")
    return rgba.size, hashlib.sha256(rgba.tobytes()).hexdigest()


def iter_targets(root: Path):
    for path in sorted((root / "assets").rglob("*.png")):
        if "placeholders" not in path.parts:
            yield path


def optimize(path: Path, dry_run: bool) -> tuple[bool, int, int]:
    with Image.open(path) as source:
        size, digest = pixel_digest(source)
        rgba = source.convert("RGBA")
        fd, temp_name = tempfile.mkstemp(prefix=path.stem + ".", suffix=".png", dir=path.parent)
        os.close(fd)
        temp_path = Path(temp_name)
        try:
            rgba.save(temp_path, format="PNG", optimize=True, compress_level=9)
            with Image.open(temp_path) as encoded:
                encoded_size, encoded_digest = pixel_digest(encoded)
            if encoded_size != size or encoded_digest != digest:
                raise RuntimeError(f"decoded pixels changed for {path}")
            old_bytes = path.stat().st_size
            new_bytes = temp_path.stat().st_size
            if new_bytes >= old_bytes:
                return False, old_bytes, new_bytes
            if not dry_run:
                os.replace(temp_path, path)
            return True, old_bytes, new_bytes
        finally:
            temp_path.unlink(missing_ok=True)


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--project-root", type=Path, default=Path(__file__).resolve().parents[1])
    parser.add_argument("--dry-run", action="store_true", help="report savings without writing")
    args = parser.parse_args()
    root = args.project_root.resolve()
    targets = list(iter_targets(root))
    changed = 0
    old_total = 0
    new_total = 0
    for path in targets:
        did_change, old_bytes, new_bytes = optimize(path, args.dry_run)
        if did_change:
            changed += 1
            old_total += old_bytes
            new_total += new_bytes
            action = "would optimize" if args.dry_run else "optimized"
            print(f"{action}: {path.relative_to(root)} ({old_bytes:,} -> {new_bytes:,} bytes)")
    mode = "dry-run" if args.dry_run else "write"
    print(f"RUNTIME PNG OPTIMIZATION {mode.upper()}: {changed} files; decoded pixels unchanged.")
    if changed:
        print(f"Changed-file bytes: {old_total:,} -> {new_total:,} ({(old_total - new_total) / 1048576:.2f} MiB saved).")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
