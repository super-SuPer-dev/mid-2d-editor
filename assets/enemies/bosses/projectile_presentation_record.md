# Boss Projectile Presentation Runtime Record

**State:** Integrated (technical pilot; contrast and final boss-feel review pending)  
**Promotion date:** 2026-08-31  
**Runtime contract:** Every canonical boss `pattern_id` selects a four-frame,
800 × 800-cell projectile strip through `BossPatternCatalog` and
`BossProjectilePatternRunner`. The strips use nearest filtering, binary alpha,
and a pattern-specific scale. Pool reuse resets the texture, frame count,
scale and frame clock through `EnemyProjectile.activate()`.

## Pattern mapping

| Boss | Pattern IDs | Fruit-specific runtime strip |
|---|---|---|
| Thorn Matriarch | `thorn_fan_three_way` / `thorn_alternating_lanes` | Rambutan hair-thorn spin / lane-thorn emergence |
| Maw Bloom Sovereign | `maw_spore_rain` / `maw_rotating_five_way` / `maw_aimed_seed_burst` | Mangosteen spore pod / durian-mangosteen seed spin |
| Possessed Banyan | `banyan_seed_columns` / `banyan_diagonal_roots` | Jackfruit seed fall / diagonal root line |
| Root Hydra | `hydra_head_crossfire` / `hydra_offset_rings` / `hydra_water_lane_walls` | Nipa wedge bolt / nutrient ring orb / water-lane eruption |
| Root-Core Eye | `eye_rotating_spirals` / `eye_aimed_rings` / `eye_alternating_curtains` | Spiral seed-eye orb / pupil lance dart / dragon-bract curtain blade |

## Technical acceptance

- Each strip is exactly 3200 × 800 px: four 800 × 800 frames.
- Runtime copies are quantized at alpha threshold 128, so every pixel is
  either transparent or fully opaque; no filtering blur is permitted.
- Pattern IDs remain English canonical IDs and are not localized.
- Smoke coverage validates the opening projectile binding for all five bosses,
  four-frame grids, non-default scales, phase transitions, cap enforcement and
  pool cleanup.
- The package remains below `Verified` until human review confirms projectile
  silhouettes, contrast against each biome, motion readability and final memory
  cost on Web.

## Provenance hashes

| Runtime file | Source SHA-256 | Runtime SHA-256 |
|---|---|---|
| `thorn_matriarch/projectiles/hair_thorn_spin_strip_normalized_v2.png` | `D5E734E7A8CE7C51B6A18BB720E7AB72F487B9D77BAD065405FF1437A31E8C5F` | `FA75906FF42935EBCC816198DEFF842759196A71BE4C487353587798FD49E759` |
| `thorn_matriarch/projectiles/lane_thorn_emerge_strip_normalized_v2.png` | `2B4AD4BA0FF9519B78E5EF3F18111BCA3F7908EAD335E3B4A932AEFFDC65DAD8` | `A303283222B998FED7F7EF47AE5237B5E505E5A58B974E3FB88232176271BF93` |
| `maw_sovereign/projectiles/spore_pod_fall_strip_normalized_v2.png` | `D2F71949D306837E101A82E802C2C7B771F67F2B57278F77CE05A8EE3ED55607` | `7A2B83E2FDA72BE34F4194BB7E7FE561D6D7A22F814C2B3D1292B309AFF25CE6` |
| `maw_sovereign/projectiles/seed_bullet_spin_strip_normalized_v2.png` | `B35B70CD5F2360ADCA6BF2814A7373965F25811F01FCEC3C69B9D42D92CFD07B` | `37BCD26F8DA27827F5DDF38FD645E88C0D8F2F6A29D8398FC93DA89AA25B22E3` |
| `possessed_banyan/projectiles/jackfruit_seed_fall_strip_normalized_v2.png` | `ED6FEF1C5E315EEBF061D55817306E238D730FB04C45153665616CF98F43D941` | `64F7D91ED9E3A366E3F4FAD168943EB16A997877D1EAAC23596DCDCD933EA7D5` |
| `possessed_banyan/projectiles/diagonal_root_line_strip_normalized_v2.png` | `82F6AD8EB9775BCB41188943FAD6D0E91792B7006F7FFE36BB9D2D684E755A3E` | `60E9DAF20697C0262EA99D6ECDBEF52634E494D1176EE43CF8736744670655BE` |
| `root_hydra/projectiles/root_hydra_nipa_wedge_bolt_normalized_v2.png` | `4193108FFF5065A58BA471D730FDEB474408A7FD785005B63D4FF880679926B7` | `8DEF25A86351D7D8F0D72731E29F1CFCD0FCC6DE2711E185F319F07F138452A1` |
| `root_hydra/projectiles/root_hydra_nutrient_ring_orb_normalized_v2.png` | `CC1052E028EE0C6C59EF699F14227E8D9B7E8170BDFF8C21F16AF4908A263F00` | `B11FF5BA34D56E6ECE4C35147069C936190F8DBB49465064946AB41A8C326E56` |
| `root_hydra/projectiles/root_hydra_water_lane_eruption_normalized_v2.png` | `5B4C3A08D9AD471CBA41761295C36BCE00CC9E14E80CCBD2A207A130E73B5354` | `C6ED1DCBCBD0CB7E90FB6EB2DDAEA2378DD17F6AB3E0BF0B3D7725803C960457` |
| `root_core_eye/projectiles/root_core_eye_spiral_seed_eye_orb_normalized_v2.png` | `62CF58CB83CCF4F8A0A3F76666D41168E90EEFDC717EEFBB675E273AA41DC33D` | `C7B530953919F71F49A2F3902F88F0F82E79A5498B4E959B9ADCCD1DB07499CB` |
| `root_core_eye/projectiles/root_core_eye_pupil_lance_dart_normalized_v2.png` | `E3158E5FBE194B204F87E33467123F337C7D0AA76BC7F51E901E5E6F31495C40` | `CE0AE9B0F69F9895841AC7532B315303B3A05F8EB9A8EE7B8D7015820558732B` |
| `root_core_eye/projectiles/root_core_eye_bract_curtain_blade_normalized_v2.png` | `703BF63D3CF6F80C031C16EE1685427C3C7DB88394A624653C99ADF71D31764C` | `83C7D6438511343DAD695EE59D71F1A1099CCD282E13AD4AA3E16587C25AD087` |

The runtime hashes above are regenerated after quantization and must be
recomputed if any source or normalization parameter changes.
