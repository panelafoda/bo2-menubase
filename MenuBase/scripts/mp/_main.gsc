#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include scripts\mp\_utils;
#include scripts\mp\_functions;

init() {
    thread OnPlayerConnect();
}

OnPlayerConnect() {
    while(true) {
        level waittill("connected", player);
        player thread OnPlayerSpawned();
    }
}

OnPlayerSpawned() {
    while(true) {
        self waittill("spawned_player");
        if(isdefined(self.playerSpawned))
            continue;
        self.playerSpawned = true;

        self scripts\mp\menu\_setupmenu::SetupMenu();
        self SetVariables();
        self FreezeControls(false);
    }
}

SetVariables() {
    self SetPersIfUni("test_slider", 5);
    SetDvarIfUni("test_dvar_slider", 5);
    self SetupBind("test_bind_slider", "OFF", ::TestBind);
}