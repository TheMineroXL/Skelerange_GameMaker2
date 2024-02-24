function MenuButton(_x, _y, _w, _h, _index, _name) constructor
{
	name = _name
	index = _index
	x = _x
	y = _y
	w = _w
	h = _h
	
	static is_hovering = function()
	{
		return point_in_rectangle(mouse_x, mouse_y, x, y, x + w, y + h)
	}
	
	static draw = function(_selected)
	{
		if (_selected)
		{
			draw_rectangle_color(x, y, x + w, y + h, c_red, c_red, c_red, c_red, true);
		} else {
			draw_rectangle_color(x, y, x + w, y + h, c_blue, c_blue, c_blue, c_blue, true);
		}
	}
}