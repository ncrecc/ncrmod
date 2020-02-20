usestandardenemies();

function isenemyindungeon(enemyname){
  var enemylist = getenemylistindungeon();
  if(enemylist.indexOf(enemyname) == -1) return false;
  return true;
}

var items = [];
var gooditems = [];
var otherstuff = [];
var goodotherstuff = [];

trace("starting....");

//Floor 1:
var switchbonetech = ["Switchblade", "Bone Club", "Technology"];
shuffle(switchbonetech);
var scraplist = ["Scrap Slingshot", "Scrap Trap", "Scrapsies", "Scrapstick", "Scrap Lamp", "Scrap Crystal", "Scraptula", "Scrap Slam"];
shuffle(scraplist);

items = [switchbonetech.pop(), rand(["Scrap Slingshot", "Scrap Crystal", "Scrap Lamp", "Scrap Trap"])];
scraplist.remove(items[1]);
gooditems = [pick(["Clump", "Slim Jim", "Welder"])];
otherstuff = [];
goodotherstuff = [];

addfloor("small")
  .additems(items, gooditems)
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();
  
trace("floor 1 done");

//Floor 2:
var spearswing = pick(["Spearhead", "Swing Me Another 6"]);

var brgimmicks = ["Under Pressure", "Whipcrack", "Undermine"];
shuffle(brgimmicks);

var commonlist1 = [spearswing, "Sharp Straw", "Gadsby Gun", switchbonetech.pop(), "Icebox", "Ice Nine", "Sacrificial Blade@3", "Berlin Massachusetts Key", "Cubby", "Broadkunai", brgimmicks.pop()];
if(chance(30)) commonlist1.push("Dripping Yellow Madness");
var shoplist1 = ["Virtue Grip", "Kale Smoothie", switchbonetech.pop(), "Shiny Nunchucks", "No Pain No Gain", "Berliner", "Tragic Entrance", "Buzzsaw", "Smartwatch", "Bronze Dagger"];
if (chance(30)) shoplist1.push("Warhammer");
commonlist1 = shuffle(commonlist1);
shoplist1 = shuffle(shoplist1);

items = [];
gooditems = [commonlist1.pop(), commonlist1.pop()];

otherstuff = [
  health(), 
  health()
];
goodotherstuff = [
  shop(shuffle(["upgrade", shoplist1.pop(), shoplist1.pop()]), shuffle([2, 3, 4]))
];

addfloor("small")
  .additems(items, gooditems)
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();

trace("floor 2 done");

var autohookorhuntingknife = rand([0|1]);
var whips = ["Hamment@I", "Hamment@S", "Whisp@W", "Whisp@F"];
shuffle(whips);

//Floor 3:

function cleanwhips(x) {
	switch (x) {
		case "Hamment@I":
			whips.remove("Hamment@S");
		case "Hamment@S":
			whips.remove("Hamment@S");
		case "Whisp@W":
			whips.remove("Whisp@F");
		case "Whisp@F":
			whips.remove("Whisp@W");
	}
}

var midtierdrops = shuffle(["Revolver", "Starspear", "Chainsmoke", "Vanity Mirror", "Gas Lamp", "Operator", "Sucker Punch"]);
var shielddrops = shuffle(["Industrial Press", "Back Shield", "Rickety Shield"]);  
if(chance(20)) { midtierdrops.push("Flicker"); }
items = [rand(["Scrap Trap", "Scrapsies", "Scrapstick", "Scrap Slam"])];
items.push(pick(["Kale Bat", "Tension", "Cookie Cake", "Biohazard"]));
gooditems = [midtierdrops.pop()];
		
var includewhip = [];
includewhip.push(whips.pop());
cleanwhips(includewhip[0]);
		
var commonlist2 = ["Uberbump", "Innovate", "Lightstick", "Spite", "Gyrate Hook", "Wrongo", "Junk Sword", "Bumpbomb", "Heat Pump", scraplist.pop()];

if(includewhip.length > 0) { commonlist2.push(includewhip.pop()); }
if(autohookorhuntingknife == 1) { commonlist2.push(pick(["Hunting Knife@small", "Hunting Knife@large"])); }
else { commonlist2.push("Autohook");
if (chance(20)) commonlist2.push("Lava Quenching");
if (chance(50)) { commonlist2.push("Velocity"); commonlist2.push("Platinum Blade"); }
shuffle(commonlist2);
	
var chancewhip = [];
if(chance(20)) {
	chancewhip.push(whips.pop());
	cleanwhips(chancewhip[0]);
}
	
otherstuff = [health()];
goodotherstuff = [
  shop(shuffle([chancewhip.length > 0 ? chancewhip.pop() : shoplist1.pop(), shoplist1.pop(), commonlist1.pop()]), shuffle([1, 2, 3])),
  shop(shuffle([commonlist2.pop(), commonlist2.pop(), "upgrade"]))
];
	
addfloor("big")
  .additems(items, gooditems)
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();
  
trace("floor 3 done");
  
//Floor 4:

var zombobmoz = false;

if(chance(6.25)) { var zombobmoz = true; }

if(zombobmoz != true) {
	items = [pick(["Keyhole", "Seize", "Cybernetics"])];
}
else {
	items = [pick(["Zombocom", "Obmozcom"])];
}

gooditems = [midtierdrops.pop()];

otherstuff = [health(), health()];
goodotherstuff = [];
		
addfloor("normal")
  .additems(items, gooditems)
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();
  
  
trace("floor 4 done");
  
//Floor 5:
items = [pick([brgimmicks.pop(), "Hot Table", "Tear Down This Wall", "Holy Water", "Mirrorang"]), scraplist.pop()];
gooditems = [midtierdrops.pop()];
		
otherstuff = [health(), health()];
goodotherstuff = [
  shop(shuffle([commonlist2.pop(), "health", commonlist2.pop()])),
  upgrade()
];
		
addfloor("big")
  .additems(items, gooditems)
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();
  
  
trace("floor 5 done");

//Floor 6:
items = [];
gooditems = [];
otherstuff = [];
goodotherstuff = [];

var lastfloor = addfloor("boss");

if (getfinalboss() == "Drake"){
  items.push(["Steel Sword"]);
}

lastfloor
  .additems(items, gooditems)
  .setlocation('BOSS')
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();
		
trace("last floor done");