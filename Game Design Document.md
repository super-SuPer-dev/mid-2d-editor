# Low Altitude Warrior — Game Design Document

**Document status:** Authoritative English design specification  
**Version:** 2.0  
**Updated:** 2026-08-28
**Engine:** Godot 4.7  
**Target platforms:** Windows and Web  
**Native presentation:** 1280 × 720  
**Companion translation:** [Thai GDD](docs/th/GDD_TH.md)

English is the source of truth for IDs, mechanics, balance targets, interfaces,
and acceptance criteria. Thai is a complete optional runtime language and has a
maintained companion document. If the two documents conflict, this document
wins until the translation is synchronized.

## 1. High Concept

**Low Altitude Warrior** is a Thai science-fiction side-scrolling action
platformer with light persistent progression. A seed-like alien capsule has
crashed in northeastern Thailand and is converting farmland, forests, and
wetlands into a connected predatory ecosystem by absorbing and weaponizing the
genetics of Thai-grown fruit. A field operator uses a locally
available backpack brush cutter—modified by the Alien Containment Organization
(ACO)—to cut through hostile growth, defeat the organism protecting each root
node, and prevent planetary germination.

The game turns familiar Thai rural equipment and environments into heroic
science-fiction tools without treating them as a joke. The tone combines
grounded field operations, ecological danger, readable action, and restrained
warmth between the ACO team members.

### 1.1 Player Promise

The player should feel like a practical field specialist overcoming an
impossible alien ecosystem through movement skill, readable combat, equipment
improvement, and knowledge gained from collected samples.

### 1.2 Genre and Camera

- 2D side-scrolling action platformer
- Short authored campaign missions
- Melee-focused combat with platforming and hazards
- Light RPG statistics and persistent upgrades
- Fixed side camera with a 2× gameplay zoom

The top-down Action RPG direction in the original concept is retired. The
implemented side-scrolling movement, jumping, dashing, and melee structure is
authoritative. `[GDD-VISION-01]`

### 1.3 Inspiration Hierarchy

[GDD-INSPIRATION-01] **Hollow Knight and Castlevania are the primary gameplay
and presentation references.** They guide responsive side-scrolling movement,
deliberate melee spacing, purposeful enemy placement, atmospheric layered
environments, memorable room-scale set pieces, and bosses that reward reading
telegraphs before committing to an attack.

The project takes different strengths from the two reference families:

- **Hollow Knight:** precise movement and attack response, clean silhouettes,
  restrained combat UI, environmental mood, and boss phases built around
  learnable movement rhythms.
- **Castlevania:** deliberate platform-and-enemy composition, strong biome and
  landmark progression, dramatic monster staging, readable projectile arcs,
  and escalating castle-like encounter structure adapted to rural Thailand.
- **Touhou:** a secondary reference limited to selected boss projectile
  formations, rhythm, and safe-lane logic. It does not define the campaign
  structure, normal combat density, visual style, or overall difficulty.

These references guide quality and feel, not content replication. The game
remains a linear five-mission campaign rather than an interconnected
Metroidvania. Maps, characters, creatures, UI, music, animation silhouettes,
and exact attack patterns must be original to the ACO setting and Thai
science-fiction identity.

## 2. Product Scope

### 2.1 Audience

- Players aged approximately 12 and above
- Players who enjoy accessible action platformers and short replayable missions
- Players interested in Thai settings, unusual improvised weapons, and
  ecological science fiction
- Primary input audience: keyboard and mouse

### 2.2 Session and Campaign Targets

- One mission: 5–7 minutes from player control to successful extraction
- First campaign clear: approximately 35–50 minutes including menus and normal retries
- Replay value: sample collection, operator mastery, improved clear consistency,
  and using all four operators
- One tuned launch difficulty

### 2.3 Included Release Scope

- Five linear campaign missions
- Four selectable operators
- Six standard enemy families, with one new family or mechanically distinct variant introduced in every mission
- One dedicated boss in every mission
- Threat-clear, boss, and extraction mission phases
- Persistent Base Technology and Operator Mastery
- English and Thai runtime localization
- Portrait briefings, radio calls, boss warnings, and debriefings
- Windows and Web builds

### 2.4 Explicit Exclusions

The initial release does not include multiplayer, online rankings, an
explorable ACO hub, NPC side quests, branching story decisions, multiple
endings, multiple currencies, full operator-specific movesets, gamepad support,
or recorded voice-over. `[GDD-SCOPE-01]`

