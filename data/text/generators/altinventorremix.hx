usestandardenemies();

var items = [];
var gooditems = [];
var otherstuff = [];
var goodotherstuff = [];

trace("starting....");

//Floor 1:
var switchbonetech = ["Switchblade", "Bone Club", "Technology"];
shuffle(switchbonetech);
var sbt1 = switchbonetech.pop();
var sbt2 = switchbonetech.pop();
var sbt3 = switchbonetech.pop();

items = [sbt1, rand(["Scrap Slingshot", "Scrap Crystal", "Scraptula", "Scrap Lamp"])];
gooditems = [pick(["Gadsby Gun", "Slime Ball", "Spearhead"])];
if(chance(1)) { gooditems = ["AWESOMESWORD"]; }
otherstuff = [];
goodotherstuff = [];

addfloor("small")
  .additems(items, gooditems)
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();
  
trace("floor 1 done");

//Floor 2:
var commonlist1 = ["Gyrate Hook", sbt2, "Table Flip", "Icebox", "Ice Nine", "Sacrificial Blade@3", "Berlin Massachusetts Key", "Slim Jim", "Cubby", "Broadkunai"];
if(chance(30)) commonlist1.push("Dripping Yellow Madness");
var shoplist1 = ["Shiny Nunchucks", "No Pain No Gain", "Lightstick", "Berliner", "Tragic Entrance", "Buzzsaw", "Swing Me Another 6", "Smartwatch", "Uberbump", "Innovate", "Big Knife", "Bronze Dagger"];
if (chance(30)) shoplist1.push("Warhammer");
//shoplist1 = shoplist1.concat(shoplist1);
shoplist1.push("Rickety Shield");
shoplist1.push("Back Shield"); //hack to make all items twice as likely as rickety and back shield, so rickety and back shield have the combined weight of one item //hack to disable this hack because nah. shield is rare enough as is, so making the shield items even rarer just further messes up the potential industrial press-other shield item synergy
commonlist1 = shuffle(commonlist1);
shoplist1 = shuffle(shoplist1);

items = [];
gooditems = [commonlist1.pop(), commonlist1.pop()];

otherstuff = [
  health(), 
  health()
];
goodotherstuff = [
  shop(shuffle(["upgrade", shoplist1.pop(), rand(["Scrap Slingshot", "Scrap Trap", "Scrapsies", "Scrapstick", "Scrap Lamp", "Scrap Crystal", "Scraptula"])]), shuffle([2, 3, 4]))
];

addfloor("small")
  .additems(items, gooditems)
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();

trace("floor 2 done");

//Floor 3:
var midtierdrops = shuffle(["Sharp Straw", "Chainsmoke", "Vanity Mirror", "Gas Lamp", "Operator", "Sucker Punch"]);
if(chance(20)) { midtierdrops.push("Flicker"); }
items = [rand(["Scrap Slingshot", "Scrap Trap", "Scrapsies", "Scrapstick", "Scrap Lamp", "Scrap Crystal", "Scraptula"])];
items.push(pick(["Kale Bat", "Starspear", "Two Handed Spike", "Tension", "Cookie Cake", "Biohazard", "Baby's First Counting Book"]));
gooditems = [midtierdrops.pop()];
		
var commonlist2 = ["Autohook", sbt3, "Wrongo", "Industrial Press", "Junk Sword", "Bumpbomb", "Heat Pump", "Virtue Grip", rand(["Scrap Slingshot", "Scrap Trap", "Scrapstick", "Scrap Crystal", "Scraptula", "Scrap Lamp"]), pick(["Hamment@I", "Hamment@S", "Whisp@W", "Whisp@F"]), pick(["Hunting Knife@small", "Hunting Knife@large"])];
if (chance(50)) commonlist2.push("Lava Quenching");
if (chance(50)) { commonlist2.push("Velocity"); commonlist2.push("Platinum Blade"); }
shuffle(commonlist2);
	
otherstuff = [health()];
goodotherstuff = [
  shop(shuffle([shoplist1.pop(), shoplist1.pop(), commonlist1.pop()]), shuffle([1, 2, 3])),
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
items = [pick(["Freeze Frame", "Tear Down This Wall", "Particle Accelerator", "Holy Water", "Mirrorang"])];
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