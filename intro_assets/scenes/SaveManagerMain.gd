extends Node

const SAVE_PATH := "user://save_checkpoint.cfg"
const SECTION   := "checkpoint"

var cfg := ConfigFile.new()

# Data kept in-memory after load
var last_scene_path: String = ""
var resume_marker: String = ""   # e.g. "engine_after_main"
var payload: Dictionary = {}     # anything extra you want (room states etc.)

# ✅ Check if a save exists
func has_checkpoint() -> bool:
	var err = cfg.load(SAVE_PATH)
	return err == OK and cfg.has_section_key(SECTION, "scene")

# ✅ Save checkpoint data
func save_checkpoint(scene_path: String, marker: String, extra: Dictionary = {}) -> void:
	cfg = ConfigFile.new()
	cfg.set_value(SECTION, "scene", scene_path)
	cfg.set_value(SECTION, "marker", marker)
	cfg.set_value(SECTION, "payload", extra)
	var err = cfg.save(SAVE_PATH)
	if err != OK:
		push_warning("Save failed: %s" % err)
	else:
		print("💾 Saved checkpoint:", scene_path, " marker:", marker)

# ✅ Load checkpoint and return as Dictionary
func load_checkpoint() -> Dictionary:
	var err = cfg.load(SAVE_PATH)
	if err != OK:
		print("⚠ No checkpoint found (err code %s)" % err)
		return {}

	var data := {
		"scene": cfg.get_value(SECTION, "scene", ""),
		"marker": cfg.get_value(SECTION, "marker", ""),
		"payload": cfg.get_value(SECTION, "payload", {})
	}

	print("📂 Loaded checkpoint:", data)
	return data

# ✅ Warp directly to checkpoint
func goto_checkpoint() -> void:
	var data := load_checkpoint()
	if data.is_empty():
		print("⚠ No checkpoint to load.")
		return

	var scene_path = data["scene"]
	if ResourceLoader.exists(scene_path):
		print("➡ Going to saved scene:", scene_path)
		get_tree().change_scene_to_file(scene_path)
	else:
		print("⚠ Saved scene file not found:", scene_path)

# ✅ Optional: remove save
func clear_save() -> void:
	var empty := ConfigFile.new()
	empty.save(SAVE_PATH)
	last_scene_path = ""
	resume_marker = ""
	payload.clear()
	print("🗑️ Save cleared.")