## 3. Design Pillars

1. **Thai field equipment versus fruit-derived alien biology.** Rural tools,
   workwear, soil, crops, local terrain, and recognizable Thai fruit anatomy
   must remain visible within the alien mutation. `[GDD-PILLAR-01]`
2. **Readable brush-cutter combat.** Enemy tells, cutter reach, hit feedback,
   invulnerability, and boss hazards must be understandable at 1280 × 720.
   `[GDD-PILLAR-02]`
3. **Distinct environments with ecological stakes.** Each biome shows a later
   stage of the same invasion and introduces a new traversal or hazard idea.
   `[GDD-PILLAR-03]`
4. **Persistent, legible progression.** Samples earned in missions improve
   shared technology or one operator's mastery without introducing redundant
   currencies. `[GDD-PILLAR-04]`

## 4. Core Loops

### 4.1 Campaign Loop

`Select Operator → Story Briefing → Select Mission → Play Mission → Debrief → Upgrade → Select Next Mission`

The ACO base is represented by the character, mission, briefing, workshop,
mastery, and debriefing screens. It is not an explorable level.

### 4.2 Mission Loop

`Traverse → Read Enemy/Hazard → Attack or Evade → Collect Samples → Clear Threat Quota → Defeat Boss → Reach Extraction`

Every mission uses three explicit phases: `[GDD-LOOP-01]`

1. `CLEAR_THREATS` — regular enemies count toward the mission quota.
2. `BOSS_ACTIVE` — the dedicated boss is revealed or unlocked after the quota.
3. `EXTRACTION` — the portal activates only after the boss is defeated.

Samples are optional for mission completion but are the only persistent upgrade
currency. Failure restarts the mission; collected samples are banked only after
successful extraction.

### 4.3 Mission Pacing Contract

The critical path of every mission targets **5–7 minutes** for a competent
first-time player, excluding briefing and debriefing. `[GDD-LEVEL-01]`

| Segment | Target | Purpose |
|---|---:|---|
| Entry and mechanic introduction | 30–45 seconds | Establish the biome, route and first readable threat |
| Encounter A | 60–90 seconds | Teach the level's signature enemy/hazard interaction |
| Traversal set piece | 60–90 seconds | Change elevation, route shape or environmental pressure |
| Encounter B and boss approach | 60–90 seconds | Remix threats and deliver the final radio beat |
| Boss | 75–120 seconds | Two or three concise phases with recovery windows |
| Extraction | 15–30 seconds | Release tension, collect nearby samples and exit |

Each level contains three authored gameplay beats before its boss rather than a
long repeated corridor. Optional samples may reward a short side route but may
not add more than 45 seconds to the critical path. Boss health is tuned around
pattern mastery rather than extended damage sponging.

## 5. Controls and Player Rules

| Action | Default input | Rule |
|---|---|---|
| Move | A/D or Left/Right | Accelerated horizontal movement |
| Jump | W, Space, or Up | Supports jump buffering and coyote time |
| Dash | Shift | Short horizontal burst with temporary invulnerability |
| Attack | Left mouse button | Forward brush-cutter hit area |
| Pause | Escape | Pauses gameplay and opens mission controls |

- Operators automatically face their latest horizontal input direction.
- Jump routes must remain reachable by the operator with the weakest mobility.
- Damage provides a short invulnerability period and readable feedback.
- Falling out of the level counts as lethal damage.
- A boss attack must show an actionable tell before its damaging frame.
  `[GDD-COMBAT-01]`

## 6. Operators

All operators share the same input scheme and animation names: `idle`, `run`,
`jump`, `fall`, `attack`, `dash`, `hurt`, and `death`.

| ID | Display name | Role | HP | Move | Damage | Dash | Passive |
|---|---|---:|---:|---:|---:|---:|---|
| `tonkla` | Tonkla | Balanced ACO field operator | 8 | 190 | 2 | 470 | Field Recovery |
| `ranger` | Rin | Mobile ranger | 6 | 225 | 2 | 545 | Rapid Evade |
| `villager` | Khem | Durable Isan volunteer | 9 | 170 | 3 | Wide Sweep |
| `t800` | T-800 | Armored synthetic | 12 | 155 | 3 | Armored Frame |

### 6.1 Passives

- **Field Recovery:** Tonkla heals 1 HP after collecting three samples. The
  counter resets at mission start and after triggering.
