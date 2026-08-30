# Root-Core Eye Runtime Pilot

**Asset ID:** BOSS-ROOT-CORE-EYE  
**State:** Integrated (pilot; human final-boss review pending)  
**Primary fruit identity:** Longan eye cluster with dragon-fruit bracts  
**Source package:** `art_source/generated/bosses/root_core_eye/body/`  
**Promotion date:** 2026-08-31

## Promotion contract

- Sealed and exposed idle strips are normalized to exactly 4 × 1000 × 900 px
  cells with the authored 840 px baseline.
- Alpha was quantized with threshold 128. Both promoted strips contain only
  alpha 0 or 255 and use nearest-neighbor filtering.
- The final boss starts with the sealed strip and switches to the exposed strip
  at phase 2; both states advance at 3 fps. The existing Root-Core Eye
  projectile pattern set remains authoritative for combat behavior.
- The longan-seed projectile pilot is a separate 4-frame horizontal strip
  normalized to 4 × 800 × 800 px cells. It is selected only for
  `root_core_eye_boss`, advances at 10 fps in the pooled projectile visual, and
  resets to the default one-frame projectile contract when reused by another
  boss.
- Attack/tell/death body strips, detached projectile art and presentation frames
  remain source candidates for later integration.

## Provenance hashes

| File | SHA-256 |
|---|---|
| `art_source/generated/bosses/root_core_eye/body/root_core_eye_idle_sealed_v1.png` | `715A7D2B40A1765160AB12DE445CB0B7F73A47752D02B6D6DD6539E5A2CACD5A` |
| `art_source/generated/bosses/root_core_eye/body/root_core_eye_idle_exposed_v1.png` | `8A3BBFC0190630E008A7B85B366001760DBFE20423A83E2E9419E7B7ACF8FD13` |
| `assets/enemies/bosses/root_core_eye/root_core_eye_idle_sealed_normalized_v2.png` | `5D68E732275764C6F3077310E21C7A61ECA7E7D4AB09C743BD25BC3CACB4D9B9` |
| `assets/enemies/bosses/root_core_eye/root_core_eye_idle_exposed_normalized_v2.png` | `4A8FD045266742FB0DE9B4910B72DA64ECA8A30D89A8890DF7FD2B83EEF92EAC` |
| `art_source/generated/bosses/root_core_eye/projectiles/root_core_eye_longan_seed_bullet_v1.png` | `F58B016A602DF3EACFE7774604C266A7DD60B87427C42AA9F4A6C6F720C0480D` |
| `assets/enemies/bosses/root_core_eye/root_core_eye_longan_seed_bullet_normalized_v2.png` | `5604C770CC7EE921F648B3D9E61250522CB0B8E1541BE94448E44BFB02BBB8AA` |

## Acceptance status

Technical decode, 4-frame grid, binary-alpha, runtime import, baseline,
phase-state and pooled-projectile reset checks pass. The package remains below
`Verified` until human review confirms longan/dragon-fruit identity, final-boss
scale, phase readability and projectile contrast in the Level 5 nexus scene.
