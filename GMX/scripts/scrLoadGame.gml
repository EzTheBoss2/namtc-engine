///scrLoadGame(loadfile)
///loads the game
///argument0 - sets whether or not to read the save file when loading the game

var loadFile = argument0;

//only load save data from the save file if the script is currently set to (we should only need to load these on first load because the game stores them afterwards)
if (loadFile)
{
    //load the save map
    var saveMap;
    
    if (global.extraSaveProtection) //use ds_map_secure function
    {
        saveMap = ds_map_secure_load("Data\save"+string(global.savenum));
    }
    else    //use text file
    {
        var f = file_text_open_read("Data\save"+string(global.savenum));
        
        saveMap = json_decode(base64_decode(file_text_read_string(f)));
        
        file_text_close(f);
    }
    
    var saveValid = true;   //keeps track of whether or not the save being loaded is valid
    
    if (saveMap != -1)  //check if the save map loaded correctly
    {
        global.death = ds_map_find_value(saveMap,"death");
        global.time = ds_map_find_value(saveMap,"time");
        global.timeMicro = ds_map_find_value(saveMap,"timeMicro");
        
        global.difficulty = ds_map_find_value(saveMap,"difficulty");
        global.saveRoom = ds_map_find_value(saveMap,"saveRoom");
        global.savePlayerX = ds_map_find_value(saveMap,"savePlayerX");
        global.savePlayerY = ds_map_find_value(saveMap,"savePlayerY");
        global.saveGrav = ds_map_find_value(saveMap,"saveGrav");
        
        if (is_string(global.saveRoom))   //check if the saved room loaded properly
        {
            if (!room_exists(asset_get_index(global.saveRoom)))  //check if the room index in the save is valid
                saveValid = false;
        }
        else
        {
            saveValid = false;
        }
        
        for (var i = 0; i < global.secretItemTotal; i++)
        {
            global.saveSecretItem[i] = ds_map_find_value(saveMap,"saveSecretItem["+string(i)+"]");
        }
        
        for (var i = 0; i < global.bossItemTotal; i++)
        {
            global.saveBossItem[i] = ds_map_find_value(saveMap,"saveBossItem["+string(i)+"]");
        }
        
        global.saveGameClear = ds_map_find_value(saveMap,"saveGameClear");
        
        //load md5 string from the save map
        var mapMd5 = ds_map_find_value(saveMap,"mapMd5");
        
        //check if md5 is not a string in case the save was messed with or got corrupted
        if (!is_string(mapMd5))
            mapMd5 = "";   //make it a string for the md5 comparison
        
        //generate md5 string to compare with
        ds_map_delete(saveMap,"mapMd5");
        var genMd5 = md5_string_unicode(json_encode(saveMap)+global.md5StrAdd);
        
        if (mapMd5 != genMd5)   //check if md5 hash is invalid
            saveValid = false;
        
        //destroy the map
        ds_map_destroy(saveMap);
    }
    else
    {
        //save map didn't load correctly, set the save to invalid
        saveValid = false;
    }
    
    if (!saveValid) //check if the save is invalid
    {
        //save is invalid, restart the game
        
        show_message("Save invalid!");
        
        scrRestartGame();
        
        exit;
    }
}

//set game variables and set the player's position

with (objPlayer) //destroy player if it exists
    instance_destroy();

global.gameStarted = true;  //sets game in progress (enables saving, restarting, etc.)
global.noPause = false;     //disable no pause mode
global.autosave = false;    //disable autosaving since we're loading the game

global.grav = global.saveGrav;

for (var i = 0; i < global.secretItemTotal; i++)
{
    global.secretItem[i] = global.saveSecretItem[i];
}

for (var i = 0; i < global.bossItemTotal; i++)
{
    global.bossItem[i] = global.saveBossItem[i];
}

global.gameClear = global.saveGameClear;




// (NAMTC) We need to load the data from the save regardless of load location

//load the save map
var saveMap;

if (global.extraSaveProtection) //use ds_map_secure function
{
    saveMap = ds_map_secure_load("Data\save"+string(global.savenum));
}
else    //use text file
{
    var f = file_text_open_read("Data\save"+string(global.savenum));
    
    saveMap = json_decode(base64_decode(file_text_read_string(f)));
    
    file_text_close(f);
}

var saveValid = true;   //keeps track of whether or not the save being loaded is valid

if (saveMap != -1)  //check if the save map loaded correctly
{
    show_debug_message("Loading stats...")
    global.kidHP =    ds_map_find_value(saveMap, "kidHP")
    global.kidATK =   ds_map_find_value(saveMap, "kidATK")
    global.kidDEF =   ds_map_find_value(saveMap, "kidDEF")
    global.kidEXP =   ds_map_find_value(saveMap, "kidEXP")
    global.kidLevel = ds_map_find_value(saveMap, "kidLevel")
    
    global.save_kidHP =    global.kidHP
    global.save_kidATK =   global.kidATK
    global.save_kidDEF =   global.kidDEF
    global.save_kidEXP =   global.kidEXP 
    global.save_kidLevel = global.kidLevel 
    
    global.keyAreas = ds_map_find_value(saveMap, "keyAreas")
    for (i = 0; i < global.keyAreas; i++) {
        for (j = 0; j < global.keyTypes; j++) {
            global.kidKey[i, j] = ds_map_find_value(saveMap, "kidKey[" + string(i) + "," + string(j) + "]")
        }
    }
    
    for (i = 0; i <= room_last; i++) {
        for (j = 0; j < 256; j++) {
            global.saveRoomObject[i, j] = ds_map_find_value(saveMap, "saveRoomObject[" + string(i) + "," + string(j) + "]")
        }
    }

    for (i = 0; i < global.keyAreas; i++) {
        for (j = 0; j < global.keyTypes; j++) {
            global.save_kidKey[i, j] = global.kidKey[i, j]
        }
    }
    
    for (i = 0; i <= room_last; i++) {
        for (j = 0; j < 256; j++) {
            global.save_saveRoomObject[i, j] = global.saveRoomObject[i, j]
        }
    }
    
} else {
    //save map didn't load correctly, set the save to invalid
    saveValid = false;
}

if (!saveValid) //check if the save is invalid
{
    //save is invalid, restart the game
    
    show_message("Save invalid!");
    
    scrRestartGame();
    
    exit;
}

instance_create(global.savePlayerX,global.savePlayerY,objPlayer);

room_goto(asset_get_index(global.saveRoom));
