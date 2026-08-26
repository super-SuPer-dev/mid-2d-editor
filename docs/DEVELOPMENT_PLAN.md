# Development Plan

**Project:** ACO: Capsule 07  
**Version:** 2.0  
**Status:** Production roadmap  
**Authority:** English is authoritative. See [Thai companion](th/DEVELOPMENT_PLAN_TH.md).

This plan converts the design in [Game Design Document](../Game%20Design%20Document.md) into reviewable production gates. It is organized for a solo developer using agent-assisted implementation. Dates are intentionally omitted: a gate closes only when its exit criteria are evidenced.

## 1. Current-State Audit

[DEV-AUDIT-01] The current build is a useful prototype, not a content-complete campaign.

| Area | Current state | Release gap |
|---|---|---|
| Core play | Side-scrolling movement, jump, dash, cutter attack, damage, pickups, quota, portal | Formal three-phase mission controller and boss lifecycle |
| Campaign | Three authored levels selectable from a map | Retrofit Levels 1–3 and build Levels 4–5 |
| Operators | Tonkla, Rin, Khem, and T-800 share controls and animation structure | Passives, mastery, full production animation contracts |
| Enemies | Thornling, spitter, and maw behaviors | Two more standard families, distinct art, tuning, telegraphs |
| Bosses | Generic enlarged enemy behavior used in Level 3 | Five dedicated, multi-phase bosses |
| Progression | Shared upgrades plus duplicate per-character tracks | Base Technology + Operator Mastery and save migration v2 |
| Story | No complete runtime narrative flow | Briefings, radio events, boss introductions, debriefings, story state |
| Localization | User-facing text is partly hardcoded, primarily Thai | English-default key-based localization with complete Thai parity |
| UI/UX | Main flows work; several screens use provisional generated assets | Responsive layout, dialogue UI, boss UI, accessibility and text expansion |
| Art | Generated operator/UI assets and many runtime placeholders | Approved production assets, alpha/grid validation, Levels 4–5 worlds |
| Audio | One click sound is repitched for multiple events | Music suite, approximately 40 SFX, mix and platform validation |
| QA | Smoke test covers four operators and three levels | Five-level, boss, dialogue, migration, localization and export coverage |

## 2. Production Principles

- [DEV-PRINCIPLE-01] Lock IDs and data contracts before creating dependent content.
- [DEV-PRINCIPLE-02] Level 1 is the production slice and quality benchmark.
- [DEV-PRINCIPLE-03] Every implementation task must be small enough to review, test, and roll back independently.
- [DEV-PRINCIPLE-04] Generated assets remain provisional until technical and visual review is complete.
- [DEV-PRINCIPLE-05] Human review is mandatory for story tone, Thai translation quality, animation, artwork, boss feel, accessibility, and final balance.
- [DEV-PRINCIPLE-06] English content is written first; Thai content is delivered in the same feature slice.

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
**Work:** Finalize English documents and Thai companions; lock NPC, operator, enemy, boss, level, localization and requirement IDs; approve glossary terms and five-act progression.  
**Exit criteria:**

- All eight documents exist and cross-link correctly.
- English/Thai companion files contain identical canonical IDs.
- Story and scope receive human approval.
- Every known asset is represented in the asset register.
- No Must-have requirement is ambiguous.

### Gate 1 — Production Foundation

[DEV-GATE-01]

**Inputs:** Gate 0 documents and locked IDs.  
**Work:**

- Add `localization/ui.csv`, `localization/story.csv`, and `localization/glossary.csv`.
- Make English the new-profile default and add live English/ไทย selection.
- Replace user-facing hardcoded strings with keys and English fallback.
- Extend level data with quota, boss, biome, mission phases and story sequences.
- Implement `CLEAR_THREATS → BOSS_ACTIVE → EXTRACTION`.
- Define boss lifecycle/phase/health signals.
- Add speaker, dialogue and story-state data contracts.
- Implement passives, Operator Mastery, and save schema v2 migration.
- Extend automated validation to five-level catalogs and localization parity.

**Exit criteria:** Fresh and migrated profiles load safely; language switching is live and persistent; a test mission can execute all three phases; dialogue can be shown/skipped without changing results; automated contract checks pass.

### Gate 2 — Level 1 Production Slice

[DEV-GATE-02]

**Inputs:** Gate 1 foundation and approved Level 1 asset concepts.  
**Work:** Produce the complete Contaminated Grassland mission, Thorn Matriarch boss, briefing, three radio events, boss introduction, debriefing, operator barks, English/Thai text, VFX, music and SFX. Replace all Level 1 placeholders required by the asset register.

**Exit criteria:** Level 1 is playable from briefing through debriefing on Windows and Web; it sets the approved art, animation, audio, encounter, UI and localization standard; no P0/P1 defects remain.

### Gate 3 — Retrofit Levels 2–3

[DEV-GATE-03]

**Inputs:** Approved production slice.  
**Work:** Retrofit the Mutated Forest and Roots Beneath Capsule 07 using the approved standard. Add Maw Bloom Sovereign and Possessed Banyan, distinct hazards/enemies, full bilingual sequences, environmental storytelling, audio and midpoint Capsule 07 reveal.

**Exit criteria:** Levels 1–3 form a stable narrative arc; bosses and environments are mechanically distinct; unlock/retry/story state is stable; routes work for every operator.

### Gate 4 — Build Levels 4–5

[DEV-GATE-04]

**Inputs:** Stable three-level campaign.  
**Work:** Build Devouring Root Marsh and Alien Eye Nexus, Root Hydra and Root-Core Eye, final enemy families, landmarks, ending sequences, campaign completion and post-ending state.

**Exit criteria:** The five-level campaign is completable without developer intervention; ending and restrained sequel hook play once at the correct stage; Windows and Web campaign tests pass.

### Gate 5 — Campaign Polish

[DEV-GATE-05]

**Inputs:** Feature-complete campaign.  
**Work:** Balance economy, Base Technology, Mastery and passives; polish cutter feel, telegraphs, VFX, animation timing, dialogue pacing, tutorials, accessibility, UI layouts, mix and translation. Run pseudo-localization and full asset review.

**Exit criteria:** Target playtime and difficulty are met; English and Thai reviews are approved; all Must-have assets are at least Verified; weighted readiness is at least 85% with a credible path to release.

### Gate 6 — Release Hardening

[DEV-GATE-06]

**Inputs:** Polished release candidate.  
**Work:** Regression, full-campaign, save recovery, 30-minute soak, performance, memory, browser, Windows export, Unicode, documentation and provenance verification.

**Exit criteria:** Weighted readiness is at least 90%; no Must-have item is below Verified; no P0/P1 defects are open; English and Thai coverage is complete; release checklist is signed off.

## 5. Dependency Order

1. Canonical IDs, glossary and save contract.
2. Localization, mission phases, boss interface, story data and automated checks.
3. Level 1 production slice.
4. Reusable enemy/boss/content pipelines proven by Level 1.
5. Levels 2–3 retrofit.
6. Levels 4–5 production and campaign ending.
7. Balance, accessibility, localization review and release hardening.

Art concepts, music exploration and translation drafting may proceed in parallel, but integration waits for their dependent contracts. A boss cannot be marked Integrated before its mission phase, health signal, defeat signal and retry behavior exist.

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

