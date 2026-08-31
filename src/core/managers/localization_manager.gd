extends Node

signal language_changed(locale: String)

const DEFAULT_LANGUAGE := "en"
const SUPPORTED_LANGUAGES := ["en", "th"]
const PSEUDO_PREFIX := "[!"
const PSEUDO_SUFFIX := "!]"
const PSEUDO_MIN_EXPANSION := 1.35
const EXPORT_SELF_TEST_KEYS := [
	"MENU_SUBTITLE", "MENU_SETTINGS", "LEVEL_05_NAME", "BOSS_ROOT_CORE_EYE",
	"SETTINGS_LANGUAGE", "DIALOGUE_CONTINUE",
]
const PSEUDO_ACCENTS := {
	"a": "à", "A": "À", "b": "ḃ", "B": "Ḃ", "c": "ç", "C": "Ç",
	"d": "đ", "D": "Đ", "e": "é", "E": "É", "f": "ḟ", "F": "Ḟ",
	"g": "ĝ", "G": "Ĝ", "h": "ĥ", "H": "Ĥ", "i": "î", "I": "Î",
	"j": "ĵ", "J": "Ĵ", "k": "ķ", "K": "Ķ", "l": "ĺ", "L": "Ĺ",
	"m": "ḿ", "M": "Ḿ", "n": "ń", "N": "Ń", "o": "ô", "O": "Ô",
	"p": "ṗ", "P": "Ṗ", "r": "ŕ", "R": "Ŕ", "s": "ş", "S": "Ş",
	"t": "ť", "T": "Ŧ", "u": "û", "U": "Û", "v": "ṽ", "V": "Ṽ",
	"w": "ŵ", "W": "Ŵ", "y": "ý", "Y": "Ý", "z": "ž", "Z": "Ž",
}
const TABLE_PATHS := [
	"res://localization/ui.csv",
	"res://localization/story.csv",
	"res://localization/glossary.csv",
]
const COMPILED_TABLE_PATHS := {
	"en": [
		"res://localization/ui.en.translation",
		"res://localization/story.en.translation",
		"res://localization/glossary.en.translation",
	],
	"th": [
		"res://localization/ui.th.translation",
		"res://localization/story.th.translation",
		"res://localization/glossary.th.translation",
	],
}

var current_language: String = DEFAULT_LANGUAGE
var english_fallback: Dictionary = {}
var warned_missing_keys: Dictionary = {}
var pseudo_localization_enabled := false
var compiled_english_fallbacks: Array[Translation] = []


func _enter_tree() -> void:
	_load_tables()
	set_language(DEFAULT_LANGUAGE, false)
	if "--validate-localization" in OS.get_cmdline_user_args() or OS.get_environment("LOW_ALTITUDE_VALIDATE_LOCALIZATION") == "1":
		call_deferred("_run_export_self_test")


func _run_export_self_test() -> void:
	var failures: Array[String] = []
	for locale: String in SUPPORTED_LANGUAGES:
		TranslationServer.set_locale(locale)
		for key: String in EXPORT_SELF_TEST_KEYS:
			var translated := TranslationServer.translate(StringName(key))
			if translated.is_empty() or translated == key:
				failures.append("%s:%s" % [locale, key])
	if failures.is_empty():
		print("LOCALIZATION EXPORT SELF TEST PASS: English and Thai samples loaded.")
	else:
		for failure: String in failures:
			push_error("Localization self-test missing translation: %s" % failure)
		print("LOCALIZATION EXPORT SELF TEST FAIL: %d missing samples." % failures.size())
	if OS.has_feature("headless"):
		get_tree().quit(0 if failures.is_empty() else 1)


func _load_tables() -> void:
	var translations := {"en": Translation.new(), "th": Translation.new()}
	var compiled_translations: Array[Translation] = []
	for locale: String in translations:
		translations[locale].locale = locale
	for table_index in TABLE_PATHS.size():
		if _load_table(TABLE_PATHS[table_index], translations):
			continue
		# CSV files are available in the editor but may be compiled into
		# .translation resources in exported builds. Load those resources when
		# FileAccess cannot expose the source CSV inside the PCK.
		_load_compiled_table(str(COMPILED_TABLE_PATHS["en"][table_index]), "en", compiled_translations)
		_load_compiled_table(str(COMPILED_TABLE_PATHS["th"][table_index]), "th", compiled_translations)
	for locale: String in translations:
		TranslationServer.add_translation(translations[locale])
	for compiled: Translation in compiled_translations:
		TranslationServer.add_translation(compiled)
		if compiled.locale == "en":
			compiled_english_fallbacks.append(compiled)


