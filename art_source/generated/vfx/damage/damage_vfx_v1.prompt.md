# Damage and Status VFX Source Record v1

Generated on 2026-08-29 with OpenAI ImageGen for the English-first bilingual
high-resolution pixel-art production package. These are detached, text-free
effects. Runtime timing, scale, blend mode, and gameplay binding remain subject
to integration review.

## Shared contract

- Exactly four frames in one horizontal row.
- One isolated effect per equal square cell with a fixed center and generous
  transparent gutters.
- Detailed, original, non-realistic high-resolution pixel art.
- VFX only: no character, enemy body, weapon, floor, scenery, text, or watermark.
- Transparent background.

## Sources

| Runtime candidate | ImageGen source ID | Raw SHA-256 | Normalized SHA-256 |
|---|---|---|---|
| `damage_player_hit_normalized_v1.png` | `exec-559627c7-94cd-48ae-bf75-97c01613bfa2.png` | `ffaf6fec4940a6ddc11a11f826f7a04a24b9d1da83eca06a9178ce43bae7800f` | `8b7ccdd084d9c44e87b9cd3b14b9de5c8d0d456513cbfd13bf08338740d566f8` |
| `damage_organic_hit_normalized_v1.png` | `exec-e1ca9a84-d87a-4920-b881-e58b17c65e5c.png` | `12dcef4297290ec5d221003b44915e6365ad8122ab9e342d391f3a28b3672acb` | `3265ca9da9b82b343ee5e1d12983e56ad51d6e7f72ed09d6f48e5393f2a0ff01` |
| `damage_armored_hit_normalized_v1.png` | `exec-6f14c98e-62ee-4051-be5c-3f258ef9dddf.png` | `859a91d3c0062707b833db795486e2737e5d6d95021eee777bfa7b2d234278a6` | `37a73f337385ba4e671e8accf75b22d7abb8cf5d40823b8dca5a6649e22569a1` |
| `damage_boss_core_hit_normalized_v1.png` | `exec-f5778176-1c28-41b5-bd85-bcb9959eff34.png` | `f6e98a49883a2cb92a55e3fb9074403df10a4d00a4622e765269845c74b242c6` | `cad8b2cbfcbdf376e4383e1c8dd04cd349dc3b8e15a79ea8012cb354decd6334` |
| `status_root_contamination_normalized_v1.png` | `exec-eb91d34d-8e81-4ef7-b0d6-cf240e893924.png` | `4e895d1487e4bca9d4a5840320e1088502065b0d9d7690df720056dde43f294f` | `bff0e51283719e32f0308516e4f8bbc180eaec3566a2d0bf4a32779670605a04` |

## Prompt-specific direction

### Player hit

White-orange contact flash, amber star and thin red shock ring, followed by
charcoal flecks, red-orange breakup, and a small warm fade. The effect reads as
damage to an operator rather than a successful enemy strike.

### Organic hit

Pale-green flash, radial plant-fiber and sap burst, magenta droplets, olive
fragment breakup, and fading biological motes. The fruit-derived organic read
uses tissue, fiber, seed, and sap shapes rather than a generic green recolor.

### Armored hit

White-blue metal contact spark, hard angular cyan-white star, thin hexagonal
shock ring, aged-gold sparks, gunmetal flakes, blue electrical breakup, and cool
fade. It must read as hard armor rather than plant tissue.

### Boss-core hit

Heavy Longan Eye Cluster / Dragon-Fruit Bract impact: white-gold core crack,
black longan-seed center, magenta bract shards, cyan root-energy arcs, pale
longan-flesh fragments, circular shock ring, seed-eye sparks, and a short fade.

### Root-contamination status

Four-frame loop with a consistently open center: curved magenta and
bruised-purple root tendrils, acidic-green spores, pale seed motes, and tiny
eye-buds. The lower ring keeps a stable anchor and communicates rooted/poisoned
alien contamination rather than healing or fire.

## Processing and validation

Each accepted `2172 × 724` source was normalized with
`tools/normalize_grid_sprite_strip.ps1` using four frames, `800 × 800` cells,
center alignment, and alpha threshold 1. Every normalized strip is
`3200 × 800`, `Format32bppArgb`, and has zero non-transparent pixels on all four
cell boundaries. A visual contact-sheet review confirmed isolated actions,
stable anchors, distinct damage materials, clear status center, and no visible
neighbor-frame contamination.

The first root-contamination attempt (`exec-be2d1197-9214-49d8-9184-123fe7636e8b.png`)
was rejected for full-canvas haze. Its cleanup edit
(`exec-3d425e26-8f01-4b98-97a0-195cab3c4e4e.png`) was rejected because it baked
an RGB checkerboard instead of true alpha. Neither rejected file was copied into
this package.
