#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include scripts\mp\_utils;

IsInMenu() {
    return self.menu.isopen;
}

CreateMenu(menu, parent) {
    self.menu.text[menu] = [];
    self.menu.bool[menu] = [];
    self.menu.parent[menu] = parent;
}

AddOption(menu, text, func, bool, input, input2) {
    index = self.menu.text[menu].size;
    if(isdefined(func))
        self.menu.func[menu][index] = func;
    else
        self.menu.func[menu][index] = ::PlaceHolder;
    if(isdefined(bool))
        self.menu.bool[menu][index] = bool;
    else
        self.menu.bool[menu][index] = "";
    if(isdefined(func) && func == ::LoadMenu)
        self.menu.bool[menu][index] = ">";
    self.menu.text[menu][index] = text;
    self.menu.input[menu][index] = input;
    self.menu.input2[menu][index] = input2;
    self.menu.slidertype[menu][index] = "none";
}

AddSlider(menu, text, func, pers, min, max, amount) {
    index = self.menu.text[menu].size;
    if(isdefined(func))
        self.menu.func[menu][index] = func;
    else
        self.menu.func[menu][index] = ::Placeholder;
    self.menu.text[menu][index] = text;
    self.menu.bool[menu][index] = "<" + self GetPers(pers) + ">";
    self.menu.pers[menu][index] = pers;
    self.menu.min[menu][index] = min;
    self.menu.max[menu][index] = max;
    self.menu.amount[menu][index] = amount;
    self.menu.slidertype[menu][index] = "slider";
}

AddDvarSlider(menu, text, func, dvar, min, max, amount) {
    index = self.menu.text[menu].size;
    self.menu.bool[menu][index] = "<" + GetDvarFloat(dvar) + ">";
    if(isdefined(func))
        self.menu.func[menu][index] = func;
    else
        self.menu.func[menu][index] = ::Placeholder;
    self.menu.text[menu][index] = text;
    self.menu.dvar[menu][index] = dvar;
    self.menu.min[menu][index] = min;
    self.menu.max[menu][index] = max;
    self.menu.amount[menu][index] = amount;
    self.menu.slidertype[menu][index] = "dvar";
}

AddArraySlider(menu, text, func, array, arrayname) {
    index = self.menu.text[menu].size;
    if(!isdefined(level.arrayscrolls))
        level.arrayscrolls = [];
    level.arrayscrolls[arrayname] = array;
    self.menu.array[menu][index] = array;
    self.menu.arrayname[menu][index] = arrayname;
    if(!isdefined(self GetPers("arrayindex_" + arrayname)))
        self SetPers("arrayindex_" + arrayname, 0);
    self.menu.bool[menu][index] = "<" + level.arrayscrolls[arrayname][Int(self GetPers("arrayindex_" + arrayname))] + " [" + (Int(self GetPers("arrayindex_" + arrayname)) + 1) + "/" + level.arrayscrolls[arrayname].size + "]>";
    if(isdefined(func))
        self.menu.func[menu][index] = func;
    else
        self.menu.func[menu][index] = ::Placeholder;
    self.menu.text[menu][index] = text;
    self.menu.slidertype[menu][index] = "array";
}

AddBindSliders(menu, text, func, pers) {
    index = self.menu.text[menu].size;
    if(isdefined(func))
        self.menu.func[menu][index] = func;
    else
        self.menu.func[menu][index] = ::Placeholder;
    self.menu.text[menu][index] = text;
    if(self GetPers(pers) != "OFF")
        self.menu.bool[menu][index] = "<[{" + self GetPers(pers) + "}]>";
    else
        self.menu.bool[menu][index] = "<" + self GetPers(pers) + ">";
    self.menu.pers[menu][index] = pers;
    self.menu.slidertype[menu][index] = "bind";
}

LoadMenu(menu) {
    self scripts\mp\menu\_structure::Structure();
    self.menu.smoothscroll = false;
    self.menu.lastscroll[self.menu.current] = self.menu.scroll;
    if(self IsInMenu())
        self DestroyMenuHud();
    self.menu.current = menu;
    if(!isdefined(self.menu.lastscroll[self.menu.current]))
        self.menu.scroll = 0;
    else
        self.menu.scroll = self.menu.lastscroll[self.menu.current];
    self CreateMenuHud();
    self scripts\mp\menu\_menulogic::UpdateScroll();
    self UpdateMenuBackground();
    self.menu.smoothscroll = true;
}

ExecuteFunction(f, i1, i2) { 
    if(isdefined( i2 ))
        return self thread [[ f ]]( i1, i2 );
    else if(isdefined( i1 ))
        return self thread [[ f ]]( i1 );

    return self thread [[ f ]]();
}

DestroyMenuHud() {
    foreach(key, element in self.hud) {
        if(key != "text" && key != "bool_text") {
            element Destroy();
        }
        else {
            foreach(text_element in self.hud[key]) {
                text_element Destroy();
            }
        }
    }
}

CreateMenuHud() {
    self.hud = [];
    self.hud["background"] = self CreateRectangle("white", "TOP", "CENTER", 150, -100, 180, 200, self.menu.color["backgorund"], 0, 1);
    self.hud["header_box"] = self CreateRectangle("white", "TOP", "CENTER", 150, -100, 180, 30, self.menu.color["accent"], 1, 1);
    self.hud["top_bar"] = self CreateRectangle("white", "TOP", "CENTER", 150, -100, 180, 1, self.menu.color["black"], 2, 1);
    self.hud["middle_bar"] = self CreateRectangle("white", "TOP", "CENTER", 150, -70, 180, 1, self.menu.color["black"], 2, 1);
    self.hud["left_bar"] = self CreateRectangle("white", "TOP", "CENTER", 60, -100, 1, 200, self.menu.color["black"], 2, 1);
    self.hud["right_bar"] = self CreateRectangle("white", "TOP", "CENTER", 240, -100, 1, 200, self.menu.color["black"], 2, 1);
    self.hud["bottom_bar"] = self CreateRectangle("white", "TOP", "CENTER", 150, 100, 181, 1, self.menu.color["black"], 2, 1);

    self.hud["title"] = self CreateText("objective", 1.1, "CENTER", "CENTER", 150, -88, self.menu.color["white"], 4, 1, "Menu Base - [1/10]");

    self.hud["scroll"] = self CreateRectangle("white", "CENTER", "CENTER", 150, -61, 179, 16, self.menu.color["accent"], 4, 1);

    self.hud["text"] = [];
    self.hud["bool_text"] = [];

    for (i = 0; i < 8; i++) {
        self.hud["text"][i] = self CreateText("default", 1, "LEFT", "CENTER", 63, -64 + (i * 16), self.menu.color["white"], 6, 1, "Option " + (i + 1));

        self.hud["bool_text"][i] = self CreateText("default", 1, "RIGHT", "CENTER", 232, -64 + (i * 16), self.menu.color["white"], 6, 1, "[OFF]");
    }
}

UpdateMenuBackground() {
    amount = self.menu.text[self.menu.current].size;
    if(amount > 8) {
        amount = 8;
    }
    
    self.hud["background"] SetShader("white", 180, 31 + (16 * amount));
    self.hud["left_bar"] SetShader("white", 1, 31 + (16 * amount));
    self.hud["right_bar"] SetShader("white", 1, 31 + (16 * amount));
    self.hud["bottom_bar"].y = -71 + (16 * amount);
}