- **Rapid Evade:** Rin's dash cooldown is reduced by 25%.
- **Wide Sweep:** Khem's attack hit area is 25% wider without increasing the
  visual weapon beyond its authored frame.
- **Armored Frame:** T-800 reduces incoming damage by 1, to a minimum of 1.

Passives must be visible in character selection, mastery, and pause/help UI.
They may alter numbers or hit geometry but may not add a new input action.
`[GDD-OPERATOR-01]`

### 6.2 Operator Voice Profiles

- **Tonkla:** practical, calm, curious, and willing to improvise.
- **Rin:** concise, tactical, alert, and impatient with avoidable risk.
- **Khem:** protective, grounded, locally knowledgeable, and quietly humorous.
- **T-800:** literal, analytical, and unintentionally funny without parodying
  the danger.

The shared story never assumes a specific selected operator. Each mission has
two short operator-specific barks: one near mission entry and one around the
boss reveal or victory. `[GDD-NARRATIVE-07]`

## 7. Progression and Economy

### 7.1 Samples

Alien samples are the single persistent currency. A successful extraction adds
collected samples to the profile and records the best mission result. Mission
failure does not bank the current run's samples. `[GDD-ECONOMY-01]`

### 7.2 Base Technology

Base Technology applies to every operator and has five purchasable levels.

| Track | Effect per level | Current cost curve target |
|---|---|---|
| Blade | +1 attack damage | `4 + level × 4` samples |
| Engine | +5% move and dash speed | `4 + level × 4` samples |
| Armor | +1 maximum HP | `4 + level × 4` samples |

### 7.3 Operator Mastery

Each operator has one Mastery rank from 0–5. Mastery replaces the three
duplicated character-specific stat tracks. The initial target cost is
`3 + rank × 3` samples. Ranks provide: `[GDD-PROGRESSION-01]`

- Rank 1: passive unlocked and explained
- Rank 2: passive effectiveness +10%
- Rank 3: +1 maximum HP for that operator
- Rank 4: passive effectiveness +10% again
- Rank 5: passive capstone and mastery badge

Exact capstone values are balance data, not new active abilities.

## 8. World and Enemy Progression

### 8.1 Standard Enemy Families

| ID | Role | Primary read | Campaign introduction |
|---|---|---|---|
| `thornling` | Basic melee pursuer | Low body and forward contact attack | Level 1 |
| `spore_spitter` | Ranged pressure | Swells before firing a visible projectile | Level 1 |
| `carnivorous_maw` | Durable bruiser | Opens before a short-range bite | Level 2 |
| `capsule_husk` | Armored lane controller | Shell opens to expose a weak core after a charge | Level 3 |
| `root_skitter` | Ambush/flanker | Ground disturbance precedes emergence | Level 4 |
| `eye_wisp` | Floating ranged support | Eye glow precedes aimed shot | Level 5 |

Standard enemies require dedicated visual identities and animation rather than
coloring or scaling a single placeholder sprite. `[GDD-ENEMY-01]`

#### Thai Local-Fruit Enemy Theme (Canonical)

Thai local fruit—defined here as fruit grown in Thailand and familiar through
local farms, markets, kitchens, and regional food culture—is the canonical main
theme for every organic enemy and boss. The fruit identity must drive the
silhouette, surface material, locomotion, attack language, projectiles, and
hazards rather than appearing as decoration. Capsule 07 does not create generic
alien plants: it hijacks local fruit genetics and repurposes rind, seed, flesh,
calyx, cluster, sap, fiber, and root structures as armor, sensory organs,
weapons, and projectile systems. Roots, vines, fungi, and capsule tissue may be
used as secondary connective biology, but they may not replace the assigned
fruit as the hostile's primary read.
`[GDD-FRUIT-01]`

Fruit recognition is secondary to gameplay readability. Each family has one
primary fruit reference, one readable combat role and one distinct silhouette;
enemies must not become round palette swaps or cute food mascots. Fruit traits
drive mechanics as well as decoration: thorny rind communicates armor, split
shells expose weak cores, clustered seeds support projectile patterns, and
sticky flesh or sap supports area denial.

