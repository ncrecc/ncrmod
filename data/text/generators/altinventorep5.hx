usestandardenemies();

var otherstuff = [];
var goodotherstuff = [];

//getequipmentlist(null,[],['skillcard','excludefromrandomlists','robotonly','witchonly','onceperbattle','alternateversion','testitem','unfinished'])

var dummy = new elements.Fighter("Wisp");
var geteq = new elements.Skill("Against all odds_old");
geteq.script = "var eqlist = getequipmentlist(null,[],['skillcard','excludefromrandomlists','robotonly','witchonly','onceperbattle','alternateversion']); self.innate = eqlist;";
geteq.execute(dummy,dummy);

var eqlist = dummy.innate;


var allequipment = shuffle(eqlist);

dummy = null;
geteq = null;

//Floor 1:

otherstuff = [];
goodotherstuff = [];

addfloor("small")
  .additems([allequipment.pop(), allequipment.pop()], [allequipment.pop()])
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();
  
//Floor 2:

otherstuff = [
  health(), 
  health()
];
goodotherstuff = [
  shop(shuffle(["upgrade", allequipment.pop(), allequipment.pop()]), shuffle([2, 3, 4]))
];

addfloor("small")
  .additems([], [allequipment.pop(), allequipment.pop()])
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();

//Floor 3:
		
otherstuff = [health()];
goodotherstuff = [
  shop(shuffle([allequipment.pop(), allequipment.pop(), allequipment.pop()]), shuffle([1, 2, 3])),
  shop(shuffle([allequipment.pop(), allequipment.pop(), "upgrade"]))
];
	
addfloor("big")
  .additems([allequipment.pop(), allequipment.pop()], [allequipment.pop()])
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();
  
//Floor 4:

otherstuff = [health(), health()];
goodotherstuff = [];
		
addfloor("normal")
  .additems([allequipment.pop()], [allequipment.pop()])
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();
  
//Floor 5:
		
otherstuff = [health(), health()];
goodotherstuff = [
  shop(shuffle([allequipment.pop(), "health", allequipment.pop()])),
  upgrade()
];
		
addfloor("big")
  .additems([allequipment.pop()], [allequipment.pop()])
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();

//Floor 6:
var items = [];

otherstuff = [];
goodotherstuff = [];

var lastfloor = addfloor("boss");

if (getfinalboss() == "Drake"){
  items.push("Wooden Stake");
}

lastfloor
  .additems(items, [])
  .setlocation('BOSS')
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();
		
		