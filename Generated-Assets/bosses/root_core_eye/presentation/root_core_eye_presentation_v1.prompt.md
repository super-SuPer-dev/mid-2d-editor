# BOSS-ROOT-CORE-EYE presentation source set v1

**State:** Review (not integrated)

**Fruit identity:** Longan eye cluster within dragon-fruit bracts /
พวงตาลำไยในกลีบแก้วมังกร

**Localization contract:** All presentation art is text-free. Boss name,
warning, health, phase and accessibility strings must be rendered at runtime
from localization keys. Portrait/title/health openings use true alpha; the
three small HUD phase sockets retain dark backing for icon contrast.

## Package contract

| Asset | Grid / canvas | Runtime intent |
|---|---|---|
| Portrait states | 3 x 1, 900 x 900 cells | Sealed, awakened and exposed-core crops |
| Boss-intro frame | 1800 x 1000 | Left portrait socket plus title-safe opening |
| Boss-HUD frame | 2200 x 800 | Portrait socket, health opening and three phase sockets |
| Phase markers | 3 x 1, 900 x 900 cells | Sealed bud, awakened eye and exposed core |

## Validation hashes and provenance

| Normalized asset | Built-in source | SHA-256 |
|---|---|---|
| `root_core_eye_portrait_states_normalized_v1.png` | `exec-95c8052a-d30b-499b-ab6b-a7e1543e0726.png` | `9C6C6E32BB559390F1605B11BB60824B4D9783178C517AA249F9C975B723F9C5` |
| `root_core_eye_intro_frame_normalized_v1.png` | `exec-3ab4d365-f46e-4e26-8684-7c852bc62ea7.png` | `BF5090D51AC45AE13189D7A624CC3C1C7DEF2B45453697880A6F23C2FF200D95` |
| `root_core_eye_boss_hud_frame_normalized_v1.png` | `exec-13fd7e81-4f68-47a8-9870-54fa97033e1e.png` | `1F374DC0CF63DC6B85DC13C96158C00FB3661D56AD4DBEE897E44393E6581894` |
| `root_core_eye_phase_markers_normalized_v1.png` | `exec-668c6a72-bee6-4820-be08-b8b8bab0cc8f.png` | `FBAB2D4B96B77F2B56D178F749B4A3CAE7DA76A3C95BE8B044E3B4EC3900199A` |

All normalized outputs are 32-bit ARGB PNGs with transparent corner pixels.
Direct samples confirmed alpha zero in the intro portrait/title openings and
HUD portrait/health openings; the HUD phase socket sample remains opaque for
icon contrast. The first and last three columns of every portrait and marker
cell contain zero alpha. Visual review confirms distinct states, empty runtime
text regions and no baked English or Thai text.

The initial intro-frame source `exec-db6b33a7-2785-438c-813d-5815296468c7.png`
contained a baked checkerboard and was rejected. Its transparency-only edit
preserved the approved design and produced the accepted true-alpha source.

## Prompt contracts

### Portrait states

> Preserve the exact sealed, awakened and exposed Root-Core Eye design. Create
> three consistent close crops: sealed dragon-fruit bract bud with five crown
> eyes; fully awakened central longan seed pupil; cracked exposed seed with
> peeled bracts and dim crown eyes. Keep the upper root trunk but omit the
> ground pedestal. Exactly three equal horizontal cells.

### Boss-intro frame

> Preserve the approved wide intro layout: a large circular transparent
> portrait socket on the left and a large clean transparent title-safe opening
> across the center/right. Decorate only the perimeter with charcoal ACO metal,
> aged brass, violet neural roots, pale longan flesh, glossy seed inlays,
> magenta-green dragon-fruit bracts and cyan sensor veins.

### Boss-HUD frame

> Preserve the approved compact HUD layout: left circular portrait opening,
> long central health opening and three phase sockets on the right. Create a
> slim Root-Core Eye skin using charcoal metal, aged brass, violet roots,
> longan-seed/flesh inlays, magenta-green bracts and cyan veins.

### Phase markers

> Create three matching circular icons: sealed bract bud with five crown-eye
> emblems; awakened central longan seed with five alert eyes; cracked exposed
> seed with peeled bracts and five dim eyes. Use identical charcoal-metal and
> aged-brass sockets with violet-root and cyan-vein accents.

Every prompt prohibited words, labels, numbers, scenery, floor, projectiles,
watermarks, overlap, grid lines and cropped edges, and ended with
`Transparent background.` Integration still requires the reusable 1280 x 720
layout, nearest-neighbor imports, localized label fitting, contrast checks and
Windows/Web validation.
