# Art direction

English is the default shipping interface language; Thai is a complete optional
selection. All native Godot controls use the shared font stack with complete
Latin and Thai glyph coverage. No runtime image contains baked UI text.

Campaign environments use four native `Parallax2D` planes: sky, distant
horizon, middle vegetation, and transparent foreground. The reusable scenes
live under `Scenes/backgrounds/`; layer textures and scroll scales are editable
directly in the Inspector.

The `art_source/references/` boards define the production target. The generated five-biome
campaign anchor is stored at
`art_source/references/generated_campaign_style_anchor.png`; its prompt and provenance are
recorded beside it. It is a source reference only and must never be imported as
a runtime background. The game should feel like
a grounded Thai rural survival story disrupted by alien biology—not a clean
space-station adventure.

## Reference hierarchy

Hollow Knight and Castlevania are the primary references for silhouette
clarity, atmospheric depth, dramatic monster staging, readable combat spaces
and strong landmark progression. Hollow Knight informs restraint, clean combat
readability and layered mood; Castlevania informs deliberate architecture,
monster composition and biome escalation. These qualities are translated into
high-resolution pixel art, northeastern Thai rural environments and ACO field
technology rather than copied visual motifs.

Touhou is a secondary gameplay reference for selected projectile formations
only. It does not set the general art style, UI language or normal encounter
density. Do not copy or trace reference maps, characters, silhouettes, UI,
icons, animation poses, music imagery or exact projectile arrangements.

## Core statement

**Thai field equipment versus invasive alien plant life.** Familiar soil,
grass, workwear, farm tools, and local character archetypes carry the human
side. Toxic green tissue, purple roots, luminous spores, and the fallen seed
capsule carry the alien side.

## Visual medium

The entire game uses **high-resolution pixel art**. “High-resolution” means
larger canvases, more deliberate animation detail, and richer environments—not
realistic rendering. Every raster asset must still read as authored pixel art:

- Visible, consistently sized square pixel clusters and stepped contours
- Hard-edged alpha with no white matte, fringe, or semi-transparent paint haze
- Limited color ramps with selective highlights rather than smooth gradients
- Integer nearest-neighbor scaling for sprites, tiles, portraits, and pixel UI
- Simplified anatomy, faces, foliage, materials, and lighting
- Stable sprite pivots and foot baselines across every animation frame

The following are outside the art direction: photorealism, realistic skin
texture, painterly concept-art brushwork, soft airbrushing, vector-smooth
characters, 3D renders, PBR materials, cinematic depth of field, and generated
images that only imitate pixels with a noisy texture overlay.

For isolated generated sprites, prompts should stay concise: identify the
subject, facing direction, gameplay scale, reference role, pose, no baked text,
and `Transparent background.` Do not describe checkerboards or transparency
failure modes in the generation prompt; technical alpha, matte and edge checks
belong in post-generation validation.

Every source file declares its logical pixel canvas. A typical portrait may be
authored at 256 × 256 logical pixels and displayed at an integer multiple; a
gameplay sprite uses the smallest grid that preserves silhouette and attack
readability. Final dimensions are asset-specific and recorded in the asset
register.

## Palette

- UI charcoal: `#0C100E`
- Panel green-black: `#151A16`
- Parchment text: `#DED8C2`
- Aged gold: `#CAA85E`
- Field olive: `#91BD45`
- Soil brown: `#42372A`
- Alien purple: `#A75BA9`
- Ranger blue: `#5F91BD`

Avoid large fields of saturated cyan and pristine sci-fi blue. Cyan may appear
only on small screens, instruments, or rare alien effects.

## Shapes and texture

- Characters use stocky, readable silhouettes, workwear layers, backpacks,
  gloves, caps, cloth, and practical equipment.
- Tonkla's grass cutter must read in idle and attack poses: red engine pack,
  long metal shaft, circular blade, green cutting arc.
- Plant enemies combine recognizable tropical plants with teeth, roots,
  thorns, spores, and asymmetrical mutation.
- Terrain is layered grass over dark soil with distant hills, tall grass,
  forest trunks, hanging roots, haze, and occasional ACO equipment.
- Pixel assets use deliberate clusters, stepped curves, and restrained
  highlights. Do not use smooth vector gradients or continuous painted shading.

## Thai fruit enemy language

Thai local fruit is the mandatory primary motif for every organic enemy and
boss. Designs translate recognizable
fruit structures into hostile anatomy: rind becomes armor, calyx becomes jaws
or crowns, seeds become eyes and projectiles, fibrous flesh becomes muscle,
sap becomes area denial, and fruit clusters become multi-origin attack nodes.
The result remains alien horror/action pixel art, not a cute fruit mascot.

| Campaign use | Primary fruit reads |
|---|---|
| Level 1 | Rambutan hair-thorns; makrut-lime dimpled spitter sacs |
| Level 2 | Young-mangosteen shell jaws; durian crown and armored boss rind |
| Level 3 | Santol segmented husk; jackfruit fibers and seed columns |
| Level 4 | Salak scale armor; nipa-palm cluster heads |
| Level 5 | Longan seed eyes; dragon-fruit bracts around the final core |

Use one dominant fruit identity per standard family. Bosses may combine one
secondary fruit only when the primary read remains obvious. Do not create
families by recoloring the same round fruit body. Preserve distinct height,
width, locomotion, facing direction, attack reach and weak-point placement.
Fruit colors are starting references rather than strict palettes; gameplay
contrast and biome separation take priority.

Each concept sheet names one primary fruit, labels at least three structural
translations, and identifies the one that drives gameplay. A concept fails the
art gate if removing its color makes the fruit identity disappear, or if its
body is a reused round silhouette with different surface decoration.

## UI language

Use dense military field-journal panels with square corners, fine borders,
aged-gold headings, olive selection states, compact stat blocks, and strong
hierarchy. Interfaces may be information-rich, but primary actions must remain
obvious at the native 1280 × 720 presentation size.

Preferred labels include `FIELD MAP`, `FIELD OPERATOR`, `BASE WORKSHOP`,
`ALIEN SAMPLES`, `THREATS`, `EXTRACT`, and `CUTTER`.

## Character roster

1. Tonkla — balanced ACO field operator and primary mower specialist.
2. Rin — mobile special-forces ranger.
3. Khem — durable Isan volunteer with strong wide attacks.
4. T-800 — slow synthetic exterminator with high endurance.

## Campaign environments

1. Contaminated Grassland — daylight, distant mountains, tall grass, fallen
   seed traces, muted military presence.
2. Mutated Forest — deep green canopy, spores, damp wood, glowing plant tissue.
3. Alien Root Cave — dark soil and stone, purple infection, massive root forms,
   possessed banyan heart.

## Runtime placeholders

Current polygons deliberately approximate these silhouettes and palettes.
They are layout and gameplay stand-ins. Do not rasterize or crop the reference
boards into the game. Replace placeholder visual nodes using the contracts in
`ASSET_REPLACEMENT.md`. Generated assets remain provisional until their pixel
grid, alpha, palette, runtime filtering, and in-game scale pass visual review.
