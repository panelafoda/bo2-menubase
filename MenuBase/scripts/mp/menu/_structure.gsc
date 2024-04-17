#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include scripts\mp\_utils;
#include scripts\mp\menu\_menuutils;
#include scripts\mp\_functions;

Structure() {
    self CreateMenu("Menu Base", "exit");
    self AddOption("Menu Base", "Placeholder 1");
    self AddOption("Menu Base", "Placeholder 2");
    self AddOption("Menu Base", "Placeholder 3");
    self AddOption("Menu Base", "Sliders", ::LoadMenu, undefined, "Sliders");

    self CreateMenu("Sliders", "Menu Base");
    self AddSlider("Sliders", "Slider", undefined, "test_slider", 0, 10, 1);
    self AddDvarSlider("Sliders", "Dvar Slider", undefined, "test_dvar_slider", 0, 10, 1);
    self AddArraySlider("Sliders", "Array Slider", ::TestArraySlider, StrTok("Option 1,Option 2,Option 3,Option 4,Option 5", ","), "test_array_slider");
    self AddBindSliders("Sliders", "Bind Slider", ::TestBind, "test_bind_slider");
}