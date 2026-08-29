# Spitter Detached VFX Source Record — v1

- Asset family: `ENEMY-SPITTER`
- Fruit identity: Makrut lime / มะกรูด
- State: `Review` source package; not yet integrated into runtime combat
- Art direction: detailed high-resolution pixel art, original Thai-fruit alien biology, true transparent background

## Deliverables

| Runtime purpose | Source | Normalized grid |
|---|---|---|
| Narrow makrut seed projectile travel loop | `spitter_makrut_seed_projectile_v1.png` | `spitter_makrut_seed_projectile_normalized_v1.png`, 4 × 700 px centered cells |
| Heavy makrut juice glob travel loop | `spitter_makrut_juice_glob_v1.png` | `spitter_makrut_juice_glob_normalized_v1.png`, 4 × 700 px centered cells |
| Seed projectile impact | `spitter_seed_impact_v1.png` | `spitter_seed_impact_normalized_v1.png`, 4 × 700 px centered cells |
| Ground-anchored juice splash and residue | `spitter_juice_splash_v1.png` | `spitter_juice_splash_normalized_v1.png`, 4 × 800 px cells, baseline 740 |

## Built-in ImageGen provenance

| Asset | Generated source ID | Normalized SHA-256 |
|---|---|---|
| Makrut seed projectile | `exec-94fa6f89-7c8c-48c0-9a43-41c783b34d63.png` | `DF6438D01E51E4909B603BB051B4CB1BAC6FD2F3BE2925503852C6FBC9088AA2` |
| Makrut juice glob | `exec-242db18a-99f1-43aa-8063-731392caa9cf.png` | `97A526B62BB09B76A88D977B12B1186C58276AF3E9D750CA3CA86D7E4D4F041F` |
| Seed impact | `exec-ba12ec6d-50fe-4447-8bec-2b11ae17edf8.png` | `6F377D038C5B9DB586DE8317B269B65AB5D724E787E4D7EA9EA13F29B9B6FBAC` |
| Juice splash | `exec-69093650-374a-40b0-9276-ede5e97c4529.png` | `C0B176C9F5EBFBDC2DA09D12CAFA6E99170EF4E490E0DFDCF68A208D54259FAF` |

## Prompt summaries

- Seed projectile: four-frame travel loop of one narrow pointed pale citrus seed with a dimpled green makrut-rind cap, magenta alien vein and yellow-green motion trail.
- Juice glob: four loop states of one heavy translucent yellow-green juice glob carrying green rind fragments and magenta alien fiber.
- Seed impact: four-frame compact pale-green-orange impact burst, intentionally smaller than the juice splash.
- Juice splash: four-frame ground impact progressing from compression through a tall broad splash to a low puddle and fading residue.
- Shared ending constraint: `Transparent background.`

## Technical validation

- Every normalized PNG reports `Format32bppArgb`.
- All four canvas corners have zero alpha.
- Every normalized cell has zero nontransparent pixels on its outer boundary.
- The juice splash was normalized with connected-component isolation at alpha threshold 1 to retain translucent liquid while removing cross-cell contamination.
- Visual review confirmed distinct seed/glob silhouettes and readable impact size hierarchy.

Runtime integration, projectile collision sizing, animation timing, pooling behavior, and gameplay-scale readability remain required before promotion to `Integrated`.
