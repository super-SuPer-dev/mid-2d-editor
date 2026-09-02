extends Node

signal sequence_requested(sequence_id: String)
signal sequence_completed(sequence_id: String)

var pending_mission_introduction: String = ""


func request_sequence(sequence_id: String, force: bool = false) -> bool:
	if DialogueCatalog.get_sequence(sequence_id).is_empty():
		push_warning("Unknown dialogue sequence: %s" % sequence_id)
		return false
	if not force and has_seen(sequence_id) and _is_one_shot(sequence_id):
		return false
	sequence_requested.emit(sequence_id)
	return true


func complete_sequence(sequence_id: String) -> void:
	if _is_one_shot(sequence_id):
		var seen: Array = SaveManager.profile.get("seen_dialogue_sequences", [])
		if sequence_id not in seen:
			seen.append(sequence_id)
			SaveManager.profile["seen_dialogue_sequences"] = seen
			SaveManager.save_game()
	sequence_completed.emit(sequence_id)


func has_seen(sequence_id: String) -> bool:
	return sequence_id in SaveManager.profile.get("seen_dialogue_sequences", [])


func set_campaign_act(act: int) -> void:
	SaveManager.profile["story_stage"] = clampi(act, 1, 5)
	SaveManager.save_game()


func get_campaign_act() -> int:
	return int(SaveManager.profile.get("story_stage", 1))


func _is_one_shot(sequence_id: String) -> bool:
	for entry: Dictionary in DialogueCatalog.get_sequence(sequence_id):
		if bool(entry.get("one_shot", false)):
			return true
	return false

