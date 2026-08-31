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
- During telegraph, `eye_rotating_spirals`, `eye_aimed_rings` and
  `eye_alternating_curtains` select the matching spiral, aimed-seed and
  bract-curtain cast strips at 8 fps. These casts use the same 4 × 1000 × 900
  grid, 840 px baseline, binary alpha and nearest filtering as the idle states.
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
| `art_source/generated/bosses/root_core_eye/body/root_core_eye_spiral_cast_v1.png` | `58A5B7F2212AEA2911797CB6410CD87096F4A7E52C0C3E7145116C6C9655C55A` |
| `assets/enemies/bosses/root_core_eye/root_core_eye_spiral_cast_strip_normalized_v2.png` | `C408768230AF7D7001E13AA7856FAE1AC4754D40EBBD1AAF74C45F588786FC2F` |
| `art_source/generated/bosses/root_core_eye/body/root_core_eye_aimed_seed_cast_v1.png` | `30FD2361DF31C7B8BF7327887287AA37A2582B5E654ECC6D393752DF43C9A766` |
| `assets/enemies/bosses/root_core_eye/root_core_eye_aimed_seed_cast_strip_normalized_v2.png` | `E98311EBF073D8D72720BC51E6EBF99A2934DE18D39C8FAD31E38BD6121800DA` |
| `art_source/generated/bosses/root_core_eye/body/root_core_eye_bract_curtain_cast_v1.png` | `BFECD724E2C429AEC494123D050881877DF685A0BF1EC4DAA70BA53CF51B5A9D` |
| `assets/enemies/bosses/root_core_eye/root_core_eye_bract_curtain_cast_strip_normalized_v2.png` | `097CD82FCB255D23E479178A816FDB188357D7C34DC5515D12919DE738F367D4` |

## Acceptance status

Technical decode, 4-frame grid, binary-alpha, runtime import, baseline,
phase-state, pooled-projectile reset and pattern-signal cast-binding checks
pass. The package remains below `Verified` until human review confirms the
longan/dragon-fruit identity, final-boss scale, projectile contrast, cast
readability and phase presentation in the Level 5 nexus scene.

## Death promotion

The normalized source death strip is promoted to
`root_core_eye_death_strip_normalized_v2.png`. It is a 4000 × 900 four-frame
binary-alpha strip using the same 1000 × 900 cell contract and 840 px baseline
as the body package. The shared enemy lifecycle plays it non-blocking after the
campaign-ending boss defeat signal while disabling collision and pattern
processing.

| File | SHA-256 |
|---|---|
| `art_source/generated/bosses/root_core_eye/body/root_core_eye_death_normalized_v1.png` | `5095F98C83913CE71EB6FE14E984C0526A8F9A543462D55C6623AF13BF01D106` |
| `assets/enemies/bosses/root_core_eye/root_core_eye_death_strip_normalized_v2.png` | `5095F98C83913CE71EB6FE14E984C0526A8F9A543462D55C6623AF13BF01D106` |
