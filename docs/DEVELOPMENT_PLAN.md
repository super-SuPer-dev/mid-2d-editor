# Development Plan

**Project:** Low Attitude Warrior
**Version:** 2.0  
**Status:** Production roadmap  
**Authority:** This English document is the only maintained production roadmap. Existing Thai documents are frozen references.

This plan converts the design in [Game Design Document](../Game%20Design%20Document.md) into reviewable production gates. It is organized for a solo developer using agent-assisted implementation. Dates are intentionally omitted: a gate closes only when its exit criteria are evidenced.

## 1. Current-State Audit

[DEV-AUDIT-01] The current build is a useful prototype, not a content-complete campaign.

| Area | Current state | Release gap |
|---|---|---|
| Core play | Side-scrolling movement, jump, dash, cutter attack, damage, pickups, quota, three-phase mission controller, gated boss lifecycle and extraction | Full-campaign encounter tuning, retry/recovery coverage, accessibility and release-platform feel validation |
| Campaign | Three authored levels selectable from a map | Retrofit Levels 1–3 and build Levels 4–5 |
| Operators | Tonkla, Rin, Khem, and T-800 share controls and animation structure | Passives, mastery, full production animation contracts |
| Enemies | Thornling, spitter, and maw behaviors | Three more standard families, biome-specific rosters, distinct art, tuning and telegraphs |
| Bosses | Thorn Matriarch has a health-driven two-phase projectile contract; all five bosses have validated phase/pattern data and pooled caps | Dedicated behavior, production art/animation, hazards, tuning and human feel approval for all five bosses |
| Progression | Base Technology, Operator Mastery, save schema v2, legacy ID/track migration, and story-stage advancement are implemented | Economy and milestone tuning, recovery testing, and full-campaign persistence validation |
| Story | Data-driven briefing, quota-radio, boss-introduction and debrief flow with one-shot state; Level 1 handoff is runtime-validated | Complete Level 2–5 narrative volume, authored trigger review, pacing and human story approval |
| Localization | English-default live switching, English fallback, three bilingual tables, and localization-key-only scene defaults are implemented and validated | Pseudo-localization, human Thai review, and Windows/Web parity evidence |
| UI/UX | Main flows work; dialogue/boss HUD, shared operator cards and Base Workshop cards are bilingual and runtime-validated at 1280×720; main menu, mission map, settings and mastery passed live bounds review | Pseudo-localization, accessibility options, responsive resolutions and Windows/Web evidence |
| Art | 474 generated PNG candidates inventoried; the repeatable validator confirms 474/474 decode and 188/188 normalized widths, but 335 opaque-art candidates still warn on soft alpha; one quantized Root Skitter idle/scuttle pilot is now integrated | Remediate/select remaining candidates, verify package grids and animation, integrate approved art, then validate Windows/Web appearance and memory |
| Audio | One click sound is repitched for multiple events | Music suite, approximately 40 SFX, mix and platform validation |
| QA | Isolated smoke test covers four operators, five-level catalogs/dialogue references, all five runtime levels, boss patterns, v1→v2 migration, one-shot story state, language fallback, and pseudo-localization | Retry/recovery, export, performance, soak coverage, and human campaign playtest |

## 2. Production Principles

- [DEV-PRINCIPLE-01] Lock IDs and data contracts before creating dependent content.
- [DEV-PRINCIPLE-02] Level 1 is the production slice and quality benchmark.
- [DEV-PRINCIPLE-03] Every implementation task must be small enough to review, test, and roll back independently.
- [DEV-PRINCIPLE-04] Generated assets remain provisional until technical and visual review is complete.
- [DEV-PRINCIPLE-05] Human review is mandatory for story tone, Thai translation quality, animation, artwork, boss feel, accessibility, and final balance.
- [DEV-PRINCIPLE-06] English content is written first; Thai content is delivered in the same feature slice.
- [DEV-PRINCIPLE-07] Every mission is authored for a 5–7 minute completion target and must have a distinct traversal rhythm, encounter mix, enemy roster, tile kit, background stack and boss pattern identity.
- [DEV-PRINCIPLE-08] Hollow Knight and Castlevania are the primary feel references; Touhou is secondary and applies only to selected projectile phases. Reference analysis may identify principles, but production content must remain visually, mechanically and narratively original.
- [DEV-PRINCIPLE-09] Thai local fruit morphology is the mandatory primary enemy and boss theme. Every organic hostile family locks one fruit reference, silhouette, material language and mechanic before animation production; fruit recognition may not reduce combat readability or become a palette-only variant.
- [DEV-PRINCIPLE-10] Enemy and boss concept approval requires a fruit identity sheet mapping at least three fruit structures to hostile anatomy and at least one to gameplay. Generic alien plants, pasted-on fruit, and recolored shared bodies do not proceed to animation.
- [DEV-PRINCIPLE-11] The generated-source audit is evidence, not approval. Opaque sprites, tiles, portraits and UI must resolve the soft-alpha blocker before large-scale integration; intentional translucent VFX require a documented exception and runtime readability test.

