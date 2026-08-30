# ENEMY-THORNLING contact VFX source set v1

**State:** Review (not integrated)

**Fruit identity:** Rambutan / เงาะ

**Grid contract:** One four-frame horizontal strip normalized to 2800 x 700
with four 700 x 700 centered cells. Connected-component normalization keeps
the readable impact body and removes detached fragments that could contaminate
neighboring animation cells.

## Runtime contract

| Runtime role | Asset | Readability rule |
|---|---|---|
| Thornling contact damage | `thornling_contact_hit` | Red-orange hooked hair fan, pale contact center and green sap accents |

The effect attaches to the authored collision point. Runtime hitboxes must not
derive from visible alpha bounds.

## Validation and provenance

| Normalized asset | Built-in source | SHA-256 |
|---|---|---|
| `thornling_contact_hit_normalized_v1.png` | `exec-d24cbb63-16f8-4da8-8e83-1d5e5adca502.png` | `5159C6364E7CFB4FA852635437B738D500A8B98CA76A0C8F5CFC71E826B98802` |

The normalized output is a 32-bit ARGB PNG with transparent corner pixels.
The first and last three columns of all four cells contain zero alpha. This
proves the accepted strip has no neighboring-frame contamination.

## Prompt contract

> Preserve the Thornling's detailed high-resolution pixel-art style and
> rambutan hair-thorn materials. Create four contact-impact frames: tiny pale
> contact point, sharp red-orange thorn fan, widest hooked-hair starburst with
> green sap accents, then shrinking curved sparks. Non-gory and readable at
> small gameplay scale. Exactly four equal horizontal cells with one complete
> effect per cell. No enemy body, scenery, floor, UI, text, watermark or grid
> lines. Transparent background.

Integration still requires hit-position tuning, nearest-neighbor imports,
contrast checks against Level 1 and Windows/Web gameplay validation.
