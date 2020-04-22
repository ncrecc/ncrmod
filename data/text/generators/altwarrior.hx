usestandardenemies();

var items = [];
var gooditems = [];
var otherstuff = [];
var goodotherstuff = [];

var bassguitar = false;
if(chance(20)) bassguitar = true;

//the following dice manip is all "normal" versions of the dice manip that can appear as warrior's skillcard.
var dicemanip = ["Keyhole", "Innovate", "Virtue Grip"]; //new manip, essentially chance 100
var chance75manip = ["Crucible", "Illuminate", "Cauldron", "Table Slam", "Spanner", "Gold Cauldron", "Silver Cauldron", "Gumball Machine", "Ungeradedice", "Giant Spatula"]; //specific dice manip that not many classes receive
var chance50manip = ["Doppeldice", "Hall of Mirrors", "Berlin Key"]; //common dice manip that warrior doesn't get
var chance25manip = ["Bump", "Spatula", "Sine Wave"]; //already warrior dice manip

function chancepush(pushto,pushfrom,pushchance) {
	for(item in pushfrom) {
		if(pushchance) {
			pushto.push(item);
		}
	}
}

chancepush(dicemanip,chance75manip,75);
chancepush(dicemanip,chance50manip,50);
chancepush(dicemanip,chance25manip,25);
dicemanip = shuffle(dicemanip);

var warriorshops = [rand(["Shiked Spield@sword", "Shiked Spield@shield"]), "Retreat", "Warhammer", "Swing Me Another 6", "Pocket Protector", "Cubby", "Swing Me Another 6", "Big Knife", "Vanity Mirror", "Sleight of Hand"];
if(!bassguitar) warriorshops.push("Electric Guitar");

warriorshops = shuffle(warriorshops);

var strangeshop = ["Uberbump", "Humility", "Bizarro Blade", "Doppeldfire", "Undermine"];
strangeshop = shuffle(strangeshop);

//Floor 1:
items = [];
var awesomelist = ["Shiny Nunchucks", "Heavenly Nectar", "Snare Drum", "Sap Gloves", "Halligan Bar"];
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
var floor3items = [dicemanip.pop(), "Rainmaking", "Kale Bat", "Bone Club", "Ice Nine"];
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
var floor4items = ["Biohazard", "Russian Roulette", "Wrongo", "Strychnine", "Red Hot Dagger"];
if(bassguitar && floor3items.indexOf("Bass Guitar") != -1) { floor4items.push("Bass Guitar"); }
items.push(pick(floor4items));
gooditems = [];

otherstuff = [health(), health()];
goodotherstuff = [
  upgrade(),
  shop(["upgrade", strangeshop.pop(), "health"], [4, 4, 4])
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
  items.push("Steel Sword");
}

lastfloor
  .additems(items, gooditems)
  .setlocation('BOSS')
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();