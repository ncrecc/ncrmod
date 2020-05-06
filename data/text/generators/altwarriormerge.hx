usestandardenemies();

var items = [];
var gooditems = [];
var otherstuff = [];
var goodotherstuff = [];

var bassguitar = true;

//the following dice manip is all "normal" versions of the dice manip that can appear as warrior's skillcard.
var dicemanip = ["Keyhole", "Innovate", "Virtue Grip"]; //new manip, essentially chance 100
var chance75manip = ["Crucible", "Illuminate", "Cauldron", "Table Slam", "Spanner", "Gold Cauldron", "Silver Cauldron", "Gumball Machine", "Ungeradedice", "Giant Spatula"]; //specific dice manip that not many classes receive
var chance50manip = ["Doppeldice", "Hall of Mirrors", "Berlin Key"]; //common/simple dice manip that warrior doesn't get
var chance25manip = ["Bump", "Spatula", "Sine Wave"]; //already warrior dice manip

chance75manip = shuffle(chance75manip);
chance50manip = shuffle(chance50manip);
chance25manip = shuffle(chance25manip);

function chancepush(pushto,pushfrom,pushchance) {
	var pushfromlength = pushfrom.length;
	for(i in 0...pushfromlength) {
		if(pushchance) {
			pushto.push(pushfrom.pop());
		}
	}
}

chancepush(dicemanip,chance75manip,75);
chancepush(dicemanip,chance50manip,50);
chancepush(dicemanip,chance25manip,25);
while(dicemanip.length < 6) dicemanip.push(chance75manip.pop());
dicemanip = shuffle(dicemanip);

var warriorshops = ["Sharp Straw", "Broadsword", "Iron Shield", "Dagger", "Buckler", "Target Shield", "Nightstick", "Blight", "Snake Eye Charm", "Midnight Charm", rand(["Healing Crystal", "Thick Skin", "Elastic Heart"]), "Claw", "Snowball", "Boomerang", "Tazer", rand(["First Aid Kit", "Kite Shield"]), "Parrying Dagger", "Boxing Gloves", "Last Stand", "Singularity", "Half Moon Charm", "Dramatic Exit", "Hookshot", "Capacitor", rand(["Shiked Spield@sword", "Shiked Spield@shield"]), "Retreat", "Warhammer", "Swing Me Another 6", "Pocket Protector", "Big Knife", "Vanity Mirror", "Sleight of Hand", "Wail Bat", "Energy Ball", "Whipcrack", "Circuit Breaker"];
if(chance(10)) { warriorshops.pop(); warriorshops.push("Strange Apparatus"); }

warriorshops = shuffle(warriorshops);

var strangeshop = ["Lightning Rod", "Shriek", "Hammer", "Juggling Ball", "Toxic Ooze", "Candle", "Particle Accelerator", "Flying Skull", "Sledgehammer", "Slingshot", "Fishing Net", "Scissors", "Uberbump", rand(["Humility", "Charity"]),  "Bizarro Blade", "Doppeldfire", "Undermine", "Fuel Bat"];
strangeshop = shuffle(strangeshop);

//Floor 1:
items = [];
var awesomelist = ["Whip", "Toxic Ooze", "Claw", "Staff", "Hammer", "Shovel", "Battle Axe", "Trident", "Fishing Net", "Gemstone Staff", "Sledgehammer", "Nail Bat", "Quarterstaff", "Shiny Nunchucks", "Heavenly Nectar", "Snare Drum", "Sap Gloves", "Halligan Bar", "Smart Spike", "Sceptre"];
awesomelist = shuffle(awesomelist);
gooditems = [awesomelist.pop()];
otherstuff = [];
goodotherstuff = [];

addfloor("tiny")
  .additems(items, gooditems)
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();

//Floor 2:
items = [];
gooditems = [dicemanip.pop()];
otherstuff = [health()];
goodotherstuff = [shop([warriorshops.pop(), warriorshops.pop(), warriorshops.pop()])];

addfloor("small")
  .additems(items, gooditems)
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();

//Floor 3:
items = [];
var floor3items = [dicemanip.pop(), "Six Shooter", "Crystal Sword", "Chocolate Cookie", "Blight", "Detonator", "Scissors", "Battle Cry", "Sine Wave", "Last Stand", "Fireworks", dicemanip.pop(), "Rainmaking", "Kale Bat", "Bone Club", "Ice Nine", "Echochamber", "Plasma Rifle"];
if(bassguitar) floor3items.push("Bass Guitar");
floor3items = shuffle(floor3items);
items.push(floor3items.pop());
gooditems = [dicemanip.pop()];

otherstuff = [health(), health()];

goodotherstuff = [
  shop([warriorshops.pop(), warriorshops.pop(), warriorshops.pop()]),
  upgrade()
];

addfloor("normal")
  .additems(items, gooditems)
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();
  
//Floor 4:
items = [];
//awesomelist.push("Wrath");
awesomelist = shuffle(awesomelist);
gooditems = [awesomelist.pop()];

otherstuff = [health()];
goodotherstuff = [
  trade(["weapon", "shield"], [awesomelist.pop()])
];

addfloor("normal")
  .additems(items, gooditems)
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();
  
//Floor 5:
items = [];
var floor4items = ["Counter Spell", "Pea Shooter", "Chocolate Cookie", "Toxic Ooze", "Blight", "Detonator", "Disco Ball", "Parrying Dagger", "Sine Wave", "Fishing Net", "Last Stand", "Fireworks", "Biohazard", "Russian Roulette", "Wrongo", "Strychnine", "Red Hot Dagger"];
if(bassguitar && floor3items.indexOf("Bass Guitar") != -1) { floor4items.push("Bass Guitar"); }
items.push(pick(floor4items));
gooditems = [];

otherstuff = [health(), health()];
goodotherstuff = [
  upgrade(),
  shop(["upgrade", chance(98) ? strangeshop.pop() : "Katsuhiro Bat", "health"], [4, 4, 4])
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
  items.push(pick(["Steel Sword", "Wooden Stake"]));
}

lastfloor
  .additems(items, gooditems)
  .setlocation('BOSS')
  .addotherstuff(otherstuff, goodotherstuff)
  .generate(); 