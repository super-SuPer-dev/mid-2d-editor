# ENEMY-EYE-WISP longan animation source set v1

**State:** Review (not integrated)

**Generation mode:** Built-in image generation

**Fruit identity:** Longan / ลำไย

**Visual source:** Detailed first-version Eye Wisp plus the five-biome campaign
anchor

The redesign preserves the approved lightweight floating eye silhouette while
making longan anatomy explicit. Translucent pale flesh forms the eye, a glossy
black seed becomes the pupil, broken tan rind forms eyelids, and a woody fruit
stem carries neural tendrils and two unopened longan pods.

## Animation contract

| Action | Frames | Loop | Runtime intent |
|---|---:|---|---|
| Hover | 4 | Yes | Quiet aerial idle and restrained pupil glint |
| Fly | 4 | Yes | Forward tilt with trailing tendrils |
| Aim tell | 4 | No | Rind opens, pupil tracks and energy organ charges |
| Seed-bolt attack | 4 | No | Pupil contraction, firing recoil and recovery |
| Beam attack | 4 | No | Focused aperture, attached firing flare and recoil |
| Hurt | 4 | No | Aerial compression, curled tendrils and recovery |
| Death | 4 | No | Glint loss, descent, rind closure and inert husk |

Raw built-in outputs are retained as `eye_wisp_*_strip_v1.png`. Normalized
review strips use a strict 4 columns x 1 row grid at 2800 x 800 pixels:

- Cell size: 700 x 800 pixels
- Horizontal pivot guide: x = 350 within each cell
- Lower visual-extent guide: y = 740 within each cell
- Solid-alpha threshold: 128
- Output: 32-bit RGBA PNG with transparent corners
- No rescaling or interpolation during normalization

The shared lower-extent guide keeps every pose inside a predictable runtime
cell while retaining the generated tendril motion. Runtime animation should
use a stable body-centered pivot near the seed-eye rather than treating y=740
as a ground contact. The final death frames deliberately descend and rest low.

## Validation hashes

| Candidate | SHA-256 |
|---|---|
| `eye_wisp_longan_anchor_v1.png` | `EC00415848765C1DED38E16CDA68FE44A69BB01B1E78B7037A840E388CB973ED` |
| `eye_wisp_hover_strip_normalized_v1.png` | `513418BB4F153F4537DA02378C344C25689489741FD4685923067F0EB4CDA7FC` |
| `eye_wisp_fly_strip_normalized_v1.png` | `1DB2D8002EB808CD4CF3D18008776B287FAB094E15C26E5C108D084A88EA4D5B` |
| `eye_wisp_aim_tell_strip_normalized_v1.png` | `D9AC4B42B3AAA93094AA2BC75139D0573273CCDA3F86B03068A7047ED5E4EE9E` |
| `eye_wisp_seed_bolt_strip_normalized_v1.png` | `64E71F0575756B14981C022C6319C1F23C7279FC5E4CDFAED2ED01BFB2E87FED` |
| `eye_wisp_beam_attack_strip_normalized_v1.png` | `905DD1438783D932035D7D14E85C0675A273D40D1EEFECC06D2908F5EFA07E8B` |
| `eye_wisp_hurt_strip_normalized_v1.png` | `8927BA068657BF5734D39A3F4591D69B9B0D8BEBF29FD5E2AD7CCFA88D282D8E` |
| `eye_wisp_death_strip_normalized_v1.png` | `46768AAB0AD8D3DB4148AA11FD4546A8446152B6745B49907808E2ECEFC78DC1` |

All normalized strips are 2800 x 800, `Format32bppArgb`, with corner alpha
`0,0,0,0`. All detected poses fit the 700-pixel cell contract; the tallest is
the 559-pixel final aim-tell frame. Visual review covered every action and
confirmed that no neighboring poses contaminate a cell. Runtime integration
still needs logical downscale review, nearest-neighbor import settings,
body-centered pivot testing, playback timing, aerial steering, and attack
timing. Detached seed-bolt, impact and sustained-beam art remains in the shared
projectile/VFX production pass.

## Built-in source provenance

| Asset | Preserved built-in output |
|---|---|
| Longan design anchor | `exec-a0b1f84b-7c7a-4647-8746-d41d4cbe56f7.png` |
| Hover | `exec-05744db8-82b9-42ca-bda6-ebc97fbbc8db.png` |
| Fly | `exec-93e2c111-505e-4ce8-a655-1cebb771e03f.png` |
| Aim tell | `exec-cb7ef065-138b-4df6-896c-eb94da30c932.png` |
| Seed-bolt attack | `exec-cf7fcf2d-9dde-4c8a-a322-9af6b007d0d3.png` |
| Beam attack | `exec-b9318c1e-7dc1-4c14-bfcf-bf5fed021128.png` |
| Hurt | `exec-6f2606f6-54a8-40c7-b0ce-2d23388e72d0.png` |
| Death | `exec-abf224e7-6c6b-4148-b6bf-3f504fdb7dad.png` |

