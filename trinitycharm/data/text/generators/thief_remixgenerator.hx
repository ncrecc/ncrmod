// Regular and Parallel universe generators, smushed together
usestandardenemies();

var items = [];
var gooditems = [];
var otherstuff = [];
var goodotherstuff = [];

//Floor 1:
var chiselorcandle = ["Chisel", "Candle"];
chiselorcandle = shuffle(chiselorcandle);

var commonlist1 = shuffle(["Cloak", chiselorcandle.pop(), "Plaster", "Dramatic Exit", "Blast Chiller", "Square Pair", "Leather Armor", "Bump", "Bandage", "Pickpocket", "Pea Shooter", "Snake Eye Charm"]);
		
items = [commonlist1.pop()];

var tempfloor = addfloor("tiny")
  .additems(items, gooditems)
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();

//Floor 2:
commonlist1.push("Thick Skin");
commonlist1.push("Healing Crystal");
commonlist1 = shuffle(commonlist1);

items = [commonlist1.pop()];
gooditems = [];

otherstuff = [health(), health()];
goodotherstuff = [shop(shuffle([rand(["Befuddle", "Counterfeit"]), commonlist1.pop(), commonlist1.pop()]))];

addfloor("normal")
  .additems(items, gooditems)
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();
  
//Floor 3:
var commonlist2 = [rand(["Paper Lantern", "Lantern"]), "Last Stand", "Kite Shield", "Tetraphobia", "Chisel", "Lucky 7", "First Aid Kit", "Big Knife", rand(["Staff", "Gemstone Staff"]), "Lockpick", "Poison Slingshot"];
var rarelist1 = ["Dramatic Entrance", "Raw Ambition", "Hookshot", "Signal Jammer", "Determination", "Dodge", "Snake Eye Charm", "Midnight Charm"];

commonlist2 = shuffle(commonlist2);
rarelist1 = shuffle(rarelist1);
items = [commonlist2.pop()];
gooditems = [];

otherstuff = [
  health(),
  health()
];
goodotherstuff = [
  shop([commonlist2.pop(), commonlist2.pop(), commonlist1.pop()]),
  upgrade()
];

addfloor("normal")
  .additems(items, gooditems)
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();
  
//Floor 4:
var commonlist3 = [chiselorcandle.pop(), "Secret Weapon", rand(["Splitula", "Spatula"]), "Broken Mirror", "Iron Armor", "Blight", "Detonator"];
commonlist3 = shuffle(commonlist3);
items = [commonlist3.pop()];
gooditems = [];

var floor5item = commonlist3.pop();

commonlist3.push("Table Slam");
commonlist3.push("Nudgeblade");
commonlist3 = shuffle(commonlist3);

otherstuff = [health(), health()];

var thieftrade;
if(chance(10)){
  thieftrade = trade(["master key", "lockpick", "berlin key", "nunchucks", "dagger"], ["Blender"]);
}else if(chance(10)){
  thieftrade = trade(["master key", "lockpick", "berlin key", "nunchucks", "dagger"], ["Doppeltwice"]);
}else if(chance(10)){
  thieftrade = trade(["master key", "lockpick", "berlin key", "nunchucks", "dagger"], ["Ungeradedice"]);
}else{
  thieftrade = trade(["master key", "nunchucks", "lockpick", "dagger"], ["Mechanical Leg", "Determination", "Broken Mirror", "Catastrophe", "Glass Cauldron"]);
}

goodotherstuff = [
  shop([rarelist1.pop(), rarelist1.pop(), commonlist2.pop()]),
  thieftrade
];

addfloor("big")
  .additems(items, gooditems)
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();
  
 //Floor 5:
items = [floor5item];
gooditems = [];
otherstuff = [health(), health(), health()];
goodotherstuff = [
  shop(shuffle(["health", commonlist3.pop(), pick([rarelist1.pop(), commonlist2.pop()])])), 
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
		