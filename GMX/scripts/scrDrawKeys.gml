///scrDrawKeys(x, y, offset)
var xx = argument0;
var yy = argument1;
var offset = argument2;
draw_set_font(fDefault24)
switch global.currentArea { // Change key rendering for each area; different sprites
    default:
        draw_sprite_ext(sprKey, 0, xx, yy+((offset+0)*32), 1, 1, 0, c_orange, 1)
        draw_sprite_ext(sprKey, 0, xx, yy+((offset+1)*32), 1, 1, 0, c_blue, 1)
        draw_sprite_ext(sprKey, 0, xx, yy+((offset+2)*32), 1, 1, 0, c_red, 1)
        draw_sprite_ext(sprKey, 0, xx, yy+((offset+3)*32), 1, 1, 0, c_green, 1)
        draw_sprite_ext(sprKey, 0, xx, yy+((offset+4)*32), 1, 1, 0, c_gray, 1)
        
        draw_sprite_ext(sprCrossKey,   0, xx+96, yy+((offset+0)*32), 1, 1, 0, c_white, 1)
        draw_sprite_ext(sprDiamondKey, 0, xx+96, yy+((offset+1)*32), 1, 1, 0, c_white, 1)
        draw_sprite_ext(sprHeartKey,   0, xx+96, yy+((offset+2)*32), 1, 1, 0, c_white, 1)
        draw_sprite_ext(sprSquareKey,  0, xx+96, yy+((offset+3)*32), 1, 1, 0, c_white, 1)
        draw_sprite_ext(sprStarKey,    0, xx+96, yy+((offset+4)*32), 1, 1, 0, c_white, 1)
    break;
}

draw_set_halign(0)
for (i = 0; i <= 4; i++) {
    scrDrawTextOutline(xx+32,  yy+((i+offset)*32)-2, global.kidKey[global.currentArea, i],   c_white, c_black)
    scrDrawTextOutline(xx+128, yy+((i+offset)*32)-2, global.kidKey[global.currentArea, i+5], c_white, c_black)
}
