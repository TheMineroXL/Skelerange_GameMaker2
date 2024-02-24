switch (menu_estado)
{
	case "principal":
		draw_sprite_ext(spr_menu, 0, 0, 0, 0.3309, 0.3309, 0, c_white, 1)
		break
	case "modo":
		draw_sprite_ext(spr_menu_mode, 0, 0, 0, 0.3309, 0.3309, 0, c_white, 1)
		break
}

if (IS_DEBUG)
{
	// Feather ignore GM1041
	var _estado_actual = estados[? menu_estado]

	for (var _i = 0; _i < array_length(_estado_actual); _i += 1)
	{
		var _button = _estado_actual[_i]
		var _hovering = (selected_indx == _button.index)
	
		_button.draw(_hovering)
	}
}

draw_sprite(spr_transition, 0, transition_x, 0)