Every enemy concept sheet must name its primary fruit and show how at least
three recognizable structures—such as rind, seed, flesh, calyx, cluster, sap,
fiber, or root—map to anatomy, telegraph, defense, locomotion, or attack. At
least one mapped structure must affect gameplay. A generic alien-plant concept
with a fruit palette or fruit pasted onto its body fails the theme review.
Within one level, standard families must use different primary fruit identities.
A boss may combine at most two fruit references, but one must remain visually
dominant at gameplay scale so the design does not become an unreadable collage.

| Enemy family | Primary Thai fruit reference | Mutation and gameplay read |
|---|---|---|
| Thornling | Rambutan / เงาะ | Hair-like rind spines become forward thorns and contact armor |
| Spore Spitter | Makrut lime / มะกรูด | Dimpled citrus rind swells before ejecting acidic seed/spore sacs |
| Carnivorous Maw | Young mangosteen / มังคุดอ่อน | Thick green-purple rind separates into a jaw around a segmented core |
| Capsule Husk | Santol / กระท้อน | Dense rind and segmented pulp form opening armor around a weak seed core |
| Root Skitter | Salak / สละ | Scaled snake-fruit skin and palm roots form a low burrowing arthropod |
| Eye Wisp | Longan / ลำไย | Pale flesh and glossy black seed become an eye within a floating fruit cluster |

Bosses escalate the same language without simply enlarging standard enemies:

| Boss | Primary fruit mutation | Mechanical expression |
|---|---|---|
| Thorn Matriarch | Rambutan queen cluster | Sweeping hair-thorns, rolling fruit mines and opening cluster weak points |
| Maw Bloom Sovereign | Durian crown over mangosteen anatomy | Armored rind phases, spore rain and seed-burst volleys |
| Possessed Banyan | Jackfruit fused with banyan fig | Fibrous trunk armor, falling seed columns and sticky sap zones |
| Root Hydra | Nipa-palm fruit cluster | Multiple segmented heads, water-lane shots and regenerating cluster nodes |
| Root-Core Eye | Longan eye cluster within dragon-fruit bracts | Seed-eye rings, bract spirals, aimed pupils and final exposed flesh core |

The five-level progression therefore moves from familiar orchard reads to
increasingly alien recombinations: rambutan and makrut lime in Level 1;
mangosteen and durian in Level 2; santol and jackfruit in Level 3; salak and
nipa palm in Level 4; longan and dragon fruit in Level 5. Existing approved
animation may be retained when targeted rind, calyx, seed and palette details
make the assigned fruit readable without damaging its timing or silhouette.

### 8.2 Boss Rules

- Every level has one dedicated boss scene, silhouette, health bar, attack set,
  introduction, death sequence, and validation checklist.
- Bosses do not count toward the regular threat quota.
- Boss arenas must prevent leaving during combat but must never trap the player
  before the boss state is valid.
- Boss health and phase changes remain visible without obscuring the player.
- A boss may reuse systemic projectiles or hazards, but not another boss's full
  visual identity. `[GDD-BOSS-01]`

Boss fundamentals follow the Hollow Knight/Castlevania reference hierarchy:
strong melee spacing, clear anticipation, committed attacks and punish
windows. Selected phases additionally use **Touhou-inspired,
platformer-readable danmaku**: authored bullet formations with recognizable
rhythm and safe lanes, not uncontrolled random projectile spam.
`[GDD-BULLET-01]`

- Every pattern has a named ID, preview tell, active interval, recovery window,
  projectile speed band, active-projectile cap and deterministic cleanup rule.
- Bullets may form fans, aimed bursts, rotating rings, alternating lane walls,
  arcs or spirals. Randomness may vary an angle or starting side but may not
  remove the guaranteed safe route.
- The safe route is at least 1.75 player widths and accounts for jump, fall and
  dash recovery. No projectile may spawn inside the player or hit from beyond
  the visible camera without an on-screen tell.
- A dense pattern lasts 3–6 seconds, followed by at least 0.75 seconds of
  reduced pressure or a punish window. Melee contact and floor hazards may not
  close every bullet-safe route simultaneously.
- Suggested active caps at 1280 × 720 are 18 for Level 1, 32 for Level 2, 36
  for Level 3, 48 for Level 4 and 64 for Level 5. Lower Web caps may reduce
  decorative bullets, never the pattern's safe-lane logic.
- Projectiles clear on phase transition, boss defeat, retry and arena exit.
  High-contrast outlines and color/shape coding must remain readable without
  relying only on red/green differences.

### 8.3 Level Diversity Matrix