## 3. Agentic Task Contract

[DEV-TASK-01] No agentic implementation task is ready until it defines all fields below.

| Field | Required content |
|---|---|
| Objective | One observable player or production outcome |
| Inputs | Requirement IDs, data contracts, reference art, affected scenes and dependencies |
| Permitted files | Explicit files/directories that may be changed |
| Outputs | Code, data, assets and documentation expected |
| Required tests | Automated commands and manual scenarios |
| Localization impact | New/changed keys, placeholders, tables and parity checks |
| Evidence | Logs, screenshots at 1280×720, recordings when timing matters, and asset metadata |
| Rollback condition | Failure threshold and files/data that must be restored |
| Human review | Named judgment that automation cannot approve |

Agents must preserve unrelated worktree changes. A task that discovers a contract conflict stops at a documented proposal; it does not silently redefine canonical IDs or scope.

## 4. Gate Roadmap

### Gate 0 — Design and Narrative Lock

[DEV-GATE-00]

**Inputs:** Current prototype, old design notes, the rewritten GDD, current asset directories.  
**Work:** Finalize the authoritative English documents; lock NPC, operator, enemy, boss, level, localization and requirement IDs; approve the inspiration hierarchy, originality boundaries, glossary terms, five-act progression, the 5–7 minute mission budget, Thai-fruit mutation matrix, biome diversity matrix, boss pattern IDs and per-level projectile caps. Existing Thai documents are frozen references and are not gate deliverables.
**Exit criteria:**

- The authoritative GDD, development plan, asset register and validation protocol exist and cross-link correctly.
- Canonical IDs are defined once in English documentation and match runtime data.
- Story and scope receive human approval.
- The Thai local-fruit enemy bible is approved: every planned organic enemy and
  boss has a locked fruit identity, structural/mechanical mapping, and distinct
  per-level silhouette role.
- Every known asset is represented in the asset register.
- The generated-source audit blockers have owners and remediation decisions; no candidate is called production-ready from file integrity alone.
- No Must-have requirement is ambiguous.

### Gate 1 — Production Foundation

[DEV-GATE-01]

**Inputs:** Gate 0 documents and locked IDs.  
**Work:**

- Add `localization/ui.csv`, `localization/story.csv`, and `localization/glossary.csv`.
- Make English the new-profile default and add live English/ไทย selection.
- Replace user-facing hardcoded strings with keys and English fallback.
- Extend level data with quota, boss, biome, mission phases, story sequences, encounter segments, enemy roster, tile/background kit IDs, boss pattern set and projectile cap.
- Implement `CLEAR_THREATS → BOSS_ACTIVE → EXTRACTION`.
- Define boss lifecycle/phase/health signals.
- Implement a reusable, pooled boss-projectile pattern runner with telegraph, duration, recovery, safe-route and cleanup contracts.
- Add speaker, dialogue and story-state data contracts.
- Implement passives, Operator Mastery, and save schema v2 migration.
- Extend automated validation to five-level catalogs and localization parity.

**Exit criteria:** Fresh and migrated profiles load safely; language switching is live and persistent; a test mission can execute all three phases; dialogue can be shown/skipped without changing results; automated contract checks pass.

**Implementation evidence — 2026-08-30:** Foundation code is implemented. The headless smoke suite passes with in-memory save isolation and covers v1→v2 migration, story-stage advancement, duplicate-safe one-shot state, all five levels' story references, localization fallback, three mission phases, and pooled boss-projectile caps. The localization validator passes 165 English/Thai entries and rejects any non-key scene text. Live Godot MCP inspection confirms the fresh-profile main menu renders English. Release-platform persistence, pseudo-localization, and Windows/Web parity remain later-gate work.

### Gate 2 — Level 1 Production Slice

[DEV-GATE-02]

