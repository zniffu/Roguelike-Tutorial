extends Node2D

# https://coolors.co/f8f9fa-e9ecef-dee2e6-ced4da-adb5bd-6c757d-495057-343a40-212529
# https://coolors.co/d8f3dc-b7e4c7-95d5b2-74c69d-52b788-40916c-2d6a4f-1b4332-081c15
# https://coolors.co/f8b945-dc8a14-b9690b-854e19-a03401
# Colour palettes generated and used in the tutorial

#Dictionary constant of specified colours for sprites (white png transparency ascii symbols)
const PALETTE: Dictionary = {
	&"BACKGROUND": "#212529",
	&"LIGHT_GREY": "#ADB5BD",
	&"GREEN": "#52B788",
	&"DARK_GREEN": "#2D6A4F",
	&"GREY": "#6C757D",
	&"DARK_GREY": "#343A40",
	&"ORANGE": "#F8B945",
	&"DARK_ORANGE": "#854E19",
	&"DEBUG": "#FE4A49",
}

#Setting the size of the 2D grid and the steps between (which match the dimensions of sprites.)
const START_X: int = 50
const START_Y: int = 54 #starting pixel coords of the grid, visually offsets from edge of window xy pixels
const STEP_X: int = 24 #steps reflect pixel size of the sprites tutorial 26
const STEP_Y: int = 36 #tutorial 34, maybe error since the 4 and 6 are swapped according to sprite size



func _ready() -> void: #-> void is a best practice thing for return types, would produce same result without doing so.
	RenderingServer.set_default_clear_color(PALETTE["BACKGROUND"])
	_create_pc()

#function accepts an argument offset in case a sprite is needing off the grid
func _get_position_from_coord(coord: Vector2i,
			offset: Vector2i = Vector2i(0,0)) -> Vector2i:
		var new_x: int = START_X + STEP_X * coord.x + offset.x
		var new_y: int = START_Y + STEP_Y * coord.y + offset.y
		return Vector2i(new_x, new_y)

#function assumes sprite fits exactly into the grid
func _get_coord_from_sprite(sprite: Sprite2D) -> Vector2i:
	var new_x: int = floor((sprite.position.x - START_X) / STEP_X)
	var new_y: int = floor((sprite.position.y - START_Y) / STEP_Y)
	return Vector2i(new_x, new_y)

func _create_pc() -> void:
	# var pc: Sprite2D = preload("res://sprite/pc.tscn").instantiate()
	
	var pc: PackedScene = preload("res://sprite/pc.tscn")
	var new_pc: Sprite2D
	var new_position: Vector2i = Vector2i(0, 0)
	new_pc = pc.instantiate()
	new_pc.position = _get_position_from_coord(new_position)
	new_pc.modulate = PALETTE['GREEN']
	new_pc.add_to_group("PC_TAG")

	# var pc: PackedScene = preload("res://sprite/pc.tscn")
	# var new_pc: Sprite2D
	# var new_position: Vector2i = Vector2i(0, 0)

	# for i: StringName in PALETTE.keys():
	# 	new_pc = pc.instantiate()
	# 	new_pc.position = _get_position_from_coord(new_position)
	# 	new_pc.modulate = PALETTE[i]
	# 	add_child(new_pc)
	# 	print(_get_coord_from_sprite(new_pc))
	# 	print(_get_position_from_coord(new_position))
	# 	new_position.y +=1

func _move_pc(direction: StringName) -> void:
	var pc: Sprite2D = get_tree().get_first_node_in_group(PC_TAG)
	var coord: Vector2i = _get_coord_from_sprite(pc)

# 	match direction:
# 		MOVE_LEFT:
# 			coord += Vector2i.LEFT
# 		MOVE_RIGHT:
# 			coord += Vector2i.RIGHT
# 		MOVE_UP:
# 			coord += Vector2i.UP
# 		MOVE_DOWN:
# 			coord += Vector2i.DOWN

# 	pc.position = _get_position_from_coord(coord)

# func _unhandled_input(event: InputEvent):
# 	for i: StringName in MOVE_INPUTS:
# 		if event.is_action_pressed(i):
# 			_move_pc(i)
