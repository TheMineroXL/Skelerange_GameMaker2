/// @description Render

// Inherit the parent event
event_inherited();

draw_rectangle(meu_x , meu_y , meu_x +alcance_x + face, meu_y - alcance_y, true);
draw_rectangle(ponto_x, ponto_y, ponto_x +tamano - face , ponto_x ,true);
draw_circle(meu_x, meu_y, 5,true);
