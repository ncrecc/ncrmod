usestandardenemies();

var items = [];
var gooditems = [];
var otherstuff = [];
var goodotherstuff = [];

//Floor 1:
var commonlist_basic = shuffle(["Healing Crystal", "Buckler", "Spare 4", "Plasma Cannon", "Sharp Spike"]);
var commonlist_advanced = shuffle(["Juggling Ball", "Pea Shooter", "Spiked Shield", "Doppeldice", "Short Circuit"]);

items = [];
gooditems = [commonlist_basic.pop()];
otherstuff = [];
goodotherstuff = [];

addfloor("tiny")
  .additems(items, gooditems)
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();
  
//Floor 2:
commonlist_basic.push("Bumpblade");
commonlist_basic.push("Flame Spell");
shuffle(commonlist_basic);

commonlist_advanced.push("Forcefield");
commonlist_advanced.push("Backstab");
shuffle(commonlist_advanced);

items = [];

gooditems = ["Mechanical Arm"];
otherstuff = [health(), health()];
goodotherstuff = [
  shop(shuffle([commonlist_advanced.pop(), commonlist_basic.pop(), commonlist_advanced.pop()]))
];

addfloor("normal")
  .additems(items, gooditems)
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();
  
//Floor 3:
commonlist_basic.push("Freeze Spell");
commonlist_basic.push("Spatula");
commonlist_basic.push("Hammer");
shuffle(commonlist_basic);

commonlist_advanced.push("Counter Spell");
commonlist_advanced.push("Chocolate Cookie");
commonlist_advanced.push("Lament");
commonlist_advanced.push("Meteor");
shuffle(commonlist_advanced);

items = [commonlist_basic.pop()];
gooditems = [];

otherstuff = [
  health(), 
  health()
];
goodotherstuff = [
  shop([commonlist_basic.pop(), commonlist_basic.pop(), commonlist_advanced.pop()]), 
  upgrade()
];

addfloor("normal")
  .additems(items, gooditems)
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();
  
//Floor 4:
items = [];
gooditems = [pick([commonlist_advanced.pop(), commonlist_advanced.pop()])];

otherstuff = [health(), health()];
goodotherstuff = [
  trade(["Heat Sink", "Increment", "weapon"], ["Venus Fly Trap", "Spatula", "Juggling Ball", "Headbutt"])
];

addfloor("normal")
  .additems(items, gooditems)
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();
  
//Floor 5:
items = [];
gooditems = [commonlist_basic.pop()];

otherstuff = [health(), health()];
goodotherstuff = [
  shop(shuffle(["health", commonlist_advanced.pop(), commonlist_advanced.pop()])), 
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
  items.push("Wooden Stake");
}

lastfloor
  .additems(items, gooditems)
  .setlocation('BOSS')
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();