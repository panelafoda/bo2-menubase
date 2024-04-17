#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include scripts\mp\_utils;
#include scripts\mp\menu\_menuutils;

TestArraySlider(value) {
    self IPrintLnBold("You Selected: " + value);
}

TestBind(bind, endonstring) {
    self endon("stop" + endonstring);

    while(true) {
        self waittill(bind);

        if(!self IsInMenu()) {
            self IPrintLnBold("Hello World");
        }
    }
}