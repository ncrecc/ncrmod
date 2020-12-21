usestandardenemies();

var items = [];
var gooditems = [];
var otherstuff = [];
var goodotherstuff = [];

var brostep = rand([false,true]);

var clumporbump = rand(["Clump", "Overbump"]);

//Floor 1:
var commonlist1 = shuffle(["Toolbox@flip", "Disk Eject", "Pocket Protector", "Welder", "Innovate"]);
var commonlist2 = shuffle(["Talent Contest", "Blockbuster", "Smart Spike", "Heaven on Earth"]); //"Reckless Piracy"
var sizetwo = ["Sharpened Rosary", "Strange Parcel", "Blast Processing", "Spin Attack", "Snatch", "Throwing Axe", "Extreme Detail Bat", "Crystallize", "Two Handed Spatula", "Powerball", "Gyrate Hook"];
if(!brostep) { sizetwo.push(rand(["Coil", "Jacob's Ladder"])); }
shuffle(sizetwo);
if(chance(33)) { sizetwo.push("Wand of Wishing"); shuffle(sizetwo); }
var sizetwocopy = sizetwo.copy();
var commonlist1copy = commonlist1.copy();
var commonlist2copy = commonlist2.copy(); //if(commonlist2copy.indexOf("Talent Contest") != commonlist2copy.lastIndexOf("Talent Contest")) commonlist2copy.remove("Talent Contest");

items = [];
gooditems = [commonlist2.pop()];
otherstuff = [];
goodotherstuff = [];

addfloor("tiny")
  .additems(items, gooditems)
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();
  
//Floor 2:
commonlist1.push("Security Hole");
commonlist1.push("Popular Vote");
var murkorspec = rand(["Murk", "Spectral Cauldron"]);
commonlist1.push(murkorspec);
commonlist1.push("Pummel");
shuffle(commonlist1);
commonlist1copy.push("Security Hole");
commonlist1copy.push("Popular Vote");
commonlist1copy.push(murkorspec);
commonlist1copy.push("Pummel");

//commonlist2.push("Ransomware");
var brosteporshockhumour = rand(["Loud Brostep", "Shock Humour"]);
if(brostep) commonlist2.push(brosteporshockhumour);
commonlist2.push("Baby's First Counting Book");
commonlist2.push(clumporbump);
shuffle(commonlist2);
//commonlist2copy.push("Ransomware");
if(brostep) commonlist2copy.push(brosteporshockhumour);
commonlist2copy.push("Baby's First Counting Book");
commonlist2copy.push(clumporbump);

items = [];

gooditems = [];
otherstuff = [health(), health()];
goodotherstuff = [
  chance(50) ? shop(shuffle([commonlist1.pop(), commonlist2.pop(), commonlist1.pop()])) : shop(shuffle([commonlist1.pop(), commonlist2.pop(), "upgrade"]))
];

addfloor("normal")
  .additems(items, gooditems)
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();
  
//Floor 3:
commonlist1.push("Crysis");
commonlist1.push("Reverse Emulation");
commonlist1.push("Technology");
commonlist1.push("Rosepetal Blade");
commonlist1.push("Decimate");
shuffle(commonlist1);
commonlist1copy.push("Crysis");
commonlist1copy.push("Reverse Emulation");
commonlist1copy.push("Technology");
commonlist1copy.push("Rosepetal Blade");
commonlist1copy.push("Decimate");

var hypertension = rand(["Hyper Beam", "Tension"]);
commonlist2.push(hypertension);
commonlist2.push("Penultima Weapon");
var glueorshame = rand(["Glue Gun", "Shame"]);
commonlist2.push(glueorshame);
commonlist2.push("Global Thermonuclear War");
commonlist2.push("Manual Repair");
commonlist2.push("Handcuffs");
commonlist2.push("Talent Contest"); //duplicate, but i had this happen to me in my first playthrough and i thought, you know, maybe this is cool
var egoorbreaking = rand(["Ego Stroke", "Breaking Point"]);
commonlist2.push(egoorbreaking);
shuffle(commonlist2);
commonlist2copy.push(hypertension);
commonlist2copy.push("Penultima Weapon");
commonlist2copy.push(glueorshame);
commonlist2copy.push("Global Thermonuclear War");
commonlist2copy.push("Manual Repair");
commonlist2copy.push("Handcuffs");
commonlist2copy.push(egoorbreaking);

items = [sizetwo.pop()];
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
items = [];
gooditems = [pick([commonlist1.pop(), commonlist1.pop()])];

otherstuff = [health(), health()];
goodotherstuff = [
  chance(50) ? trade(sizetwocopy, [sizetwo.pop()]) : trade(commonlist1copy, commonlist2copy)
];

addfloor("normal")
  .additems(items, gooditems)
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();
  
//Floor 5:
items = [];
gooditems = [commonlist2.pop()];

otherstuff = [health(), health()];
goodotherstuff = [
  shop(shuffle(["health", commonlist1.pop(), sizetwo.pop()])), 
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