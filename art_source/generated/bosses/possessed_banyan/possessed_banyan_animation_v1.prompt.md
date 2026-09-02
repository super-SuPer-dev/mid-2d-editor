# BOSS-POSSESSED-BANYAN animation source set v1

**State:** Review (not integrated)

**Generation mode:** Built-in image generation

**Fruit identity:** Jackfruit + banyan fig / ขนุน + ลูกไทร

**Identity source:** `possessed_banyan_fruit_identity_v1.md`

The Level 3 boss is a tall uprooted banyan fused with Capsule 07. A vertical
jackfruit forms its armored chest, golden fibers bind the attack anatomy,
glossy seeds support falling columns, latex supports area denial, and
red-purple banyan figs act as distributed sensors on aerial roots.

## Animation contract

| Action | Frames | Loop | Runtime intent |
|---|---:|---|---|
| Armored idle | 4 | Yes | Trunk breath, aerial-root lift and rind pulse |
| Move | 4 | Yes | Alternating heavy buttress-root walk |
| Charge tell | 4 | No | Braced non-damaging launch anticipation |
| Charge attack | 4 | No | Compact trunk lunge, contact and recovery |
| Root-sweep tell | 4 | No | Forward arm coils high before the low sweep |
| Root-sweep attack | 4 | No | Attached low sweep, committed hold and recovery |
| Seed-column cast | 4 | No | Upward sensor/seed-socket charge and release |
| Diagonal-root cast | 4 | No | Opposing aerial-root aim and release |
| Sap cast | 4 | No | Latex gland swell and downward release |
| Phase break | 4 | No | Rind splits to reveal fiber, seeds and Capsule heart |
| Exposed idle | 4 | Yes | Stable visible-heart pulse |
| Hurt | 4 | No | Heart dim, trunk stagger and recovery |
| Death | 4 | No | Progressive collapse to a low inert fruit-root pile |

Raw built-in outputs are retained as `possessed_banyan_*_strip_v1.png`.
Normalized review strips use a strict 4 columns x 1 row grid at 3600 x 900:

- Cell size: 900 x 900 pixels
- Pivot guide: x = 450 within each cell
- Ground baseline: y = 840 within each cell
- Solid-alpha threshold: 128
- Output: 32-bit RGBA PNG with transparent corners
- No rescaling or interpolation during normalization

Connected-component isolation selects the four complete authored boss poses,
centers them, fixes their baseline and discards clipped neighboring-pose
fragments. Detached projectile, impact and ground-hazard VFX are intentionally
excluded from the body strips.

## Validation hashes

| Candidate | SHA-256 |
|---|---|
| `possessed_banyan_idle_armored_strip_normalized_v1.png` | `ACF8D7BB7A56C0E6371716EFBD2721AFD3ED3163ECCBF411A9FD58FC1D75A90C` |
| `possessed_banyan_move_strip_normalized_v1.png` | `BDD1924A48808886B8D60994088007ED16CAFE4E11FD31E3DE65C90AFBFC50E9` |
| `possessed_banyan_charge_tell_strip_normalized_v1.png` | `81FE6912C3E29F131BC11F35F56AD4614DBE9FB910B30B50A7ED316863C45B7C` |
| `possessed_banyan_charge_attack_strip_normalized_v1.png` | `9454DD666122EFC8F9BFB514996A796325AF9C3F9A731E7F7F3AA088D0143989` |
| `possessed_banyan_root_sweep_tell_strip_normalized_v1.png` | `5CB63682CF838B31DE2BEC8EDB040CE20E8CE9E59EF6FE7691B394C98AAAB03F` |
| `possessed_banyan_root_sweep_attack_strip_normalized_v1.png` | `E4B7878A8368C667A4EF8F625DD0F56D553977803FAADFAA0AA22ECFC0B2DA53` |
| `possessed_banyan_seed_column_cast_strip_normalized_v1.png` | `BE4037D2D3C48594260AEF21F4D4525712CB860C195238CD39B864A4BF254F1A` |
| `possessed_banyan_diagonal_root_cast_strip_normalized_v1.png` | `A220E90C4D203FC043165B8516470292BFF0414D8FC209925DC68191BA55DEA7` |
| `possessed_banyan_sap_cast_strip_normalized_v1.png` | `7047B1D62DA9E2BFCBB67CA62A135F22AED5B6AAC429A26522A891F36FF16169` |
| `possessed_banyan_phase_break_strip_normalized_v1.png` | `67B5298A6FF7F9A1E00BFA5F4F2B386E21454EED1E54491176902330BBC987D0` |
| `possessed_banyan_idle_exposed_strip_normalized_v1.png` | `23D47551F3C82EBFC345A695F64830307B65765962DC57F5EE138982E2292C95` |
| `possessed_banyan_hurt_strip_normalized_v1.png` | `61B1945CFBA8CE699CBF08B07F8E723D8C0A73324F47DCCE4084A56E1F27DDA7` |
| `possessed_banyan_death_strip_normalized_v1.png` | `C1708E21C73A93D230962C1588B7D30BD17956008C5462016A59C80A93BB7AEB` |

