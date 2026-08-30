# Spitter Runtime Pilot

**Asset ID:** ENEMY-SPITTER  
**State:** Integrated (pilot; human art review pending)  
**Fruit identity:** Makrut-lime spitter  
**Source package:** `art_source/generated/enemies/spitter/`  
**Promotion date:** 2026-08-31

## Promotion contract

- Idle and walk strips are normalized to exactly 4 × 700 × 800 px cells with
  the authored 740 px foot baseline.
- Alpha was quantized with threshold 128. Promoted strips contain only alpha 0
  or 255 and use nearest-neighbor filtering.
- Level 1–3 Spitters select the idle strip while stationary and the walk strip
  while grounded and moving. Both loops advance at deterministic 4/7 fps.
- A 4-frame seed-burst strip is selected for the 0.5 second ranged attack
  presentation at 8 fps; projectile behavior and collision geometry remain
  unchanged. Pressure-tell, juice-lob, hurt and death strips remain source
  candidates for later integration.

## Provenance hashes

| File | SHA-256 |
|---|---|
| `art_source/generated/enemies/spitter/spitter_idle_strip_v1.png` | `A441CF7315FC23F91317C57DF4072316358ECED3841735A91109E4BC6ABA9ED8` |
| `art_source/generated/enemies/spitter/spitter_walk_strip_v1.png` | `848EE0D5AB47755E2169732099A73135C07DC4FBE31F6E8519FFBA6C6A8AB2A6` |
| `assets/enemies/standard/spitter/spitter_idle_strip_normalized_v2.png` | `F6494F755CEBFDB06A604CD95C8BABD9A41D55BA3D17EB0A00833CEF73B8DCD7` |
| `assets/enemies/standard/spitter/spitter_walk_strip_normalized_v2.png` | `3331EC7B7149A768A45D07117D41035EEBACF609954E7F96C0FC72EAAFEB38B9` |
| `art_source/generated/enemies/spitter/spitter_seed_burst_strip_v1.png` | `AA8835121A268ED60DA6AEA395C2C5CCCDF526BFCE32312A16116D5AC1B19C56` |
| `assets/enemies/standard/spitter/spitter_seed_burst_strip_normalized_v2.png` | `A55E71AEFC9A3BB1CB1CEFEC6BB8D645D2F75ADE01D749B7231946CEF95E875C` |

## Acceptance status

Technical decode, 4-frame grid, binary-alpha, runtime import, baseline,
idle/walk and seed-burst state checks pass. The package remains below
`Verified` until human review confirms makrut-lime identity, grounded
silhouette, cast readability and contrast against each forest/grassland
background.