**Inputs:** Gate 1 foundation and approved Level 1 asset concepts.  
**Work:** Redesign and produce the complete Contaminated Grassland mission around three authored pre-boss beats and a 5–7 minute completion target. Produce the Thorn Matriarch with tutorial fan/lane projectile patterns, briefing, three radio events, boss introduction, debriefing, operator barks, English/Thai text, a distinct farmland tile/parallax kit, enemy composition, VFX, music and SFX. Replace all Level 1 placeholders required by the asset register.

**Exit criteria:** Level 1 is playable from briefing through debriefing on Windows and Web in 5–7 minutes; movement/melee response, enemy placement, atmosphere and boss punish windows meet the primary reference benchmark without copying protected expression; its three beats remain readable without empty travel or combat padding; Rambutan Thornlings, makrut-lime Spitters, and the Thorn Matriarch prove the Thai local-fruit identity standard at gameplay scale; the boss preserves its safe routes and projectile cap; it sets the approved art, animation, audio, encounter, UI and localization standard; no P0/P1 defects remain.

**Implementation progress — 2026-08-30:** The native Level 1 route is extended from 2,700 to 4,300 px and now contains three reusable encounter gates with 2/3/3 threat assignments, eight total standard threats, nine traversal platforms, four thorn hazards, six samples, and a 375-second authored pacing budget. Automated tests prove unique threat assignment, physical player-overlap activation, barrier release, quota → boss → extraction, projectile cleanup, and jump-step reachability. Live Godot MCP play confirms the first gate activates both assigned Thornlings. The Thorn Matriarch now uses a health-driven two-phase contract: the readable three-way fan is isolated to phase 1, half health starts the alternating-lane phase, the transition clears all owned bullets before the new telegraph, and the bilingual HUD displays the current phase. The smoke suite verifies phase selection, GameManager propagation, phase-change cleanup, phase-2 emission, cap enforcement, shutdown cleanup, and defeat cleanup; live Godot MCP inspection confirmed `Phase 1/2 → Phase 2/2` with zero active bullets at the transition. Timed human 5–7 minute playtesting, final art/animation, music/SFX, Windows/Web evidence, safe-route and punish-window approval, and human feel review remain before Gate 2 can close.

**Narrative handoff evidence — 2026-08-30:** Level 1's three quota-driven radio sequences are requested exactly once in canonical order and remain non-pausing. When several calls are queued, the Thorn Matriarch and its projectile runner now stay disabled until the radio queue reaches the boss introduction and that introduction completes. The pre-fight HUD is initialized with full health and the correct `Phase 1/2` contract instead of stale defaults. Automated tests cover order, duplicates, pause state, pre-intro inactivity, HUD preview data, and post-intro activation across the implemented levels. Live Godot MCP inspection confirmed a compact radio call at `Threats 2/8`, then the paused boss introduction with boss combat inactive, full health, and `Phase 1/2`; completing the introduction changed both boss and runner to active.

**Operator-select UI evidence — 2026-08-30:** The shared operator-card source now reserves a compact aspect-correct portrait column, uses a consistent two-line statistics hierarchy, and gives localized role and description text the remaining width. Font-measured wrapping inserts breaks only at spaces, so English no longer splits words such as “repositions,” “wider,” or “advancing”; Thai glyphs and longer labels remain inside the same 1280×720 cards. Smoke tests validate both locales, character preservation across inserted line breaks, maximum line counts, non-clipping descriptions, card bounds, and button bounds. Live Godot MCP screenshots verified all four English and Thai cards without stretch, overlap, clipping, or mid-word breaks.

**Main-flow UI audit evidence — 2026-08-30:** Live Godot MCP review covered the main menu, mission map, Base Workshop, settings and operator mastery at 1280×720 in English and Thai. The workshop Engine description no longer produces the visible `pe\nr` split: the shared row disables arbitrary engine wrapping and the screen binder now reflows font-measured text only at spaces after locale or viewport changes. Automated tests prove source-text preservation, a three-line ceiling, disabled clipping/autowrap, card bounds and purchase-button bounds for all three upgrades in both locales. The Thai mastery description now uses complete Thai terminology instead of exposing the English words “passive” and “milestone.” Live screenshots verified the final English `+5% movement and +4% dash speed\nper level` and the corresponding Thai wrap without overlap or clipping. Pseudo-localization, non-native resolutions, accessibility options and Windows/Web evidence remain before Gate 2 closes.

### Gate 3 — Retrofit Levels 2–3

[DEV-GATE-03]

