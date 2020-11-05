//Flower Pot|Flower Pot|Hunting Knife@large

usestandardenemies();

var items = [];
var gooditems = [];
var otherstuff = [];
var goodotherstuff = [];

//Floor 1:
var freezeburngivenyet = false; //this isn't used for anything as of yet
var jinxgivenyet = false;

var commonlist1 = shuffle(["Watering Can", "Peapod", "Freezeburn", "Magic Flute"]);

items = [commonlist1.pop()];

addfloor("tiny")
  .additems(items, gooditems)
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();
  
//Floor 2:
commonlist1.push("Blue Ocean");
commonlist1.push("Enchanted Shield");
commonlist1.push("Glitter Bomb");
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
var scraplist = ["Scrap Slingshot", "Scrap Trap", "Scrapsies", "Scrapstick", "Scrap Lamp", "Scrap Crystal", "Scraptula", "Scrap Slam"];
scraplist = shuffle(scraplist);

var lockpickvariants = ["Open Sesame", "Luckpick"];
lockpickvariants = shuffle(lockpickvariants);
if(chance(5)) {
	lockpickvariants.pop();
	lockpickvariants.push("Hijack");
	lockpickvariants = shuffle(lockpickvariants);
}
var lockpickvariant1 = lockpickvariants.pop();
var lockpickvariant2 = lockpickvariants.pop();

var commonlist2 = ["Honeysuckle", "Gas Lamp", "Telephone", "Cookie Cake", "Blacklight", lockpickvariant1];
if(chance(20)) commonlist2.push("Survivor's Guilt");
var rarelist1 = [chance(66) ? "Precious Egg@6" : "Rotten Egg@6", "Arf Arf Arf", chance(50) ? "Jester" : "Call for Backup Robot", "Lotus Swing", "Black Lotus@ncrmod", "Autohook", "Magic Flute", "Combat Roll", "Fool's Fire"];
if(chance(20)) { rarelist1.push("Metacrowbar"); }
if(chance(20)) { rarelist1.remove("Fool's Fire"); rarelist1.push("Stupid's Shock"); }

commonlist2 = shuffle(commonlist2);
rarelist1 = shuffle(rarelist1);
items = [commonlist2.pop()];
gooditems = [pick(["Uberbump", "Slim Jim", "Welder"])];
if(chance(10)) gooditems = ["Change Machine"];

otherstuff = [
  health(),
  health()
];
goodotherstuff = [
  shop([commonlist2.pop(), chance(66) ? commonlist2.pop() : scraplist.pop(), commonlist1.pop()]),
  upgrade()
];

addfloor("normal")
  .additems(items, gooditems)
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();
  
//Floor 4:
if(
	commonlist2.indexOf("Telephone") == -1 || 
	commonlist2.indexOf("Gas Lamp") == -1 || 
	scraplist.indexOf("Scrapsies") == -1 || 
	rarelist1.indexOf("Arf Arf Arf") == -1 ||
	rarelist1.indexOf("Lotus Swing") == -1
  )
	jinxgivenyet = true;

var commonlist3 = [lockpickvariant2, "Iron Shield", "Defense Mechanism", "Plight", "Warhammer"];
if(jinxgivenyet) commonlist3.push("Hijinx");
commonlist3 = shuffle(commonlist3);
items = [commonlist3.pop()];
gooditems = [];

var floor5item = commonlist3.pop();

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
  shop([rarelist1.pop(), chance(66) ? rarelist1.pop() : scraplist.pop(), commonlist2.pop()]),
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
  items.push("Steel Sword");
}

lastfloor
  .additems(items, gooditems)
  .setlocation('BOSS')
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();
		