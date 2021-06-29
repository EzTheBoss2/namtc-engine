///initializes all global variables needed for the game

scrSetGlobalOptions();       //initialize global game options

global.savenum = 1;
global.difficulty = 0;  //0 = medium, 1 = hard, 2 = very hard, 3 = impossible
global.death = 0;
global.time = 0;
global.timeMicro = 0;
global.saveRoom = "";
global.savePlayerX = 0;
global.savePlayerY = 0;
global.grav = 1;
global.saveGrav = 1;

for (var i = global.secretItemTotal-1; i >= 0; i--)
{
    global.secretItem[i] = false;
    global.saveSecretItem[i] = false;
}

for (var i = global.bossItemTotal-1; i >= 0; i--)
{
    global.bossItem[i] = false;
    global.saveBossItem[i] = false;
}

global.gameClear = false;
global.saveGameClear = false;

for (var i = 99; i >= 0; i--)
{
    global.trigger[i] = false;
}

global.gameStarted = false;     //determines whether the game is in progress (enables saving, restarting, etc.)
global.noPause = false;         //sets whether or not to allow pausing (useful for bosses to prevent desync)
global.autosave = false;        //keeps track of whether or not to autosave the next time the player is created
global.noDeath = false;         //keeps track of whether to give the player god mode
global.infJump = false;         //keeps track of whether to give the player infinite jump

global.gamePaused = false;      //keeps track of whether the game is paused or not
global.pauseSurf = -1;       //stores the screen surface when the game is paused
global.pauseDelay = 0;      //sets pause delay so that the player can't quickly pause buffer

global.currentMusicID = -1;  //keeps track of what song the current music is
global.currentMusic = -1;    //keeps track of current main music instance
global.deathSound = -1;     //keeps track of death sound when the player dies
global.gameOverMusic = -1;   //keeps track of game over music instance
global.musicFading = false;     //keeps track of whether the music is being currently faded out
global.currentGain = 0;     //keeps track of current track gain when a song is being faded out

global.menuSelectPrev[0] = 0;     //keeps track of the previously selected option when navigating away from the difficulty menu
global.menuSelectPrev[1] = 0;     //keeps track of the previously selected option when navigating away from the options menu

//get the default window size
global.windowWidth = surface_get_width(application_surface);
global.windowHeight = surface_get_height(application_surface);

//keeps track of previous window position/size when display_reset is used for setting vsync
global.windowXPrev = 0;
global.windowYPrev = 0;
global.windowWidthPrev = 0;
global.windowHeightPrev = 0;

display_set_gui_size(surface_get_width(application_surface),surface_get_height(application_surface));  //set the correct gui size for the Draw GUI event

global.controllerMode = false;  //keeps track of whether to use keyboard or controller
global.controllerDelay = -1;    //handles delay between switching between keyboard/controller so that the player can't use both at the same time

randomize();    //make sure the game starts with a random seed for RNG

// NAMTC Content

global.drawHUD = true;     // Do we draw the HUD? (Override for disabling it in game)
global.widescreen = false; // Do we force widescreen? (Useful for bosses)

global.hudBacksprite = sprHUDPanelDefault; // Change this global to change what back sprite the panel uses

global.screenShader = -1;   // Screen shader for unique setups
// Kid stats

global.kidHP = 1;
global.kidATK = 1;
global.kidDEF = 0;

global.kidEXP = 0;
global.kidLevel = 1;

// Kid keys; define how many key types per area there will be here
global.keyTypes = 10;

// This will be loaded from save, but we need to define it anyway
global.keyAreas = 4;

for (h = 0; h < global.keyAreas; h++) {
    for (i = 0; i < global.keyTypes; i++) {
        global.kidKey[h, i] = 0;
    }
}

global.currentArea = 0; // Set in room creation code
global.currentFloor = 0; // Set in room creation code

// Persistent objects; set hard limit of 256 per room to avoid headache with dynamic array size
// You can literally only fit 475 objects on one screen without overlapping to begin with
for (i = 0; i <= room_last; i++) {
    for (j = 0; j <= 256; j++) {
        global.saveRoomObject[i, j] = false;
    }
}

// save_ versions of each of these variables are required because the save system is a little jank

global.save_kidHP = 1;
global.save_kidATK = 1;
global.save_kidDEF = 0;

global.save_kidEXP = 0;
global.save_kidLevel = 1;

for (h = 0; h < global.keyAreas; h++) {
    for (i = 0; i < global.keyTypes; i++) {
        global.save_kidKey[h, i] = 0;
    }
}

for (i = 0; i <= room_last; i++) {
    for (j = 0; j <= 256; j++) {
        global.save_saveRoomObject[i, j] = false;
    }
}
