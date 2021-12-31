///mouse_in_window()
//Thanks based renex

var dx,dy,wx,wy,ww,wh;

dx=display_mouse_get_x();
dy=display_mouse_get_y();
wx=window_get_x();
wy=window_get_y();
ww=window_get_width();
wh=window_get_height();

return (dx >= wx && dy >= wy && dx < wx + ww && dy < wy + wh);

