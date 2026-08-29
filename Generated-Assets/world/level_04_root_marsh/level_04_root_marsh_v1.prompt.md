# Level 04 — Devouring Root Marsh World Source Record v1

Generated on 2026-08-29 with OpenAI ImageGen for the English-first bilingual
high-resolution pixel-art campaign. This package is a production source
candidate. Runtime parallax speeds, crops, tile slicing, collision masks,
mirrored variants, placement, texture budgets, and color grading remain for
integration review.

## Art and narrative contract

- Original, detailed, non-realistic high-resolution pixel art.
- The marsh combines northeastern Thai wetland infrastructure, nipa and salak
  growth, drowned field equipment, and an invasive alien nutrient network.
- Salak and nipa anatomy reinforces the canonical Thai-local-fruit enemy theme;
  roots and vines remain secondary connective tissue.
- The landmark must read as a biomass artery carrying harvested nutrients, not
  as a conventional machine or generic fantasy tree.
- Raster assets contain no baked English or Thai text.

## Accepted sources and hashes

| Asset | ImageGen source ID | Dimensions | SHA-256 |
|---|---|---:|---|
| `parallax/marsh_storm_horizon_far_v1.png` | `exec-ae6e1be2-ffd9-4406-9ea8-41a086041d82.png` | 1536 × 1024 | `54abbf1fe0bcda94a055004daf1712d11413a9e0dd7a2ee484a4f1cdbed9d5a0` |
| `parallax/marsh_reeds_nipa_far_v1.png` | `exec-0ce36c49-fd28-422e-bbf2-244c2a7a144b.png` | 2172 × 724 | `06823d41c1923c45763f16ffef6275c47063170965d6341059309c9b135d5ee3` |
| `parallax/marsh_nutrient_conduit_mid_v1.png` | `exec-56b847ff-43c4-4062-b12a-3f3f186491c9.png` | 2079 × 756 | `4ea1da438aea515a2d59de81ddca5a7067f1e9a7c9b0771f57c8b184df6b9394` |
| `parallax/marsh_root_buttresses_near_v1.png` | `exec-47c70d06-473e-4cb2-9840-6ef06c1c2494.png` | 1672 × 941 | `dc965ab1f8cc4a8664aeb05dc4fb4ccce52e40b3a11b647b0767bbefb24edd25` |
| `parallax/marsh_foreground_frame_v1.png` | `exec-d23fda45-1620-4121-b55c-45bdc638dd98.png` | 1672 × 941 | `2ec71d2d8ded207d9870dfb921d03ad1cc074f754530a8e283f1805c0c3b4f77` |
| `tiles/marsh_ground_straight_v1.png` | `exec-29629335-06ed-4acd-874d-6939cf857e9a.png` | 2079 × 756 | `ea4722f0202fedc6f7758f0f109c1e739a5b7d0222754ccdd0ef93f08444753d` |
| `tiles/marsh_ground_cap_left_v1.png` | `exec-423f521e-a05c-49a8-b082-26303b0731b7.png` | 1536 × 1024 | `1ffcc701c2c0f132ac257040ab226015d7ab7da5a94aac2d1cefa39dfc2362fd` |
| `tiles/marsh_platform_floating_v1.png` | `exec-a05e13cc-9baf-4862-908c-7176effd6de3.png` | 1536 × 1024 | `cc083f45241757e7d868eb7f0e974c52ae0aae9a12b15088450a8c6d730ecf8f` |
| `tiles/marsh_slope_up_v1.png` | `exec-3ae71480-0ae4-4fe0-a1c4-092eb32e6e57.png` | 1536 × 1024 | `e4953e396758bd275eac304f375a9d6ad153160051aade19446b59946529dcc5` |
| `tiles/marsh_corner_v1.png` | `exec-36b18797-87cb-4a9c-9dfe-e73aff7291e7.png` | 1286 × 1223 | `5896b36a38f4f384a83472b4316e5923d66f8935449fd688b0f6cf9692296661` |
| `tiles/marsh_ground_broken_v1.png` | `exec-bf05c892-bf8b-45f5-8dc3-7ff64e22af69.png` | 1774 × 887 | `fd31ff27711f4cbe151d400f309be6e928ef83c6bf070f19982dd26d0910db73` |
| `tiles/marsh_fruit_infestation_overlay_v1.png` | `exec-75fc3d27-6424-4859-9309-0fa87762e0c9.png` | 1536 × 1024 | `e3cf5b3deba32a0b2cd90d5c8089b87523951320769962cb49c78e1bd9526e2e` |
| `hazards/nutrient_root_eruption_v1.png` | `exec-f38ad2ef-ba9d-41da-8e56-e94fc0fdd23f.png` | 2172 × 724 | `04e03c9fddec593cc80064cb6844eed325c6d50a9a85c39fd86954717b9bc6ff` |
| `hazards/nutrient_root_eruption_normalized_v1.png` | derived from source above | 3200 × 800 | `de8487698952a18bae390ce60b25928755d56478dafbd08e8e1bfac8ec6c2d78` |
| `extraction/marsh_extraction_beacon_v1.png` | `exec-68101d15-71d0-4bbb-9536-4e80da944fb1.png` | 1536 × 1024 | `39dd690ce1a5b1737e6019e763debf4adc48aef87c128149478dcfc0d3822303` |
| `landmarks/root_nutrient_conduit_v1.png` | `exec-98453d08-f697-49c4-9f8c-edbb1cb3631f.png` | 1536 × 1024 | `899dbccd342446a3fdc1488612d659d8832def3316e846bed9aa1062662d941a` |

## Prompt-specific direction

### Parallax stack

The opaque storm horizon establishes the flooded wetland and toxic water. Four
alpha layers add distant nipa/reed islands, a mid-depth nutrient artery, near
mangrove buttresses, and a dark reed/root foreground frame. The central combat
window remains open across the stack.

### Gameplay tile kit

Individual cutouts provide straight root mat, left cap, floating raft, clean
up-slope, rotatable corner, broken/sinking ground, and a collision-free
salak/nipa infestation overlay. Right cap, down-slope, opposite corner, ceiling,
and wall orientations may be derived by deterministic runtime mirroring or
rotation after collision and lighting review; bitmap stretching is forbidden.

### Hazard, extraction, and landmark

The four-frame nutrient-root eruption progresses from a readable ground pulse
through bulge, dangerous full extension, and collapse. The stilted ACO beacon
provides a clear cyan mission endpoint. The Root Nutrient Conduit combines an
alien biomass artery with ruined irrigation gates and a traversable lower route.

## Processing and validation

The eruption strip was normalized with `tools/Normalize-GridSpriteStrip.ps1`
using four frames, `800 × 800` cells, bottom alignment, baseline 740, and alpha
threshold 1. The normalized file is `Format32bppArgb`; all three internal cell
boundary counts are zero. Every parallax overlay, tile, hazard, extraction prop,
and landmark contains true alpha; the storm horizon is the only intentional
opaque RGB layer. Visual QA covered the five depth layers and a full source
contact sheet. Runtime crop, parallax speed, collision seams, hazard timing,
Web texture memory, landmark placement, and 1280 × 720 combat readability remain.
