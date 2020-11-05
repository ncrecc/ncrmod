//To do: document this properly, complete this guide.
//
//When this script starts, an empty Dungeon is created with zero floors.
//
//  addfloor(template) 
//    Creates a new floor - this becomes the new "top floor" of the dungeon. returns a "floor" object.
//    Layout is based on the template, loaded from the data/text/levels/ folder.
//    Matches any level file that contains the string "template", so "tiny" will match "graph_tiny1", "graph_tiny2", etc
//
//  floor.additems(normallist, goodlist)
//    Items that can be found on this floor, as an array of strings.
//    (In general, the normal list is close to where the player starts, and the good list is near the staircase.)
//
//  floor.addenemies(normallist, hardlist)
//    Enemies that can be found on this floor, as an array of strings. If you set usestandardenemies(true), then
//    you shouldn't need to do this - the game will automatically distribute enemies throughout a normal dungeon layout.
//    (In general, the normal list is close to where the player starts, and the good list is near the staircase.)

usestandardenemies();

var finalboss:String = level6enemies.pop();

var randomnumber = rand([1,2]);
trace("RANDOM NUMBER: " + randomnumber);

//9, 15 if later items pushed in are counted
var jester_dice_pool = ["Saving Throw", "Bumpbomb", "Hijack", "Table Flip", "Luckpick", "Welder", "Slim Jim", "Innovate", "Dime", "Coldron"];

var dontreplaceinstore = jester_dice_pool.copy();
/*dontreplaceinstore.push("Backfire");*/ dontreplaceinstore.push("Ping");

//15, 16 if wonder gummi is counted (pushed in later), 17 if hammer up is counted
var jester_damage_pool = ["Tap", "Sharpened Rosary", "Smart Spike", rand(["Bad Damage", "Cheap Shot"]), "Breaking Point", "Prod", "Magic Cyanide", "Throwing Axe", "Supervolcano", "Spin Attack", "Sharp Straw", "Bass Guitar", "Ouija Board", "Holy Water", "Mirror on a Stick"];
if(chance(33)) jester_damage_pool.push("Hammer Up!");

function doubleitems(list) {
	var templist = [];
	for(item in list) {
		if(list.indexOf(item) == list.lastIndexOf(item) && chance(50)) {
			templist.push(item);
		}
	}
	list = shuffle(list.concat(templist));
	return list;
}

function doublepush(list, item) {
	list.push(item);
	if(chance(50)) list.push(item);
	return list;
}

function hasbeentaken(list, item) {
	if(list.indexOf(item) == -1 || list.indexOf(item) != list.lastIndexOf(item)) {
		return true;
	}
	return false;
}
	

jester_dice_pool = doubleitems(jester_dice_pool);
jester_damage_pool = doubleitems(jester_damage_pool);


var items = [jester_dice_pool.pop()];
var gooditems = [];
var otherstuff = [];
var goodotherstuff = [];

//Floor 1:
var floor1 = addfloor("tiny")
  .additems(items, gooditems)
  .generate();

//Floor 2:
var finals = loadtext("ncrmod/initialequipment/jester");
for(i in 0...finals.length) { finals[i] = finals[i].split("InitialEquipment:")[1]; }
shuffle(finals);
items = [finals[0]];
gooditems = [jester_dice_pool.pop()];
otherstuff = [
  health(), 
  health()
];
goodotherstuff = [
  shop([jester_damage_pool.pop(), "Backfire", "Delete"], [2, 3, 2]),
  upgrade()
];

var floor2 = addfloor("normal")
  .additems(items, gooditems)
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();
  
doublepush(jester_dice_pool, "Gas Lamp");
doublepush(jester_dice_pool, "Spearhead");
doublepush(jester_dice_pool, "Mirrorang");
doublepush(jester_dice_pool, "Doppeldfire");
doublepush(jester_dice_pool, "Distort");
dontreplaceinstore.push("Gas Lamp");
dontreplaceinstore.push("Spearhead");
dontreplaceinstore.push("Mirrorang");
dontreplaceinstore.push("Doppeldfire");
dontreplaceinstore.push("Distort");
jester_damage_pool.push("Wonder Gummi");

jester_dice_pool = shuffle(jester_dice_pool);
jester_damage_pool = shuffle(jester_damage_pool);

//Floor 3:
items = [jester_dice_pool.pop()];
gooditems = [];
otherstuff = [
  health(), 
  health()
];

doublepush(jester_dice_pool, "Greed");
jester_dice_pool = shuffle(jester_dice_pool);

goodotherstuff = [
  shop([jester_dice_pool.pop(), chance(75) ? jester_damage_pool.pop() : "Ping", "Delete"])
];

var floor3 = addfloor("normal")
  .additems(items, gooditems)
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();

//Floor 4
items = [];
gooditems = ["Bop,Bop,Bop"];

otherstuff = [
  health(), 
  upgrade()
];

var cfb = null;

goodotherstuff = [
  shop([jester_damage_pool.pop(), pick([jester_damage_pool.pop(), jester_dice_pool.pop()]), jester_dice_pool.pop()]),
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
  
var floors = [floor2, floor3, floor4, floor5];

/*for(floor in floors) {
	trace("inspecting a floor...");
	for(node in floor.nodes) { trace(node.item); if(node.item != " " && node.item.indexOf(",") == -1 && finals.indexOf(node.item) == -1) { node.item = "IC Chip"; } }
}*/

var chiplist = loadtext("ncrmod/floorspawnablechips");
chiplist = shuffle(chiplist);

var floor2chips = [chiplist.pop(), chiplist.pop()];
var floor3chips = [chiplist.pop(), chiplist.pop(), chiplist.pop()];
var floor4chips = [chiplist.pop(), chiplist.pop()];

var actfloorthing = new motion.actuators.SimpleActuator(null,0,null); //larrytech!
actfloorthing.repeat(-1);
var funcfloorthing = new hscript.Parser().parseString("
	if(floors == null || floors[0] == null) { actfloorthing._repeat = 0; }
	else {
		if(Rules.substitutions.exists(\"replacewithchips\")) {
			trace(\"replacing items w/ chips\");
			for(floor in floors) {
				trace(\"inspecting a floor...\");
				for(node in floor.nodes) { if(node.item != \" \" && node.item.indexOf(\",\") == -1 && finals.indexOf(node.item) == -1) { trace(node.item); node.item = \"IC Chip\"; } }
				if(floor.shops.length > 0) { for(shop in floor.shops) { if(shop.contents.length > 0) { for(stock in shop.contents) { if(stock.type == \"equipment\" && dontreplaceinstore.indexOf(stock.name) == -1) { stock.name = \"IC Chip\"; } } } } }
			}
			trace(\"finished chip replacement\");
			actfloorthing._repeat = 0; /*stop actuator when it is done*/
		}
	}
");

if(Rules.substitutions == null) Rules.substitutions = new elements.Equipment("Equipment That Does Nothing").gamevar;

var interp = new hscript.Interp();
interp.variables.set("floors", floors);
interp.variables.set("Rules", Rules);
interp.variables.set("actfloorthing", actfloorthing);
interp.variables.set("trace", trace);
interp.variables.set("null", null);
interp.variables.set("finals", finals);
interp.variables.set("dontreplaceinstore", dontreplaceinstore);
interp.variables.set("chiplist", chiplist);
actfloorthing.onRepeat(interp.execute, [funcfloorthing]);
actfloorthing.move();