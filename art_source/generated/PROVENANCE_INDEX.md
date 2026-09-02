# Generated Source-Art Provenance Index

This index is the nearby provenance record for generated PNG candidates that
predate the per-package records under `art_source/generated/`. It is an audit
record, not a release approval. These files are retained as source references
only and must not be promoted to `assets/` without technical validation,
visual approval and a confirmed license/provenance decision.

## Legacy source groups

- `Background/ChatGPT Image *.png`: six original background candidates plus one
  additional background candidate generated during the first environment pass.
- `Background/removed-bg/ChatGPT Image *.png`: six background-removal outputs
  retained for comparison; they are not runtime assets.
- `character/*.png`: `esan-farmer.png`, `jintana.png`, `t800.png` and
  `tonkla.png`, the original operator-sheet candidates. Runtime copies are
  normalized under `assets/characters/operators/`.
- `character/fixed/tonkla.png`: a later operator-sheet revision retained as a
  source reference. The runtime-approved copy remains the normalized asset
  registered in `docs/ASSET_REGISTER.md`.
- `level selection/ref.png`: the original level-selection reference image;
  runtime UI uses the text-free atlas under `assets/images/ui/level_select/`.
- `removed-bg/ChatGPT Image *.png`: two isolated-background candidates kept
  for provenance comparison only.
- `ui/1.png`, `ui/2.png` and `ui/4.png`: early UI reference candidates; runtime
  UI uses the reviewed assets under `assets/images/ui/` and `assets/ui/`.

## Source and license status

Generation source is the project conversation/image-generation workflow. No
external samples are embedded, but the original prompt/session metadata and
third-party license status are not recorded for these legacy candidates.
They therefore remain `Review` and cannot be marked `Verified` or
`Release-ready` until a human owner records provenance, confirms rights and
approves the pixel-art treatment. The audit validator uses this file only to
confirm that every candidate has a named provenance record.

## Runtime promotion rule

Only a normalized, nearest-filtered, grid-validated copy with an explicit
asset-register entry may be referenced by Godot scenes or scripts. Legacy
source images must never be loaded directly by runtime code.
