#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include scripts\mp\_utils;
#include scripts\mp\menu\_menuutils;
#include scripts\mp\menu\_structure;

Menubuttons() {
    while(true) {
        if(!self.menu.isopen) {
            if(self ActionSlotOneButtonPressed() && self AdsButtonPressed()) {
                self.menu.isopen = true;
                self LoadMenu("Menu Base");
            }
        }
        else {
            if(self ActionSlotOneButtonPressed()) {
                self.menu.scroll--;
                self UpdateScroll();
            }
            
            if(self ActionSlotTwoButtonPressed()) {
                self.menu.scroll++;
                self UpdateScroll();
            }

            if(self ActionSlotThreeButtonPressed() && self.menu.slidertype[self.menu.current][self.menu.scroll] == "slider") {
                pers = self.menu.pers[self.menu.current][self.menu.scroll];
                value = Float(self GetPers(pers));

                value -= self.menu.amount[self.menu.current][self.menu.scroll];
                if(value < self.menu.min[self.menu.current][self.menu.scroll])
                    value = self.menu.max[self.menu.current][self.menu.scroll];

                self SetPers(pers, value);

                self ExecuteFunction(self.menu.func[self.menu.current][self.menu.scroll], self GetPers(pers));
                self Structure();
                self LoadMenu(self.menu.current);
            }

            if(self ActionSlotFourButtonPressed() && self.menu.slidertype[self.menu.current][self.menu.scroll] == "slider") {
                pers = self.menu.pers[self.menu.current][self.menu.scroll];
                value = Float(self GetPers(pers));

                value += self.menu.amount[self.menu.current][self.menu.scroll];
                if(value > self.menu.max[self.menu.current][self.menu.scroll])
                    value = self.menu.min[self.menu.current][self.menu.scroll];

                self SetPers(pers, value);

                self ExecuteFunction(self.menu.func[self.menu.current][self.menu.scroll], self GetPers(pers));
                self Structure();
                self LoadMenu(self.menu.current);
            }

            if(self ActionSlotThreeButtonPressed() && self.menu.slidertype[self.menu.current][self.menu.scroll] == "dvar") {
                dvar = self.menu.dvar[self.menu.current][self.menu.scroll];
                value = GetDvarFloat(dvar);

                value -= self.menu.amount[self.menu.current][self.menu.scroll];
                if(value < self.menu.min[self.menu.current][self.menu.scroll])
                    value = self.menu.max[self.menu.current][self.menu.scroll];

                SetDvar(dvar, value);

                self ExecuteFunction(self.menu.func[self.menu.current][self.menu.scroll], GetDvarFloat(dvar));
                self Structure();
                self LoadMenu(self.menu.current); 
            }

            if(self ActionSlotFourButtonPressed() && self.menu.slidertype[self.menu.current][self.menu.scroll] == "dvar") {
                dvar = self.menu.dvar[self.menu.current][self.menu.scroll];
                value = GetDvarFloat(dvar);

                value += self.menu.amount[self.menu.current][self.menu.scroll];
                if(value > self.menu.max[self.menu.current][self.menu.scroll])
                    value = self.menu.min[self.menu.current][self.menu.scroll];

                SetDvar(dvar, value);

                self ExecuteFunction(self.menu.func[self.menu.current][self.menu.scroll], GetDvarFloat(dvar));
                self Structure();
                self LoadMenu(self.menu.current); 
            }

            if(self ActionSlotThreeButtonPressed() && self.menu.slidertype[self.menu.current][self.menu.scroll] == "array") {
                array = self.menu.array[self.menu.current][self.menu.scroll];
                arrayname = self.menu.arrayname[self.menu.current][self.menu.scroll];
                index = Int(self GetPers("arrayindex_" + arrayname));

                index--;
                if(index < 0)
                    index = array.size - 1;

                self SetPers("arrayindex_" + arrayname, index);

                self Structure();
                self LoadMenu(self.menu.current); 
            }

            if(self ActionSlotFourButtonPressed() && self.menu.slidertype[self.menu.current][self.menu.scroll] == "array") {
                array = self.menu.array[self.menu.current][self.menu.scroll];
                arrayname = self.menu.arrayname[self.menu.current][self.menu.scroll];
                index = Int(self GetPers("arrayindex_" + arrayname));

                index++;
                if(index >= array.size)
                    index = 0;

                self SetPers("arrayindex_" + arrayname, index);

                self Structure();
                self LoadMenu(self.menu.current); 
            }

            if(self ActionSlotThreeButtonPressed() && self.menu.slidertype[self.menu.current][self.menu.scroll] == "bind") {
                pers = self.menu.pers[self.menu.current][self.menu.scroll];
                self notify("stop" + pers);

                switch(self GetPers(pers)) {
                    case "OFF":
                        self SetPers(pers,"+smoke");
                        break;
                    case "+smoke":
                        self SetPers(pers,"+frag");
                        break;
                    case "+frag":
                        self SetPers(pers,"+actionslot 1");
                        break;
                    case "+actionslot 1":
                        self SetPers(pers,"+actionslot 2");
                        break;
                    case "+actionslot 2":
                        self SetPers(pers,"+actionslot 3");
                        break;
                    case "+actionslot 3":
                        self SetPers(pers,"+actionslot 4");
                        break;
                    case "+actionslot 4":
                        self SetPers(pers,"OFF");
                        break;
                }


                if(self GetPers(pers) != "OFF")
                    self ExecuteFunction(self.menu.func[self.menu.current][self.menu.scroll], self GetPers(pers), pers);
                self Structure();
                self LoadMenu(self.menu.current);
            }

            if(self ActionSlotFourButtonPressed() && self.menu.slidertype[self.menu.current][self.menu.scroll] == "bind") {
                pers = self.menu.pers[self.menu.current][self.menu.scroll];
                self notify("stop" + pers);

                switch(self GetPers(pers)) {
                    case "OFF":
                        self SetPers(pers,"+actionslot 1");
                        break;
                    case "+actionslot 1":
                        self SetPers(pers,"+actionslot 2");
                        break;
                    case "+actionslot 2":
                        self SetPers(pers,"+actionslot 3");
                        break;
                    case "+actionslot 3":
                        self SetPers(pers,"+actionslot 4");
                        break;
                    case "+actionslot 4":
                        self SetPers(pers,"+frag");
                        break;
                    case "+frag":
                        self SetPers(pers,"+smoke");
                        break;
                    case "+smoke":
                        self SetPers(pers,"OFF");
                        break;
                }


                if(self GetPers(pers) != "OFF")
                    self ExecuteFunction(self.menu.func[self.menu.current][self.menu.scroll], self GetPers(pers), pers);
                self Structure();
                self LoadMenu(self.menu.current);
            }

            if(self UseButtonPressed()) { 
                if(self.menu.slidertype[self.menu.current][self.menu.scroll] == "none") {
                    self ExecuteFunction(self.menu.func[self.menu.current][self.menu.scroll],self.menu.input[self.menu.current][self.menu.scroll],self.menu.input2[self.menu.current][self.menu.scroll]); 
                    self LoadMenu(self.menu.current);    
                }
                else if(self.menu.slidertype[self.menu.current][self.menu.scroll] == "array") {
                    arrayname = self.menu.arrayname[self.menu.current][self.menu.scroll];
                    self ExecuteFunction(self.menu.func[self.menu.current][self.menu.scroll],level.arrayscrolls[arrayname][Int(self GetPers("arrayindex_" + arrayname))]);
                    self LoadMenu(self.menu.current);    
                }
                wait 0.2;
            }

            if(self MeleeButtonPressed()) {
                if(self.menu.parent[self.menu.current] == "exit") {
                    self DestroyMenuHud();
                    self.menu.isopen = false;
                }
                else {
                    self LoadMenu(self.menu.parent[self.menu.current]);
                }
                wait 0.2;
            }
        }
        wait 0.05;
    }
}