Every normalized strip is 3600 x 900, `Format32bppArgb`, with transparent
corner pixels. Visual review confirmed isolated poses, shared baseline,
distinct charge/sweep/seed/root/sap tells, a readable armored-to-exposed
transition, stable visible-heart idle and progressive death collapse. Runtime
integration, logical downscale, nearest-neighbor import, frame timing,
hitboxes, projectiles/hazards and gameplay validation remain.

## Built-in source provenance

| Asset | Preserved built-in output |
|---|---|
| Armored idle | `exec-c6887dc4-1b5b-4934-80b7-97034bf55a68.png` |
| Move | `exec-ee120ae3-da9c-42a2-a11e-805358248fb0.png` |
| Charge tell | `exec-db23bbc7-a055-4de1-bfa6-edd13d3d2594.png` |
| Charge attack | `exec-d46e6df5-89d1-4d13-8195-815db3e5fac6.png` |
| Root-sweep tell | `exec-bca7b1cc-dab8-4372-b01c-1849e6c39fb9.png` |
| Root-sweep attack | `exec-bea1b6f1-079b-4c56-8114-2431dbbcc49c.png` |
| Seed-column cast | `exec-ef7320b9-a95f-4a28-9131-a2b6aec1dd51.png` |
| Diagonal-root cast | `exec-22632e52-73f0-47af-85b5-78665d517f03.png` |
| Sap cast | `exec-d6071e73-f9f6-4928-abed-e269215a95c0.png` |
| Phase break | `exec-6daec460-9528-4d8f-9a0c-7087133354b1.png` |
| Exposed idle | `exec-734ec82d-35bb-4b63-b027-6f1100f2f6cb.png` |
| Hurt | `exec-f2b1249e-92ac-4cff-ba54-e5df057c0ddb.png` |
| Death | `exec-cfbd1a16-923a-4852-ae27-0c76788f660e.png` |

## Prompts

### Armored idle

> Use case: stylized-concept
>
> Asset type: game boss four-frame idle animation strip
>
> Input images: Images 1 and 2 establish the project's detailed
> high-resolution original pixel-art density, strong silhouette, upper-left
> lighting, and non-realistic Thai fruit alien-horror direction. Do not copy
> either creature's anatomy.
>
> Create the Possessed Banyan, the Level 3 boss, as a completely distinct
> right-facing side-view creature. A tall gnarled banyan trunk has uprooted
> into four heavy buttress-root legs and one long forward sweeping root arm. A
> large green-yellow jackfruit is fused vertically into the trunk as chest
> armor: its hexagonal thorn rind is closed, but thin violet seams and a little
> golden fiber show between plates. Clusters of small red-purple banyan figs
> act as alien sensor nodules along two hanging aerial roots. Dark charcoal
> Capsule 07 metal bands and violet living membrane penetrate the bark. Keep
> the silhouette top-heavy and tree-like, clearly different from the low Maw
> and multi-headed Thorn Matriarch.
>
> Animate four armored idle states: grounded neutral, aerial roots and fig
> sensors lift, jackfruit armor and violet seams pulse, then roots settle
> toward neutral. Preserve one fixed scale, ground baseline, right-facing
> orientation, body identity, and lighting. No attack, projectile, detached
> debris, floor, scenery, text, labels, or watermark.
>
> Exactly four equal cells in one horizontal row, one complete boss per cell,
> generous transparent separation, no overlap, no grid lines.
>
> Transparent background.

### Move

