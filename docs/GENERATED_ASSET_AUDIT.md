# Generated Asset Audit

**Project:** Low Attitude Warrior  
**Audit date:** 2026-08-31
**Scope:** `art_source/generated/`  
**Authority:** This English audit is maintained. Existing Thai documents are frozen references.

This is a source-candidate audit, not production approval. Generated files remain outside Godot's runtime import tree and retain the `Review` state until visual, integration, platform, and human-review gates pass.

## 1. Inventory Result

| Check | Result | Evidence / interpretation |
|---|---|---|
| PNG inventory | Pass | 477 PNG files; 837,845,904 bytes total |
| Decode and dimensions | Pass | 477/477 files decode; no invalid, zero-size, fully transparent, or over-16,384 px texture was found |
| Transparency presence | Pass with scope note | 458 files contain transparent pixels; 19 files are fully opaque backgrounds/maps or other opaque candidates where alpha is not inherently required |
| Normalized strip geometry | Provisional pass | All 188 files named `_normalized_` have widths divisible by four; declared cell mappings, gutters, pivots, and baselines still require package-by-package verification |
| Hard-edge pixel-art alpha | Blocked | 337 opaque-art candidates exceed the 2% semi-transparent-pixel limit; this conflicts with the current hard-cluster acceptance rule for opaque sprites, tiles, portraits, and UI |
| Provenance records | Pass with scope note | The repeatable validator finds a nearby English Markdown record for all 477/477 candidates; package-level one-to-one source/session/license confirmation is still incomplete |
| Runtime import/filtering | Partial | The promoted `assets/enemies/` opaque-art group passes the binary-alpha check; generated source remains excluded from Godot import and still requires package-level grid, filtering, memory and visual verification |
| Windows/Web appearance and memory | Not tested | Requires integrated assets, 1280 x 720 captures, and platform builds |
| Art-direction approval | Blocked | High-resolution pixel-art style, silhouette quality, animation continuity, and intentional transparency require human visual review |

`true alpha` in this report means that transparent pixels exist. It does not mean that edges are clean, binary, halo-free, or approved for pixel-art use.

## 2. Repeatable Validation

The source audit can be reproduced from the repository root with:

```powershell
pwsh -NoProfile -Command '& .\\tools\\validate_generated_assets.ps1 -ProjectRoot (Get-Location).Path -AlphaSampleStride 8 -NormalizedAlphaSampleStride 2'
```

The validator decodes every PNG, rejects zero-size or over-limit textures, checks normalized-strip geometry, reports nearby provenance coverage, and emits soft-alpha warnings without falsely promoting a candidate. Pass `-StrictSoftAlpha` when a package is expected to meet the binary-alpha gate; the command then exits non-zero for opaque-art candidates above the configured 2% limit. Alpha percentages use a dense 2x sample for normalized strips and an 8x sample for other source images to keep the audit memory-safe.

## 3. Decision

The source library passes basic file integrity and now has a nearby English provenance index for every candidate, but it still fails the current production-readiness gate. A strict run (`-StrictSoftAlpha`) exits with code `2` because 337 opaque-art candidates exceed the configured 2% limit. No audited generated candidate is promoted to `Verified` or `Release-ready` by this audit. Existing `Review` states remain unchanged because soft-alpha, per-package technical checks, rights confirmation and human visual approval are still required.

Semi-transparent pixels may be intentional for glow, smoke, projectile trails, or other VFX. Those assets require a documented VFX exception and runtime readability test. Continuous soft alpha on character bodies, enemy bodies, bosses, tiles, landmarks, portraits, and opaque UI ornament must be removed, quantized at the logical pixel resolution, or regenerated before integration approval.

## 4. Required Remediation

1. Classify every candidate as opaque pixel art, intentional translucent VFX, full background, or non-runtime reference.
2. Regenerate or quantize opaque pixel-art candidates at their declared logical resolution, then upscale with nearest-neighbor sampling.
3. Verify exact cell count, gutter, neighboring-frame isolation, crop, pivot, foot baseline, and per-action timing for every animation package.
4. Select only approved candidates for promotion into `assets/`; configure nearest filtering and avoid unnecessary transparent canvas memory.
5. Capture every integrated screen and gameplay asset at 1280 x 720 in English and Thai on Windows and Web.
6. Require human approval for art direction, animation smoothness, silhouette readability, fruit identity, and boss projectile readability before advancing beyond `Integrated`.

The runtime enemy-art check is reproducible with:

```powershell
python .\tools\quantize_runtime_alpha.py --project-root (Get-Location).Path --check
```

It intentionally excludes `assets/enemies/**/projectiles/`, where translucent
glow is part of the projectile readability contract.

## 5. Progress Impact

- Source discovery and file-integrity audit: complete.
- Repeatable dimension, decode, normalized-grid and provenance audit: complete (2026-08-31).
- Pixel-art edge compliance: blocked.
- Runtime integration: pending candidate remediation and selection.
- Platform verification: pending integration.
- Overall generated-source state: `Review`.
