# BOSS-MAW-SOVEREIGN animation source set v1

**State:** Review (not integrated)

**Generation mode:** Built-in image generation

**Fruit identity:** Durian crown + mangosteen anatomy / มงกุฎทุเรียน + กายมังคุด

**Authoritative visual source:** The true-alpha armored idle strip. Early
standalone concept attempts retained the detailed design but also retained an
opaque backdrop, so they were rejected and are not packaged. All production
review strips below have genuine alpha.

The boss expands the standard Maw into a mobile royal mutation. Green-gold
durian rind protects Phase 1, thick white mangosteen flesh forms the jaw and
Phase 2 bloom, and a glossy dark seed becomes the exposed weak point. Six root
legs, hanging spore sacs and a calyx tail support its forest-arena identity.

## Animation contract

| Action | Frames | Loop | Runtime intent |
|---|---:|---|---|
| Armored idle | 4 | Yes | Heavy breathing, crown lift and spore pulse |
| Move | 4 | Yes | Alternating six-root scuttle |
| Bite tell | 4 | No | Braced, non-damaging jaw wind-up |
| Bite attack | 4 | No | Launch, snap, damaging hold and recoil |
| Spore cast | 4 | No | Attached sacs swell before upward rain release |
| Phase break | 4 | No | Durian armor opens into the mangosteen bloom |
| Exposed idle | 4 | Yes | Stable open bloom with visible seed |
| Rotating volley cast | 4 | No | Five firing nodes and clockwise crown twist |
| Aimed volley cast | 4 | No | Seed tracks lower-right target and iris narrows |
| Summon cast | 4 | No | Root-downward pulse for the half-health summon |
| Hurt | 4 | No | Seed dim, uneven petal fold and root recovery |
| Death | 4 | No | Progressive wilt to a low inert fruit-root pile |

Raw built-in outputs are retained as `maw_sovereign_*_strip_v1.png`.
Normalized review strips use a strict 4 columns x 1 row grid at 3600 x 900:

- Cell size: 900 x 900 pixels
- Pivot guide: x = 450 within each cell
- Ground baseline: y = 840 within each cell
- Solid-alpha threshold: 128
- Output: 32-bit RGBA PNG with transparent corners
- No rescaling or interpolation during normalization

The final bite strip was regenerated with explicit transparent gutters after
visual QA rejected a first attempt whose long poses crossed cell boundaries.
The accepted strip uses connected-component isolation like the other actions.

## Validation hashes

| Candidate | SHA-256 |
|---|---|
| `maw_sovereign_idle_armored_strip_normalized_v1.png` | `9485D560AC45350BE3E784CF652923B737067405487A5F323AE26F18BB60172F` |
| `maw_sovereign_move_strip_normalized_v1.png` | `0615B7EC2E7C567B19B592420C2DC3D09A2B1CFFD386581416E2E6CD9D63CBAD` |
| `maw_sovereign_bite_tell_strip_normalized_v1.png` | `F38BF026DCE1A595FEA93A257A0802609B70108B698548C5820BA42E33170B9A` |
| `maw_sovereign_bite_attack_strip_normalized_v1.png` | `483EEC24174F202624946A9A83AEC441E1ADFB6AF1B884EF90E0BE0479DAB2C2` |
| `maw_sovereign_spore_cast_strip_normalized_v1.png` | `705E0604298104ADFB8EA268ADD616BB984FABD0DA491FC583278D2F0F4937A2` |
| `maw_sovereign_phase_break_strip_normalized_v1.png` | `E1A7FD56BF8950BA63CA894B2ED9E5A6AC6A6B8439D8AD4B5F9AC89B76ED9F80` |
| `maw_sovereign_idle_exposed_strip_normalized_v1.png` | `A21E83F8E1889BA2CF607849DED5E7626BEEC740273E2671879763A6A165531C` |
| `maw_sovereign_rotating_volley_cast_strip_normalized_v1.png` | `5DE2FA4D80EABAC37C8C3032D9F6EF05A65FF280A165F218E5F98DC490EDB832` |
| `maw_sovereign_aimed_volley_cast_strip_normalized_v1.png` | `8CC81C173C3030944E8997ED1D183E41A3806B68B8FDDC8BAEC1E3B185B7ACED` |
| `maw_sovereign_summon_cast_strip_normalized_v1.png` | `8EFCDA8E2EC9B99C9B7414CD09902470AF69503580F0E8E502990D39D14E1AB5` |
| `maw_sovereign_hurt_strip_normalized_v1.png` | `31103DCF52492F7C09DCA2D10882102CE2FF549C2F7B4E99145233244FD87149` |
| `maw_sovereign_death_strip_normalized_v1.png` | `814D4035A899FBFE472F99105C29A30F25518D4B5152E2C63811239AF709607F` |

