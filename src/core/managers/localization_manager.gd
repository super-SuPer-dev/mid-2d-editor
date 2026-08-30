extends Node

signal language_changed(locale: String)

const DEFAULT_LANGUAGE := "en"
const SUPPORTED_LANGUAGES := ["en", "th"]
const PSEUDO_PREFIX := "[!"
const PSEUDO_SUFFIX := "!]"
const PSEUDO_MIN_EXPANSION := 1.35
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

var current_language: String = DEFAULT_LANGUAGE
var english_fallback: Dictionary = {}
var warned_missing_keys: Dictionary = {}
var pseudo_localization_enabled := false


func _enter_tree() -> void:
	_load_tables()
	set_language(DEFAULT_LANGUAGE, false)


func _load_tables() -> void:
	var translations := {"en": Translation.new(), "th": Translation.new()}
	for locale: String in translations:
		translations[locale].locale = locale
	for path in TABLE_PATHS:
		_load_table(path, translations)
	for locale: String in translations:
		TranslationServer.add_translation(translations[locale])


func _load_table(path: String, translations: Dictionary) -> void:
	var file := FileAccess.open(path, FileAccess.READ)
	if file == null:
		push_error("Localization table could not be opened: %s" % path)
		return
	if file.eof_reached():
		return
	var header := file.get_csv_line()
	var key_index := header.find("key")
	var en_index := header.find("en")
	var th_index := header.find("th")
	if key_index < 0 or en_index < 0 or th_index < 0:
		push_error("Localization table requires key,en,th columns: %s" % path)
		return
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

