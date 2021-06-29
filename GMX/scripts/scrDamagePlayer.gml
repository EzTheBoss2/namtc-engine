///scrDamagePlayer(amount)
// Damages the player, killing them if need be
// [int]  amount: amount to damage the player by
// [bool] flat: should this ignore defence or not?
if instance_exists(objPlayer) {
    if objPlayer.alarm[0] < 1 {
        global.kidHP -= max(0, (argument0 - global.kidDEF ))
        audio_play_sound(sndBossHit, 0, false)
        objPlayer.alarm[0] = objPlayer.iframes;
        objPlayer.image_alpha = 0.5;
    }
    
    if global.kidHP <= 0 {
        scrKillPlayer()
    }
}