No two consecutive levels may reuse the same primary tile kit, background
silhouette, traversal rhythm, encounter composition or boss projectile grammar.
Palette swaps do not satisfy this requirement. `[GDD-DIVERSITY-01]`

| Level | Traversal/set-piece identity | Enemy composition | Background and tile identity | Boss projectile identity |
|---|---|---|---|---|
| 1 — Contaminated Grassland | Open horizontal farm route, irrigation gaps and one elevated evacuation-road sequence | Rambutan Thornling melee packs plus makrut-lime Spitter crossfire | Sunlit fields, distant hills, farm structures; grass/soil, irrigation concrete and thorn-root tiles | Tutorial three-way fans and alternating thorn lanes with large safe gaps |
| 2 — Mutated Forest | Short vertical canopy climb, collapsing fungal shelves and spore-visibility pockets | Spitters at elevation, young-mangosteen Maws in confined clearings, aggressive Thornling variant | Dense canopy silhouettes, hanging roots and mist; bark, moss, fungal shelf and hollow-trunk tiles | Durian spore rain, rotating five-way blooms and aimed seed bursts |
| 3 — Roots Beneath Capsule 07 | Descending impact tunnel, moving root lifts and an arena that opens the capsule heart | Carnivorous Maws, santol Capsule Husks and ambush roots | Capsule wreck landmark, metal-organic walls and underground pulse; shell, fibrous root and living membrane tiles | Jackfruit seed columns and diagonal root lines that reshape platform-safe zones |
| 4 — Devouring Root Marsh | Alternating dry islands, sinking root rafts and toxic-water timing | Salak Root Skitters, marsh Spitter variant and conduit-fed Maw encounters | Wetland horizon, conduit landmark and reflective toxic water; mud, reed mat, root raft and conduit tiles | Nipa-cluster crossfire, offset radial rings and alternating water-lane walls |
| 5 — Alien Eye Nexus | Compact combat ascent through shifting eye platforms and collapsing safe ground | Longan Eye Wisps, elite Capsule Husks and advanced mixed-family encounters | Alien-eye landmark, pulsing network layers and impossible organic depth; eye membrane, neural root and core-shell tiles | Seed-eye spirals, aimed bursts, radial rings and final dragon-fruit-bract curtains |

Each biome ships with at least four parallax layers, one foreground framing set,
one unmistakable landmark, one primary tile kit with caps/corners/transitions,
one signature hazard and one extraction treatment. Each mission introduces at
least one new enemy family or mechanically distinct variant with unique
silhouette, animation and attack timing.

## 9. Story, Cast, and Campaign

### 9.1 Premise

Capsule 07 crashes into an agricultural district in northeastern Thailand. It
is first treated as wreckage. Within days, underground roots begin draining
water and nutrients from the soil. Crops mutate, livestock disappear, and
plant organisms become coordinated predators.

The Alien Containment Organization creates a temporary field base. Conventional
weapons tear the visible growth but fail against its fibrous root system. ACO
technician Chai modifies backpack brush cutters already common in the region,
adding reinforced blades, containment shielding, and sample collectors. The
selected operator must follow the root network and stop Capsule 07 from
completing planetary germination.

### 9.2 Main NPCs

| ID | Name | Function | Character arc |
|---|---|---|---|
| `cmd_anan` | Commander Anan | Objectives, evacuation priorities, tactical warnings | Moves from containment doctrine to accepting that the core must be destroyed |
| `dr_mali` | Dr. Mali | Xenobotany, sample analysis, invasion discovery | Curiosity becomes responsibility when she proves the organism is an intelligent harvester |
| `tech_chai` | Technician Chai | Cutter upgrades, field engineering, restrained humor | Turns familiar tools into credible ACO equipment and keeps the team focused on local lives |

NPCs appear through portraits in briefings, debriefings, and radio calls. There
is no explorable NPC hub. `[GDD-NARRATIVE-01]`

### 9.3 Act I — Contaminated Grassland

**Mission ID:** `level_01`  
**Threat quota target:** 4  
**Boss:** Thorn Matriarch (`boss_thorn_matriarch`)  
**Samples target:** 6

The operator reopens the evacuation route through mutated farmland. The first
samples prove that separate plants are responding to one coordinated pulse.

**Level-design identity:** open farm lanes lead into an irrigation-gap set piece
and an elevated evacuation road. Thornlings pressure movement while Spitters
teach crossfire and safe-lane recognition.