Every normalized strip is 3600 x 900, `Format32bppArgb`, with transparent
corner pixels. Visual review confirmed isolated poses, shared baseline,
readable armored/exposed phases, distinct radial/aimed/summon casts and a
progressively lower death sequence. Runtime integration, logical downscale,
nearest-neighbor import, timing, hitboxes and projectile packages remain.

## Built-in source provenance

| Asset | Preserved built-in output |
|---|---|
| Armored idle | `exec-54702780-da9b-4083-a473-e516f40ccf61.png` |
| Move | `exec-41c6bf4e-3a5d-45e7-8692-6d9bbbe9e92f.png` |
| Bite tell | `exec-a770c0b5-f871-4a92-9936-73c1c5bb394b.png` |
| Bite attack, accepted retry | `exec-8e675bff-3d33-4f83-97bf-d3cb39ab1920.png` |
| Spore cast | `exec-9e574bf6-7f02-4e69-9e5a-2d8a925435d4.png` |
| Phase break | `exec-f385c0c7-74d0-47bd-a232-11f7ef67e1c8.png` |
| Exposed idle | `exec-85d2e835-889b-46ea-862c-39f0a5451635.png` |
| Rotating volley cast | `exec-465b2d03-0277-4e03-bf52-132aa3b14371.png` |
| Aimed volley cast, accepted retry | `exec-2f1e3395-a2be-4744-83f3-d2c50a0973ef.png` |
| Summon cast | `exec-5440eccc-9454-4ff8-bfd2-d790a584c458.png` |
| Hurt | `exec-55b2fb25-03ef-4e38-8c40-cc8c3c2b01a2.png` |
| Death | `exec-e24e211e-d794-463a-821a-fc8893ea6b97.png` |

## Prompts

### Armored idle

> Create a four-frame horizontal Phase 1 idle animation. Keep the same durian-
> crown and mangosteen body, six root legs, giant white-flesh jaw, violet core,
> spore sacs, calyx tail, scale, pixel detail, palette, and upper-left lighting.
> Animate a heavy breathing loop: neutral armored stance, root legs flex,
> durian crown rises slightly, spore sacs and violet core pulse, then return
> toward neutral. Face right in every frame.
>
> Exactly four equal cells in one horizontal row, one complete boss per cell,
> fixed camera scale and ground baseline, generous separation, no overlap, no
> text or grid lines.
>
> Transparent background.

### Move

> Create a four-frame horizontal heavy scuttle animation. Preserve the same
> durian crown, purple mangosteen body, white-flesh jaw, six root legs, spore
> sacs, calyx tail, violet core, scale, pixel detail, palette, and lighting.
> Animate alternating root-leg contacts as the boss advances to the right; the
> crown and jaw bob with weight while the body remains low. No attack,
> projectile, or detached effect.
>
> Exactly four equal cells in one horizontal row, one complete boss per cell,
> fixed camera scale and ground baseline, generous separation, no overlap, no
> text or grid lines.
>
> Transparent background.

### Bite tell

> Create a four-frame horizontal bite-attack anticipation animation. Preserve
> the same design, scale, pixel detail, palette, lighting, side view, and
> right-facing orientation. Animate a clearly non-damaging tell: neutral
> stance, six root legs brace and body leans backward, durian crown lifts while
> the white mangosteen jaw petals spread, then a final held wide-open pose with
> the violet core bright. Do not show the forward bite or any detached effect.
>
> Exactly four equal cells in one horizontal row, one complete boss per cell,
> fixed camera scale and ground baseline, generous separation, no overlap, no
> text or grid lines.
>
> Transparent background.

### Bite attack

> Create a four-frame horizontal bite-attack animation for this armored Maw
> Bloom Sovereign. Animate: low launch, forward jaw snap, closed damaging hold,
> recoil. Keep the complete boss compact inside each quarter of the strip;
> shorten the forward travel rather than crossing a cell edge. Leave a wide
> transparent gap between every pose. Preserve the same design, detail, scale,
> colors, lighting, and ground baseline. No effects, projectiles, floor,
> scenery, or text.
>
> Exactly four equal cells in one horizontal row, one complete separated boss
> per cell.
>
> Transparent background.

### Spore cast

> Create a four-frame horizontal spore-rain casting animation. Preserve the
> same design, scale, side view, pixel detail, palette, and lighting. Animate
> the six root legs planting firmly, hanging purple spore sacs swelling and
> glowing toxic lime, the broad calyx tail and durian crown lifting as sacs aim
> upward, then a strong release recoil. Keep all spores and sacs attached
> during this body animation; do not draw detached rain, projectiles, clouds,
> or impact effects.
>
> Exactly four equal cells in one horizontal row, one complete boss per cell,
> fixed camera scale and ground baseline, generous separation, no overlap, no
> text or grid lines.
>
> Transparent background.