**Inputs:** Approved production slice.  
**Work:** Retrofit the Mutated Forest and Roots Beneath Capsule 07 using the approved standard and separate 5–7 minute grayboxes. Give each level a unique route topology, tile/parallax kit, landmark, hazards and enemy roster. Add the projectile-heavy Maw Bloom Sovereign with spore rain, rotating volleys and aimed bursts; add the Possessed Banyan with seed columns, diagonal root lines and arena-control phases; complete bilingual sequences, environmental storytelling, audio and the midpoint Capsule 07 reveal.

**Exit criteria:** Levels 1–3 form a stable narrative arc; bosses and environments are mechanically distinct; unlock/retry/story state is stable; routes work for every operator.

### Gate 4 — Build Levels 4–5

[DEV-GATE-04]

**Inputs:** Stable three-level campaign.  
**Work:** Build separate 5–7 minute routes for Devouring Root Marsh and Alien Eye Nexus with unique traversal, tile/parallax kits, foregrounds, hazards, enemy rosters and landmarks. Produce the projectile-heavy Root Hydra with multi-origin crossfire, rings and lane walls, and the Root-Core Eye with spirals, aimed rings and bullet curtains. Complete final enemy families, ending sequences, campaign completion and post-ending state.

**Exit criteria:** The five-level campaign is completable without developer intervention; ending and restrained sequel hook play once at the correct stage; Windows and Web campaign tests pass.

**Greybox implementation evidence — 2026-08-31:** Dedicated `level_04.tscn` and `level_05.tscn` scenes now route through `SceneManager.play_level`, use distinct marsh/nexus parallax palettes and landmark overlays, provide seven/eight authored platform steps with hazards, six roster-valid threats, samples, portals and dedicated bosses. `root_skitter`, `marsh_spitter`, `eye_wisp`, `capsule_husk_elite`, `mixed_elite`, `root_hydra_boss` and `root_core_eye_boss` now have explicit runtime contracts instead of falling through to generic defaults. The Godot smoke suite validates both scenes through quota → queued radio/boss introduction → three-phase projectile pattern → boss defeat → extraction, plus projectile cleanup and 100 px jump-step reachability. Live Godot MCP screenshots verified `Devouring Root Marsh` and `Alien Eye Nexus` at 1280×720 with readable HUDs and no screen stretch. Final generated pixel-art tiles, foreground props, fruit-specific enemy art/animation, audio, ending polish, Windows/Web builds and human 5–7 minute playtest remain required before Gate 4 closes.

**Generated-asset audit evidence — 2026-08-31:** `tools/validate_generated_assets.ps1` now provides a repeatable, memory-safe source audit. It scanned all 474 PNG candidates (831,196,936 bytes), decoded 474/474, confirmed 188/188 normalized strips have widths divisible by four, found nearby Markdown provenance for 450/474 files, and reported 335 opaque-art soft-alpha warnings. The validator intentionally leaves candidates in `Review`; binary-alpha remediation, per-package grid/pivot/baseline review, runtime promotion, and human pixel-art approval remain open.

**Generated-asset promotion evidence — 2026-08-31:** The Root Skitter (salak) package now has a reversible runtime pilot. Seven source actions were normalized to 4 × 700 × 800 strips with a 740 px baseline and threshold-128 binary alpha; idle and scuttle are wired to the Level 4 enemy controller with nearest filtering, floor offset and measured 5.5/8 fps timing. Godot MCP runtime inspection confirmed `hframes=4`, the promoted texture path, `position.y=-17`, and frame advancement. The package remains `Integrated` rather than `Verified` pending visual silhouette, animation-continuity and combat-scale review; the other five actions still need binding.

**Campaign ending evidence — 2026-08-31:** The smoke suite now triggers the real Level 5 portal callback after boss defeat and proves the run ends before debrief presentation, the debrief is requested exactly once, its one-shot state is recorded, story stage reaches the final act, and the campaign-complete modal opens only after the dialogue queue drains. This closes the sequencing contract for the current greybox; ending art, final audio, platform exports and human tone review remain open.

**Retry and recovery evidence — 2026-08-31:** The smoke suite now deals lethal damage to a live operator, verifies `GameManager.run_active` becomes false, the game pauses, and the game-over modal is visible, then recreates the same level as a retry. The retry resets health and reactivates the mission without replaying the completed one-shot briefing or duplicating its request. Save writes remain disabled inside the test session, so this check cannot mutate a developer profile.

### Gate 5 — Campaign Polish

[DEV-GATE-05]

