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
- Tile, hazard, landmark, shrine, extraction and VFX sources remain candidates
  until their own runtime contracts and human review are complete.

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
