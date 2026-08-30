# Brush-Cutter Combat VFX Source Record — v1

- Asset family: `VFX-CUTTER-SET`
- State: `Review` source package; old/provisional runtime attack effect remains until integration
- Art direction: detailed high-resolution pixel art, detached operator-safe effects, true transparent background
- Contamination contract: no operator, weapon, enemy or neighboring-frame pixels are baked into any effect

## Deliverables

| Runtime purpose | Source | Normalized grid |
|---|---|---|
| Standard cutter swing | `cutter_swing_arc_v1.png` | `cutter_swing_arc_normalized_v1.png`, 4 × 800 px cells |
| Organic contact impact | `cutter_organic_contact_v1.png` | `cutter_organic_contact_normalized_v1.png`, 4 × 800 px cells |
| Charged/upgraded swing | `cutter_charged_swing_v1.png` | `cutter_charged_swing_normalized_v1.png`, 4 × 800 px cells |
| Technology upgrade activation | `cutter_upgrade_activation_v1.png` | `cutter_upgrade_activation_normalized_v1.png`, 4 × 800 px cells |

## Built-in ImageGen provenance

| Asset | Accepted generated source ID | Normalized SHA-256 |
|---|---|---|
| Standard swing | `exec-e6905e07-68c7-4f31-97bf-efe7478da9c6.png` | `6F51FDC471E365D6F15DE99D62EE033ADC7341D8E151D51945F5E4299D36F789` |
| Organic contact | `exec-c7450cfa-8729-4cb7-bc25-b64d78f95f68.png` | `B9D336ABE6612AF13D2C996F6891880E44AA846AE5CAD99204ACE5620E5B9EEA` |
| Charged swing | `exec-c5252ff7-f6a7-46c1-b15a-92db4726c98d.png` | `110A7E64ED44F29166E16A28BF4B66AB6217BB77412830B3B8064C12B568C49E` |
| Upgrade activation | `exec-e04a75e4-7d5d-4f5a-9097-e746f705717e.png` | `2E3F2229C872890514201C84D5A94618248FCD572A6955FC5CD3D51C3AF51B50` |

## Final prompt summaries

- Standard swing: thin ignition crescent, broad green cutting peak, breakup streaks and fading motes around a fixed open pivot.
- Organic contact: compact contact star, sliced plant-fiber/sap fan, magenta-contamination breakup and fade.
- Charged swing: white-gold ignition ring, broad double green/gold crescent, secondary shock crescent and cyan/gold fade.
- Upgrade activation: compact charge, open gear ring with violet samples, cutter-tooth radial peak and fading open ring.
- Shared prompt: four isolated frames, VFX only, no body/weapon/enemy/floor, transparent background.
- The first upgrade-activation draft was rejected after normalization exposed a neighboring-frame slice. The accepted targeted revision increased transparent gutters and normalized without contamination.

## Technical validation

- Every normalized strip is 3200 × 800 px with four 800 × 800 cells.
- Every normalized PNG reports `Format32bppArgb`.
- All canvas corners have zero alpha and every cell reports zero nontransparent boundary pixels.
- Visual review confirms clean frame separation, consistent pivots and distinct standard/contact/charged/upgrade reads.

Runtime replacement of the legacy attack effect, animation timing, operator-facing transforms, collision synchronization, colorblind/readability review and 1280 × 720 gameplay validation remain required before promotion to `Integrated`.
