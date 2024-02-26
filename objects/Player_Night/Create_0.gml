/// @description Inserte aquí la descripción
// Puede escribir su código en este editor

// Heredamos variables como velh, velz, face, z, etc.
event_inherited()

vel_max = 2;
vel_salto = 5;
grav = .2;

up		= noone;
down	= noone;
left	= noone;
right   = noone;
jump    = noone;
attack  = noone;

buffer_ataque = false;

last_speed = image_speed;

// Para contener todos los estados de manera mas bonita
mirando = 1;

estados[? "controla_player"] = function()
{
	up = keyboard_check(ord("W"));
	down = keyboard_check(ord("S"));
	left = keyboard_check(ord("A"));
	right = keyboard_check(ord("D"));

	attack = keyboard_check_pressed(ord("J"));
	jump   = keyboard_check_pressed(ord("K"));

	velh = (right - left)  * vel_max;
	velv = (down - up)  * vel_max;
}

estados[? "estado_idle"] = function()
{
	sprite_index = spr_n_idle;
	
	estados[? "controla_player"]();
	
	//saliendo del estado del juegador
	
	if (velh != 0 or velv != 0)
	{
        estado = "estado_walk";
	}
	
	if (jump)
	{
		estado = "estado_salto";
		velz = -5;
	}
	
	if (attack)
	{
		estado = "estado_ataque";
	}
}

estados[? "estado_walk"] = function()
{
	sprite_index = spr_n_walk;
    image_xscale = 0.5981436 * mirando;
	
	estados[? "controla_player"]();
	
	if (velh == 0 && velv == 0)
	{
		estado = "estado_idle";
    }
	
	//pa saltar
	if (jump)
	{
		estado = "estado_salto";
		velz = -5;
	}
	
	if (attack)
	{
		estado = "estado_ataque";
	}
}

estados[? "estado_salto"] = function()
{
    if (sprite_index != spr_n_jump && velz <= 0)
    {
		sprite_index = spr_n_jump;
		image_index = 0;
	}
	estados[? "controla_player"]();
    
    if (image_index >= image_number -1)
    {
		image_index = image_number -1;
	}
	
	if (velz > 0)
	{
		sprite_index = spr_n_jump;
	}
            
            
    //elevando
    z += velz; 
    
    //aplicando gravedad
    if (z < 0)
    {
		velz += grav;
    }
    else 
    { 
        velz = 0;
        z = 0;
        estado = "estado_idle"
    }
}

estados[? "estado_salto"] = function()
{
    if (sprite_index != spr_n_jump && velz <= 0)
    {
		sprite_index = spr_n_jump;
		image_index = 0;
	}
	
    estados[? "controla_player"]();
    
    if (image_index >= image_number -1)
    {
        image_index = image_number -1;
	}
	
	if (velz > 0)
	{
		sprite_index = spr_n_jump;
	}
            
            
    //elevando
    z += velz; 
    
    //aplicando gravedad
    if (z < 0)
    {
		velz += grav;
    }
    else 
    { 
        velz = 0;
        z = 0;
        estado = "estado_idle";
    }
}

estados[? "estado_ataque"] =  function()
{	
	//Parando ataque cuando te muevas
	velh = 0;
	velv = 0;
	
	var _attack = keyboard_check_pressed(ord("J"));
	
	if (buffer_ataque == true)
	{
		_attack	= true;	
	}
	else //Buffer ataque false
	{
		buffer_ataque = keyboard_check_pressed(ord("J"));
	}
	
	//resteando animacion
	if (sprite_index != spr_n_punch && sprite_index != spr_n_punch)
	{
		image_index = 0;
		sprite_index = spr_n_punch;
	}
	
	if (_attack && image_index >= image_number -1)
	{	
		//estado chequeando
		if (sprite_index ==spr_n_punch)
		{	
			sprite_index =  spr_n_punch;
			image_index = 0;
			buffer_ataque = false;
		}
		
		//Tercer ataque
		if (sprite_index == spr_n_punch && buffer_ataque)
		{
			sprite_index = spr_n_punch;
			image_index = 0;
			buffer_ataque = false;
		}
	}
	
	//garantizando animacion
	if (image_index >= image_number -1)
	{
	
		estado = "estado_idle";
		buffer_ataque = false;
	}
}
 
estados[? "ajusta_fundo"] = function()
{
	if (sprite_index != spr_n_jump && velz <= 0)
	{
		sprite_index = spr_n_jump;
		image_index = 0;
	}
	
	estados[? "controla_player"]();
	
	if (image_index >= image_number -1)
	{
		image_index = image_number -1;
	}
	
	if (velz > 0)
	{
		sprite_index = spr_n_jump;
	}
			
	if (attack)
	{
		estado = estado_ataque_ar;
	}
	
	//elevando
	z += velz; 
	
	//aplicando gravedad
	if (z < 0)
	{
		velz += grav;
	}
	else 
	{ 
		velz = 0;
		z = 0;
		estado = "estado_idle"
	}
}

estados[? "ajusta_fundo"] = function()
{
   //pegando a layer
   var _layer = layer_get_id("background");
   
   var _x = camera_get_view_x(view_camera[0]);
    var _y = camera_get_view_x(view_camera[0]);
   
   layer_x(layer, _x / 4);
   layer_y(layer, _y / 4);
}

estado_ataque_ar = function()
{
	if (sprite_index != spr_n_SEX_kick)
   
   { 
	 sprite_index = spr_n_SEX_kick;
	 image_index = 0;
    }
}


//estado del jugador

estado = "estado_walk";

actualizar_mirando = function()
{
	if(velh != 0) mirando = sign(velh);
}