func _load_table(path: String, translations: Dictionary) -> bool:
	var file := FileAccess.open(path, FileAccess.READ)
	if file == null:
		return false
	if file.eof_reached():
		return false
	var header := file.get_csv_line()
	var key_index := header.find("key")
	var en_index := header.find("en")
	var th_index := header.find("th")
	if key_index < 0 or en_index < 0 or th_index < 0:
		push_error("Localization table requires key,en,th columns: %s" % path)
		return false
	while not file.eof_reached():
		var row := file.get_csv_line()
		if row.size() <= maxi(key_index, maxi(en_index, th_index)):
			continue
		var key := row[key_index].strip_edges()
		if key.is_empty() or key.begins_with("#"):
			continue
		var english := row[en_index]
		var thai := row[th_index]
		english_fallback[key] = english
		translations["en"].add_message(StringName(key), english)
		if not thai.is_empty():
			translations["th"].add_message(StringName(key), thai)
	return true


func _load_compiled_table(path: String, locale: String, compiled_translations: Array[Translation]) -> bool:
	var compiled := ResourceLoader.load(path, "Translation", ResourceLoader.CACHE_MODE_IGNORE) as Translation
	if compiled == null:
		push_error("Compiled localization table could not be loaded: %s" % path)
		return false
	# OptimizedTranslation intentionally does not expose an iterable message
	# list, but get_message(key) remains available to TranslationServer.
	compiled_translations.append(compiled)
	return true


func set_pseudo_localization(enabled: bool) -> void:
	if pseudo_localization_enabled == enabled:
		return
	pseudo_localization_enabled = enabled
	language_changed.emit(current_language)


func normalize_language(locale: String) -> String:
	var normalized := locale.to_lower().split("_")[0].split("-")[0]
	return normalized if normalized in SUPPORTED_LANGUAGES else DEFAULT_LANGUAGE


func set_language(locale: String, emit_change: bool = true) -> void:
	var normalized := normalize_language(locale)
	var changed := current_language != normalized
	current_language = normalized
	TranslationServer.set_locale(normalized)
	if emit_change and changed:
		language_changed.emit(current_language)


func text(key: String, values: Dictionary = {}) -> String:
	var translated := TranslationServer.translate(StringName(key))
	var result := str(translated)
	if result.is_empty() or result == key:
		result = str(english_fallback.get(key, key))
		if result == key:
			for compiled: Translation in compiled_english_fallbacks:
				var compiled_result := compiled.get_message(StringName(key))
				if not compiled_result.is_empty() and compiled_result != key:
					result = compiled_result
					break
		if result == key and not warned_missing_keys.has(key):
			warned_missing_keys[key] = true
			push_warning("Missing localization key: %s" % key)
	if pseudo_localization_enabled:
		result = _pseudo_localize(result)
	return result.format(values) if not values.is_empty() else result


func has_key(key: String) -> bool:
	return english_fallback.has(key)


func _pseudo_localize(source: String) -> String:
	if source.is_empty():
		return source
	var expanded := ""
	var char_index := 0
	var cursor := 0
	while cursor < source.length():
		var character := source[cursor]
		if character == "{":
			var closing := source.find("}", cursor)
			if closing >= 0:
				expanded += source.substr(cursor, closing - cursor + 1)
				cursor = closing + 1
				continue
		char_index += 1
		var mapped: String = PSEUDO_ACCENTS.get(character, character)
		expanded += mapped
		var doubleable := (character >= "a" and character <= "z") or (character >= "A" and character <= "Z") or (character >= "0" and character <= "9")
		if char_index % 3 == 0 and doubleable:
			expanded += mapped
		cursor += 1
	var wrapped := PSEUDO_PREFIX + expanded + PSEUDO_SUFFIX
	var target := int(ceil(source.length() * PSEUDO_MIN_EXPANSION))
	if wrapped.length() < target:
		expanded += "!".repeat(target - wrapped.length())
		wrapped = PSEUDO_PREFIX + expanded + PSEUDO_SUFFIX
	return wrapped
