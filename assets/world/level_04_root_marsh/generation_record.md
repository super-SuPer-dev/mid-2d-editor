# Devouring Root Marsh Parallax Pilot

**Asset ID:** WORLD-L4-MARSH-PARALLAX  
**State:** Integrated (pilot; human composition review pending)  
**Source package:** art_source/generated/world/level_04_root_marsh/parallax/

Five generated layers are wired through scenes/backgrounds/marsh_generated_parallax.tscn:
storm horizon, nipa reeds, nutrient conduit, root buttresses and foreground
frame. Nearest filtering, independent scroll scales and aspect-preserving scales
are used; gameplay collision and mission logic are unchanged.

| Source file | Dimensions | SHA-256 |
|---|---:|---|
| marsh_storm_horizon_far_v2.png | 1536 × 1024 | 8424C6CE116B4665CC635A08CEC9008559E83F49DC33CD3BF58EB30D5E77B2F2 |
| marsh_reeds_nipa_far_v2.png | 2048 × 768 | CD8D171395FD0C89D1B5FBD6F67C1F85052738EDC2090E4A7B7D56CC821A07DE |
| marsh_nutrient_conduit_mid_v2.png | 2079 × 756 | 7B86FBC7142857A6EE48847C59D7497C16E9E32748FE99A2FFFC24849F30DBF6 |
| marsh_root_buttresses_near_v2.png | 2048 × 768 | A74AE4C01C749F07A95CADD9EB303C1320D7D375017B7FA6B3C6EC71D669D828 |
| marsh_foreground_frame_v2.png | 1672 × 941 | 02774A0DE4566EE0EE1F933BD02C8EAAB3F49CC2A3508C1D61C9DFBE586C0770 |

Technical scene instantiation and campaign smoke coverage pass. Human pixel-art,
composition, memory and 1280 × 720 playtest approval remain before Verified.

The generated nutrient-root eruption strip is bound to every Level 4 hazard
with a four-frame 800 px-cell animation at 8 fps. Source SHA-256:
D5614E7297FE548997181321F9AF734D6DB0C69F18762A451BEB1A6CD657D316.
Runtime binary-alpha SHA-256: B81146782D30498A90E4E8330651CFA6212A46F86E526C283540307C7CDD8F7A.

The generated nutrient-conduit landmark (1536 × 1024) is placed behind the
Level 4 boss arena at a 0.34 presentation scale and does not add collision.
Source SHA-256: AB567935B52D6FD910D1C557242CBCCDBF164EDC7EA6661BECFFCB3A18FA0E0D.
Runtime binary-alpha SHA-256: 1E3EBC84B23B53B506EEB122E18B9FE3AFD2AF75963ED3FE3D0B720A2AD0FCE2.

## Tile variant promotion

Broken-ground, left-cap and uphill-slope visuals are promoted as three
presentation-only accents at z = -2. They use nearest filtering and do not
alter collision geometry.

| Variant | Source SHA-256 | Runtime SHA-256 |
|---|---|---|
| `marsh_ground_broken_v2.png` | `F239D8EFDBCBD80B9BB7349953350B850DE9ADEAFB98D078596318510CAA7734` | `F239D8EFDBCBD80B9BB7349953350B850DE9ADEAFB98D078596318510CAA7734` |
| `marsh_ground_cap_left_v2.png` | `F9E4D05C4841CA78EA48A02C1C437583121E7D530D84B222EE56893D1B1C7B4F` | `F9E4D05C4841CA78EA48A02C1C437583121E7D530D84B222EE56893D1B1C7B4F` |
| `marsh_slope_up_v2.png` | `3C1DE0CE3E4FF8F0DA86FCBBFF8A6577CA8347FD9EB528CDDB985812488B8B09` | `3C1DE0CE3E4FF8F0DA86FCBBFF8A6577CA8347FD9EB528CDDB985812488B8B09` |
