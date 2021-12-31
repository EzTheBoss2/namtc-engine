
switch global.screenPosition {
    case 0:
        return mouse_x + -288 + (mouse_x / 800) * 288
    break; case 1:
        return mouse_x + -144 + (mouse_x / 800) * 288
    break; case 2:
        return mouse_x + (mouse_x / 800) * 288
    break;
}

