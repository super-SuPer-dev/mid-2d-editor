# Completeness and Validation Protocol

**Project:** ACO: Capsule 07  
**Version:** 2.0  
**Status:** Mandatory gate and release protocol  
**Authority:** This English protocol is the only maintained documentation authority. Existing Thai documents are frozen references.

This protocol determines whether a requirement, asset, gate or build is complete. It supplements the design acceptance criteria; it does not replace human review.

## 1. Traceability

[VAL-TRACE-01] Every test result must reference at least one Requirement ID, build identifier and platform. Canonical IDs are English, stable and must match runtime data.

Minimum trace chain:

`Requirement ID → implementation/data IDs → automated/manual test → evidence → defect or approval → readiness score`

An item without evidence cannot score above Integrated (2), even if it appears complete.

## 2. Readiness Scoring

[VAL-SCORE-01]

| Score | Meaning |
|---:|---|
| 0 | Missing |
| 1 | Placeholder |
| 2 | Integrated |
| 3 | Verified |
| 4 | Release-ready |

Category readiness is the average of its scored requirements, normalized to 100%. Overall weighted readiness is:

`Systems × 25% + Content and Narrative × 25% + Art/UI × 20% + Audio × 10% + QA × 15% + Release × 5%`

Release requires all of the following:

- Overall weighted readiness of at least 90%.
- No Must-have/P0 requirement below Verified (3).
- No open P0 or P1 defect.
- Complete English and Thai localization coverage.
- Windows and Web release candidates pass their required suites.

## 3. Defect Severity and Gate Rules

[VAL-DEFECT-01]

| Severity | Definition | Gate effect |
|---|---|---|
| P0 | Data loss, security/legal failure, launch failure, campaign cannot complete | Stops all promotion/release |
| P1 | Soft-lock, major progression/story failure, unusable controls/UI, missing Must-have content | Stops affected gate and release |
| P2 | Noticeable defect with a practical workaround; quality below target | Must be triaged and assigned before promotion |
| P3 | Minor cosmetic/text/polish defect | May defer with documented owner and rationale |

Reopening a verified defect invalidates the associated evidence and readiness score until retested.

## 4. Evidence Bundle

[VAL-EVIDENCE-01] Each gate produces a stored evidence bundle containing:

- Build identifier, commit/diff reference, date, tester and platform.
- Automated command, output and exit code.
- Test-case IDs and Requirement IDs.
- 1280×720 screenshots for affected screens/levels in English and Thai.
- Short recording for animation, boss phases, dialogue timing or soft-lock-sensitive flows.
- Save fixtures before and after migration tests.
- Asset technical reports for grid, alpha, dimensions, import and memory.
- Known defects, readiness scores and human approvals.

Screenshots must show the runtime build, not only editor previews. Evidence is replaced when a dependent asset, layout, data contract or algorithm changes materially.

## 5. Automated Validation

[VAL-AUTO-01] Automated checks must fail loudly and return a non-zero status when a Must-have contract breaks.

### Catalog and Scene Integrity

- Four canonical operators load and point to valid scenes/data.
- Five canonical levels load, are registered for navigation/unlocks and contain valid spawn/extraction bounds.
- Every level declares threat quota, boss ID/name key, biome, briefing, radio, debrief and mission phases.
- Every level declares encounter segments, enemy roster, tile/background kit IDs, boss pattern set and projectile cap.
- Every referenced scene, texture, audio file, localization key and dialogue entry exists.
- Canonical IDs are unique and never localized.

### Mission and Gameplay State

- Mission starts in `CLEAR_THREATS`.
- Quota completion triggers the configured boss once and enters `BOSS_ACTIVE`.
- Boss defeat enters `EXTRACTION` once; the portal cannot complete the mission earlier.
- Death/retry resets combat state without duplicating rewards or one-shot story flags.
- All required routes are reachable by the slowest/least mobile allowed operator configuration.
- Each passive applies only to its operator and respects its exact minimum/maximum rules.
- Base Technology and Mastery ranks clamp to 0–5 and spend currency exactly once.

### Save and Migration

- New profile uses schema v2 and English by default.
- Valid legacy saves migrate existing currency, upgrades, selection and campaign progress.
- Duplicate character Blade/Engine/Armor tracks retire according to the approved migration mapping.
- Language, mastery, story stage and seen sequences persist through restart.
- Invalid/missing fields recover to documented defaults without deleting valid progress.
- Interrupted/corrupt save handling follows backup/recovery policy.

