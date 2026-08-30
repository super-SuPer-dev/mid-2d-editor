# Project Structure

This document is the canonical repository-layout contract. Runtime code and
Godot-importable resources must remain separate from source artwork, generated
candidates, exports, editor caches, and validation evidence.

## Target layout

```text
assets/                 Runtime-importable art, audio, fonts, and data resources
art_source/             Non-runtime source material; ignored by Godot
  generated/            AI/generated candidates and their provenance records
  legacy/               Superseded, unreferenced art retained for review
  references/           Art-direction boards and external visual references
docs/                   English-authoritative design and production documents
  th/                   Thai companion documents
localization/           English/Thai translation tables and glossary
scenes/                 Godot scenes and scene-local resources
  actors/
  backgrounds/
  core/
  gameplay/
  levels/
  tests/
  ui/
src/                    GDScript organized by feature responsibility
tools/                  Repository maintenance and asset-processing tools
validation/             Test manifests and intentionally retained evidence
```

`project.godot`, export configuration, `README.md`, `LICENSE`, and the canonical
English GDD remain at repository root. Empty template/export folders are not
versioned until they contain a documented artifact.

## Runtime asset rule

Scenes and scripts may reference only `res://assets/`, `res://scenes/`,
`res://src/`, `res://localization/`, or a deliberate root configuration file.
They must never reference `res://art_source/`, validation captures, editor
caches, or raw generated filenames.

An asset moves from source to runtime only when it has:

1. A stable lowercase English filename using `snake_case`.
2. Recorded provenance and review state in the asset register.
3. Technical validation for alpha, dimensions, grid, gutters, baseline, and
   filtering as applicable.
4. A destination grouped by gameplay role rather than generation batch.
5. Updated Godot references and a passing import/reference validation pass.

Source-art `.import` files are forbidden. Runtime asset `.import` files remain
tracked when they preserve import settings or resource UIDs.

`art_source/`, `tools/`, and `validation/` contain `.gdignore` sentinels so a
fresh Godot import does not scan source candidates, maintenance code, or QA
evidence into a release build.

## Naming conventions

- Directories and files: lowercase `snake_case`, except third-party addons that
  retain upstream naming.
- Scenes: descriptive noun or screen name, for example `level_select.tscn`.
- Scripts: match the primary scene, resource, manager, or responsibility.
- Catalog IDs: stable English `snake_case`; never localize IDs or paths.
- Versions: use `_v2` only for concurrent reviewed revisions. Remove rejected
  revisions from active runtime folders after a recoverable Git checkpoint.
- Avoid spaces, localized dates, generic numeric filenames, and tool-generated
  names in runtime paths.

## Dependency direction

```text
project/autoloads -> src/core -> feature scripts -> scenes -> assets
                                      |              |
                                      +-> data       +-> localization

art_source -> review/promotion -> assets
validation -> observes runtime; runtime never depends on validation
```

UI and gameplay features may depend on core managers and catalogs. Core code
must not depend on individual UI screens or level scenes. Tests may depend on
runtime content; runtime content must not depend on tests.

## Migration protocol

Each structure change is committed separately and must include:

- a before/after path map;
- updates to every `res://` and documentation reference;
- completed Godot import pass;
- resource-reference scan with no missing files;
- smoke-test result, including any pre-existing failure explicitly identified;
- no unrelated editor, addon, or user changes staged.

## Completed migration checkpoints

- `0d1442a` promoted live generated art into stable runtime destinations.
- `b03e9be` isolated source candidates and references under `art_source/`.
- `b3770e9` normalized runtime directory casing for case-sensitive exports.
- `8a49601` archived unreferenced legacy art and added structure enforcement.

Run `tools/validate_project_structure.ps1` and
`tools/validate_localization.ps1` before the Godot smoke scene. These checks are
the required baseline for subsequent feature and content branches.
