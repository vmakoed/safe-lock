extends Node

var state = {
    "level_selector": {
        "last_selected_index": 0
    }
}
const CONFIG_PATH = "user://game_state.cfg"


func _ready() -> void:
    _load_from_disk()

func save_to_disk() -> void:
    var file = FileAccess.open("user://game_state.json", FileAccess.WRITE)
    file.store_string(JSON.stringify(state, "\t"))

func get_last_selected_level() -> int:
    return state["level_selector"]["last_selected_index"]

func set_last_selected_level(index: int) -> void:
    state["level_selector"]["last_selected_index"] = index

func _load_from_disk() -> void:
    if not FileAccess.file_exists("user://game_state.json"):
        return

    var file = FileAccess.open("user://game_state.json", FileAccess.READ)
    var json_string = file.get_as_text()
    state = JSON.parse_string(json_string)
    