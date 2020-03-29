//Flower Pot|Flower Pot|Hunting Knife@large

usestandardenemies();

var items = [];
var gooditems = [];
var otherstuff = [];
var goodotherstuff = [];

//Floor 1:
var freezeburngivenyet = false; //this isn't used for anything as of yet

var commonlist1 = shuffle(["Watering Can", "Peapod", "Freezeburn", "Magic Flute", "Enchanted Shield"]);
		
items = [commonlist1.pop()];

addfloor("tiny")
  .additems(items, gooditems)
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();
  
//Floor 2:
commonlist1.push("Blue Ocean");
commonlist1 = shuffle(commonlist1);

items = [commonlist1.pop()];
gooditems = [];

otherstuff = [health(), health()];
goodotherstuff = [shop(shuffle(["Keyhole", commonlist1.pop(), commonlist1.pop()]))];

if(commonlist1.indexOf("Freezeburn") == -1) freezeburngivenyet = true;

addfloor("normal")
  .additems(items, gooditems)
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();
  
//Floor 3:
var lockpickvariant1 = pick(["Open Sesame", "Luckpick"]);
var lockpickvariants = ["Open Sesame", "Luckpick"];
lockpickvariants.remove(lockpickvariant1);
lockpickvariant2 = lockpickvariants[0];

var commonlist2 = ["Matchbox", "Gas Lamp", "Last Stand", "First Aid Kit", "Glitter Bomb", lockpickvariant1];
if(chance(20)) commonlist2.push("Survivor's Guilt");
var rarelist1 = ["Black Lotus", "Autohook", "Magic Flute", "Combat Roll", "Fool's Fire"];
if(chance(20)) { commonlist2.remove("Fool's Fire"); commonlist2.push("Stupid's Shock"); }

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
var commonlist3 = [lockpickvariant2, "Defense Mechanism", "Blight", "Detonator", "Spatula"];
commonlist3 = shuffle(commonlist3);
items = [commonlist3.pop()];
gooditems = [];

var floor5item = commonlist3.pop();

commonlist3.push("Nudgeblade");
commonlist3 = shuffle(commonlist3);

otherstuff = [health(), health()];

var thieftrade;
if(chance(10)){
  thieftrade = trade(["flower pot"], ["snapdragon"]);
}else if(chance(10)){
  thieftrade = trade(["flower pot"], ["gladioli"]);
}else{
  thieftrade = trade(["flower pot", "poppy", "woodchipper", "dynamite", "open sesame", "luckpick", "hunting knife@large" "hunting knife@small"], ["Backstab", "Blight", "Catastrophe", "Glass Cauldron"]);
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
		