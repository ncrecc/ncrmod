var bonetech = ["Bone Club", "Technology"];
shuffle(bonetech);
var floor1countdowns = [bonetech.pop()];
floor1countdowns = floor1countdowns.concat(floor1countdowns);
var switchcyanide = ["Switchblade@even", "Magic Cyanide"];
shuffle(switchcyanide);
var floor1spanner = [switchcyanide.pop()];
floor1spanner = floor1spanner.concat(floor1spanner);
var floor1crap = ["Uberbump", "Slim Jim", "Welder"];
if(chance(6.25)) { floor1crap = ["Zombo", "Zombo", "Zombo"]; }

var spearswing = pick(["Spearhead", "Swing Me Another 6"]);

var brgimmicks = ["Under Pressure", "Whipcrack", "Undermine", "Suspense"];
shuffle(brgimmicks);
var whips = ["Hamment@I", "Hamment@S", "Whisp@W", "Whisp@F"];
shuffle(whips);

function cleanwhips(x,y) {
	switch (x) {
		case "Hamment@I":
			y.remove("Hamment@S");
		case "Hamment@S":
			y.remove("Hamment@S");
		case "Whisp@W":
			y.remove("Whisp@F");
		case "Whisp@F":
			y.remove("Whisp@W");
	} trace("hi");
};

var gimmickorwhip = rand([0|1]);

var gimmickwhipgiven = false;

var commonlist1 = ["Industrial Press", "Defense Mechanism", "Rickety Shield", spearswing, "Sharp Straw", switchcyanide.pop(), "Icebox", "Ice Nine", "Sacrificial Blade@3", pick(["Berlin Massachusetts Key", "Table Flip"]), "Cubby", "Broadkunai"];
if(chance(20)) { commonlist1.remove("Ice Nine"); commonlist1.push("PyrotechnIX"); } //good pun
if(gimmickorwhip == 1) { commonlist1.push(whips.pop()); cleanwhips(commonlist1[commonlist1.length - 1], whips); }
else { commonlist1.push(brgimmicks.pop()); }

var shoplist1 = ["Compact Resonator", "Survivor's Guilt", "Radio Dial", "Autohook", "Virtue Grip", bonetech.pop(), "Lightstick", "No Pain No Gain", "Berliner", "Tragic Entrance", "Buzzsaw", "Smartwatch", "Bronze Dagger", "Wail Bat"];
if (chance(30)) shoplist1.push("Warhammer");
var scrapitems = ["Scrap Slingshot", "Scrap Trap", "Scrapsies", "Scrapstick", "Scrap Lamp", "Scrap Crystal", "Scraptula", "Scrap Slam"];
var midtierdrops = ["Gadsby Gun", "Technology", "Chainsmoke", "Keyhole", "Gas Lamp", "Operator", "Sucker Punch", "Hush", "Shudder", "Veneer"];
if(chance(33)) { midtierdrops.push(rand(["Charity", "Humility"])); }
if(chance(33)) { midtierdrops.push(rand(["Greed", "Envy"])); }
var floor3items = ["Kale Smoothie", "Starspear", "Biohazard"];

var includewhipgimmick = [];
if(gimmickwhipgiven == false) {
if(gimmickorwhip == 1) {
includewhipgimmick.push(whips.pop());
cleanwhips(includewhipgimmick[0],whips);
} else {
includewhipgimmick.push(brgimmicks.pop());
} }

var commonlist2 = ["Roman Candle@ncrmod", "Healer Staff", "Gizmotron", "Gag Rule", "Two Handed Spatula", "Cremator", "Sheer Will", "Queen of Diamonds", "Revolver@ncrmod", "Tear Down This Wall", "Vanity Mirror", "Starspear", "Innovate", "Gyrate Hook", "Junk Sword", "Bumpbomb", "Heat Pump"];
if(chance(30)) commonlist2.push("Dripping Yellow Madness");

if(includewhipgimmick.length > 0) { commonlist2.push(includewhipgimmick.pop()); }
commonlist2.push(pick(["Hunting Knife@small", "Hunting Knife@large"]));
if (chance(20)) commonlist2.push("Glassblowing");
if (chance(30)) { commonlist2.push("Velocity"); commonlist2.push("Platinum Blade"); }
if (chance(10)) { commonlist2.push("Cybernetics"); }

var floor4items = ["Pepper Spray", "Ancestral Staff", "Ego Stroke"];

var floor5items = [brgimmicks.pop(), "Hot Table", "Mirrorang", "Baby's First Counting Book"];
var vampireitem = ["Steel Sword"];

var myitempools = [floor1countdowns,floor1spanner,floor1crap,commonlist1,shoplist1,scrapitems,midtierdrops,floor3items,commonlist2,floor4items,floor5items,vampireitem];
return myitempools;