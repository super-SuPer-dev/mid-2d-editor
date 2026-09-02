# Alien Eye Nexus Parallax Pilot

**Asset ID:** WORLD-L5-NEXUS-PARALLAX  
**State:** Integrated (pilot; human composition review pending)  
**Source package:** art_source/generated/world/level_05_alien_eye_nexus/parallax/

Five generated layers are wired through scenes/backgrounds/nexus_generated_parallax.tscn:
impossible-depth far, neural lattice, longan-eye network, dragon bracts and
foreground frame. Nearest filtering, independent scroll scales and
aspect-preserving scales are used; gameplay collision and mission logic are
unchanged.

| Source file | Dimensions | SHA-256 |
|---|---:|---|
| nexus_impossible_depth_far_v2.png | 1536 × 1024 | E4DD0AB4F339ECA67CAC4DD39B5A2792CD661DCDB608AD01461E105934A95C6B |
| nexus_neural_lattice_far_v2.png | 1672 × 941 | ED92166873773B4679932E7CEEDFC3CC637D31B31FC584FEECA6224D2B7D7F5B |
| nexus_longan_eye_network_mid_v2.png | 1536 × 1024 | 700CA48041666B7114F1CCD8A78B29542CAB7F7EB233E282A73AC072B951E5CE |
| nexus_dragon_bracts_near_v2.png | 1672 × 941 | DA0ED2A35238D2E8CCA75ACFA6F131547E0F602F1D95A75CAD3B720FB0DB524D |
| nexus_foreground_frame_v2.png | 1536 × 1024 | 6A546405C1822284CD1E91A5E26004B1748D078BAA147F5187D77B82B49D04CA |

Technical scene instantiation and campaign smoke coverage pass. Human pixel-art,
composition, memory and 1280 × 720 playtest approval remain before Verified.

The generated sensory-platform collapse strip is bound to every Level 5 hazard
with a four-frame 800 px-cell animation at 8 fps. Source SHA-256:
77F6ECACEC166C96D6B655EF48F71385BFA70B47779DCD2B685CC87E48593FA8.
Runtime binary-alpha SHA-256: A08D373A9326437694D1FA004B67EF4EF8D0D4B9672BAAB79122224A45D5ADCF.

The generated awakened sensory nexus landmark (1536 × 1024) is placed behind
the Level 5 final arena at a 0.34 presentation scale and does not add collision.
Source SHA-256: 4B9750F3146A753D16FF5DADB8634A1A747193DB31657CB2B52C0B6AD0B5EAB5.
Runtime binary-alpha SHA-256: C94B1876BC8CA87B9AB733DD98DAC96A9B4DCAE25E64DE591011C5EB29CC8CCC.

## Tile variant promotion

Broken-ground, left-cap and uphill-slope visuals are promoted as three
presentation-only accents at z = -2. They use nearest filtering and do not
alter collision geometry.

| Variant | Source SHA-256 | Runtime SHA-256 |
|---|---|---|
| `nexus_ground_broken_v2.png` | `C087805C86BC7A48B3E74D41252F81B0A237AB8F85820D4149DE2A73147E357D` | `C087805C86BC7A48B3E74D41252F81B0A237AB8F85820D4149DE2A73147E357D` |
| `nexus_ground_cap_left_v2.png` | `817DE844FEA61454B79BD84575E280120074D8A18E714193A4B2734CCBB682E5` | `817DE844FEA61454B79BD84575E280120074D8A18E714193A4B2734CCBB682E5` |
| `nexus_slope_up_v2.png` | `2D29633E3F9880E1EF7BAFF6FF741925ABA59B37A42BA76B2926BFB435A1C950` | `2D29633E3F9880E1EF7BAFF6FF741925ABA59B37A42BA76B2926BFB435A1C950` |
