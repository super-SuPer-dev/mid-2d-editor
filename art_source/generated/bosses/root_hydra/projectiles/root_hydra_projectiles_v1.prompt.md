# BOSS-ROOT-HYDRA projectile, telegraph and impact source set v1

**State:** Review (not integrated)

**Fruit identity:** Nipa-palm fruit cluster / พวงลูกจาก

**Grid contract:** Seven detached assets, each a four-frame horizontal strip
normalized to 3200 x 800 with four 800 x 800 cells. Projectile/VFX strips are
centered; the water-lane eruption and beam impact use baseline 760.

## Pattern contract

| Runtime role | Asset | Shape/readability rule |
|---|---|---|
| Alternating head crossfire | `nipa_wedge_bolt` | Fast copper-orange wedge with cyan seam |
| Offset radial rings | `nutrient_ring_orb` | Round cyan orb with triangular nipa-scale notch |
| Crossfire timing | `crossfire_muzzle_vfx` | Orange fan ramps to cyan-white release star |
| Ring spawn timing | `radial_ring_telegraph` | Open-center cyan circle with four dark nodes |
| Moving lane wall | `water_lane_eruption` | Floor-anchored ripple-to-column sequence |
| Exposed-core shot | `core_beam_segment` | Narrow cyan lance with orange double helix |
| Beam collision feedback | `core_beam_impact` | Centered cyan splash with orange fiber arcs |

The asset set defines visual language only. Runtime pattern data must still
enforce projectile caps, deterministic safe routes, cleanup on phase/death/retry
and contrast against the Level 4 background.

## Validation hashes and provenance

| Normalized asset | Built-in source | SHA-256 |
|---|---|---|
| `root_hydra_nipa_wedge_bolt_normalized_v1.png` | `exec-d364ec23-f2df-45e5-bcc2-5efd0bdfb275.png` | `4193108FFF5065A58BA471D730FDEB474408A7FD785005B63D4FF880679926B7` |
| `root_hydra_nutrient_ring_orb_normalized_v1.png` | `exec-1e70b263-fa46-4197-889a-9a5c00542492.png` | `CC1052E028EE0C6C59EF699F14227E8D9B7E8170BDFF8C21F16AF4908A263F00` |
| `root_hydra_crossfire_muzzle_vfx_normalized_v1.png` | `exec-82ab37f6-5707-4018-804b-559fbdcc6576.png` | `8BE923D3EA8E137DD7E351AF43C81D4190632B22BA7F792D72F8EBACC0EA7CD0` |
| `root_hydra_radial_ring_telegraph_normalized_v1.png` | `exec-98fc2931-a6b2-4f6c-87bf-993f43c07caa.png` | `3377E372FF1AA8DB9B70B6D5E5561DB901DB37F9E551345D30CFC957E3CA1627` |
| `root_hydra_water_lane_eruption_normalized_v1.png` | `exec-61e2a723-00d7-4175-a310-bae9fe8f5351.png` | `5B4C3A08D9AD471CBA41761295C36BCE00CC9E14E80CCBD2A207A130E73B5354` |
| `root_hydra_core_beam_segment_normalized_v1.png` | `exec-ba6c5949-b66c-4d36-9228-fe0681d3f907.png` | `297C1ED2051572B278B81F310BBECABB55F0FFAB0731BE54F500136B85038B75` |
| `root_hydra_core_beam_impact_normalized_v1.png` | `exec-34955b01-ee8b-49a8-a80d-54ca9c696210.png` | `DCD13F0D19955BED7296C21CA529BC46A141E564F4623DC7A6D18EA52C78ABBA` |

All normalized outputs have true-alpha corner pixels. Visual review confirmed
distinct wedge/circle/lane/beam silhouettes, readable telegraph ramps and no
neighboring-frame fragments. Two attempted tall looping water-wall outputs
retained an opaque matte and were rejected; the accepted floor-anchored
eruption strip supplies the lane-wall visual states without those sources.

## Prompts

Every prompt used the normalized Root Hydra fruit-identity strip only as its
authoritative material/palette reference and ended with
`Transparent background.`

### Nipa wedge bolt

> Create one compact fast crossfire projectile made from an armored dark-umber
> nipa-palm fruit wedge. It has a sharp copper-orange fibrous point, a thin cyan
> nutrient-energy seam, and a short readable trailing spark. Four sequential
> travel frames in one horizontal row: compressed launch, full-speed wedge,
> slight spin, fading trail. Strong diamond/wedge silhouette for Touhou-style
> multi-origin crossfire, readable at small gameplay scale, detailed
> high-resolution original pixel art.

### Nutrient ring orb

> Create one small round nutrient-droplet projectile for offset radial rings. A
> bright cyan liquid core is wrapped by three tiny dark nipa-fruit wedge scales
> and a thin copper-orange rim. Four looping travel frames in one horizontal
> row: tight orb, cyan pulse expands, wedge scales rotate, pulse contracts.
> Strong circular silhouette with a small triangular notch so it is visually
> distinct from the crossfire wedge, readable in dense Touhou-style patterns.

### Crossfire muzzle VFX

> Create one compact four-frame muzzle effect that attaches to any Root Hydra
> head before and during crossfire. Frame 1 faint orange fibrous fan; frame 2
> brighter fan with cyan center point; frame 3 sharp orange-cyan starburst at
> projectile release; frame 4 short fading fiber sparks. Detailed
> high-resolution original pixel art with a clean readable timing ramp.

### Radial-ring telegraph

> Create a four-frame circular telegraph for an offset radial bullet ring. Frame
> 1 a faint thin cyan circle with four tiny dark nipa-wedge nodes; frame 2 the
> circle brightens and eight orange fiber ticks appear; frame 3 a sharp
> cyan-orange pulse shows the exact spawn circumference while leaving the center
> open; frame 4 the ring collapses into four fading sparks. Clean radial
> symmetry, safe center clearly visible.

### Water-lane eruption

> Create a four-frame ground telegraph for a moving vertical marsh-water wall.
> It is a low horizontal warning strip anchored to the floor: frame 1 faint cyan
> ripples and one dark nipa wedge; frame 2 brighter ripples spread left-right
> with orange fiber ticks; frame 3 a sharp cyan center line and upward-pointing
> orange spray marks indicate the exact wall lane; frame 4 holds at maximum
> warning brightness immediately before eruption.

### Core-beam segment

> Create a compact horizontal conduit-beam segment fired by the exposed core.
> It is a bright cyan spear-shaped energy body wrapped by two thin rotating
> copper-orange fibers and a few dark nipa-scale fragments near its leading tip.
> Four sequential travel frames in one horizontal row: narrow ignition lance,
> full bright beam segment, fiber rotation variant, dim trailing variant. Keep a
> consistent narrow collision silhouette and screen-left direction.

### Core-beam impact

> Create a four-frame impact animation for the exposed-core beam striking a
> surface. Frame 1 compact cyan point; frame 2 sharp cyan splash with two orange
> fiber arcs; frame 3 widest starburst with a few tiny dark nipa-scale flecks;
> frame 4 shrinking droplets and fading orange threads. Non-gory, strong center
> anchor.

All prompts also prohibited boss bodies, scenery, floor tiles, UI, text,
watermarks, grid lines, overlap and cropped glow. Integration must use the
runtime hitbox rather than visible alpha bounds.