> Use case: stylized-concept
>
> Asset type: game boss four-frame movement animation strip
>
> Input images: Image 1 is the authoritative Possessed Banyan armored idle.
> Preserve the exact tall banyan trunk, vertical green-yellow jackfruit chest
> armor, hexagonal rind, four buttress-root legs, long forward root arm,
> red-purple banyan-fig sensors, aerial roots, leaves, Capsule metal bands,
> violet membrane, detailed high-resolution pixel art, palette, scale, and
> upper-left lighting.
>
> Create a four-frame heavy uprooted walk cycle facing right. Alternate the
> four buttress-root contacts so the trunk advances with weight; the jackfruit
> chest and leafy crown counter-bob, the forward root arm stays ready, and the
> fig-bearing aerial roots trail behind. No attack, charge, detached fruit,
> dust, floor, scenery, text, labels, or watermark.
>
> Exactly four equal cells in one horizontal row, one complete boss per cell,
> fixed scale and ground baseline, generous transparent separation, no
> overlap, no grid lines.
>
> Transparent background.

### Charge tell

> Use case: stylized-concept
>
> Asset type: game boss four-frame charge-anticipation animation strip
>
> Input images: Image 1 is the authoritative Possessed Banyan armored idle.
> Preserve the exact design, fruit structures, detailed high-resolution pixel
> art, palette, scale, right-facing side view, and upper-left lighting.
>
> Create a clearly non-damaging four-frame trunk-charge tell. Animate: armored
> neutral; four buttress roots spread and grip the ground; the tall trunk leans
> backward while the long forward root arm curls tightly beside the jackfruit
> chest; then a held launch-ready pose with the green-yellow jackfruit rind
> plates clamped, violet seams bright, and red-purple fig sensors glowing
> toward the right. Do not show forward movement or contact. No detached
> effect, projectile, floor, scenery, text, labels, or watermark.
>
> Exactly four equal cells in one horizontal row, one complete boss per cell,
> fixed scale and ground baseline, generous transparent separation, no
> overlap, no grid lines.
>
> Transparent background.

### Charge attack

> Use case: stylized-concept
>
> Asset type: game boss four-frame charge-attack animation strip
>
> Input images: Image 1 is the authoritative Possessed Banyan armored idle.
> Preserve its exact jackfruit-banyan anatomy, four buttress-root legs, forward
> root arm, fig sensors, Capsule membrane, detailed high-resolution pixel art,
> palette, scale, right-facing orientation, and lighting.
>
> Create a four-frame compact trunk-charge attack: low launch from braced
> roots, short powerful forward lunge with the closed jackfruit chest leading,
> damaging shoulder/chest contact pose, then root-drag recoil beginning to
> recover. Show weight through stretched rear roots and a forward-bent trunk,
> but keep the complete boss compact inside each quarter of the strip; shorten
> travel rather than crossing a cell edge. No detached dust, impact flash,
> projectile, floor, scenery, text, labels, or watermark.
>
> Exactly four equal cells in one horizontal row, one complete separated boss
> per cell, fixed ground baseline, wide transparent gaps, no overlap, no grid
> lines.
>
> Transparent background.

### Root-sweep tell

> Use case: stylized-concept
>
> Asset type: game boss four-frame root-sweep anticipation strip
>
> Input images: Image 1 is the authoritative Possessed Banyan armored idle.
> Preserve the exact design, jackfruit armor, banyan-fig sensors, aerial and
> buttress roots, Capsule membrane, detailed high-resolution pixel art,
> palette, scale, right-facing side view, and lighting.
>
> Create a clearly non-damaging four-frame root-sweep tell. Animate: neutral;
> the long forward root arm pulls backward and upward; golden jackfruit fibers
> along the shoulder stretch and glow while the four root legs brace; then a
> held high coiled pose with the forward arm ready to sweep low across the
> right side and fig sensors lit in sequence. Do not show the damaging sweep.
> No detached effect, projectile, floor, scenery, text, labels, or watermark.
>
> Exactly four equal cells in one horizontal row, one complete boss per cell,
> fixed scale and ground baseline, generous transparent separation, no
> overlap, no grid lines.
>
> Transparent background.

### Root-sweep attack