### Dialogue and Localization Data

- Every English key has one Thai entry and every Thai key exists in English.
- Placeholder names/counts match between languages.
- Dialogue sequence entry IDs, trigger IDs and completion actions match between languages.
- Speaker IDs, portrait expressions and next-entry references are valid.
- No runtime user-facing raw string is introduced outside allowed diagnostic/developer text.

## 6. Gameplay Validation

[VAL-GAMEPLAY-01]

For each operator × level combination, test:

1. Briefing start, skip and completion.
2. Spawn, movement, jump, fall, dash and attack responsiveness.
3. Route reachability, collision, camera bounds and hazard recovery.
4. Threat quota counting, enemy death and sample collection.
5. Three radio triggers during normal play and under active combat.
6. Boss introduction exactly once, all phases, telegraphs, damage, defeat and retry.
7. Extraction, debriefing, rewards and next-level unlock.
8. Death/retry before quota, during boss and after boss.
9. Pause/settings/language changes where permitted.
10. No mission phase, boss phase, dialogue or portal can soft-lock.

Record completion time, segment splits, deaths, damage sources, currency earned/spent and boss phase duration. Each level targets 5–7 minutes from player control to extraction for a competent first-time player; initial campaign completion targets 35–50 minutes including briefings, debriefings and normal menu use. A mandatory route must contain at least three authored pre-boss beats and no more than 20 seconds of travel without a traversal choice, threat, reward or story cue.

### Boss Projectile and Danmaku Validation

[VAL-BULLET-01] Touhou-inspired patterns are accepted only when they remain readable in a side-scrolling platformer.

- Each volley resolves from a canonical `pattern_id` and is deterministic enough to reproduce defects.
- Telegraph, active and recovery timing are logged; dense patterns run for 3–6 seconds and provide at least 0.75 seconds of recovery.
- Every pattern preserves a reachable safe route at least 1.75 player widths wide for the slowest operator configuration.
- Projectiles never spawn inside the player, behind an unavoidable camera edge or under combat-critical UI.
- Concurrent projectile caps are Level 1: 18, Level 2: 32, Level 3: 36, Level 4: 48 and Level 5: 64.
- Phase change, boss death, player death/retry and scene exit remove every owned projectile and cancel pending emitters.
- Projectile silhouettes, colors, motion and warning tells remain distinct from scenery, pickups, enemy bodies and friendly cutter VFX.
- Windows and Web captures verify 60 FPS at the level cap while enemies, VFX and radio UI are also active.

## 7. Story Validation

[VAL-STORY-01]

- Briefings play once at the correct campaign stage and are replay-safe.
- Skipping any sequence produces the same gameplay/story state as completing it.
- Death/retry does not duplicate one-shot dialogue, rewards or unlocks.
- Radio dialogue never pauses combat, steals gameplay input or covers combat-critical HUD/telegraphs.
- Boss introductions trigger exactly once per attempt according to the approved retry rule.
- Debriefing completes before next-mission unlock presentation.
- Operator barks match the selected operator and do not replace required shared information.
- English and Thai sequences have identical entry IDs, triggers, conditions and completion actions.
- The five reveals occur in order: coordinated signal, data-bearing spores, seed/relay/harvester truth, sensory-core awakening, dormant fragment.
- Human review approves character voice, Thai regional sensitivity, scientific clarity and sequel-hook restraint.

## 8. Localization Validation

[VAL-LOC-01]

- English is active on a fresh profile.
- Settings offers `English` and `ไทย`; selection persists after restart.
- Switching language updates the current screen without reload or progress loss.
- Missing/invalid translations visibly fall back to English and create a diagnostic warning.
- All user-facing UI, objectives, tutorials, display names, descriptions, dialogue and dynamic HUD messages use keys.
- Dynamic text uses named/indexed placeholders; neither language depends on string concatenation order.
- Latin and Thai glyphs, combining marks, numerals, punctuation and line breaks render correctly.
- Pseudo-localization tests at least 35% expansion and exposes clipping/overlap.
- Windows and Web render equivalent Unicode strings and font fallback.
- Images contain no baked language-specific UI text.
- Thai translation receives human fluency/tone review; machine parity alone is insufficient.

