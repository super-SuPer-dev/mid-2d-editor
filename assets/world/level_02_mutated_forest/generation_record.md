# Mutated Forest Parallax Pilot

**Asset ID:** WORLD-L2-FOREST-PARALLAX  
**State:** Integrated (pilot; human pixel-art and composition review pending)  
**Biome:** Mutated Forest  
**Source package:** `art_source/generated/world/level_02_mutated_forest/parallax/`  
**Promotion date:** 2026-08-31

## Promotion contract

- Five generated layers replace the placeholder forest parallax: sky far,
  tree-line far, canopy mid, trunks near and foreground frame.
- Runtime uses dedicated `Parallax2D` layers with nearest-neighbor filtering,
  independent scroll scales and 1280 px repeat widths. Layer scaling preserves
  each source aspect ratio; no runtime stretch or smoothing is introduced.
- The pilot changes only presentation. Level 2 collision, encounter, quota,
  boss-pattern and extraction contracts remain unchanged.
- Tile, extraction and VFX sources remain candidates until their own runtime
  contracts and human review are complete. The field-shrine prop now has a
  background-only runtime pilot.

## Provenance hashes

| File | Dimensions | SHA-256 |
|---|---:|---|
| `art_source/generated/world/level_02_mutated_forest/parallax/forest_sky_far_v1.png` | 1774 × 887 | `A7AF3EC285F0BE6A8728DEED66CAC3F2D0C27FB4C99316B2BC72D4AF165DFA61` |
| `assets/world/level_02_mutated_forest/parallax/forest_sky_far_v1.png` | 1774 × 887 | `A7AF3EC285F0BE6A8728DEED66CAC3F2D0C27FB4C99316B2BC72D4AF165DFA61` |
| `art_source/generated/world/level_02_mutated_forest/parallax/forest_tree_line_far_v1.png` | 1983 × 793 | `C9B605D76BC8070E1A985B0CC906609C33FDE804C0040F908AB654427F02B7ED` |
| `assets/world/level_02_mutated_forest/parallax/forest_tree_line_far_v1.png` | 1983 × 793 | `C9B605D76BC8070E1A985B0CC906609C33FDE804C0040F908AB654427F02B7ED` |
| `art_source/generated/world/level_02_mutated_forest/parallax/forest_canopy_mid_v1.png` | 1983 × 793 | `34E9B98D9C07E4899D8EDE70A60C6BC16C8EE59CDA3FBBD3F6342C3BB31AC657` |
| `assets/world/level_02_mutated_forest/parallax/forest_canopy_mid_v1.png` | 1983 × 793 | `34E9B98D9C07E4899D8EDE70A60C6BC16C8EE59CDA3FBBD3F6342C3BB31AC657` |
| `art_source/generated/world/level_02_mutated_forest/parallax/forest_trunks_near_v1.png` | 1774 × 887 | `15F8D89BCD9E6DCAE5AEDF97480912F67DF9112695B77E6777434100866CABB8` |
| `assets/world/level_02_mutated_forest/parallax/forest_trunks_near_v1.png` | 1774 × 887 | `15F8D89BCD9E6DCAE5AEDF97480912F67DF9112695B77E6777434100866CABB8` |
| `art_source/generated/world/level_02_mutated_forest/parallax/forest_foreground_frame_v1.png` | 1672 × 941 | `5B36D38A3C27ED262F0E88A0945FA6A838EA2BE3714413815B6BB977915609B7` |
| `assets/world/level_02_mutated_forest/parallax/forest_foreground_frame_v1.png` | 1672 × 941 | `5B36D38A3C27ED262F0E88A0945FA6A838EA2BE3714413815B6BB977915609B7` |

## Acceptance status

Technical decode, runtime import, nearest filtering and scene instantiation are
covered by the Level 2 smoke path. The package remains below `Verified` until
human review confirms pixel-art edge quality, composition at 1280 × 720,
foreground readability and memory/performance behavior during a full mission.

The generated mangosteen spore-vent strip is bound to every Level 2 hazard with
a four-frame 800 px-cell animation at 8 fps.
Source SHA-256: 3B5699E9F46F92F648868B4F6C234A58801DCDA65FCCE639AC5398CA0DD35AE4.
Runtime binary-alpha SHA-256: 1F4888158BDD4D339FD5E98A063416A7E750FC1A12259AF45F5FC2AE36A20623.

The generated Maw Bloom lair landmark (1536 × 1024) is placed behind the Level
2 boss arena at a 0.34 presentation scale and does not add collision.
Source SHA-256: 1B045AD45CB352713E305862E60EF12A8F26F081DDD81B9B68DADFBDE63ADB88.
Runtime binary-alpha SHA-256: F729C2E8F657896B025080ABEF01298A2A0C39C4149FB5B7DA792219D8609FC2.

The generated Forest Field Shrine prop (1166 × 1349) is placed behind the
mid-route platforms at a 0.23 presentation scale, z = -4, with no collision.
Source/runtime SHA-256: 96FF102DC457B3A2F0D759B06B4DC8161885802634F5D3F261ED24BF0788454B.

## Tile variant promotion

Broken-ground, left-cap and uphill-slope visuals are promoted as three
presentation-only accents at z = -2. They use nearest filtering and do not
alter collision geometry.

| Variant | Source SHA-256 | Runtime SHA-256 |
|---|---|---|
| `forest_ground_broken_v1.png` | `CE4F96B98A4FD139619A94CD619682A9579A404E6377A16977722B5677A0E83D` | `CE4F96B98A4FD139619A94CD619682A9579A404E6377A16977722B5677A0E83D` |
| `forest_ground_cap_left_v1.png` | `5DCAB92542E17926D3AAD00A8257FA59EC098CF52657B1B6E94545FC39502800` | `5DCAB92542E17926D3AAD00A8257FA59EC098CF52657B1B6E94545FC39502800` |
| `forest_slope_up_v1.png` | `248E632B48801D4952304C9978213EBFAA3309CA5A813C499CE66803AD278DD7` | `248E632B48801D4952304C9978213EBFAA3309CA5A813C499CE66803AD278DD7` |