**Inputs:** Feature-complete campaign.  
**Work:** Balance economy, Base Technology, Mastery and passives; polish cutter feel, telegraphs, VFX, animation timing, dialogue pacing, tutorials, accessibility, UI layouts, mix and translation. Run pseudo-localization and full asset review.

**Exit criteria:** Every mission meets the 5–7 minute target without HP inflation or dead traversal; projectile patterns are readable and performant; each biome passes the diversity review; English and Thai reviews are approved; all Must-have assets are at least Verified; weighted readiness is at least 85% with a credible path to release.

### Gate 6 — Release Hardening

[DEV-GATE-06]

**Inputs:** Polished release candidate.  
**Work:** Regression, full-campaign, save recovery, 30-minute soak, performance, memory, browser, Windows export, Unicode, documentation and provenance verification.

**Exit criteria:** Weighted readiness is at least 90%; no Must-have item is below Verified; no P0/P1 defects are open; English and Thai coverage is complete; release checklist is signed off.

## 5. Dependency Order

1. Canonical IDs, glossary and save contract.
2. Localization, mission phases, boss interface, story data and automated checks.
3. Five mission grayboxes, encounter timing budgets and a boss-pattern laboratory.
4. Level 1 production slice and its farmland diversity kit.
5. Reusable enemy, projectile, boss and content pipelines proven by Level 1.
6. Levels 2–3 retrofit with dedicated biome kits and rosters.
7. Levels 4–5 production and campaign ending.
8. Balance, accessibility, localization review and release hardening.

Art concepts, music exploration and translation drafting may proceed in parallel, but integration waits for their dependent contracts. A boss cannot be marked Integrated before its mission phase, health signal, defeat signal and retry behavior exist.

### 5.1 Level, Boss, and Diversity Redesign Package

[DEV-LEVEL-01] Each level is delivered through the same five milestones: timing graybox, enemy/hazard pass, boss-pattern laboratory, biome art pass, and integrated timing/polish review.

| Level | Traversal and encounter identity | Fruit mutation identity | Boss projectile identity | Required visual diversity |
|---|---|---|---|---|
| 1 — Contaminated Grassland | Irrigation channels, low farm roofs and destructible crop lanes; three teaching beats | Rambutan Thornlings and makrut-lime Spitters | Hair-thorn fans and citrus-seed lanes with generous recovery | Grass/soil/concrete tile kit, rural props, four-layer farmland parallax and crash-smoke landmark |
| 2 — Mutated Forest | Vertical canopy routes, fungal shelves and falling-spore decisions | Young-mangosteen Maws; durian-crown Sovereign | Spore rain, rotating five-way volleys and player-aimed seed bursts | Bark/moss/fungal tile kit, dense canopy layers, luminous spores and Maw Bloom landmark |
| 3 — Roots Beneath Capsule 07 | Impact tunnels, root lifts and short chamber locks | Santol Capsule Husks and jackfruit-banyan boss | Jackfruit seed columns and diagonal root lines supporting arena control | Capsule shell/root/membrane kit, subterranean depth layers and exposed seed landmark |
| 4 — Devouring Root Marsh | Sinking islands, moving root rafts and toxic-water route swaps | Salak Root Skitters and nipa-palm Hydra | Multi-head cluster crossfire, expanding rings and moving water-lane walls | Mud/reed/conduit kit, mist/water parallax and nutrient-conduit landmark |
| 5 — Alien Eye Nexus | Shifting eye platforms, elite remixes and a compact final ascent | Longan Eye Wisps and dragon-fruit-bract Root-Core Eye | Seed-eye spirals, aimed rings and bullet curtains with deterministic safe routes | Membrane/neural-root/core kit, pulsing depth layers and the Root-Core Eye landmark |

Every graybox must fit entry, three authored pre-boss beats, a 75–120 second boss and extraction inside the 5–7 minute target before final art begins. Optional sample routes may add no more than 45 seconds. Enemy health, travel distance and repeated waves may not be increased merely to fill time.

Boss pattern data must expose `pattern_id`, phase, telegraph duration, active duration, recovery duration, projectile speed/range, projectile cap, spawn origins, safe-route rule and cleanup event. Pattern tests use the level caps defined by [GDD-BULLET-01] and must clear all bullets on phase change, death, retry and scene exit.

Enemy and boss asset tasks must name the primary fruit reference and identify
which rind, seed, flesh, calyx, cluster, sap or root traits support silhouette,
telegraph and attack behavior. Human art review confirms cultural
recognizability and rejects generic alien-plant designs before full animation.
Previously approved animation is revised with targeted fruit cues where
possible rather than discarded automatically.