### Phase break

> Create a four-frame horizontal Phase 1-to-Phase 2 armor-break transition.
> Preserve the same boss identity, scale, root legs, mangosteen body, white
> flesh, durian crown, spore sacs, pixel detail, palette, and lighting. Animate
> the green-gold durian crown cracking along violet seams, rind plates peeling
> upward into a radial spiked bloom, thick white mangosteen flesh opening
> around a glossy dark seed core, then a stable exposed royal-flower form. Keep
> the boss grounded and the final open form clear. No detached debris,
> projectiles, hit flashes, text, or scenery.
>
> Exactly four equal cells in one horizontal row, one complete boss per cell,
> fixed camera scale and ground baseline, generous separation, no overlap, no
> text or grid lines.
>
> Transparent background.

### Exposed idle

> Create a four-frame horizontal exposed-bloom idle animation. Preserve the
> final radial durian rind petals, thick white mangosteen flesh ring, glossy
> dark seed core, six root legs, purple body, spore sacs, scale, detailed pixel
> art, palette, and lighting. Keep the bloom fully open and the dark seed
> visible in every frame. Animate a tense loop: open neutral, white flesh
> flexes, seed and spore sacs pulse while rind petals tilt outward, then return
> toward neutral.
>
> Exactly four equal cells in one horizontal row, one complete boss per cell,
> fixed camera scale and ground baseline, generous separation, no overlap, no
> text or grid lines.
>
> Transparent background.

### Rotating volley cast

> Create a four-frame horizontal rotating-volley casting animation. Preserve
> the open durian petal crown, white mangosteen flesh ring, glossy dark seed,
> rooted body, spore sacs, scale, detailed pixel art, palette, and lighting.
> Animate the seed core charging violet, the radial rind petals twisting
> clockwise, five small attached firing nodes lighting around the flesh ring,
> then a strong rotational release recoil. The dark seed remains visible. Do
> not draw detached bullets, projectile trails, or impact effects.
>
> Exactly four equal cells in one horizontal row, one complete boss per cell,
> fixed camera scale and ground baseline, generous separation, no overlap, no
> text or grid lines.
>
> Transparent background.

### Aimed volley cast

> Create a four-frame horizontal aimed seed-volley casting animation for this
> exposed Maw Bloom Sovereign. Keep the same design and ground baseline.
> Animate the dark seed turning toward the lower right, the white flesh ring
> narrowing like an aiming iris, attached purple seed buds charging, and
> firing recoil. No detached projectiles, particles, floor, scenery, or text.
>
> Exactly four equal cells in one horizontal row with one complete boss per
> cell and clear transparent gaps.
>
> Transparent background.

### Summon cast

> Create a four-frame horizontal summon-casting animation. Preserve the same
> exposed bloom, root legs, spore sacs, calyx tail, scale, pixel detail,
> palette, and lighting. Animate the boss lowering its open crown, six roots
> spreading and pressing into the ground, hanging spore sacs pulsing in
> sequence, and the violet body core sending a final downward release through
> the roots. Make the summoning silhouette distinct from projectile casts. Do
> not draw summoned enemies, detached spores, ground effects, text, or scenery.
>
> Exactly four equal cells in one horizontal row, one complete boss per cell,
> fixed camera scale and ground baseline, generous separation, no overlap, no
> text or grid lines.
>
> Transparent background.

### Hurt

> Create a four-frame horizontal hurt and stagger animation. Preserve the same
> open durian bloom, mangosteen flesh, dark seed, root legs, spore sacs, scale,
> pixel detail, palette, and lighting. Animate a readable non-gory reaction:
> the seed dims and tilts backward, white flesh compresses, rind petals fold
> unevenly, roots buckle but stay planted, then the boss begins recovering
> toward exposed idle. No weapon, attacker, hit flash, detached debris, text,
> or scenery.
>
> Exactly four equal cells in one horizontal row, one complete boss per cell,
> fixed camera scale and ground baseline, generous separation, no overlap, no
> text or grid lines.
>
> Transparent background.

### Death

> Create a four-frame horizontal non-gory death animation. Preserve the same
> durian-mangosteen identity, root anatomy, white flesh, dark seed, spore sacs,
> scale, pixel detail, palette, and lighting. Animate the radial rind petals
> wilting and folding, the glossy seed dimming and sinking, six root legs
> buckling as the bloom loses height, then a final low inert pile of split
> durian rind, mangosteen flesh, dark seed, and dead roots. Maintain one fixed
> ground baseline and clearly reduce height each frame. No explosion, detached
> debris, attacker, text, floor, or scenery.
>
> Exactly four equal cells in one horizontal row, one complete boss per cell,
> fixed camera scale and ground baseline, generous separation, no overlap, no
> text or grid lines.
>
> Transparent background.
