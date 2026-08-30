# BOSS-ROOT-CORE-EYE projectile, telegraph and impact source set v1

**State:** Review (not integrated)

**Fruit identity:** Longan eye cluster within dragon-fruit bracts /
พวงตาลำไยในกลีบแก้วมังกร

**Grid contract:** Seven detached assets, each a four-frame horizontal strip
normalized to 3200 x 800 with four 800 x 800 centered cells.

## Pattern contract

| Runtime role | Asset | Shape/readability rule |
|---|---|---|
| Aimed seed volley | `longan_seed_bullet` | Glossy black oval seed with pale flesh rim |
| Fast aimed burst | `pupil_lance_dart` | Narrow violet-white spear with black seed center |
| Spiral volley | `spiral_seed_eye_orb` | Round eye-orb with a visible clockwise notch |
| Bract bullet curtain | `bract_curtain_blade` | Magenta-green crescent distinct from round bullets |
| Radial-ring timing | `radial_ring_telegraph` | Open-center circle with five crown-eye nodes |
| Central eye beam | `core_beam_segment` | Narrow horizontal lance with pale segmented bands |
| Exposed-core feedback | `core_shockwave_impact` | Centered expanding ring and bract-shaped sparks |

The source set defines visual language only. Runtime pattern data must still
enforce the Level 5 projectile cap, deterministic safe routes, pooled reuse,
cleanup on phase/death/retry and contrast against the Alien Eye Nexus.

## Validation hashes and provenance

| Normalized asset | Built-in source | SHA-256 |
|---|---|---|
| `root_core_eye_longan_seed_bullet_normalized_v1.png` | `exec-94fc52c2-1015-4fff-804e-ce5c8ab06c75.png` | `EC9ACBCBD62298880D15D961BAC1A06B89323236864E826FF1A4BA6B9B1D5FE7` |
| `root_core_eye_pupil_lance_dart_normalized_v1.png` | `exec-daf62cf5-6312-4b12-a96f-0d1947be52db.png` | `E3158E5FBE194B204F87E33467123F337C7D0AA76BC7F51E901E5E6F31495C40` |
| `root_core_eye_spiral_seed_eye_orb_normalized_v1.png` | `exec-31319712-e324-44a7-8854-e7d0dede6d49.png` | `62CF58CB83CCF4F8A0A3F76666D41168E90EEFDC717EEFBB675E273AA41DC33D` |
| `root_core_eye_bract_curtain_blade_normalized_v1.png` | `exec-5e3f27ff-c4d0-476a-a14c-4e320a4a0efa.png` | `703BF63D3CF6F80C031C16EE1685427C3C7DB88394A624653C99ADF71D31764C` |
| `root_core_eye_radial_ring_telegraph_normalized_v1.png` | `exec-295262a9-1423-42c1-a998-94adc5afd420.png` | `706AAF9D52DC7D19304C9EDD106C78C7E578AFAE1E44898EC1EC5793CA7CB18D` |
| `root_core_eye_core_beam_segment_normalized_v1.png` | `exec-371f27ab-6483-4a03-b31c-bb699ffb1b54.png` | `35717EE21DF2DBD162526FFC9D17E1DBAC7C6BBB124C7B670AA3FD482A5FF517` |
| `root_core_eye_core_shockwave_impact_normalized_v1.png` | `exec-33dbe887-0490-4672-b3ce-8ba7b10cb2d5.png` | `F96DBFB83EA241D41ECDFFF6BE66FC344EA1716B49B6114D6156CAF60BA18803` |

All normalized outputs are 32-bit ARGB PNGs with transparent corner pixels.
The first and last three columns of every cell contain zero alpha, proving no
neighboring-frame contamination. Visual review confirms distinct oval, lance,
circle, crescent, open-ring, beam and impact silhouettes with no baked UI or
language-specific text.

## Prompt contracts

Every prompt used the matching normalized body action as its authoritative
pixel-art material and palette reference and ended with
`Transparent background.`

- `longan_seed_bullet`: glossy black oval seed, pale flesh rim, violet pupil
  glint; compressed launch, full-speed seed, quarter-turn and pulse frames.
- `pupil_lance_dart`: narrow violet-white spear, black seed center and tiny
  pale-flesh fins; ignition, full-speed, bright pulse and fading-tail frames.
- `spiral_seed_eye_orb`: round violet-magenta eye orb with pale crescent and
  clockwise notch; tight, expanded, half-turn and contracted frames.
- `bract_curtain_blade`: crimson-magenta dragon-fruit crescent with green tip,
  dark inner edge and pale seam; four readable rotation states.
- `radial_ring_telegraph`: five-node open circle, pale flesh ticks, maximum
  spawn circumference and collapse frame with the center always visible.
- `core_beam_segment`: screen-left violet-white lance, seed fleck, segmented
  energy bands and magenta ribbons; four narrow travel states.
- `core_shockwave_impact`: cracked-seed point, expanding flesh ring, widest
  open-center starburst and shrinking bract-shaped sparks.

Every prompt required four equal horizontal cells, one complete detached asset
per cell, generous separation, no boss body/scenery/floor/UI/text/watermarks/
grid lines, and no cropped glow. Runtime hitboxes must use authored collision
data rather than visible alpha bounds.
