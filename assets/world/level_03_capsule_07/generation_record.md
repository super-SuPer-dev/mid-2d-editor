# Capsule 07 Parallax Pilot

**Asset ID:** WORLD-L3-CAPSULE-PARALLAX  
**State:** Integrated (pilot; human composition review pending)  
**Source package:** art_source/generated/world/level_03_capsule_07/parallax/

Five generated layers are wired through scenes/backgrounds/capsule_generated_parallax.tscn:
cavern far, shell ribs far, membranes mid, buttresses near and foreground frame.
Nearest filtering, independent scroll scales and aspect-preserving scales are
used; gameplay collision and mission logic are unchanged.

| Source file | Dimensions | SHA-256 |
|---|---:|---|
| capsule_cavern_far_v1.png | 1774 × 887 | 2912F51F260DD919B71B2372BDAFA3B5E9EA96314EF3049BD81D6D21F1A942A3 |
| capsule_shell_ribs_far_v1.png | 1672 × 941 | B5DEA45A6CB16DD63253BD318AB2CEC1B7D77B66E973CF0314777654340694FE |
| capsule_membranes_mid_v1.png | 1672 × 941 | 43521F7A6CD9EE0BAD08DFF84F1A112E143FB8A194322C3E45B17F323F425D6D |
| capsule_buttresses_near_v1.png | 1672 × 941 | D987F95FCBA282F112A727C41DD349DBDF61F007C893A7D322DA547CF3D247E0 |
| capsule_foreground_frame_v1.png | 1672 × 941 | 4B693A042C18C3C845F942CBA29AC5E622F25E461F54D20523C48ADBCD656DB2 |

Technical scene instantiation and campaign smoke coverage pass. Human pixel-art,
composition, memory and 1280 × 720 playtest approval remain before Verified.

The generated santol seed-piston strip is bound to every Level 3 hazard with a
four-frame 800 px-cell animation at 8 fps. Source SHA-256:
Source SHA-256: 599D1F0BE240FDCB7C2231C4688144D394895C6241388BB8FCF2102357E6BAC0.
Runtime binary-alpha SHA-256: 09882826C19C4AA1774BAC5C124D93F9CFD47F49BC85F31F554333C0B8F66FE3.

The generated Capsule 07 seed-harvester landmark (1224 × 1285) is placed behind
the midpoint/boss route at a 0.34 presentation scale and does not add collision.
Source SHA-256: 22F1BF022277E1BFAC734B0707F211EBFA30D9C3AEFE808D7008E86025920249.
Runtime binary-alpha SHA-256: 00490F82CD0AA83E43925DB7AC2D5605BC211C447194768AA95B3CA9108FB9A0.

## Tile variant promotion

Broken-ground, left-cap and uphill-slope visuals are promoted as three
presentation-only accents at z = -2. They use nearest filtering and do not
alter collision geometry.

| Variant | Source SHA-256 | Runtime SHA-256 |
|---|---|---|
| `capsule_ground_broken_v1.png` | `5932DE2DACD8D1B20C5814A998F644EBF572F14BF7643BE554874D030D38A76C` | `5932DE2DACD8D1B20C5814A998F644EBF572F14BF7643BE554874D030D38A76C` |
| `capsule_ground_cap_left_v1.png` | `1725E25BE8E7FA6DA2B4E78198A91B8F27C38200CBEE1D201810154F21D32D6C` | `1725E25BE8E7FA6DA2B4E78198A91B8F27C38200CBEE1D201810154F21D32D6C` |
| `capsule_slope_up_v1.png` | `4E847B90952966E9DA602A3488E61E551DDA5B960E022BF5B0996D2071510CBB` | `4E847B90952966E9DA602A3488E61E551DDA5B960E022BF5B0996D2071510CBB` |
