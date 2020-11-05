usestandardenemies();

var otherstuff = [];
var goodotherstuff = [];

//Floor 1:

otherstuff = [];
goodotherstuff = [];

addfloor("tiny")
  .additems(["Blessed Wand of Wishing"], ["Blessed Wand of Wishing"])
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();
  
//Floor 2:

otherstuff = [health(), health()];
goodotherstuff = [
  shop(shuffle(["Blessed Wand of Wishing", "Blessed Wand of Wishing", "upgrade"]))
];

addfloor("normal")
  .additems([], [])
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();
  
//Floor 3:

otherstuff = [
  health(), 
  health()
];
goodotherstuff = [
  shop(["Blessed Wand of Wishing", "Blessed Wand of Wishing", "Blessed Wand of Wishing"]), 
  upgrade()
];

addfloor("normal")
  .additems(["Blessed Wand of Wishing"], [])
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();
  
//Floor 4:

otherstuff = [health(), health()];
goodotherstuff = [
  trade(["any"], ["Blessed Wand of Wishing"])
];

addfloor("normal")
  .additems([], ["Blessed Wand of Wishing", "Blessed Wand of Wishing"])
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();
  
//Floor 5:

otherstuff = [health(), health()];
goodotherstuff = [
  shop(shuffle(["health", "Blessed Wand of Wishing", "Blessed Wand of Wishing"])), 
  upgrade()
];

addfloor("big")
  .additems([], ["Blessed Wand of Wishing"])
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();
  
//Floor 6:
otherstuff = [];
goodotherstuff = [];

var lastfloor = addfloor("boss");

lastfloor
  .setlocation('BOSS')
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();