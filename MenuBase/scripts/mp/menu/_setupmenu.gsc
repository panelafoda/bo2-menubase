#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include scripts\mp\_utils;

SetupMenu() {
    self.menu = SpawnStruct();
    self.menu.isopen = false;
    self.menu.smoothscroll = false;
    self.menu.color = [];
    self.menu.color["backgorund"] = (0.1, 0.1, 0.1);
    self.menu.color["black"] = (0, 0, 0);
    self.menu.color["accent"] = (0.141, 0.141, 0.141);
    self.menu.color["white"] = (0.945, 0.945, 0.945);

    self thread scripts\mp\menu\_menulogic::MenuButtons();
    self CreateNotifys();
}

CreateNotifys() {
    foreach(value in StrTok("+actionslot 1,+actionslot 2,+actionslot 3,+actionslot 4,+frag,+smoke", ",")) {
        self NotifyOnPlayerCommand(value, value);
    }
}