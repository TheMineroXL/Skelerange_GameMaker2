extra_delay -= 1
bg_offset = (bg_offset + (256 / 120)) % 256
frames += 1

if (extra_delay < 0)
{
	extra = !extra
	extra_delay = 12
}

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
		change_button(_button.index)
	}
}

var _move = 0
if (menu_estado == "principal")
{
	_move = (keyboard_check_pressed(vk_down) - keyboard_check_pressed(vk_up))
} else {
	_move = (keyboard_check_pressed(vk_right) - keyboard_check_pressed(vk_left))
	
	if (keyboard_check_pressed(vk_escape))
	{
		cambiar_estado("principal")
	}
}

if (_move != 0)
{
	change_button((selected_indx + _move) % array_length(_estado_actual))
}

selected_indx = clamp(selected_indx, 0, array_length(_estado_actual))

// Feather restore GM1041

do_button(menu_estado, _estado_actual[selected_indx].name)