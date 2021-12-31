///scrPlayBattleMusic(soundid,loops)
///plays a song if it's not already playing
///argument0 - song to play (-1 plays nothing and stops anything currently playing)
///argument1 - whether or not to loop the song

var songID = argument0;
var loopSong = argument1;

if (!global.muteMusic)  //check if music is supposed to be muted
{
    if (songID != -1)
        global.currentBattleMusic = audio_play_sound(songID,1,loopSong);
}
