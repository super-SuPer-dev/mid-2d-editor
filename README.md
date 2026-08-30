# mid-2d-editor
Game-Dev Year3 mid term 2d project

Godot 4.7 project for **Low Altitude Warrior**, a Thai countryside sci-fi
survival side-scroller with a pixel-art production target.

## Development setup

1. Open `project.godot` with Godot 4.7 or a compatible Godot 4 release.
2. Run the project to start at the main menu.
3. Start a campaign, select one of four field operators, and clear the three
   unlockable missions.

Controls:

- A/D or Left/Right: move
- W, Space, or Up: jump
- Shift: dash
- Left mouse button: attack
- Escape: pause
- F2: debug mode
- F3: invulnerability debug mode

The repository layout and source/runtime asset boundary are defined in
[docs/PROJECT_STRUCTURE.md](docs/PROJECT_STRUCTURE.md). See
[docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) before adding a new system or
moving scenes.

Placeholder visuals are built from Godot polygons and controls. Follow
[docs/ASSET_REPLACEMENT.md](docs/ASSET_REPLACEMENT.md) when replacing them with
pixel-art or generated assets.

The active visual direction is documented in
[docs/ART_DIRECTION.md](docs/ART_DIRECTION.md) and is derived from the boards in
`art_source/references/`. Those boards are reference material, not runtime textures.

## Project validation

Run the repository structure checks before opening a pull request:

```powershell
./tools/validate_project_structure.ps1
```

The validator rejects missing `res://` targets, source-art imports, recovery
files, legacy path casing, and nonconforming runtime names.

## Smoke test

Run the project-level smoke scene headlessly with Godot 4.7:

```powershell
godot --headless --path . scenes/tests/smoke_test.tscn
```

It instantiates every front-end screen and all campaign levels, and validates
the configured character, enemy, objective, and platform counts.

# แนะนำ github repo นี้
repo นี้มีไว้เพื่อเก็บ code และ ตัว project หลักไม่ใช่ตัวเกมที่พร้อมเล่นบนเว็ป
ตัว repo ที่พร้อมเล่นบนเว็ปจะสร้าง repo แยกเป็น "mid-2d-prod" แทน

## แนะนำวิธีการ ร่วมงาน
ถ้าโดนดึงเข้า Collab แล้วก็ clone ไปทำงานได้เลย
พอ clone แล้วก็ pull เอาของใหม่มาก่อนเริ่มด้วย
แล้วก็สร้าง branch ของตัวเองขึ้นมา
พอทำงานของตัวเองเสร็จแล้วก็ commit และ push เข้า branch ของตัวเอง
แล้วก็ส่ง Pull Request มา เดี๋ยวจะดูและ merge ให้
