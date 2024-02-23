// Inherit the parent event
event_inherited();

meu_x = x;
meu_y = y;
alcance_x = 30;
alcance_y = 10;

espera_estado = game_get_speed(gamespeed_fps) * 2;
timer_estado = espera_estado;

alvo = noone;

//area de vision
area_vision = 60;

//creando estados enemigos
timer_ataque = 0;

//variables debug
ponto_x = 0;
ponto_y = 0;
tamano = 10;

//metodo para ver al jugador
estados[? "checa_area"] = function(_tamano_area = 0, _alvo = noone)
{
	//mover a donde esta la misma area
	if (_alvo == noone) return false

	return collision_circle(x, y, _tamano_area, _alvo, 0,1);
}

estados[? "estado_parado"] = function()
{
	sprite_index = spr_p_idle;

	if (timer_ataque > 0) timer_ataque--;
	
	velh = 0;
	velv = 0;
	
	timer_estado--;
	
	if (timer_estado <= 0)
	{
		var _change = random(1);
		if (_change > .5)
		{
			estado = "estado_move";
		}
		//
		timer_estado = espera_estado
	}
}

estados[? "estado_move"] = function()
{
	if (timer_ataque > 0) timer_ataque--;
	
	if (sprite_index != spr_p_walk)
	{
		sprite_index = spr_p_walk;
		image_index = 0;
	
		velh = random_range(-1,1);
		velv = random_range(-1,1);
	}
	
	timer_estado--;
	
	if (timer_estado <= 0)
	{
		estado = choose("estado_parado", "estado_move");
		timer_estado = espera_estado
	}
	
	alvo = estados[? "checa_area"](area_vision, player_night);
	
	//checando el alvo
	if (alvo && timer_ataque <= 0)
	{
		estado = "estado_perseguir";
	}
}

//perseguir
estados[? "estado_perseguir"] = function()
{
	//sabiendo la distancia del juegador
	
	var _dist = point_distance(x, y, alvo.x ,alvo.y);
	// Indicando direccion al jugador
	var _dir = point_direction(x, y ,alvo.x, alvo.y);
		
	meu_y = y - sprite_height /2 ;
	meu_x = x;
	
	//perseguir
	
	ponto_x = alvo.x;
	ponto_y = alvo.y - alvo.sprite_height /2; 
	
	//aplicando velocidad contra el jugador
	var _dist_x = abs(alvo.x - x);
	//distancia vertical
	var _dist_y  = abs(bbox_top -y);
	
	show_debug_message(_dist_x);
	show_debug_message(_dist_y);
	
	velh = lengthdir_x(_dist_x  < 25 ? 0: .5, _dir);
	velv = lengthdir_y(_dist_x  < 25 ? 0: .5,_dir);
		
	if (sprite_index != spr_p_walk)
	{
		sprite_index = spr_p_walk;
		image_index = 0;
	}
	
	//saber si  cuadrado esta en el jugador
	var _atacar = rectangle_in_rectangle(meu_x , meu_y , meu_x +alcance_x + face, meu_y - alcance_y,ponto_x, ponto_y, ponto_x +tamano - face , ponto_x);
	
	//distancia pequeña para atacar
	if (_atacar)
	{
		estado = "estado_ataque";
	}
}

estados[? "estado_ataque"] = function()
{
	velh = 0;
	velv = 0;
	if (sprite_index != spr_p_attack)
	{
		sprite_index = spr_p_attack
		image_index = 0;
	}
	
	//saliendo de estado de ataque
	if (image_index > image_number - 1)
	{
		estado = "estado_parado";
		timer_ataque = espera_estado;
	}
}

estado = "estado_parado"