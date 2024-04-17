#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;

PlaceHolder() {
    
}

SetPers(key, value) {
    self.pers[key] = value;
}

GetPers(key) {
    return self.pers[key];
}

SetPersIfUni(key, value) {
    if(!isdefined(self.pers[key])) {
        self.pers[key] = value;
    }
}

SetDvarIfUni(dvar, value) {
    if(!isdefined(GetDvar(dvar)) || GetDvar(dvar) == "") {
        SetDvar(dvar, value);
    }
}

SetupBind(pers, value, func) {
    self SetPersIfUni(pers, value);

    if(self GetPers(pers) != "OFF") {
        self thread [[func]](self GetPers(pers), pers);
    }
}

OverflowFixInit() {
    level.strings = [];
    level.overflowElem = CreateServerFontString("default", 1.5);
    level.overflowElem setSafeText("");
    level.overflowElem.alpha = 0;
    level thread OverflowFixMonitor();
}

OverflowFixMonitor() {
    while(true) {
        level waittill("string_added");
        if(level.strings.size >= 145) {
            level.overflowElem ClearAllTextAfterHudElem();
            level.strings = [];
            level notify("overflow_fixed");
        }
    }
}

setSafeText(text) {
    self.string = text;
    self SetText(text);
    self thread FixString();
    self AddString(text);
}

AddString(string) {
    level.strings[level.strings.size] = string;
    level notify("string_added");
}

FixString() {
    self notify("new_string");
    self endon("new_string");
    while(isdefined(self)) {
        level waittill("overflow_fixed");
        self SetSafeText(self.string);
    }
}

CreateText(font, fontscale, align, relative, x, y, color, sort, alpha, text) {
    textElem = CreateFontString(font, fontscale);
    textElem SetPoint(align, relative, x, y);
    textElem.sort = sort;
    textElem.type = "text";
    textElem SetSafeText(text);
    textElem.color = color;
    textElem.alpha = alpha;
    textElem.hideWhenInMenu = true;
    textElem.foreground = true;
    textElem.archived = true;
    return textElem;
}

CreateRectangle(shader, align, relative, x, y, width, height, color, sort, alpha) {
    barElem = NewClientHudElem(self);
    barElem.elemType = "icon";
    if ( !level.splitScreen )
    {
        barElem.x = -2;
        barElem.y = -2;
    }
    barElem.width = width;
    barElem.height = height;
    barElem.align = align;
    barElem.relative = relative;
    barElem.xOffset = 0;
    barElem.yOffset = 0;
    barElem.children = [];
    barElem.color = color;
    if(isdefined(alpha))
        barElem.alpha = alpha;
    else
        barElem.alpha = 1;
    barElem SetShader(shader, width , height);
    barElem.hidden = false;
    barElem.sort = sort;
    barElem SetPoint(align,relative,x,y);
    barElem.foreground = true;
    barElem.archived = false;
    return barElem;
}