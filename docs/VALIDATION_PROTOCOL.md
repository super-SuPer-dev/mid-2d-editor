# Completeness and Validation Protocol

**Project:** ACO: Capsule 07  
**Version:** 2.0  
**Status:** Mandatory gate and release protocol  
**Authority:** English is authoritative. See [Thai companion](th/VALIDATION_PROTOCOL_TH.md).

This protocol determines whether a requirement, asset, gate or build is complete. It supplements the design acceptance criteria; it does not replace human review.

## 1. Traceability

[VAL-TRACE-01] Every test result must reference at least one Requirement ID, build identifier and platform. Canonical IDs are English, stable and identical in English and Thai documents.

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

Record completion time, deaths, damage sources, currency earned/spent and boss phase duration. Level targets are 10–15 minutes for a competent first-time player and 60–90 minutes for initial campaign completion.

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
- Texture and atlas memory is measured on Web, not inferred from disk size.

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
- Run a 30-minute soak including repeated combat, pause, retry, language switching and scene transitions.
- No growing node/audio/tween count, recurring error spam, corrupted save or input loss.
- Loading and transitions remain within the approved UX budget; exact measured budgets are locked at Gate 2.

## 12. Platform and Release Matrix

Minimum release matrix:

- Windows exported build: new game, migration, full campaign, settings, save recovery and soak.
- Web build in each supported browser: new game, full campaign smoke, Unicode/font, audio unlock, memory and save persistence.
- Keyboard/mouse controls at 1280×720; additional resolutions may be supported but cannot break this reference layout.

## 13. Release Sign-off

[VAL-RELEASE-01]

- [ ] All Gate 0–6 exit criteria are evidenced.
- [ ] Overall weighted readiness is at least 90%.
- [ ] No Must-have/P0 requirement is below Verified.
- [ ] No P0/P1 defect is open.
- [ ] Levels 1–5, all bosses, passives, Mastery and campaign ending pass.
- [ ] New-profile and legacy-save migration/recovery pass.
- [ ] English/Thai key, placeholder, dialogue-entry and glossary parity pass.
- [ ] English is the default and live language switching persists.
- [ ] Art/UI/animation checks pass at 1280×720 without stretch, blur, halos or clipping.
- [ ] Windows/Web performance, memory, Unicode, audio and 30-minute soak pass.
- [ ] Asset provenance/licenses and Release-ready approvals are recorded.
- [ ] Documentation links, IDs, asset states and English/Thai parity are verified.
- [ ] Human approvals for story, Thai translation, artwork, animation, boss feel, accessibility and balance are signed.

