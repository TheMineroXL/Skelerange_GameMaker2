/// @description Dibujado de la sombra y sprite

var _escala =  z * .002;
draw_sprite_ext(spr_sombra, 0, x, y, .2 + _escala, .2 + _escala, 0, c_black, .5)
draw_sprite_ext(sprite_index, image_index, x , y + z , image_xscale * face, image_yscale, image_angle, image_blend, image_alpha);