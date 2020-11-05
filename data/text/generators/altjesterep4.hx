usestandardenemies();

var finalboss:String = level6enemies.pop();

var items = [];
var gooditems = [];
var otherstuff = [];
var goodotherstuff = [];

//Floor 1:
var floor1 = addfloor("tiny")
  .additems(items, gooditems)
  .generate();

//Floor 2:
items = [];
gooditems = [];
otherstuff = [
  health(), 
  health()
];
goodotherstuff = [
  shop(["Delete", "Copyshop", "Delete"], [2, 3, 2]),
  upgrade()
];

var floor2 = addfloor("normal")
  .additems(items, gooditems)
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();
  

//Floor 3:
items = [];
gooditems = [];
otherstuff = [
  health(), 
  health()
];

goodotherstuff = [
  shop(["Copyshop", chance(75) ? "Copyshop" : "Upgrade", "Delete"]),
  copyshop()
];

var floor3 = addfloor("normal")
  .additems(items, gooditems)
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();

//Floor 4
items = [];
gooditems = [];

otherstuff = [
  health(), 
  upgrade()
];

var cfb = null;

goodotherstuff = [
  shop(["Upgrade", "Copyshop", "Copyshop"]),
  copyshop()
];

var floor4 = addfloor("big")
  .additems(items, gooditems)
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();
  
//Floor 5
items = [];
gooditems = [];
otherstuff = [health(), health(), health()];
goodotherstuff = [rand([upgrade(), copyshop()])];

var floor5 = addfloor("normal")
  .additems(items, gooditems)
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();

// Floor 6:			
items = [];
gooditems = [];
otherstuff = [];
goodotherstuff = [];

usestandardenemies(false);
if (finalboss == "Drake"){
  items.push("Steel Sword,Steel Sword");
}

addfloor("boss")
  .addenemies([], [finalboss])
  .setlocation('BOSS')
  .additems(items, gooditems)
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();