# BOSS-ROOT-HYDRA presentation source set v1

**State:** Review (not integrated)

**Fruit identity:** Nipa-palm fruit cluster / พวงลูกจาก

**Localization contract:** All presentation art is text-free. Boss name,
warning, health, phase and accessibility strings must be rendered at runtime
from localization keys. Portrait/title/health openings use true alpha; the
three small HUD phase sockets retain dark backing for icon contrast.

## Package contract

| Asset | Grid / canvas | Runtime intent |
|---|---|---|
| Portrait states | 3 x 1, 900 x 900 cells | Armored, four-head attack and exposed-core crops |
| Boss-intro frame | 1800 x 1000 | Left portrait socket plus title-safe opening |
| Boss-HUD frame | 2200 x 800 | Portrait socket, health opening and three phase sockets |
| Phase markers | 3 x 1, 900 x 900 cells | Four heads, one broken head and exposed core |

## Validation hashes and provenance

| Normalized asset | Built-in source | SHA-256 |
|---|---|---|
| `root_hydra_portrait_states_normalized_v1.png` | `exec-b277f435-bb7b-4611-a9fd-47332ddb4c59.png` | `11BA2D7537F293070CC8E0B6E35BFDF3E5F66FE705CDB17B43DFB0CB3AC5232E` |
| `root_hydra_intro_frame_normalized_v1.png` | `exec-f530edda-865d-4e0e-99d1-9d71edafc658.png` | `75CA477DC4C5264B980EA5143622ED08F11AC25DA1FA86B6FD5A812A9CCE6BF2` |
| `root_hydra_boss_hud_frame_normalized_v1.png` | `exec-dab6de76-4a60-40c7-935b-ef4e25e17c0c.png` | `56308ED30E89D29AA4DD7E029C19626132CEC29E8949AE86BCA531313834099D` |
| `root_hydra_phase_markers_normalized_v1.png` | `exec-10e48be5-30f0-4128-adf6-c94b8cf9460d.png` | `FB64202E1E0F393C9022D05A1D0622DDD74BD6DDB3929052726DCFDBB5CD277C` |

All accepted normalized outputs have transparent corners. Direct alpha samples
confirmed transparent intro portrait/title openings and transparent HUD
portrait/health openings. Visual review confirmed distinct states, empty
runtime-text regions and no baked English or Thai text.

## Prompts

### Portrait states

> Use the inputs as the authoritative Root Hydra armored and exposed-core
> designs. Preserve the exact dark nipa-fruit wedge heads, copper-orange fiber
> jaws, cyan root veins, wet olive leaves, clustered crown armor, detailed
> high-resolution original pixel-art density, palette, outlines, and upper-left
> lighting. Create three close portrait states for boss introduction and HUD.
> Use one consistent crop showing the clustered central crown and all four
> head/neck silhouettes behind it, without the ground roots. State 1: armored
> menace with crown closed and four heads watching at staggered heights. State
> 2: aggressive crossfire with four orange-glowing jaws spread into a crown-like
> silhouette. State 3: two-head-broken exposed cyan conduit core with two sealed
> stumps and two surviving heads, damaged but non-gory. Slight three-quarter
> frontal view, consistent scale and crop. Exactly three equal cells in one
> horizontal row. Transparent background.

### Boss-intro frame

> Create one wide text-free boss-introduction UI frame. Fuse dark charcoal ACO
> containment metal and aged copper-brass with wet braided marsh roots, dark
> nipa-palm wedge-fruit plates, sparse olive palm leaves, cyan nutrient
> channels, and restrained copper-orange fibers. Include a large circular
> transparent portrait socket on the left and a large clean transparent
> title-safe opening across the center and right for runtime English or Thai
> text. Keep decoration around the outer perimeter, with small root curls and
> ripple motifs in the corners. One complete wide frame centered with generous
> transparent margin. Transparent background.

### Boss-HUD frame

> Create a compact long shallow Root Hydra boss HUD frame using Image 1 for the
> exact layout and transparency structure and Image 2 for the detailed
> high-resolution pixel-art style. Keep the left circular portrait opening,
> long central health-bar opening, and three phase sockets on the right.
> Decorate the slim frame with wet braided marsh roots, dark nipa-palm
> wedge-fruit plates, charcoal ACO metal, aged copper-brass, cyan nutrient
> channels, restrained orange fibers, ripple motifs, and sparse olive palm
> leaves. Text-free. One complete uncropped HUD asset. Transparent background.

### Phase markers

> Create exactly three matching circular phase-marker icons in one horizontal
> row. Icon 1: closed dark nipa-fruit cluster crown with four tiny intact
> head-wedge emblems around it. Icon 2: cracked crown with one cyan sealed stump
> and three orange-lit wedge emblems. Icon 3: peeled crown revealing the bright
> cyan conduit core, framed by two sealed stumps and two remaining dark wedge
> emblems. Each icon sits in the same compact charcoal-metal and aged
> copper-brass circular socket with small braided-root and ripple accents.
> Strong silhouettes readable at small HUD scale. Transparent background.

Every prompt prohibited words, labels, numbers, scenery, floor, projectiles,
watermarks, overlap, grid lines and cropped edges. Integration still requires a
1280 x 720 layout pass, logical downscale, nearest-neighbor imports, localized
label fitting, contrast checks and Windows/Web validation.
