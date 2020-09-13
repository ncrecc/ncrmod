usestandardenemies();

var items = [];
var gooditems = [];
var otherstuff = [];
var goodotherstuff = [];

//size two items from vanilla robot are kept in commonlist1/2 instead of sizetwo, since i think that allows more for interesting possibilities like two handed spatula + spatulasword

var brostep = rand([false,true]);

//Floor 1:
var commonlist1 = shuffle(["Toolbox@flip", "Disk Eject", "Pocket Protector", "Welder", "Innovate", "Healing Crystal", "Small Shield", "Nudge", rand(["Cheat Code", "Safe Bet"]), (chance(30)?"Iron Armor":"Leather Armor"), "Saw Wave", "Four Leaf Clover"]);
var commonlist2 = shuffle(["Talent Contest", "Blockbuster", "Juggling Ball", "Spanner", "Spiked Shield", "Doppeldice", "Short Circuit", "Slingshot", "Vise Grip", (chance(30)?"Starspear":"Sword Hilt"), "Ungeradedice"]); //"Reckless Piracy"
var sizetwo = ["Sharpened Rosary", "Strange Parcel", "Blast Processing", "Spin Attack", "Snatch", "Throwing Axe", "Extreme Detail Bat", "Crystallize", "Two Handed Spatula", "Powerball", "Gyrate Hook"];
if(!brostep) { sizetwo.push(rand(["Coil", "Jacob's Ladder"])); }
shuffle(sizetwo);
if(chance(33)) { sizetwo.push("Wand of Wishing"); shuffle(sizetwo); }
var sizetwocopy = sizetwo.copy();
var commonlist1copy = commonlist1.copy();
var commonlist2copy = commonlist2.copy(); //if(commonlist2copy.indexOf("Talent Contest") != commonlist2copy.lastIndexOf("Talent Contest")) commonlist2copy.remove("Talent Contest");

items = [];
gooditems = [commonlist1.pop()];
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
commonlist1.push("Lucky Star");
commonlist1.push("Mechanical Leg");
commonlist1.push("Bumpblade");
commonlist1.push("Ray Gun");
shuffle(commonlist1);
commonlist1copy.push("Security Hole");
commonlist1copy.push("Popular Vote");
commonlist1copy.push(murkorspec);
commonlist1copy.push("Pummel");
commonlist1copy.push("Lucky Star");
commonlist1copy.push("Mechanical Leg");
commonlist1copy.push("Bumpblade");
commonlist1copy.push("Ray Gun");

//commonlist2.push("Ransomware");
commonlist2.push("Smart Spike");
commonlist2.push("Heaven on Earth");
var brosteporshockhumour = rand(["Loud Brostep", "Shock Humour"]);
if(brostep) commonlist2.push(brosteporshockhumour);
commonlist2.push("Baby's First Counting Book");
commonlist2.push("Elastic Heart");
commonlist2.push("Forcefield");
var midnightorhalfmoon = rand(["Midnight Charm", "Half Moon Charm"]);
commonlist2.push(midnightorhalfmoon);
shuffle(commonlist2);
//commonlist2copy.push("Ransomware");
commonlist2copy.push("Smart Spike");
commonlist2copy.push("Heaven on Earth");
if(brostep) commonlist2copy.push(brosteporshockhumour);
commonlist2copy.push("Baby's First Counting Book");
commonlist2copy.push("Elastic Heart");
commonlist2copy.push("Forcefield");
commonlist2copy.push(midnightorhalfmoon);

items = [];

gooditems = [];
otherstuff = [health(), health()];
goodotherstuff = [
  chance(50) ? shop(shuffle([commonlist2.pop(), commonlist1.pop(), commonlist2.pop()])) : shop(shuffle([commonlist2.pop(), commonlist1.pop(), "upgrade"]))
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
commonlist1.push("Free Spin");
var spatorspatsword = rand(["Spatulasword", "Spatula"]);
commonlist1.push(spatorspatsword);
commonlist1.push("Fixed Payout");
shuffle(commonlist1);
commonlist1copy.push("Crysis");
commonlist1copy.push("Reverse Emulation");
commonlist1copy.push("Technology");
commonlist1copy.push("Rosepetal Blade");
commonlist1copy.push("Decimate");
commonlist1copy.push("Free Spin");
commonlist1copy.push(spatorspatsword);
commonlist1copy.push("Fixed Payout");

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
var daggerorspell = rand(["Parrying Dagger", "Counter Spell"]);
commonlist2.push(daggerorspell);
commonlist2.push("Dragon's Tooth");
var luckitem = pick(["Princess Guard", "Premium Heart", "Venus Gospel"]);
commonlist2.push(luckitem);
commonlist2.push("Chocolate Cookie");
shuffle(commonlist2);
commonlist2copy.push(hypertension);
commonlist2copy.push("Penultima Weapon");
commonlist2copy.push(glueorshame);
commonlist2copy.push("Global Thermonuclear War");
commonlist2copy.push("Manual Repair");
commonlist2copy.push("Handcuffs");
commonlist2copy.push(egoorbreaking);
commonlist2copy.push(daggerorspell);
commonlist2copy.push("Dragon's Tooth");
commonlist2copy.push(luckitem);
commonlist2copy.push("Chocolate Cookie");

items = [sizetwo.pop()];
gooditems = [];

otherstuff = [
  health(), 
  health()
];
goodotherstuff = [
  shop([commonlist1.pop(), commonlist1.pop(), commonlist2.pop()]), 
  upgrade()
];

addfloor("normal")
  .additems(items, gooditems)
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();
  
//Floor 4:
items = [];
gooditems = [pick([commonlist2.pop(), commonlist2.pop()])];

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
gooditems = [commonlist1.pop()];

otherstuff = [health(), health()];
goodotherstuff = [
  shop(shuffle(["health", commonlist2.pop(), sizetwo.pop()])), 
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
  items.push(rand(["Wooden Stake", "Steel Sword"]));
}

lastfloor
  .additems(items, gooditems)
  .setlocation('BOSS')
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();