## 9. Asset and Visual Validation

[VAL-ASSET-01]

### Source checks

- Dimensions, format, color space, alpha mode and editable master are recorded.
- Opaque pixel-art sprites, tiles, portraits and UI use binary alpha (0 or 255) unless a reviewed asset-specific exception defines a small discrete alpha palette; continuous anti-aliased edge alpha fails validation.
- Translucent VFX, fog and glow may use intermediate alpha only when the exception is recorded and runtime contrast, halo and readability checks pass.
- Sprite grid/cell/gutter mapping is exact; every animation frame belongs to only one cell.
- Transparent borders are cropped enough for memory and pivot consistency without cutting motion.
- Provenance and commercial-use rights are recorded.

### Runtime checks

- No white/colored halo, neighboring action, matte, seam or texture bleed is visible.
- Feet remain on the intended baseline through idle/run/attack; jump/fall movement is intentional.
- Animation speed, anticipation, contact and recovery are readable and smooth.
- Import filtering prevents unintended blur without producing unacceptable shimmer.
- UI panels do not stretch corners/ornaments; use nine-slice/layout-safe construction.
- At 1280×720, every screen is checked for stretch, blur, clipping, halos, overlap and text overflow in English, Thai and pseudo-localization.
- Level-selection icons do not obscure important landmarks and remain keyboard-focus readable.
- Boss/hazard telegraphs contrast against the current biome and remain visible during VFX-heavy combat.
- Every biome provides at least four readable parallax layers, one foreground set, one landmark, a primary tile kit with caps/corners/transitions, a signature hazard treatment and a distinct extraction treatment.
- Two levels may reuse shaders, tools and technical materials, but may not pass diversity review through palette swaps or shared primary tiles alone.
- Enemy silhouette, movement role and attack tell diversity match the approved per-level roster; every level introduces at least one new family or meaningful mechanic variant.
- Every organic enemy and boss has one approved primary Thai-fruit identity; its source sheet maps at least three fruit structures to anatomy and at least one to a mechanic.
- Each source sheet records English/Thai fruit names and evidence that the fruit
  is grown in Thailand or is clearly familiar in Thai local food/market culture.
- Fruit identity remains recognizable in silhouette/value review rather than depending only on hue; generic alien plants, pasted-on fruit and palette-only variants fail validation.
- Roots, vines, fungi and capsule tissue read as secondary connective biology,
  never as a replacement for the primary fruit identity.
- Standard families sharing a level use different primary fruits. A two-fruit
  boss retains one dominant gameplay-scale identity and passes a clutter review.
- Fruit-derived projectiles and hazards remain distinguishable from pickups, scenery, player VFX and one another at gameplay scale.
- Texture and atlas memory is measured on Web, not inferred from disk size.

### Inspiration and Originality Review

[VAL-REFERENCE-01]

- Movement response, melee spacing, enemy placement, atmosphere and boss rhythm are reviewed against the approved Hollow Knight/Castlevania principles.
- The build is not required to reproduce an interconnected Metroidvania structure; the five short linear missions remain authoritative.
- Touhou-style density appears only in approved boss phases and never replaces normal melee-platform combat.
- Maps, room layouts, silhouettes, animation poses, UI frames, icons, dialogue, music and exact attack patterns receive an originality review; recognizable copying fails the gate.
- Reference screenshots may explain a principle internally but may not be traced, shipped, or used as final asset texture content.

## 10. Audio Validation

- Music loops without audible clicks or silence gaps.
- Cutter, threat and boss telegraphs remain distinguishable in the full mix.
- Repeated actions vary without excessive pitch artifacts.
- UI, radio, victory and defeat events trigger once and obey volume settings.
- Pausing, retrying and changing scenes do not layer duplicate loops.
- Windows and Web playback timing is equivalent enough not to change combat readability.
- All audio files have recorded provenance/license and no voice-over dependency.

## 11. Performance and Stability

[VAL-PERF-01]

- Target 60 FPS at 1280×720 on supported Windows hardware and supported Web browsers.
- Web peak memory remains below 512 MB through a complete mission and scene transitions.
- Test worst-case enemy, projectile, VFX, boss and radio overlap.
- Hold each level at its documented projectile cap for at least 60 seconds; pooled node counts must stabilize without allocation growth or cleanup leaks.
- Run a 30-minute soak including repeated combat, pause, retry, language switching and scene transitions.
- No growing node/audio/tween count, recurring error spam, corrupted save or input loss.
- Loading and transitions remain within the approved UX budget; exact measured budgets are locked at Gate 2.

