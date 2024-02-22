/// @description Inserte aquí la descripción
// Puede escribir su código en este editor
velh = 0;
velv = 0;
velz = 0;

face = 1;
//z
z = 0;

vel_max = 2;
vel_salto = 5;
grav = .2;

up		= noone;
down	= noone;
left	= noone;
right   = noone;
jump    = noone;

buffer_ataque = false;

last_speed = image_speed;


estado = noone
mirando = 1;
controla_player = function()
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
//estado del jugador
estado_idle = function()
{
	sprite_index = N_idle;
	
	controla_player();
	
	//saliendo del estado del juegador
	
	if (velh != 0 or velv != 0)
	{
        estado = estado_walk;
     }
	if (jump)
		{
			estado = estado_salto;
			velz = -5;
			}
			if (attack)
	{
			 estado = estado_ataque;
	}
}
 
 
estado_walk = function()
{
	sprite_index = N_walk;
    image_xscale = 0.5981436 * mirando;
  
	
	controla_player();
	
	if (velh == 0 && velv == 0)
	{
	  estado =	estado_idle;
    }
	//pa saltar
	if (jump)
		{
			estado = estado_salto;
			velz = -5;
		}
			if (attack)
	{
			 estado = estado_ataque;
	}
}

estado_ataque = function()

{	
	//Parando ataque cuando te muevas
	velh = 0;
	
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
	if (sprite_index != N_punch && sprite_index != N_punch)
	{
		image_index = 0;
		sprite_index = N_punch;
	}
	
	if (_attack && image_index >= image_number -1)
	 
	{	
		//estado chequeando
		if (sprite_index ==N_punch)
	{	
		sprite_index =  N_punch;
		image_index = 0;
		buffer_ataque = false;
		}
		//Tercer ataque
		if (sprite_index == N_punch && buffer_ataque)
		{
		sprite_index = N_kick;
		image_index = 0;
		buffer_ataque = false;
		}
	}
	//garantizando animacion
	if (image_index >= image_number -1)
	{
	
		estado = estado_idle;
		buffer_ataque = false;
  }
}



estado_salto = function()
{
	if (sprite_index != N_jump && velz <= 0)
	{
		sprite_index = N_jump;
		image_index = 0;
		}
	controla_player();
	
	if (image_index >= image_number -1)
	{
		image_index = image_number -1;
		}
		if (velz > 0)
		{
			sprite_index = N_jump;
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
		estado = estado_idle
	}
}

ajusta_fundo = function()
{
   //pegando a layer
   var _layer = layer_get_id("background");
   
   var _x = camera_get_view_x(view_camera[0]);
    var _y = camera_get_view_x(view_camera[0]);
   
   layer_x(layer, _x / 4);
   layer_y(layer, _y / 4);
	}
estado = estado_walk;
actualizar_mirando = function() {
	if(velh != 0) mirando = sign(velh);
}
