usestandardenemies();

var items = [];
var gooditems = [];
var otherstuff = [];
var goodotherstuff = [];

//Floor 1:
var switchbonetech = ["Switchblade", "Bone Club", "Technology"];
shuffle(switchbonetech);

var sbt1 = switchbonetech.pop();

items = [pick([sbt1, sbt1, sbt1, "Gemstone Staff", "Wrecking Ball", "Staff", "Crossbow"]), rand(["Scrap Nettle", "Scrap Bump", "Scrap Club", "Scrap Book", "Scrap Spear", "Scrap Kettle", "Scrap Metal", "Scrap Slingshot", "Scrap Trap", "Scrapsies", "Scrapstick", "Scrap Lamp", "Scrap Crystal", "Scraptula", "Scrap Slam"])];
gooditems = [pick(["Uberbump", "Slim Jim", "Welder", "Spark", "Snowflake", "Buzzer", "Whisper", "Knitting Needle", "Mosquito Bite", "Spannersword"])];
otherstuff = [];
goodotherstuff = [];

addfloor("small")
  .additems(items, gooditems)
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();
  
//Floor 2:
var spearswing = pick(["Spearhead", "Swing Me Another 6"]);

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

var shielddrops = shuffle(["Industrial Press", "Defense Mechanism", "Rickety Shield"]);  

var commonlist1 = ["Gizmotron", "Blacklight", "Leather Armor", "Bump", "Healing Crystal", "Lockpick", "Spike", "Keyblade", "Hi Vis Jacket", "Saw Wave", "Elastic Heart", "Berlin Key", "Double Edge", "Blast Chiller", "Tetraphobia", spearswing, "Sharp Straw", "Gadsby Gun", switchbonetech.pop(), "Icebox", "Ice Nine", "Sacrificial Blade@3", pick(["Berlin Massachusetts Key", "Table Flip"]), "Cubby", "Broadkunai"];
if(chance(20)) { commonlist1.remove("Ice Nine"); commonlist1.push("PyrotechnIX"); }
commonlist1.push(whips.pop()); cleanwhips(commonlist1[commonlist1.length - 1], whips);


var shoplist1 = ["Virtue Grip", switchbonetech.pop(), "Lightstick", "No Pain No Gain", "Berliner", "Tragic Entrance", "Buzzsaw", "Smartwatch", "Bronze Dagger", "Dagger", "Boomerang", "Crystal Sword", "Venus Fly Trap", "Keyblade", "Nunchucks", "Big Stick", "Rubber Mallet", "Change Machine", "Screwdriver", "Giant Spatula", pick(["Gold Dagger", "Silver Dagger"])];
if (chance(30)) shoplist1.push("Six Shooter");
if (chance(30)) shoplist1.push("Sledgehammer");
if (chance(30)) shoplist1.push("Warhammer");
commonlist1 = shuffle(commonlist1);
shoplist1 = shuffle(shoplist1);

items = [];
if(chance(20)) items.push(commonlist1.pop());
gooditems = [commonlist1.pop(), chance(12.5) ? shielddrops.pop() : commonlist1.pop()];

otherstuff = [
  health(), 
  health()
];
goodotherstuff = [
  shop(shuffle(["upgrade", shoplist1.pop(), chance(50) ? shoplist1.pop() : rand(["Scrap Metal", "Scrap Nettle", "Scrap Bump", "Scrap Club", "Scrap Book", "Scrap Spear", "Scrap Kettle"])]), shuffle([2, 3, 4]))
];

addfloor("small")
  .additems(items, gooditems)
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();

//Floor 3:
//if(commonlist1.indexOf("Hamment@I") == -1 && commonlist1.indexOf("Hamment@S") == -1 && commonlist1.indexOf("Whisp@F") == -1 && commonlist1.indexOf("Whisp@W") == -1) { gimmickwhipgiven = true; }

var midtierdrops = shuffle(["Technology", "Chainsmoke", "Keyhole", "Gas Lamp", "Operator", "Sucker Punch", "Befuddle", "Mosquito Bite", "Counterfeit", "Electromagnet", "Ray Gun"]);
items = [rand(["Scrap Slingshot", "Scrap Trap", "Scrapsies", "Scrapstick", "Scrap Lamp", "Scrap Crystal", "Scraptula", "Scrap Slam", "Scrap Nettle", "Scrap Bump", "Scrap Club", "Scrap Book", "Scrap Spear", "Scrap Kettle"])];
items.push(chance(12.5) ? shielddrops.pop() :  pick(["Kale Smoothie", "Starspear", "Biohazard", "Broadsword", "Bump", "Crystal Sword", "Hall of Mirrors", "Midnight Charm", "Calculator", "Spannersword", "Rubber Mallet", "Encyclopedia", "Broken Mirror", "Lucky Star"]));
if(chance(30)) items.push("Proton Pack");
gooditems = [midtierdrops.pop()];
		
var commonlist2 = ["Queen of Diamonds", "Sceptre", pick(["Hunting Knife@small", "Hunting Knife@large"]), "Revolver", "Tear Down This Wall", "Vanity Mirror", "Starspear", "Innovate", "Gyrate Hook", "Junk Sword", "Bumpbomb", "Heat Pump", "Shovel", "Boomerang", "Pea Shooter", "Spanner", "Healing Crystal", "Scissors", "Polar Star", "Capacitor", "Puppy Paws", rand(["Scrap Slingshot", "Scrap Trap", "Scrapsies", "Scrapstick", "Scrap Lamp", "Under Crystal", "Scraptula", "Scrap Slam", "Scrap Nettle", "Scrap Bump", "Scrap Club", "Scrap Book", "Scrap Spear", "Scrap Kettle", "Scrap Metal"]), "Elastic Heart"];

commonlist2.push(whips.pop());
if(chance(30)) commonlist2.push("Dripping Yellow Madness");
if (chance(20)) commonlist2.push("Lava Quenching");
if (chance(50)) { commonlist2.push("Velocity"); commonlist2.push("Platinum Blade"); }

shuffle(commonlist2);
		
otherstuff = [health()];
goodotherstuff = [
  shop(shuffle([shoplist1.pop(), shoplist1.pop(), commonlist1.pop()]), shuffle([1, 2, 3])),
  shop(shuffle([commonlist2.pop(), chance(12.5) ? shielddrops.pop() : commonlist1.pop(), "upgrade"]))
];
	
addfloor("big")
  .additems(items, gooditems)
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();
  
//Floor 4
var zombobmoz = false;

if(chance(1)) { zombobmoz = true; }

if(zombobmoz != true) {
	items = [pick([pick([commonlist2.pop(), commonlist2.pop(), "Third Place Cauldron"]), pick(["Spark", "Snowflake", "Buzzer", "Whisper", "Knitting Needle", "Mosquito Bite"])])];
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
items = [pick(["Hot Table", "Mirrorang", "Baby's First Counting Book", "Scorpion", "Lucky 7", "Rotten Egg@6", "Transformer@1", "Plasma Cannon", "Lightning Rod"]), rand(["Scrap Nettle", "Scrap Bump", "Scrap Club", "Scrap Book", "Scrap Spear", "Scrap Kettle", "Scrap Metal", "Scrap Slingshot", "Scrap Trap", "Scrapsies", "Scrapstick", "Scrap Lamp", "Scrap Crystal", "Scraptula", "Scrap Slam"])];
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
		
		