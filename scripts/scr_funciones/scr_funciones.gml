// Los recursos de Script han cambiado para la v2.3.0 Consulta
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para más información
function scr_funciones(){

}
function aplica_gravedad(_grav = .2)
{			
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