Boss attacks: telegraphed ground thorns, a short root charge, tutorial
three-way fans and alternating thorn lanes. The fight teaches jumping and
dashing through deterministic gaps.

**Dialogue anchors:**

- Anan, briefing: “The road is the last route out of the eastern farms. Clear
  it before the roots close the gap.”
- Mali, briefing: “Bring back living tissue. Dead samples stop responding before
  I can measure the signal.”
- Chai, briefing: “Your cutter is built for grass, not extraterrestrial armor.
  Today it will learn.”
- Mali, radio: “These growths are pulsing together. This is coordination, not a
  random mutation.”
- Anan, boss warning: “Large root mass ahead. Clear the road, then cut its core.”
- Mali, debrief: “Every sample answered the same buried signal. Something is
  conducting the entire field.”

### 9.4 Act II — Mutated Forest

**Mission ID:** `level_02`  
**Threat quota target:** 5
**Boss:** Maw Bloom Sovereign (`boss_maw_sovereign`)  
**Samples target:** 8

Airborne spores lead the team into the containment forest. Mali discovers that
the spores carry encoded biological instructions. The source is beneath the
Capsule 07 impact site.

**Level-design identity:** a short vertical canopy climb connects fungal shelves
and low-visibility spore pockets. Elevated Spitters control space while Maws
force decisive close-range movement.

Boss attacks: bite cone, arcing spore rain, rotating five-way bloom bursts,
aimed seed volleys and a short half-health summon. Each dense formation ends in
a clear melee punish window.

**Dialogue anchors:**

- Anan, briefing: “Visibility is poor and the canopy blocks our drones. Follow
  the old service path.”
- Mali, briefing: “The spores are repeating the field pulse. They may be carrying
  instructions.”
- Chai, radio: “If the cutter starts coughing purple smoke, that is not a feature.”
- Mali, radio: “Confirmed. The spores contain signal-bearing cells. The forest
  is relaying orders.”
- Anan, boss warning: “The relay converges ahead. Expect whatever has been
  feeding this canopy.”
- Mali, debrief: “The signal descends directly beneath Capsule 07. The wreck is
  still active.”

### 9.5 Act III — Roots Beneath Capsule 07

**Mission ID:** `level_03`  
**Threat quota target:** 5  
**Boss:** Possessed Banyan (`boss_possessed_banyan`)  
**Samples target:** 5

The team reaches the impact site and enters the root chamber below the capsule.
A banyan has fused with the alien structure. Destroying it exposes the midpoint
truth: Capsule 07 is a seed, relay, and planetary harvester—not a spacecraft.
The surviving network withdraws toward the marsh.

**Level-design identity:** the route descends through a metal-organic impact
tunnel, uses moving root lifts, and ends in a capsule-heart arena. Armored
Capsule Husks create timed weak-point encounters distinct from forest combat.

Boss attacks: sweeping roots, falling seed columns, diagonal root lines, a
mobile trunk charge and an exposed-heart vulnerability window. Arena-control
patterns reshape safe platforms without becoming the campaign's densest
danmaku encounter.

**Dialogue anchors:**

- Anan, briefing: “We came here to secure wreckage. We are now entering a living
  structure. Treat every surface as hostile.”
- Mali, briefing: “The metal and root tissue share cells. Capsule 07 was grown,
  not manufactured.”
- Chai, radio: “That tree has swallowed half the capsule. Try not to let it
  swallow the operator too.”
- Mali, midpoint reveal: “This is no ship. It is a seed designed to rewrite the
  ground around it.”
- Anan, boss warning: “The banyan is shielding the relay. Break the heart when
  it opens.”
- Mali, debrief: “The remaining root mass is moving toward the wetlands. It is
  feeding something larger.”

### 9.6 Act IV — Devouring Root Marsh

**Mission ID:** `level_04`  
**Threat quota target:** 6
**Boss:** Root Hydra (`boss_root_hydra`)  
**Samples target:** 8

The operator cuts through a wetland transformed into the network's main
nutrient conduit. The Root Hydra protects the flow. After it falls, the team
learns that harvested biomass is awakening an alien sensory core.

**Level-design identity:** dry islands alternate with sinking root rafts and
timed toxic-water crossings. Root Skitters attack from disturbed mud while
marsh Spitters use slower arcing shots around conduit structures.

