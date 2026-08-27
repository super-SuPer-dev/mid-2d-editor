class_name DialogueCatalog
extends RefCounted

const VALID_MODES := ["briefing", "radio", "boss", "debrief"]

const SEQUENCES := {
	"level_01_briefing": [
		{"speaker_id": "commander_anan", "text_key": "STORY_L1_BRIEF_01", "portrait_expression": "urgent", "presentation_mode": "briefing", "skippable": true, "pause_game": true, "one_shot": true},
		{"speaker_id": "dr_mali", "text_key": "STORY_L1_BRIEF_02", "portrait_expression": "analytical", "presentation_mode": "briefing", "skippable": true, "pause_game": true, "one_shot": true},
		{"speaker_id": "technician_chai", "text_key": "STORY_L1_BRIEF_03", "portrait_expression": "amused", "presentation_mode": "briefing", "skippable": true, "pause_game": true, "one_shot": true},
		{"speaker_id": "commander_anan", "text_key": "STORY_L1_BRIEF_05", "portrait_expression": "urgent", "presentation_mode": "briefing", "skippable": true, "pause_game": true, "one_shot": true},
		{"speaker_id": "selected_operator", "text_key": "STORY_L1_BRIEF_04", "portrait_expression": "determined", "presentation_mode": "briefing", "skippable": true, "pause_game": true, "one_shot": true},
		{"speaker_id": "selected_operator", "text_key": "STORY_L1_BRIEF_TONKLA", "portrait_expression": "determined", "presentation_mode": "briefing", "operator_condition": "tonkla", "skippable": true, "pause_game": true, "one_shot": true},
		{"speaker_id": "selected_operator", "text_key": "STORY_L1_BRIEF_RIN", "portrait_expression": "determined", "presentation_mode": "briefing", "operator_condition": "rin", "skippable": true, "pause_game": true, "one_shot": true},
		{"speaker_id": "selected_operator", "text_key": "STORY_L1_BRIEF_KHEM", "portrait_expression": "determined", "presentation_mode": "briefing", "operator_condition": "khem", "skippable": true, "pause_game": true, "one_shot": true},
		{"speaker_id": "selected_operator", "text_key": "STORY_L1_BRIEF_T800", "portrait_expression": "determined", "presentation_mode": "briefing", "operator_condition": "t800", "skippable": true, "pause_game": true, "one_shot": true},
	],
	"level_01_radio_signal": [
		{"speaker_id": "dr_mali", "text_key": "STORY_L1_RADIO_01", "portrait_expression": "alarmed", "presentation_mode": "radio", "skippable": false, "pause_game": false, "one_shot": true},
	],
	"level_01_radio_route": [{"speaker_id": "commander_anan", "text_key": "STORY_L1_RADIO_02", "portrait_expression": "urgent", "presentation_mode": "radio", "skippable": false, "pause_game": false, "one_shot": true}],
	"level_01_radio_root": [{"speaker_id": "technician_chai", "text_key": "STORY_L1_RADIO_03", "portrait_expression": "concerned", "presentation_mode": "radio", "skippable": false, "pause_game": false, "one_shot": true}],
	"level_01_boss": [
		{"speaker_id": "commander_anan", "text_key": "STORY_L1_BOSS_01", "portrait_expression": "urgent", "presentation_mode": "boss", "skippable": true, "pause_game": true, "one_shot": false},
	],
	"level_01_debrief": [
		{"speaker_id": "dr_mali", "text_key": "STORY_L1_DEBRIEF_01", "portrait_expression": "analytical", "presentation_mode": "debrief", "skippable": true, "pause_game": true, "one_shot": true},
		{"speaker_id": "commander_anan", "text_key": "STORY_L1_DEBRIEF_02", "portrait_expression": "relieved", "presentation_mode": "debrief", "skippable": true, "pause_game": true, "one_shot": true},
		{"speaker_id": "technician_chai", "text_key": "STORY_L1_DEBRIEF_03", "portrait_expression": "amused", "presentation_mode": "debrief", "skippable": true, "pause_game": true, "one_shot": true},
		{"speaker_id": "selected_operator", "text_key": "STORY_L1_DEBRIEF_TONKLA", "portrait_expression": "determined", "presentation_mode": "debrief", "operator_condition": "tonkla", "skippable": true, "pause_game": true, "one_shot": true},
		{"speaker_id": "selected_operator", "text_key": "STORY_L1_DEBRIEF_RIN", "portrait_expression": "determined", "presentation_mode": "debrief", "operator_condition": "rin", "skippable": true, "pause_game": true, "one_shot": true},
		{"speaker_id": "selected_operator", "text_key": "STORY_L1_DEBRIEF_KHEM", "portrait_expression": "determined", "presentation_mode": "debrief", "operator_condition": "khem", "skippable": true, "pause_game": true, "one_shot": true},
		{"speaker_id": "selected_operator", "text_key": "STORY_L1_DEBRIEF_T800", "portrait_expression": "determined", "presentation_mode": "debrief", "operator_condition": "t800", "skippable": true, "pause_game": true, "one_shot": true},
	],
	"level_02_briefing": [{"speaker_id": "commander_anan", "text_key": "STORY_L2_BRIEF_01", "portrait_expression": "urgent", "presentation_mode": "briefing", "skippable": true, "pause_game": true, "one_shot": true}],
	"level_02_radio_01": [{"speaker_id": "dr_mali", "text_key": "STORY_L2_RADIO_01", "portrait_expression": "analytical", "presentation_mode": "radio", "skippable": false, "pause_game": false, "one_shot": true}],
	"level_02_radio_02": [{"speaker_id": "technician_chai", "text_key": "STORY_L2_RADIO_02", "portrait_expression": "concerned", "presentation_mode": "radio", "skippable": false, "pause_game": false, "one_shot": true}],
	"level_02_radio_03": [{"speaker_id": "dr_mali", "text_key": "STORY_L2_RADIO_03", "portrait_expression": "alarmed", "presentation_mode": "radio", "skippable": false, "pause_game": false, "one_shot": true}],
	"level_02_boss": [{"speaker_id": "commander_anan", "text_key": "STORY_L2_BOSS_01", "portrait_expression": "urgent", "presentation_mode": "boss", "skippable": true, "pause_game": true, "one_shot": false}],
	"level_02_debrief": [{"speaker_id": "dr_mali", "text_key": "STORY_L2_DEBRIEF_01", "portrait_expression": "analytical", "presentation_mode": "debrief", "skippable": true, "pause_game": true, "one_shot": true}],
	"level_03_briefing": [{"speaker_id": "commander_anan", "text_key": "STORY_L3_BRIEF_01", "portrait_expression": "urgent", "presentation_mode": "briefing", "skippable": true, "pause_game": true, "one_shot": true}],
	"level_03_radio_01": [{"speaker_id": "dr_mali", "text_key": "STORY_L3_RADIO_01", "portrait_expression": "analytical", "presentation_mode": "radio", "skippable": false, "pause_game": false, "one_shot": true}],
	"level_03_radio_02": [{"speaker_id": "technician_chai", "text_key": "STORY_L3_RADIO_02", "portrait_expression": "concerned", "presentation_mode": "radio", "skippable": false, "pause_game": false, "one_shot": true}],
	"level_03_radio_03": [{"speaker_id": "dr_mali", "text_key": "STORY_L3_RADIO_03", "portrait_expression": "alarmed", "presentation_mode": "radio", "skippable": false, "pause_game": false, "one_shot": true}],
	"level_03_boss": [{"speaker_id": "commander_anan", "text_key": "STORY_L3_BOSS_01", "portrait_expression": "urgent", "presentation_mode": "boss", "skippable": true, "pause_game": true, "one_shot": false}],
	"level_03_debrief": [{"speaker_id": "dr_mali", "text_key": "STORY_L3_DEBRIEF_01", "portrait_expression": "alarmed", "presentation_mode": "debrief", "skippable": true, "pause_game": true, "one_shot": true}],
	"level_04_briefing": [{"speaker_id": "commander_anan", "text_key": "STORY_L4_BRIEF_01", "portrait_expression": "urgent", "presentation_mode": "briefing", "skippable": true, "pause_game": true, "one_shot": true}],
	"level_04_radio_01": [{"speaker_id": "technician_chai", "text_key": "STORY_L4_RADIO_01", "portrait_expression": "concerned", "presentation_mode": "radio", "skippable": false, "pause_game": false, "one_shot": true}],
	"level_04_radio_02": [{"speaker_id": "dr_mali", "text_key": "STORY_L4_RADIO_02", "portrait_expression": "analytical", "presentation_mode": "radio", "skippable": false, "pause_game": false, "one_shot": true}],
	"level_04_radio_03": [{"speaker_id": "commander_anan", "text_key": "STORY_L4_RADIO_03", "portrait_expression": "urgent", "presentation_mode": "radio", "skippable": false, "pause_game": false, "one_shot": true}],
	"level_04_boss": [{"speaker_id": "commander_anan", "text_key": "STORY_L4_BOSS_01", "portrait_expression": "urgent", "presentation_mode": "boss", "skippable": true, "pause_game": true, "one_shot": false}],
	"level_04_debrief": [{"speaker_id": "dr_mali", "text_key": "STORY_L4_DEBRIEF_01", "portrait_expression": "alarmed", "presentation_mode": "debrief", "skippable": true, "pause_game": true, "one_shot": true}],
	"level_05_briefing": [{"speaker_id": "commander_anan", "text_key": "STORY_L5_BRIEF_01", "portrait_expression": "urgent", "presentation_mode": "briefing", "skippable": true, "pause_game": true, "one_shot": true}],
	"level_05_radio_01": [{"speaker_id": "dr_mali", "text_key": "STORY_L5_RADIO_01", "portrait_expression": "alarmed", "presentation_mode": "radio", "skippable": false, "pause_game": false, "one_shot": true}],
	"level_05_radio_02": [{"speaker_id": "technician_chai", "text_key": "STORY_L5_RADIO_02", "portrait_expression": "concerned", "presentation_mode": "radio", "skippable": false, "pause_game": false, "one_shot": true}],
	"level_05_radio_03": [{"speaker_id": "commander_anan", "text_key": "STORY_L5_RADIO_03", "portrait_expression": "urgent", "presentation_mode": "radio", "skippable": false, "pause_game": false, "one_shot": true}],
	"level_05_boss": [{"speaker_id": "commander_anan", "text_key": "STORY_L5_BOSS_01", "portrait_expression": "urgent", "presentation_mode": "boss", "skippable": true, "pause_game": true, "one_shot": false}],
	"level_05_debrief": [{"speaker_id": "dr_mali", "text_key": "STORY_L5_DEBRIEF_01", "portrait_expression": "hopeful", "presentation_mode": "debrief", "skippable": true, "pause_game": true, "one_shot": true}],
}