## Prompts

### Longan design anchor

> Redesign the Eye Wisp as a Thai longan-fruit mutation for a high-resolution
> pixel-art side-scrolling action-platformer. Preserve the eerie lightweight
> floating side-view silhouette, crisp pixel density, outline weight,
> upper-left lighting, large horizontal eye, trailing neural-root tendrils,
> and compact energy organ. Make longan identity immediately readable: a
> peeled pale translucent longan flesh orb forms the eye, its glossy black seed
> becomes the pupil, broken tan-brown longan rind segments form eyelids and
> armor, and a short woody cluster stem anchors five thin tendrils with two
> small unopened longan pods. Use near-black plum, violet, magenta and pale cyan
> only as alien accents. It faces right and remains a small ranged standard
> enemy, clearly simpler than the final eye boss. One neutral hover pose. No
> projectile, text, or numbers.
>
> Transparent background.

### Hover

> Create a four-frame horizontal hover-idle animation. Keep the same peeled
> pale longan flesh eye, glossy black seed pupil, tan-brown rind eyelids, woody
> cluster stem, five neural tendrils, two unopened longan pods, magenta energy
> organ, side view facing right, scale, pixel density, palette, and lighting.
> Animate a seamless quiet hover: neutral float, tendrils drift upward, body
> reaches a gentle high point with a restrained pupil glint, then returns
> toward neutral.
>
> Exactly four equal cells in one horizontal row, one complete creature per
> cell, fixed camera scale and center flight line, no overlap, no text or grid
> lines.
>
> Transparent background.

### Fly

> Create a four-frame horizontal flight animation. Keep the same longan design,
> colors, side view facing right, scale, pixel density, and lighting. Animate
> deliberate forward aerial movement: tendrils stream backward, rind eyelids
> narrow against motion, the body tilts forward, then rebounds into a passing
> pose. Keep the central eye and both longan pods readable in every frame.
>
> Exactly four equal cells in one horizontal row, one complete creature per
> cell, fixed camera scale and center flight line, no overlap, no text or grid
> lines.
>
> Transparent background.

### Aim tell

> Create a four-frame horizontal ranged-attack anticipation animation. Keep the
> same longan design, colors, side view facing right, scale, pixel density, and
> lighting. Animate a clear non-damaging aerial tell: neutral hover, tendrils
> spread and brace, rind eyelids open wider while the glossy seed pupil tracks
> forward, then the magenta organ and pale-cyan pupil rim reach a bright held
> charge. Do not fire a projectile or beam.
>
> Exactly four equal cells in one horizontal row, one complete creature per
> cell, fixed camera scale and center flight line, no overlap, no text or grid
> lines.
>
> Transparent background.

### Seed-bolt attack

> Create a four-frame horizontal seed-bolt attack animation. Keep the same
> longan design, colors, side view facing right, scale, pixel density, and
> lighting. Animate the glossy black seed pupil contracting, the eye and lower
> organ pulsing forward, a sharp firing recoil, then recovery toward hover. The
> firing moment must be obvious, but do not draw a detached projectile; it
> will be a separate asset.
>
> Exactly four equal cells in one horizontal row, one complete creature per
> cell, fixed camera scale and center flight line, no overlap, no text or grid
> lines.
>
> Transparent background.

### Beam attack

> Create a four-frame horizontal beam-attack animation. Keep the same longan
> design, colors, side view facing right, scale, pixel density, and lighting.
> Animate rind eyelids clamping into a focused aperture, the glossy seed pupil
> narrowing to a bright horizontal slit, an intense pale-cyan firing flare
> attached to the front eye rim, then recoil with the organ dimming. Do not
> draw a long detached beam; it will be a separate runtime VFX asset.
>
> Exactly four equal cells in one horizontal row, one complete creature per
> cell, fixed camera scale and center flight line, no overlap, no text or grid
> lines.
>
> Transparent background.

### Hurt

> Create a four-frame horizontal hurt animation. Keep the same longan design,
> colors, side view facing right, scale, pixel density, and lighting. Animate a
> short aerial hit reaction: rind eyelids snap inward, pale flesh compresses
> while the glossy seed pupil and lower organ dim, tendrils recoil and curl,
> then the creature regains its hover posture. No hit effect or projectile.
>
> Exactly four equal cells in one horizontal row, one complete creature per
> cell, fixed camera scale and center flight line, no overlap, no text or grid
> lines.
>
> Transparent background.

### Death

> Create a four-frame horizontal death animation. Keep the same longan design,
> colors, side view facing right, scale, pixel density, and lighting. Animate a
> non-gory defeat: the pupil loses its glint and tendrils fail, the body tilts
> and descends as rind eyelids close, the pale flesh shrivels while the lower
> organ goes dark, then a final inert closed longan husk with slack roots rests
> low in the frame.
>
> Exactly four equal cells in one horizontal row, one complete creature per
> cell, fixed camera scale, no overlap, no text or grid lines.
>
> Transparent background.
