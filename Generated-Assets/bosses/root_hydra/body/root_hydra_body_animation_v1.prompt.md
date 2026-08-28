# BOSS-ROOT-HYDRA body animation source set v1

**State:** Review (first batch; phase damage, hurt and death remain)

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

## Remaining body actions

`head_break`, `phase_break`, `idle_exposed`, `core_attack`, `hurt` and `death`
must use the same cell, baseline, alpha and localization contracts before this
body package can leave Review.
