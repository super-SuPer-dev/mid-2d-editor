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
- The `maw_spore_rain`, `maw_rotating_five_way` and `maw_aimed_seed_burst`
  telegraphs select their matching spore, rotating-volley and aimed-volley
  cast strips. Casts use the same 4 × 1000 × 900 grid and are driven by the
  existing pattern signal callbacks.
- Bite, cast, summon, hurt and death strips, detached projectile art and boss
  presentation frames remain source candidates for later integration.

## Provenance hashes

| File | SHA-256 |
|---|---|
| `art_source/generated/bosses/maw_sovereign/maw_sovereign_idle_armored_strip_v1.png` | `87379F8FC8948F561E8487C59E46178898AE005201D3B98DDF046B1FFEF40C8F` |
| `art_source/generated/bosses/maw_sovereign/maw_sovereign_idle_exposed_strip_v1.png` | `1C76821DB7A47564493DABF6FBC57CB1655F31A26B421A0A3D725A5BB38F0D4A` |
| `assets/enemies/bosses/maw_sovereign/maw_sovereign_idle_armored_strip_normalized_v2.png` | `68C5942F8829BFAE01E626C85A8789034CF79FDD63F4E444A9DE8DE446706995` |
| `assets/enemies/bosses/maw_sovereign/maw_sovereign_idle_exposed_strip_normalized_v2.png` | `303D11BF806F5E7C7D8AB5D3916888FD90BBAEF2B5FB2048DA2D9EC38CAD3CDD` |
| `art_source/generated/bosses/maw_sovereign/maw_sovereign_spore_cast_strip_v1.png` | `CB665DC59C5CA3D3EFF8C3F62B287B3E7A619C672360B1CAD71766E5C9DC6ED5` |
| `art_source/generated/bosses/maw_sovereign/maw_sovereign_rotating_volley_cast_strip_v1.png` | `B32584277D5BE94282321621E590DC20E5397A6E512FFB57A6327EF9138AFCDC` |
| `art_source/generated/bosses/maw_sovereign/maw_sovereign_aimed_volley_cast_strip_v1.png` | `50658241DBC0D6C3378DE6F3F19F0E948793344501E3F68BB472D91125D5E96E` |
| `assets/enemies/bosses/maw_sovereign/maw_sovereign_spore_cast_strip_normalized_v2.png` | `A388E6D22F9C4B53AFB0825A27C5E711D6EA2AEB83325804126961298AB24E60` |
| `assets/enemies/bosses/maw_sovereign/maw_sovereign_rotating_volley_cast_strip_normalized_v2.png` | `AE333239867F841CE4845A84779C819007FC397ADE0CC1B5A42CEB92CE6C45A6` |
| `assets/enemies/bosses/maw_sovereign/maw_sovereign_aimed_volley_cast_strip_normalized_v2.png` | `D014A407CCD586FCA709B63F7831E254BF005C2C1A6EBA901E32FF976819BA4B` |

## Death promotion

The 3600 × 900 three-frame death strip is promoted to runtime and plays during
the non-blocking defeat lifecycle. SHA-256:
814D4035A899FBFE472F99105C29A30F25518D4B5152E2C63811239AF709607F.

## Acceptance status

Technical decode, 4-frame grid, binary-alpha, runtime import, baseline,
phase-state and cast-binding checks pass. The package remains below `Verified`
until human review confirms durian/mangosteen identity, boss scale, phase
readability and contrast against the Level 2 forest arena.