static func get_sequence(sequence_id: String, operator_id: String = "") -> Array:
	var sequence: Array = SEQUENCES.get(sequence_id, []).duplicate(true)
	if operator_id.is_empty():
		return sequence
	var resolved_operator := CharacterCatalog.resolve_character_id(operator_id)
	return sequence.filter(func(entry: Dictionary) -> bool:
		var condition := str(entry.get("operator_condition", ""))
		return condition.is_empty() or condition == resolved_operator
	)


static func validate_sequence(sequence_id: String) -> Array[String]:
	var errors: Array[String] = []
	var sequence := get_sequence(sequence_id)
	if sequence.is_empty():
		errors.append("Sequence is empty: %s" % sequence_id)
		return errors
	for index in sequence.size():
		var entry: Dictionary = sequence[index]
		if not SpeakerCatalog.SPEAKERS.has(str(entry.get("speaker_id", ""))):
			errors.append("%s[%d] has an invalid speaker." % [sequence_id, index])
		if str(entry.get("presentation_mode", "")) not in VALID_MODES:
			errors.append("%s[%d] has an invalid presentation mode." % [sequence_id, index])
		if not LocalizationManager.has_key(str(entry.get("text_key", ""))):
			errors.append("%s[%d] has a missing text key." % [sequence_id, index])
		var operator_condition := str(entry.get("operator_condition", ""))
		if not operator_condition.is_empty() and operator_condition not in CharacterCatalog.CHARACTERS:
			errors.append("%s[%d] has an invalid operator condition." % [sequence_id, index])
	return errors