UpdateScroll() {
    if(self.menu.smoothscroll)
        self.hud["scroll"] MoveOverTime(0.1);
    else
        self.hud["scroll"] MoveOverTime(0);

    if (self.menu.scroll < 0)
        self.menu.scroll = self.menu.text[self.menu.current].size - 1;

    if (self.menu.scroll > self.menu.text[self.menu.current].size - 1)
        self.menu.scroll = 0;

    if (!isdefined(self.menu.text[self.menu.current][self.menu.scroll - 4]) || self.menu.text[self.menu.current].size <= 8) {
        for (i = 0; i < 8; i++) {
            if (isdefined(self.menu.text[self.menu.current][i] ))
                self.hud["text"][i] SetSafeText(self.menu.text[self.menu.current][i]);
            else
                self.hud["text"][i] SetSafeText("");

            self.hud["bool_text"][i] SetSafeText(self.menu.bool[self.menu.current][i]);
        }



        self.hud["scroll"].y = -63 + (16 * self.menu.scroll);
    }
    else if (isdefined(self.menu.text[self.menu.current][self.menu.scroll + 4])) {
        index = 0;

        for (i = self.menu.scroll - 4; i < self.menu.scroll + 4; i++) {
            if (isdefined(self.menu.text[self.menu.current][i]))
                self.hud["text"][index] SetSafeText(self.menu.text[self.menu.current][i]);
            else
                self.hud["text"][index] SetSafeText("");

            self.hud["bool_text"][index] SetSafeText(self.menu.bool[self.menu.current][i]);

            index++;
        }


        self.hud["scroll"].y = -63 + (16 * 4);
    }
    else {
        for (i = 0; i < 8; i++) {
            self.hud["text"][i] SetSafeText(self.menu.text[self.menu.current][self.menu.text[self.menu.current].size + i - 8]);
            self.hud["bool_text"][i] SetSafeText(self.menu.bool[self.menu.current][self.menu.bool[self.menu.current].size + i - 8]);
        }

        self.hud["scroll"].y = -63 + (16 * (self.menu.scroll - self.menu.text[self.menu.current].size + 8));
    }

    self.hud["title"] SetSafeText(self.menu.current + " - [" + (self.menu.scroll + 1) + "/" + self.menu.text[self.menu.current].size + "]");
}