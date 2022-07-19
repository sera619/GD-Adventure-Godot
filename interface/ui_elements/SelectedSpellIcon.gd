# Shows the currently selected spell. It can be set by passing it either the
# Spell's type (a number) or a spell's scene.
# If you create a new spell, make sure to add it to `scene_types`! You need to
# do this manually.
#
# This element connects to the global event bus so it can automatically switch
# spells when the player collects a new spell.
tool
class_name SelectedSpellIcon
extends HBoxContainer

# The type allows us to display text in the editor interface to check the
# different spell designs
enum Type { NONE, FLAME, ICE, LIGHTNING }

# This dictionary matches specific scenes with specific types.
# If you create a new spell, or change the location of a spell, make sure to
# update this dictionary
const scenes_types := {
	preload("res://spells/fire_rapid/SpellRapidFire.tscn"): Type.FLAME,
	preload("res://spells/fire_spray/SpellFireSpray.tscn"): Type.FLAME,
	preload("res://spells/ice_punch/SpellIcePunch.tscn"): Type.ICE,
	preload("res://spells/lightning_shot/SpellLightningShot.tscn"): Type.LIGHTNING
}

# Export the type in the interface for easy visualisation
export(Type) var current_spell_type: int = Type.NONE setget set_current_spell_type

onready var _flame_icon := $Flame/LitIcon
onready var _ice_icon := $Ice/LitIcon
onready var _lightning_icon := $Lightning/LitIcon


func _ready() -> void:
	# Connect to the global event bus to change the selected visual if the player
	# picks a different spell.
	Events.connect("selected_spell_changed", self, "_set_current_spell_from_scene")


# This function receives a scene, and matches it with a spell type to select
# the appropriate spell to show.
# CAUTION: the scene *must* be in `scenes_types`. If it isn't found, nothing
# happens.
# This function is also called from when the "selected_spell_changed" signal is
# emitted from the global Events bus.
func _set_current_spell_from_scene(scene: PackedScene) -> void:
	if scene in scenes_types:
		set_current_spell_type(scenes_types[scene])


# Sets the visually selected spell type from a type. Uses the Type enum above
func set_current_spell_type(new_type: int) -> void:
	current_spell_type = new_type
	# this function might be called before the children icons are ready, so
	# we make sure to wait for ready
	if not is_inside_tree():
		yield(self, "ready")

	# in the editor, sometimes the children aren't available, so we make sure
	# they exist
	if _flame_icon and _ice_icon and _lightning_icon:
		_update_icons_visibility()


# Hides or shows icons depending on the value of _current_spell_type
func _update_icons_visibility() -> void:
	_flame_icon.visible = current_spell_type == Type.FLAME
	_ice_icon.visible = current_spell_type == Type.ICE
	_lightning_icon.visible = current_spell_type == Type.LIGHTNING
