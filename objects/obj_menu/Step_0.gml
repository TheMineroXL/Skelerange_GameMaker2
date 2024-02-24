if (transition_x > transition_min)
{
	transition_x -= (sprite_get_width(spr_transition) / (60 * transition_duration))
	
	if ((transition_x <= -128) && (menu_estado != siguiente_estado))
	{
		menu_estado = siguiente_estado
	}
	exit
}

// Feather ignore GM1041
var _estado_actual = estados[? menu_estado]
is_using_mouse = false

for (var _i = 0; _i < array_length(_estado_actual); _i += 1)
{
	var _button = _estado_actual[_i]
	var _hovering = _button.is_hovering()
	
	if (_hovering)
	{
		is_using_mouse = true
		selected_indx = _button.index
	}
}

var _move = 0
if (menu_estado == "principal")
{
	_move = (keyboard_check_pressed(vk_down) - keyboard_check_pressed(vk_up))
} else {
	_move = (keyboard_check_pressed(vk_right) - keyboard_check_pressed(vk_left))
}

selected_indx = ((selected_indx + _move) % array_length(_estado_actual))
selected_indx = clamp(selected_indx, 0, array_length(_estado_actual))

// Feather restore GM1041

do_button(menu_estado, _estado_actual[selected_indx].name)