> Use case: stylized-concept
>
> Asset type: game boss four-frame root-sweep attack strip
>
> Input images: Image 1 is the authoritative Possessed Banyan armored idle.
> Preserve the exact design, fruit structures, detailed high-resolution pixel
> art, palette, scale, right-facing side view, and lighting.
>
> Create a four-frame low root-arm sweep attack. Animate the long forward root
> arm snapping from a high coil, extending low across the right side as the
> damaging sweep, reaching a committed low hold, then curling back in
> recovery. The tall trunk twists and golden jackfruit fibers stretch with the
> motion while all four buttress-root legs stay planted. Keep the root arm
> attached and the complete boss inside each quarter; shorten reach rather
> than crossing a cell edge. No detached arc effect, projectile, impact flash,
> floor, scenery, text, labels, or watermark.
>
> Exactly four equal cells in one horizontal row, one complete separated boss
> per cell, fixed ground baseline, wide transparent gaps, no overlap, no grid
> lines.
>
> Transparent background.

### Seed-column cast

> Use case: stylized-concept
>
> Asset type: game boss four-frame seed-column casting animation strip
>
> Input images: Image 1 is the authoritative Possessed Banyan armored idle.
> Preserve the exact design, vertical jackfruit chest armor, fig-bearing
> aerial roots, four root legs, forward root arm, Capsule membrane, detailed
> high-resolution pixel art, palette, scale, right-facing orientation, and
> lighting.
>
> Create a four-frame falling-seed-column casting animation. Animate the four
> root legs planting, red-purple banyan fig sensors turning upward, jackfruit
> rind plates spreading just enough to reveal several attached glossy brown
> seed sockets in golden fiber, the aerial roots lifting toward the ceiling,
> then a strong upward release recoil. Keep every seed attached during this
> body animation; detached falling seeds belong to a separate asset. No
> detached projectiles, rain, floor, scenery, text, labels, or watermark.
>
> Exactly four equal cells in one horizontal row, one complete boss per cell,
> fixed scale and ground baseline, generous transparent separation, no
> overlap, no grid lines.
>
> Transparent background.

### Diagonal-root cast

> Use case: stylized-concept
>
> Asset type: game boss four-frame diagonal-root casting animation strip
>
> Input images: Image 1 is the authoritative Possessed Banyan armored idle.
> Preserve the exact design, fruit structures, four buttress-root legs,
> forward root arm, fig-bearing aerial roots, detailed high-resolution pixel
> art, palette, scale, right-facing side view, and lighting.
>
> Create a four-frame diagonal-root-line casting animation. Animate the boss
> lowering its jackfruit-armored chest, anchoring all four root legs, then
> raising the two red-purple fig-bearing aerial roots into opposing upward
> diagonals as their sensor figs light from base to tip, followed by a forceful
> release recoil through the violet Capsule membrane. Make this silhouette
> distinct from the upward seed-column cast. Do not draw detached root lines,
> projectiles, floor effects, scenery, text, labels, or watermark.
>
> Exactly four equal cells in one horizontal row, one complete boss per cell,
> fixed scale and ground baseline, generous transparent separation, no
> overlap, no grid lines.
>
> Transparent background.

### Sap cast

> Use case: stylized-concept
>
> Asset type: game boss four-frame sap-hazard casting strip
>
> Input images: Image 1 is the authoritative Possessed Banyan armored idle.
> Preserve the exact jackfruit-banyan design, four buttress-root legs, forward
> root arm, fig-bearing aerial roots, Capsule membrane, detailed
> high-resolution pixel art, palette, scale, right-facing side view, and
> lighting.
>
> Create a four-frame sticky-sap casting animation. Animate the vertical
> jackfruit chest swelling, hexagonal rind seams opening slightly to reveal
> golden fibers, amber-violet latex glands gathering along the lower chest and
> root arm, then a downward release recoil as the glands empty. Keep all liquid
> attached or at the release edge during this body animation; the detached sap
> pool is a separate asset. Make the pose distinct from seed-column and
> diagonal-root casts. No detached puddle, projectile, floor, scenery, text,
> labels, or watermark.
>
> Exactly four equal cells in one horizontal row, one complete boss per cell,
> fixed scale and ground baseline, generous transparent separation, no
> overlap, no grid lines.
>
> Transparent background.

### Phase break

