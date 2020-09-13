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

//9, 15 if later items pushed in are counted
var jester_dice_pool = ["Vise Grip", "Spatulasword", "Table Slam", "Lollipop", "Nudge", "Spatula", "Cauldron", "Bump", "Mirror on a Stick", "Prod", rand(["Bad Damage", "Cheap Shot"]), "Tap", "Saving Throw", "Table Flip", "Luckpick", "Welder", "Slim Jim", "Innovate", "Dime", "Coldron", "Tootsie Pop"];

var dontreplaceinstore = jester_dice_pool.copy();
//dontreplaceinstore.push("Backfire");
dontreplaceinstore.push("Ping");

//15, 16 if wonder gummi is counted (pushed in later), 17 if hammer up is counted
var jester_damage_pool = ["Zombo", "Gumball Machine", "Kapow", "Boxing Gloves", "Rusty Sword", rand(["Telephone","Operator"]), "Missing Score", "Elastic Heart", "Juggling Ball", "Boop", "Shovel", "Lament", "Whip", "Hammer", "Blood Suck", "Zoop Zoop", "Bumpbomb", "Hijack", "Sharpened Rosary", "Smart Spike", "Breaking Point", "Magic Cyanide", "Throwing Axe", "Supervolcano", "Spin Attack", "Sharp Straw", "Bass Guitar", "Ouija Board", "Holy Water", "Ice Giant"];

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
var finals = [];
items = [];
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

var hammerup = chance(33); //Boolean
  
doublepush(jester_dice_pool, "Swing Me Another 6");
doublepush(jester_dice_pool, "Gas Lamp");
doublepush(jester_dice_pool, "Mirrorang");
doublepush(jester_dice_pool, "Doppeldfire");
doublepush(jester_dice_pool, "Distort");
if(hammerup) doublepush(jester_dice_pool, "Hammer Up!");
dontreplaceinstore.push("Swing Me Another 6");
dontreplaceinstore.push("Gas Lamp");
dontreplaceinstore.push("Mirrorang");
dontreplaceinstore.push("Doppeldfire");
dontreplaceinstore.push("Distort");
if(hammerup) dontreplaceinstore.push("Hammer Up!");
jester_damage_pool.push("Wonder Gummi");
doublepush(jester_damage_pool, "Spear");

jester_dice_pool = shuffle(jester_dice_pool);
jester_damage_pool = shuffle(jester_damage_pool);

//Floor 3:
items = [jester_dice_pool.pop()];
gooditems = [];
otherstuff = [
  health(), 
  health()
];

doublepush(jester_dice_pool, "Envy");
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

var floor4items = ["Illuminate", "Hall of Mirrors","Shadow Dice","Blood Let","Mirror Shard"];
for(item in floor4items) { doublepush(jester_dice_pool, item); }

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
  items.push(pick(["Steel Sword,Steel Sword","Wooden Stake,Wooden Stake"]));
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
//the script which replaces items with chips should ignore items which already are chips, just in case
dontreplaceinstore = dontreplaceinstore.concat(chiplist);
finals.concat(chiplist);

//uncomment this if i change my mind about finales not being replaced when chip pack is active. then get rid of the finals kludge and have a dontreplaceonfloor thing
//finals = [];

var itemreplacestomake = [];
var storereplacestomake = [];
for(floor in floors) {
	for(node in floor.nodes) {
		if(node.item.toString().length > 0 && node.item.toString().indexOf(",") == -1 && finals.indexOf(node.item.toString()) == -1) { itemreplacestomake = itemreplacestomake.concat([node.item, chiplist.pop()]); /*trace("following item: " + itemreplacestomake);*/ }
	}
	if(floor.shops.length > 0) { for(shop in floor.shops) { if(shop.contents.length > 0) { for(stock in shop.contents) { if(stock.type == "equipment" && dontreplaceinstore.indexOf(stock.equipment.name) == -1) { storereplacestomake = storereplacestomake.concat([stock.equipment.name, chiplist.pop()]); /*trace("following shop: " + storereplacestomake);*/ } } } } } // why the fuck didn't i indent this
}

//consequently, if the same item appears twice then it gets replaced with the same chip twice. that's fine for jester since they like snapping and discarding - and is why i let duplicates more freely appear for them in the first place

var actfloorthing = new motion.actuators.SimpleActuator(null,0,null); //larrytech!
actfloorthing.repeat(-1);
var funcfloorthing = new hscript.Parser().parseString("
	if(floors == null || floors[0] == null) { trace(\"exiting jester's actuator\"); actfloorthing._repeat = 0; }
	else {
		if(Rules.substitutions.exists(\"replacewithchips\")) {
			trace(\"replacing non-shop items w/ chips\");
			var i = 2;
			for(floor in floors) {
				trace(\"inspecting a floor...\");
				if(i != 3) { /*don't replace floor 3 dice manip. makes it easier on player since the chips have such different requirements*/ for(node in floor.nodes) { if(itemreplacestomake.indexOf(node.item) != -1) { node.item = itemreplacestomake[itemreplacestomake.indexOf(node.item) + 1]; } } }
				if(floor.shops.length > 0) { for(shop in floor.shops) { if(shop.contents.length > 0) { for(stock in shop.contents) { if(stock.type == \"equipment\" && storereplacestomake.indexOf(stock.equipment.name) != -1) { /*trace(\"old: \" + stock.equipment.name);*/ stock.equipment = new elements.Equipment(storereplacestomake[storereplacestomake.indexOf(stock.equipment.name) + 1]); stock.equipment.resize(2); trace(stock.equipment.name); } } } } }
				i++;
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
interp.variables.set("storereplacestomake", storereplacestomake);
interp.variables.set("itemreplacestomake", itemreplacestomake);
actfloorthing.onRepeat(interp.execute, [funcfloorthing]);
actfloorthing.move();