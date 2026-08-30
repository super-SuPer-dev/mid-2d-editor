# Maw Sovereign Runtime Pilot

**Asset ID:** BOSS-MAW-SOVEREIGN  
**State:** Integrated (pilot; human boss-feel review pending)  
**Fruit identity:** Durian crown with mangosteen anatomy  
**Source package:** `art_source/generated/bosses/maw_sovereign/`  
**Promotion date:** 2026-08-31

## Promotion contract

- Armored and exposed idle strips are normalized to exactly 4 × 1000 × 900 px
  cells with the authored 840 px foot baseline.
- Alpha was quantized with threshold 128. Promoted strips contain only alpha 0
  or 255 and use nearest-neighbor filtering.
- The Level 2 boss starts with the armored strip and switches to exposed at
  phase 2. Both states advance at 3 fps; the existing spore/ring/aimed pattern
  set remains authoritative for combat behavior.
- Bite, cast, summon, hurt and death strips, detached projectile art and boss
  presentation frames remain source candidates for later integration.

## Provenance hashes

| File | SHA-256 |
|---|---|
| `art_source/generated/bosses/maw_sovereign/maw_sovereign_idle_armored_strip_v1.png` | `87379F8FC8948F561E8487C59E46178898AE005201D3B98DDF046B1FFEF40C8F` |
| `art_source/generated/bosses/maw_sovereign/maw_sovereign_idle_exposed_strip_v1.png` | `1C76821DB7A47564493DABF6FBC57CB1655F31A26B421A0A3D725A5BB38F0D4A` |
| `assets/enemies/bosses/maw_sovereign/maw_sovereign_idle_armored_strip_normalized_v2.png` | `68C5942F8829BFAE01E626C85A8789034CF79FDD63F4E444A9DE8DE446706995` |
| `assets/enemies/bosses/maw_sovereign/maw_sovereign_idle_exposed_strip_normalized_v2.png` | `303D11BF806F5E7C7D8AB5D3916888FD90BBAEF2B5FB2048DA2D9EC38CAD3CDD` |

## Acceptance status

Technical decode, 4-frame grid, binary-alpha, runtime import, baseline and
phase-state checks pass. The package remains below `Verified` until human review
confirms durian/mangosteen identity, boss scale, phase readability and contrast
against the Level 2 forest arena.