Boss attacks: independently telegraphed tendrils, toxic water zones,
Hydra-head crossfire, offset radial rings and alternating water-lane walls. A
central core becomes vulnerable after head breaks.

**Dialogue anchors:**

- Anan, briefing: “That marsh is carrying nutrients from every infected zone.
  Sever the conduit before the core finishes feeding.”
- Mali, briefing: “Do not mistake the water for water. The network has replaced
  most of it with transport fluid.”
- Chai, radio: “Good news: the cutter is waterproof. Bad news: I only tested it
  in rain.”
- Mali, radio: “The conduit is contracting. It knows you are inside it.”
- Anan, boss warning: “Multiple root heads, one central pulse. Disable the heads
  and strike the core.”
- Mali, debrief: “The flow stopped, but the stored biomass has already reached
  the final node. It is awake.”

### 9.7 Act V — Alien Eye Nexus

**Mission ID:** `level_05`  
**Threat quota target:** 6
**Boss:** Root-Core Eye (`boss_root_core_eye`)  
**Samples target:** 10

The operator assaults the awakened alien nexus. The eye uses the full network
as its body. Destroying its germination core begins ecological recovery, but a
dormant signal fragment remains as a restrained continuation hook.

**Level-design identity:** a compact combat ascent uses shifting eye platforms,
collapsing safe ground and advanced mixed-family encounters. Eye Wisps add
vertical aimed pressure not present in earlier missions.

Boss phases: aimed beam and Wisp support; rotating spirals and radial rings;
floor-root patterns with alternating bullet curtains; then a short exposed-core
burn phase. This is the campaign's densest projectile-pattern encounter, but
every pattern preserves a deterministic platform-safe route and melee punish
window.

**Dialogue anchors:**

- Anan, briefing: “No containment line remains beyond this point. Destroy the
  core before germination begins.”
- Mali, briefing: “It can see through every infected plant. Assume the entire
  landscape is watching.”
- Chai, briefing: “I have removed every limiter from the cutter. Bring back the
  operator. The machine is negotiable.”
- Mali, radio: “The eye is opening. All network activity is converging on you.”
- Anan, boss warning: “This is the source. Hold nothing back.”
- Mali, ending: “The primary signal is gone. The soil is taking water again…
  but I am detecting one dormant fragment.”

### 9.8 Narrative Delivery Contract

Each level contains one 6–8 exchange briefing, three short radio events, one
boss warning sequence, one 4–6 exchange debriefing, and two barks per operator.
The production target is approximately 90 shared entries and 40
operator-specific entries per language. `[GDD-NARRATIVE-02]`

- Briefings and debriefings pause progression and may be skipped.
- Radio calls do not pause gameplay, steal focus, or cover combat-critical HUD.
- Skipping and completing a sequence produce identical gameplay state.
- Dialogue has no choices and cannot change the ending.
- Story triggers are based on language-independent IDs.

## 10. Dialogue and Story Data

### 10.1 Speaker Contract

Each speaker definition provides `speaker_id`, `display_name_key`,
`portrait_id`, available expressions, dialogue color, and optional radio call
sign. `[GDD-DIALOGUE-01]`

### 10.2 Sequence Contract

Each sequence entry provides:

- `sequence_id`
- `speaker_id`
- `text_key`
- `portrait_expression`
- `presentation_mode`: `briefing`, `radio`, `boss`, or `debrief`
- optional `operator_condition`
- `skippable`, `pause_game`, and `one_shot`
- next entry or completion action

Story state tracks campaign act, seen one-shot sequences, completed briefings
and debriefings, pending introductions, selected operator, and
language-independent flags. `[GDD-DIALOGUE-02]`

### 10.3 Dialogue UI

The reusable communication overlay provides a portrait, localized name,
localized text, Continue, Skip, a compact radio mode, optional typewriter
animation, and an immediate-text accessibility option. No story text is baked
into a raster image. `[GDD-DIALOGUE-03]`

## 11. Localization

English is the default runtime language. Thai is a complete selectable
language. `[GDD-LOC-01]`

- A new profile starts in English.
- Settings offers `English` and `ไทย` and applies changes live.
- The locale is persisted in `settings.language`.
- Missing or invalid translations fall back visibly to English.
- `localization/ui.csv` contains interface and gameplay text.
- `localization/story.csv` contains dialogue and narrative text.
- `localization/glossary.csv` contains canonical terminology.
- IDs remain English and are never translated.
- Dynamic text uses placeholders instead of grammar-dependent concatenation.
- Fonts must cover Latin and Thai glyphs in Windows and Web builds.
- Runtime art must not contain baked language-specific text.

