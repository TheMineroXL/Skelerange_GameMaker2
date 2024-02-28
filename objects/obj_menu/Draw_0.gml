draw_sprite_tiled(spr_pattern, 0, bg_offset, bg_offset)

switch (menu_estado)
{
	case "principal":
		draw_sprite_ext(spr_title, floor((frames / 20) % 3), 832,  161, 1, 1, sin(frames / 30) * 5, c_white, 1)
		draw_sprite_ext(spr_menu_buttons, (selected_indx*2) + extra, 0, 0, 1, 1, 0, c_white, 1)
		break
	case "modo":
		draw_sprite_ext(spr_mode, (selected_indx*2) + extra, 0, 0, 1, 1, 0, c_white, 1)
		break
}

if (debug_menu)
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