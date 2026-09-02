# BOSS-ROOT-HYDRA body animation source set v1

**State:** Review (complete source body contract; not integrated)

**Grid contract:** Every accepted animation is a four-frame horizontal strip
normalized to 4000 x 900: four 1000 x 900 cells with baseline 840. Connected
boss-silhouette normalization removes neighboring-cell contamination while
preserving the four attached heads, leaves and root base.

## Accepted actions and hashes

| Action | Built-in source | SHA-256 of normalized output |
|---|---|---|
| `idle` | `exec-460854ee-660f-4bb1-9ac4-278acd34a071.png` | `0365C4D635BFC6237FFE8F2A9E488283888BDCEC279EA97097A228F07667EAED` |
| `head_charge_tell` | `exec-65726d6e-7eb7-4be1-832a-b1a0fee66463.png` | `0DECB8707168D8C150B32F2C8B61A1F0695418F414D30B07C46CF73DB6067D13` |
| `crossfire_attack` | `exec-17156ab1-d5fc-4ffe-89ec-4c2cd9a1cdfd.png` | `F4DCDD8BC719F74985E0287A4CE837ABFABE57A02CFED6FED9253CCB47ACD7C8` |
| `radial_ring_cast` | `exec-e5160fb4-c5fc-4b7e-afae-e62cc7bcca57.png` | `4C50F5D3EE6C2BC2BB8ED46DCD5D5066A5AB3800E44A616CD3C9E21E7787F360` |
| `lane_wall_cast` | `exec-86d6e4dd-eac4-4d14-abd0-88670316ddba.png` | `BEBCBDD39118BAB25BCD15C8D4109F0EC4488E7BA6DA543BB96451459A23C116` |
| `head_break` | `exec-f0952c43-ee8c-4bed-b56a-4394ce0499f8.png` | `AF60EFDC066B0C0AEE75EBCAEFFF17E5FA466CE97C21B2FD53B92EDAEA75B362` |
| `phase_break` | `exec-d83515e4-98a5-4ca4-bd30-cf4d8a532e95.png` | `E361680F680FCF2FF62102F0C12DC25F24190AEB45B98544A70CC83AE26C293B` |
| `idle_exposed` | `exec-b6ad3e70-06cc-462a-bc28-56ece40d8f14.png` | `FEB7CE9C674E5D2F9DFDA493B63AC32F3F31355A61FD6C048689957B795080F6` |
| `core_attack` | `exec-5e822d52-35a7-4bbf-8856-fc3c15d1eb8f.png` | `BD198E857ACF10F29937D491D8079D5058B24F01DF1483F6BE4B9F995A7BD220` |
| `hurt` | `exec-761d5601-9b27-4a8d-9d92-e5b164150438.png` | `A7F6E93EDD4117104347A217FA6D303545C157D9DF9F201E968DD768E840AB7F` |
| `death` | `exec-e75596fb-6171-4444-8a7e-0ab91a4c27ec.png` | `5B4169B8DECD9F9FD71E8C376DFD5D39492E1486A5D2F8675D0EC2C7644B4432` |

All accepted outputs have transparent corner pixels. Visual review confirms
one complete connected boss per cell, no edge fragments, no floating baseline,
four distinct head origins and no baked projectiles or language-specific text.

## Prompts

All prompts used the normalized fruit-identity strip as the authoritative input
and ended with `Transparent background.`

### Idle

> Create the armored Root Hydra idle animation. Exactly four sequential frames
> in one horizontal row: roots settle and flex; four heads breathe at staggered
> timing; palm-leaf fins sway slightly; cyan veins pulse from dim to medium and
> back; the central core remains covered by the packed nipa-fruit crown. Keep
> the base planted on one identical baseline with no vertical drift. Maintain
> identical scale and camera. No projectile, attack flare, detached pieces,
> scenery, floor, UI, labels, text, watermark, or grid lines. Exactly four equal
> cells, one complete boss per cell, generous transparent separation, no
> overlap or cropped roots/heads.

### Head-charge tell

> Create the four-frame head-charge telegraph animation before a multi-origin
> projectile attack. Frame 1 heads notice and begin turning outward; frame 2 all
> four fibrous jaws open wider; frame 3 orange light gathers separately inside
> each fruit-wedge mouth while cyan veins brighten toward the heads; frame 4 is
> the strongest readable hold with four distinct glowing muzzle origins. The
> boss does not fire yet. Base stays fixed on one baseline with no floating. No
> projectile, scenery, floor, UI, text, watermark, or grid lines. Exactly four
> equal cells in one horizontal row, one complete uncropped boss per cell,
> identical scale, generous transparent separation, no overlap.

### Multi-head crossfire

> Create the four-frame multi-head crossfire attack body animation. Frame 1 the
> upper-left and lower-right heads thrust toward their firing lanes; frame 2
> those two jaws snap and recoil; frame 3 the upper-right and lower-left heads
> thrust in the opposite alternating pair; frame 4 all four necks recoil into a
> readable recovery pose. Orange mouth light flashes at the four muzzle points
> but no detached bullets are included; projectiles will be separate runtime
> assets. Keep all head origins clearly separated and the base fixed to one
> baseline with no floating. No scenery, floor, UI, text, watermark, or grid
> lines. Exactly four equal cells in one horizontal row, one complete uncropped
> boss per cell, identical scale, generous transparent separation, no overlap.

