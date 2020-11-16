var floor1countdowns = [];
var floor1sword = [];
var floor1crap = ["Uberbump", "Slim Jim", "Welder"];

var switchcyanide = ["Switchblade@even", "Magic Cyanide"];
shuffle(switchcyanide);

var commonlist1 = [switchcyanide.pop(), "Ice Nine", "Undermine"];
if(chance(20)) { commonlist1.remove("Ice Nine"); commonlist1.push("PyrotechnIX"); } //good pun

var shoplist1 = ["Technology", "Compact Resonator", "Virtue Grip", "No Pain No Gain", "Tragic Entrance", "Buzzsaw", "Smartwatch", "Wail Bat"];
var scrapitems = ["Scrap Slingshot", "Scrap Trap", "Scrapsies", "Scrap Lamp", "Scrap Crystal", "Scraptula", "Scrap Slam"];
var midtierdrops = ["Gadsby Gun", "Chainsmoke", "Keyhole", "Operator", "Shudder", "Veneer"];
var floor3items = ["Starspear"];


var commonlist2 = ["Healer Staff", "Gizmotron", "Gag Rule", "Sheer Will", "Tear Down This Wall", "Starspear", "Bumpbomb", "Heat Pump"];
if(chance(30)) commonlist2.push("Dripping Yellow Madness");

var floor5items = ["Hot Table", "Mirrorang"];
var vampireitem = ["Steel Sword"];

var myitempools = [floor1countdowns,floor1sword,floor1crap,commonlist1,shoplist1,scrapitems,midtierdrops,floor3items,commonlist2,floor5items,vampireitem];
return myitempools;