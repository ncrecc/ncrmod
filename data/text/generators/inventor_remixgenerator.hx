usestandardenemies();

var items = [];
var gooditems = [];
var otherstuff = [];
var goodotherstuff = [];

//Floor 1:
items = [pick(["Big Knife", "Welder", "Revolver", "Bone Club", "Gemstone Staff", "Wrecking Ball", "Staff", "Crossbow"]), rand(["Scrap Nettle", "Scrap Bump", "Scrap Club", "Scrap Book", "Scrap Spear" "Scrap Kettle", "Scrap Metal", "Scrap Slingshot", "Scrap Trap", "Scrapstick", "Scrap Crystal", "Scraptula", "Scrap Lamp"])]; //would have included fk-47 but that is super broken right now
gooditems = [pick(["Gadsby Gun", "Spark", "Snowflake", "Buzzer", "Whisper", "Slime Ball", "Knitting Needle", "Mosquito Bite", "Spannersword"])];
if(chance(1)) { gooditems = ["AWESOMESWORD"]; }
otherstuff = [];
goodotherstuff = [];

addfloor("small")
  .additems(items, gooditems)
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();
  
//Floor 2:
var commonlist1 = ["Table Flip", "Icebox", "Ice Nine", "Sacrificial Blade@3", "Switchblade", "Berliner", "Berlin Massachusetts Key", "Slim Jim", "Cubby", "Presto", "Leather Armor", "Bump", "Healing Crystal", "Lockpick", "Spike", "Broadkunai", "Keyblade", "Hi Vis Jacket", "Saw Wave", "Elastic Heart", "Berlin Key", "Double Edge", "Blast Chiller", "Tetraphobia"];
var shoplist1 = ["Swing Me Another 6", "Smartwatch", "Vanity Mirror", "Uberbump", "Innovate", "Big Knife", "Dagger", "Boomerang", "Crystal Sword", "Venus Fly Trap", "Keyblade", "Nunchucks", "Big Stick", "Rubber Mallet", "Change Machine", "Screwdriver", "Giant Spatula", "Bronze Dagger", pick(["Gold Dagger", "Silver Dagger"])];
if (chance(30)) shoplist1.push("Six Shooter");
if (chance(30)) shoplist1.push("Sledgehammer");
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
  shop(shuffle(["upgrade", shoplist1.pop(), rand(["Scrap Metal", "Scrap Nettle", "Scrap Bump", "Scrap Club", "Scrap Book", "Scrap Spear", "Scrap Kettle", "Scrap Slingshot", "Scrap Trap", "Scrapstick", "Scrap Crystal", "Scraptula", "Scrap Lamp"])]), shuffle([2, 3, 4]))
];

addfloor("small")
  .additems(items, gooditems)
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();

//Floor 3:
var midtierdrops = shuffle(["Keyhole", "Gas Lamp", "Operator", "Sucker Punch", "Befuddle", "Mosquito Bite", "Counterfeit", "Electromagnet", "Ray Gun"]);
items = [rand(["Scrap Nettle", "Scrap Bump", "Scrap Club", "Scrap Book", "Scrap Spear", "Scrap Kettle", "Scrap Slingshot", "Scrap Trap", "Scrapstick", "Scrap Crystal", "Scraptula", "Scrap Lamp"])];
items.push(pick(["Kale Bat", "Starspear", "Two Handed Spike", "Rifle", "Tension", "Cookie Cake", "Biohazard", "Broadsword", "Baby's First Counting Book", "Bump", "Crystal Sword", "Chocolate Cookie", "Hall of Mirrors", "Midnight Charm", "Calculator", "Spannersword", "Rubber Mallet", "Encyclopedia", "Broken Mirror", "Lucky Star"]));
gooditems = [midtierdrops.pop()];
		
var commonlist2 = ["Sickle", "Bumpbomb", "Platinum Blade", "Going Really Fast", "Heat Pump", "Whipcrack", "Gyrate Hook", "Shovel", "Boomerang", "Pea Shooter", "Spanner", "Virtue Grip", "Healing Crystal", "Scissors", "Polar Star", "Capacitor", "Puppy Paws", rand(["Scrap Nettle", "Scrap Bump", "Scrap Club", "Scrap Book", "Scrap Spear" "Scrap Kettle", "Scrap Metal", "Scrap Slingshot", "Scrap Trap", "Scrapstick", "Scrap Crystal", "Scraptula", "Scrap Lamp"]), "Elastic Heart", pick(["Hamment@I", "Hamment@S", "Whisp@W", "Whisp@F"]), pick(["Hunting Knife@small", "Hunting Knife@large"])];
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
items = [pick(["Freeze Frame", "Tear Down This Wall", "Particle Accelerator", "Holy Water", "Mirrorang", "Scorpion", "Lucky 7", "Rotten Egg@6", "Transformer@1", "Plasma Cannon", "Hookshot", "Lightning Rod"])];
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
  items.push(pick(["Wooden Stake", "Steel Sword"]));
}

lastfloor
  .additems(items, gooditems)
  .setlocation('BOSS')
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();
		
		