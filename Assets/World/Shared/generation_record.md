# Shared Gameplay-Object Generation Record

Asset IDs: `WORLD-SAMPLE`, `WORLD-PROJECTILE`, `WORLD-PORTAL`

- Generated: 2026-08-27
- Tool: OpenAI built-in image generation
- Mode: Separate transparent raster generations
- Art target: high-resolution pixel art on declared logical grids
- State: Runtime candidates pending full visual and animation review

## Final prompt summary

- Sample canister: one rugged charcoal/steel ACO field vial with aged-gold
  clamp and toxic-green alien seed, authored on a 48 × 64 logical grid; flat
  hard pixel clusters, no text, no baked UI. A checkerboard cleanup variant was
  rejected and is not present in the project.
- Spore projectile: one left-facing toxic-green seed dart wrapped in two
  dark-purple thorn fins with a short jagged opaque tail, authored on a 32 × 16
  logical grid; no blur, semitransparent trail, or extra projectile.
- Extraction beacon: one freestanding charcoal/olive portable field gate with
  aged-gold brace, transparent center opening, hard opaque green status lamps,
  cables and stabilizer feet, authored on a 96 × 128 logical grid; no baked
  symbols or language-specific text.

All prompts prohibited photorealism, painterly brushwork, airbrush haze, smooth
gradients, anti-aliasing, 3D/PBR rendering, text, backgrounds and watermarks.

## Technical inspection

| Runtime file | Dimensions | Format | Corner alpha |
|---|---:|---|---|
| `sample_canister.png` | 1024 × 1536 | 32-bit ARGB PNG | 0/0/0/0 |
| `spore_projectile.png` | 1660 × 948 | 32-bit ARGB PNG | 0/0/0/0 |
| `extraction_beacon.png` | 1199 × 1312 | 32-bit ARGB PNG | 0/0/0/0 |

The sample remains provisional until the 1280 × 720 capture confirms that no
soft exterior haze is visible at runtime pickup scale.