### Offset radial-ring cast

> Create the four-frame offset radial-ring casting animation. Frame 1 the four
> necks curl inward around the crown and cyan veins begin pulsing; frame 2 heads
> lift to four different heights and orient outward; frame 3 all four jaws open
> in a symmetric flower-like ring with bright cyan-orange throat flashes; frame
> 4 the necks recoil unevenly to show the rings launch at offset timing. Do not
> draw detached projectiles—the radial bullets are separate runtime assets.
> Keep the root base locked to one baseline with no floating. No scenery, floor,
> UI, text, watermark, or grid lines. Exactly four equal cells in one horizontal
> row, one complete uncropped boss per cell, identical scale, generous
> transparent separation, no overlap.

### Moving water-lane-wall cast

> Create the four-frame moving water-lane-wall casting animation. Frame 1 the
> two left heads lower toward the marsh surface while the two right heads rise;
> frame 2 the left pair stretch horizontally with cyan veins and orange jaws
> brightening; frame 3 the right pair mirror the formation at staggered heights,
> creating clearly different lane origins; frame 4 all four necks pull back with
> wet palm leaves trailing in recovery. Do not draw the detached water walls or
> bullets; those are separate runtime assets. The central base stays locked to
> one baseline with no floating. No scenery, floor, UI, text, watermark, or grid
> lines. Exactly four equal cells in one horizontal row, one complete uncropped
> boss per cell, identical scale, generous transparent separation, no overlap.

### Single head break

> Create a four-frame single head-break reaction. Frame 1 the lower-left fruit
> head recoils from a heavy hit and its wedge armor cracks; frame 2 the head
> folds inward with a bright cyan sap flash; frame 3 the damaged head retracts
> into the neck, leaving a short clean sealed stump glowing cyan, non-gory;
> frame 4 the remaining three heads spread defensively while the sealed stump
> dims. No detached head, debris, blood, projectile, scenery, floor, UI, text,
> watermark, or grid lines. Keep the central base fixed on one baseline.

### Major phase break

> Create the four-frame major phase-break animation after the second head is
> destroyed. Frame 1 two remaining heads pull back and the central nipa-fruit
> crown trembles; frame 2 crown wedges crack apart along cyan seams; frame 3 the
> armor petals peel outward and the bright cyan conduit core rises into view;
> frame 4 settles into a clear exposed-core combat stance with two living heads
> and two short sealed stumps, non-gory. The base remains fixed on one baseline.
> No detached debris, projectile, scenery, floor, UI, text, watermark, or grid
> lines.

### Exposed-core idle

> Create a four-frame exposed-core idle loop. The two surviving heads breathe
> at alternating timing, sealed stumps drip small attached cyan sap threads,
> peeled crown wedges flex, leaves sway, and the central core pulses
> bright-dim-bright without changing position. Keep every root locked to the
> same ground baseline with no floating. No attack flare, detached particles,
> projectile, scenery, floor, UI, text, watermark, or grid lines.

### Exposed-core attack

> Create the four-frame exposed conduit-core attack animation. Frame 1 the
> surviving heads bow outward and cyan energy gathers at the core; frame 2 root
> armor braces tighten around a concentrated core point; frame 3 the core opens
> into a bright horizontal firing aperture aimed toward screen-left with a
> short attached muzzle flare only; frame 4 the aperture contracts and the
> whole boss recoils into recovery. Do not include a detached beam or bullets;
> projectile and beam bodies are separate runtime assets. Keep the base on one
> identical baseline with no floating.

### Hurt

> Create a four-frame non-gory hurt reaction for the exposed phase. Frame 1
> normal exposed stance; frame 2 the core flashes pale cyan-white and both heads
> flinch backward; frame 3 crown wedges clamp partly inward while the roots
> compress; frame 4 the flash fades as the heads and base return toward combat
> posture. Damage response must be readable without blood, detached fragments,
> or camera movement. Keep the base fixed on one baseline.

### Death

> Create a four-frame non-gory boss death sequence with a permanent final pose.
> Frame 1 the exposed core overloads with cyan cracks and both heads arch upward;
> frame 2 the core fractures inward as the two heads lose orange light and wilt;
> frame 3 all necks collapse sideways into the root mass while crown wedges
> close loosely around the dim core; frame 4 is a low fully grounded defeated
> husk with dark heads, drooping leaves, broken cyan veins, and a tiny
> extinguishing core ember. No explosion cloud, detached debris, blood,
> projectile, scenery, floor, UI, text, watermark, or grid lines. Keep contact
> with the same baseline throughout.

All six prompts used exactly four equal horizontal cells, one complete
uncropped boss per cell, identical scale, generous transparent separation and
`Transparent background.` The body source contract now contains eleven actions
and 44 frames. Runtime timing, hitboxes, projectile emission, final VFX/SFX and
engine validation remain separate integration work.
