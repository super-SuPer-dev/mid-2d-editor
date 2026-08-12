# Art direction

The shipping interface language is Thai. All native Godot controls use
`Assets/RD CHULAJARUEK.ttf` through the shared global theme.

The `art_refs/` boards define the production target. The game should feel like
a grounded Thai rural survival story disrupted by alien biology—not a clean
space-station adventure.

## Core statement

**Thai field equipment versus invasive alien plant life.** Familiar soil,
grass, workwear, farm tools, and local character archetypes carry the human
side. Toxic green tissue, purple roots, luminous spores, and the fallen seed
capsule carry the alien side.

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
- Pixel assets should favor deliberate clusters and restrained highlights over
  smooth vector gradients.

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
`ASSET_REPLACEMENT.md`.
