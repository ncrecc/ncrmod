usestandardenemies();

var items = [];
var gooditems = [];
var otherstuff = [];
var goodotherstuff = [];

//Floor 1:
items = [pick(["Big Knife", "Switchblade", "Technology", "Bone Club"]), rand(["Scrap Slingshot", "Scrap Trap", "Scrapstick", "Scrap Crystal", "Scraptula", "Scrap Lamp"])]; //would have included fk-47 but that is super broken right now
gooditems = [pick(["Gadsby Gun", "Spark", "Snowflake", "Buzzer", "Whisper", "Slime Ball", "Knitting Needle", "Mosquito Bite", "Spannersword"])];
if(chance(1)) { gooditems = ["AWESOMESWORD"]; }
otherstuff = [];
goodotherstuff = [];

addfloor("small")
  .additems(items, gooditems)
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();
  
//Floor 2:
var commonlist1 = ["Wrongo", "Table Flip", "Icebox", "Ice Nine", "Sacrificial Blade@3", "Berliner", "Berlin Massachusetts Key", "Slim Jim", "Cubby", "Presto", "Broadkunai"];
if(chance(30)) commonlist1.push("Dripping Yellow Madness");
var shoplist1 = ["Tragic Entrance", "Buzzsaw", "Swing Me Another 6", "Smartwatch", "Überbump", "Innovate", "Big Knife", "Bronze Dagger"];
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
  shop(shuffle(["upgrade", shoplist1.pop(), rand(["Scrap Slingshot", "Scrap Trap", "Scrapsies", "Scrapstick", "Scrap Lamp", "Scrap Crystal", "Scraptula"])]), shuffle([2, 3, 4]))
];

addfloor("small")
  .additems(items, gooditems)
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();

//Floor 3:
var midtierdrops = shuffle(["Chainsmoke", "Seize", "Vanity Mirror", "Keyhole", "Gas Lamp", "Operator", "Sucker Punch"]);
items = [rand(["Scrap Slingshot", "Scrap Trap", "Scrapsies", "Scrapstick", "Scrap Lamp", "Scrap Crystal", "Scraptula"])];
items.push(pick(["Kale Bat", "Starspear", "Two Handed Spike", "Tension", "Cookie Cake", "Biohazard", "Baby's First Counting Book"]));
gooditems = [midtierdrops.pop()];
		
var commonlist2 = ["Junk Sword", "Sickle", "Bumpbomb", "Heat Pump", "Whipcrack", "Gyrate Hook", "Virtue Grip", rand(["Scrap Slingshot", "Scrap Trap", "Scrapstick", "Scrap Crystal", "Scraptula", "Scrap Lamp"]), pick(["Hamment@I", "Hamment@S", "Whisp@W", "Whisp@F"]), pick(["Hunting Knife@small", "Hunting Knife@large"])];
if (chance(50)) commonlist2.push("Lava Quenching");
if (chance(50)) commonlist2.push(["Velocity", "Platinum Blade"]);
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
  
//Floor 4:

var zombobmoz = false;

if(chance(6.25)) { var zombobmoz = true; }

if(zombobmoz != true) {
	items = [pick(["Spark", "Snowflake", "Buzzer", "Whisper", "Knitting Needle", "Mosquito Bite", "Slime Ball"])];
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
  
//Floor 5:
items = [pick(["Freeze Frame", "Spectre Charm", "Tear Down This Wall", "Particle Accelerator", "Holy Water", "Mirrorang"])];
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
		
		