## 12. UI/UX

The interface uses dense ACO field panels, aged gold, olive selection states,
dark green-black surfaces, and clear primary actions. The mission map presents
five nodes and must not obscure major background landmarks. `[GDD-UX-01]`

Required screens and overlays:

- Main menu and first-run language access
- Operator selection with passive description
- Five-node mission map with lock, selected, completed, and boss indicators
- Briefing and debriefing panels
- Base Technology workshop
- Operator Mastery
- Settings with language, volume, fullscreen, and immediate dialogue text
- Gameplay HUD, boss health, radio overlay, pause, defeat, and completion

All screens must remain readable at 1280 × 720. English expansion and Thai line
height must be tested independently.

## 13. Art Direction

The production target is **high-resolution pixel art**: deliberately simplified
forms built from visible, consistent pixel clusters, presented at a high output
resolution without becoming photorealistic, painterly, or 3D-rendered.
`[GDD-ART-01]`

- Runtime raster art is authored on a declared logical pixel grid and enlarged
  only by integer nearest-neighbor scaling; accidental smoothing is prohibited.
- Sprites use hard alpha edges, limited ramps, selective highlights, and a
  controlled palette. Soft airbrush shading, photographic textures, skin
  pores, physically based materials, and anti-aliased brushwork are prohibited.
- Portraits simplify facial features into readable pixel clusters. They must
  match the game sprites instead of resembling photographs or painted concept
  art.
- Backgrounds may contain more detail than actors but retain discrete pixel
  clusters, stepped curves, limited color ramps, and crisp depth separation.

- Characters: stocky silhouettes, practical equipment, consistent frame scale,
  and grounded foot baselines
- Human palette: soil brown, field olive, workwear black, faded orange, steel
- Alien palette: toxic green, purple roots, luminous spores, wet organic tissue
- Backgrounds: distinct layers and landmarks per biome
- Effects: bright enough to communicate attacks without hiding collision reads
- UI: text rendered by Godot controls, not baked into atlases

Nearest-neighbor presentation is the default for pixel artwork. UI fonts,
vector controls, and deliberately smooth accessibility elements are configured
separately and must not force bilinear filtering onto sprites or environments.

Approved generated art must move from `Generated-Assets/` into `Assets/` after
technical, provenance, and visual validation.

## 14. Audio Direction

The release uses text dialogue without voice-over. `[GDD-AUDIO-01]`

- One menu/base theme
- Five biome loops
- Two boss suites: standard major encounter and final nexus
- Victory and defeat stingers
- Cutter start, swing, contact, and mechanical strain
- Operator movement, damage, and death feedback
- Distinct enemy and boss tells
- Samples, portals, hazards, radio, and UI feedback

Music supports tension without masking attack tells. Gameplay events may not
reuse the UI click sound as their final production effect.

## 15. Technical and Performance Targets

- Godot 4.7, GL Compatibility renderer
- 1280 × 720 native viewport and responsive 16:9 presentation
- Target 60 FPS on reference Windows and Web environments
- Web peak memory target below 512 MB
- No recurring errors or warnings during a complete campaign run
- Save data must recover to safe defaults when optional fields are missing
- Save schema changes require versioned migration
- Every authored level remains editable in `.tscn`; scripts bind behavior rather
  than constructing production layouts at runtime

`[GDD-TECH-01]`

## 16. Completion Criteria

The release is design-complete when: `[GDD-DONE-01]`

- All five missions implement quota → boss → extraction without soft locks.
- Four operators work with their documented passive and mastery progression.
- Every standard enemy and boss has a dedicated production identity.
- The complete linear story is playable, skippable, and replay-safe.
- English and Thai contain identical localization keys and story triggers.
- All Must-have assets are at least Verified.
- Weighted project readiness reaches 90% or more.
- No P0 or P1 defects remain.
- Windows and Web release validation passes.

Detailed production gates, asset states, and validation procedures live in:

- [Development Plan](docs/DEVELOPMENT_PLAN.md)
- [Asset Register](docs/ASSET_REGISTER.md)
- [Validation Protocol](docs/VALIDATION_PROTOCOL.md)
- [Thai GDD](docs/th/GDD_TH.md)