Each hostile source package records `fruit_identity_id`, English and Thai fruit
names, local-growth/cultural reference notes, three or more structural mappings,
one or more mechanic mappings, the dominant gameplay-scale read, and grayscale
silhouette evidence. Roots, vines, fungi, and alien tissue are supporting
materials only. Two standard families in the same level cannot share a primary
fruit; a boss may recombine no more than two fruits and must retain one dominant
identity.

Production order for each hostile family is: fruit identity sheet → silhouette
and value test → idle/attack key pose → gameplay-readability review → complete
animation and projectile set → runtime validation. The family cannot enter
full animation production until the identity sheet records three structural
mappings and one mechanic mapping. Fruit reference photography or research is
reference-only; shipped designs remain original alien mutations.

## 6. Workstreams and Ownership Evidence

| Workstream | Primary outputs | Required evidence |
|---|---|---|
| Systems | Data catalogs, mission phases, save v2, localization, dialogue, progression | Automated results, migration fixtures, state logs |
| Gameplay | Operators, enemies, bosses, hazards, balance | Encounter recordings, frame data, input/retry tests |
| Narrative | English script, Thai translation, trigger map, glossary | Entry-ID parity report, human tone review |
| Art/UI | Characters, worlds, VFX, portraits, responsive screens | Source metadata, alpha/grid report, 1280×720 screenshots |
| Audio | Music, SFX, event map, mix | Loudness/loop review, platform capture |
| QA/Release | Test matrix, defects, exports, performance | Evidence bundle and signed release report |

## 7. Risk Register

| ID | Risk | Mitigation | Trigger |
|---|---|---|---|
| DEV-RISK-01 | Five bespoke bosses exceed solo capacity | Reuse lifecycle/state interfaces, not visual identities; approve Level 1 benchmark first | Boss misses two gate reviews |
| DEV-RISK-02 | Generated sprites contain bleed, halos or unstable baselines | Enforce source grid, alpha, gutter, pivot and motion tests before integration | Any contaminated frame in runtime capture |
| DEV-RISK-03 | Hardcoded text creates late localization debt | Key-first rule and parity test in Gate 1 | Raw user-facing string is added |
| DEV-RISK-04 | Web memory/performance degrades with large textures | Atlas budgets, import settings, profiling per gate | Web memory exceeds 400 MB during production test |
| DEV-RISK-05 | Radio text harms combat readability | Compact safe-area layout, queueing, combat screenshot review | Dialogue covers HUD/telegraph or blocks input |
| DEV-RISK-06 | Save migration loses player progress | Versioned migration, backups, fixtures for old schemas | Any migrated fixture changes unlocks/currency unexpectedly |
| DEV-RISK-07 | Agent work overwrites unrelated edits | Explicit permitted-file list and diff review | Diff includes an undeclared file |
| DEV-RISK-08 | Dense boss bullets become unfair or exceed Web performance | Pattern caps, pooled projectiles, deterministic safe routes, contrast tests and worst-case profiling | Safe route disappears, frame target fails or projectile count exceeds contract |
| DEV-RISK-09 | Biomes feel like palette swaps or diversity scope grows without control | One approved tile/background/landmark kit and roster matrix per level; reuse systems rather than visual identity | Two levels share a primary tile kit, route silhouette or boss pattern set |
| DEV-RISK-10 | Reference use drifts into imitation or makes Touhou-style bullets dominate the core game | Review principles separately from protected expression; require original ACO silhouettes, maps, UI, music and patterns; keep projectile-heavy phases bounded | A review identifies a recognizable copied asset/layout/pattern or normal encounters become bullet-hell combat |

## 8. Definition of Ready

A feature is ready for implementation when:

- Its Requirement IDs and canonical data IDs are locked.
- Dependencies and permitted files are listed.
- English text and localization-key intent are known.
- Thai impact is assigned, even if the approved translation follows later in the same slice.
- Required assets have register entries and acceptance criteria.
- Automated and manual test cases are defined.
- A rollback condition and human reviewer are named.

## 9. Definition of Done

[DEV-DONE-01] A feature is done only when code/content, English and Thai text, save behavior, tests, evidence, documentation and asset state are all updated together. “Works in editor” is not sufficient.

For release, use the scoring and checklists in [Validation Protocol](VALIDATION_PROTOCOL.md) and status ownership in [Asset Register](ASSET_REGISTER.md).