**Local soak evidence — 2026-08-31:** `tools/run_release_validation.ps1 -SkipExport -RunSoak -SoakSeconds 1800` passed at 1,800.6 seconds with 269
cycles, 3,227 scene mounts, 263 peak nodes, zero active SFX growth and 623.1
MB peak local allocator usage. This satisfies the local scene-transition soak
check; it does not satisfy the separate Web-browser peak-memory requirement.

**Projectile-cap hold evidence — 2026-08-31:**
`tools/run_soak_validation.ps1 -DurationSeconds 301 -ProjectileCapHoldSeconds 60`
passed all five levels at 60 seconds per documented cap, with 12 scene mounts,
455 peak nodes and zero SFX growth. Cap assertions covered the active projectile
array, pooled projectile array and cleanup after boss deactivation and scene
exit. The 628.1 MB measurement is local allocator usage and is not a Web
browser-memory result.

## 12. Platform and Release Matrix

Minimum release matrix:

- Windows exported build: new game, migration, full campaign, settings, save recovery and soak.
- Web build in each supported browser: new game, full campaign smoke, Unicode/font, audio unlock, memory and save persistence.
- Keyboard/mouse controls at 1280×720; additional resolutions may be supported but cannot break this reference layout.

**Browser execution note — 2026-08-31:** The required in-app browser attempt
could not initialize because the browser-control kernel exited during startup
with a Windows ACL helper error. No browser gameplay or Web-memory claim is
made from that attempt; a connected browser remains required for the Web
execution and `<512 MB` peak-memory checklist items.

The repeatable Gate 6 command is `tools/run_release_validation.ps1`. It runs the structure, localization and release-readiness checks, the runtime enemy-art binary-alpha check (`tools/quantize_runtime_alpha.py --check`), the Godot smoke scene, fresh Web and Windows exports, `tools/validate_export_artifacts.ps1`, an exported-build bilingual self-test (`tools/validate_export_localization.ps1`), and a three-second headless Windows launch. Use `-SkipExport` for fast regression checks against an existing build root. Add `-RunSoak -SoakSeconds 1800` to run the full scene-transition soak; use a smaller positive duration for a local smoke. Passing the runner does not replace exported-build gameplay, performance, memory, browser or human sign-off evidence.

The smoke scene also instantiates every operator and exercises the passive
contracts at runtime: sample-threshold healing, dash cooldown reduction, attack
area growth and minimum-one damage reduction. It checks rank-0 and rank-3
mastery strengths against the canonical formulas so passive tuning cannot drift
silently from the English design contract.

It also exercises the progression purchase boundary: Base Technology and
Operator Mastery apply one rank at a time, charge the exact canonical cost,
reject invalid IDs and refuse purchases at rank 5 without changing currency.
The legacy character-upgrade accessor must continue to resolve to the shared
Mastery rank during migration support.

## 13. Release Sign-off

[VAL-RELEASE-01]

- [ ] All Gate 0–6 exit criteria are evidenced.
- [ ] Overall weighted readiness is at least 90%.
- [ ] No Must-have/P0 requirement is below Verified.
- [ ] No P0/P1 defect is open.
- [ ] Levels 1–5, all bosses, passives, Mastery and campaign ending pass.
- [ ] Every level meets the 5–7 minute pacing contract and biome-diversity review.
- [ ] All boss patterns preserve safe routes, caps, cleanup and Windows/Web performance.
- [ ] New-profile and legacy-save migration/recovery pass.
- [ ] English/Thai key, placeholder, dialogue-entry and glossary parity pass.
- [ ] English is the default and live language switching persists.
- [ ] Art/UI/animation checks pass at 1280×720 without stretch, blur, halos or clipping.
- [ ] Windows/Web performance, memory, Unicode, audio and 30-minute soak pass.
- [ ] Asset provenance/licenses and Release-ready approvals are recorded.
- [ ] Documentation links, IDs, asset states and English/Thai parity are verified.
- [ ] Human approvals for story, Thai translation, artwork, animation, boss feel, accessibility and balance are signed.