> Use case: stylized-concept
>
> Asset type: game boss four-frame phase-break animation strip
>
> Input images: Image 1 is the authoritative armored Possessed Banyan.
> Preserve the exact tall trunk, four buttress-root legs, forward root arm,
> fig-bearing aerial roots, leaves, jackfruit chest, Capsule membrane, detailed
> high-resolution pixel art, palette, scale, right-facing side view, and
> lighting.
>
> Create a four-frame armored-to-exposed phase transition. Animate violet seams
> splitting the green-yellow hexagonal jackfruit rind; rind plates peeling to
> both sides while sticky golden fibers stretch; a cluster of glossy brown
> jackfruit seeds opening around a bright narrow violet Capsule heart; then a
> stable exposed form with the heart clearly framed by golden fibers and
> broken rind. Keep the boss grounded and the final weak-point silhouette
> readable. No detached debris, explosion, attacker, projectile, floor,
> scenery, text, labels, or watermark.
>
> Exactly four equal cells in one horizontal row, one complete boss per cell,
> fixed scale and ground baseline, generous transparent separation, no
> overlap, no grid lines.
>
> Transparent background.

### Exposed idle

> Use case: stylized-concept
>
> Asset type: game boss four-frame exposed idle animation strip
>
> Input images: Image 1 is the authoritative Possessed Banyan phase transition.
> Use its final exposed form exactly: broken green-yellow jackfruit rind plates,
> golden fibrous flesh, glossy brown seed ring, narrow bright violet Capsule
> heart, tall banyan trunk, four buttress-root legs, forward root arm,
> red-purple fig sensors, leaves, detailed high-resolution pixel art, palette,
> scale, and lighting.
>
> Create a four-frame exposed-phase idle loop. Keep the heart and seed ring
> visible in every frame. Animate a tense pulse: exposed neutral; golden fibers
> contract and seed ring tilts slightly; violet heart and fig sensors brighten
> while aerial roots lift; then the trunk and roots settle toward neutral. No
> armor closing, attack, detached effect, projectile, floor, scenery, text,
> labels, or watermark.
>
> Exactly four equal cells in one horizontal row, one complete boss per cell,
> fixed right-facing orientation, scale and ground baseline, generous
> transparent separation, no overlap, no grid lines.
>
> Transparent background.

### Hurt

> Use case: stylized-concept
>
> Asset type: game boss four-frame hurt animation strip
>
> Input images: Image 1 is the authoritative exposed Possessed Banyan.
> Preserve the exact broken jackfruit rind, golden fibers, glossy seed ring,
> violet heart, banyan trunk and roots, fig sensors, detailed high-resolution
> pixel art, palette, scale, right-facing side view, and lighting.
>
> Create a readable four-frame non-gory hurt and stagger reaction. Animate the
> violet heart dimming and recoiling inward; the glossy seeds and golden fibers
> compress unevenly; the tall trunk twists backward while buttress roots buckle
> but stay grounded; then the boss begins recovering toward exposed idle. No
> attacker, weapon, hit flash, detached debris, armor restoration, floor,
> scenery, text, labels, or watermark.
>
> Exactly four equal cells in one horizontal row, one complete boss per cell,
> fixed scale and ground baseline, generous transparent separation, no
> overlap, no grid lines.
>
> Transparent background.

### Death

> Use case: stylized-concept
>
> Asset type: game boss four-frame death animation strip
>
> Input images: Image 1 is the authoritative exposed Possessed Banyan.
> Preserve the exact jackfruit-banyan identity, broken rind, golden fibers,
> glossy seeds, violet heart, fig sensors, Capsule membrane, detailed
> high-resolution pixel art, palette, scale, and lighting.
>
> Create a four-frame non-gory death animation. Animate the violet heart going
> dark and seed ring loosening; leaves and fig-bearing aerial roots wilt; four
> buttress-root legs buckle as the tall trunk loses height; then the boss
> settles into one low inert pile of split jackfruit rind, dead golden fiber,
> dark seeds, bark, and collapsed roots with the heart extinguished. Maintain
> one fixed ground baseline and clearly reduce height in every frame. No
> explosion, detached debris, attacker, floor, scenery, text, labels, or
> watermark.
>
> Exactly four equal cells in one horizontal row, one complete boss or final
> remains per cell, fixed scale and ground baseline, generous transparent
> separation, no overlap, no grid lines.
>
> Transparent background.
