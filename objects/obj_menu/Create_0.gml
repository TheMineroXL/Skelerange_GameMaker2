menu_estado = "principal"
siguiente_estado = "principal"

// Pueden cambiar esto (esta en segundos)
transition_duration = 0.25

extra = false
extra_delay = 12
frames = 0

// cambia esto para ver el clickbox
debug_menu = false

bg_offset = 0

transition_min = (-sprite_get_width(spr_transition)) - 2
transition_max = (sprite_get_width(spr_transition)) + 1
transition_x = transition_min

is_using_mouse = false

estados = ds_map_create()
selected_indx = 0

// Aqui creas estados nuevos, puedes darle funcion a los botones en do_button()
// Menu principal
estados[? "principal"] = [
	new MenuButton(81, 275, 245, 71, 0, "Start"),
	new MenuButton(97, 355, 245, 71, 1, "Options"),
	new MenuButton(129, 435, 245, 71, 2, "Extras"),
	new MenuButton(113, 531, 245, 71, 3, "Credits"),
	new MenuButton(113, 643, 245, 71, 4, "Exit")
]

// Menu de modos
estados[? "modo"] = [
	new MenuButton(240, 210, 259, 492, 0, "Versus Mode"),
	new MenuButton(544, 210, 259, 492, 1, "Story Mode"),
	new MenuButton(872, 210, 259, 492, 2, "Lost Levels Mode")
]

/// @function                 clear(_estado_id);
/// @param {string}  _estado_id  El key del estado
/// @description              Limpia todos los structs
/// Feather ignore GM1041
function clear(_estado_id)
{
	/// @var {array} _estado_actual
	var _estado_actual = estados[? _estado_id]
	
	for (var _i = (array_length(_estado_actual)-1); _i >= 0; _i -= 1)
	{
		var _struct = _estado_actual[_i]
		delete _struct
		array_delete(_estado_actual, _i, 1)
	}
}

function cambiar_estado(_siguiente)
{
	siguiente_estado = _siguiente
	transition_x = transition_max
}

function change_button(_to)
{
	if (selected_indx == _to) return;
	
	audio_play_sound(sfx_select, 0, false, 0.8, 0, 1 - (selected_indx * 0.05))
	selected_indx = _to
}

function ding()
{
	audio_play_sound(sfx_choice, 0, false, 0.8)
}

function do_button(_estado, _nombre)
{
	var _clicking = false;
	
	if (keyboard_check_pressed(vk_enter) || (is_using_mouse && mouse_check_button_pressed(mb_left)))
	{
		_clicking = true;
	}
	
	if (!_clicking)
	{
		exit
	}
	
	show_debug_message(_estado + " " + _nombre)
	
	if (_estado == "principal")
	{
		if (_nombre == "Start")
		{
			ding()
			cambiar_estado("modo")
		}
		if (_nombre == "Exit") game_end();
		exit
	}
	
	if (_estado == "modo")
	{
		if (_nombre == "Story Mode")
		{
			ding()
			room_goto(rm_lvl)
		}
		exit
	}
}