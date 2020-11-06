if (levelupselections.indexOf("Boosterpack:Foggy Glass,Flicker,Flicker") > -1){
  Rules.substitute("Backfire", "Sceptre");
  Rules.substitute("Ping", "Scientology Pamphlet");
  Rules.substitute("Bop,Bop,Bop", rand(["Shudder,Flicker,Shudder","Zoop Zoop,Gaslighting,Zoop Zoop","Flicker,Sleight of Hand@ncrmod,Flicker","Zoop Zoop,Swamp Gas,Zoop Zoop"]));
}
if (levelupselections.indexOf("Boosterpack:Wall Street Shuffle,Golden Gun,Golden Gun") > -1){ //not particularly feeling this one
  Rules.substitute("Backfire", "Snake Oil");
  Rules.substitute("Ping", "Winds of Christmas");
  Rules.substitute("Bop,Bop,Bop", rand(["Even Cauldron,Healthcare,Even Cauldron","Gold Cauldron,Even Cauldron,Gold Cauldron"]));
}
if (levelupselections.indexOf("Boosterpack:Lucky Charm,Reckless Flailing,Reckless Flailing") > -1){
  Rules.substitute("Backfire", "Healer Staff");
  Rules.substitute("Ping", rand(["Fissure@ncrmod","Sheer Cold","Guillotine"]));
  Rules.substitute("Bop,Bop,Bop", rand(["Beginner's Luck,Lucky Charm,Reckless Flailing","Trinity Charm,Zoop Zoop,Trinity Charm","Delicious Fruit,Bop Bop,Delicious Fruit"]));
}
if (levelupselections.indexOf("Boosterpack:Spite,Folly,Folly") > -1){ //external circumstances make this pack really bad: the charge counter will only increment if the card is on-screen! https://github.com/TerryCavanagh/diceydungeons.com/issues/1904 ...although how good can a pack whose associated floor 4 booster contains stumble and an item known as "super backfire" be
  Rules.substitute("Backfire", "Distort");
  Rules.substitute("Ping", "Respite");
  Rules.substitute("Bop,Bop,Bop", rand(["Stumble,Boomerang,Stumble","Super Backfire,Respite,Super Backfire"]));
}
if (levelupselections.indexOf("Boosterpack:Wind Chimes,Cyclone,Cyclone") > -1){
  Rules.substitute("Backfire", "Turbine");
  Rules.substitute("Ping", "One Way Mirror");
  Rules.substitute("Bop,Bop,Bop", "Blow,Bop Bop,Blow");
}
if (levelupselections.indexOf("Boosterpack:Fastball,Hall of Mirrors,Hall of Mirrors") > -1){
  Rules.substitute("Backfire", "Retroreflector");
  Rules.substitute("Ping", "Broken Mirror");
  Rules.substitute("Bop,Bop,Bop", rand(["Cauldron,Mirror Cauldron,Cauldron","Bop Bop,Mirror Shard,Bop Bop"]));
}
if (levelupselections.indexOf("Boosterpack:Speak Softly,Ivy,Ivy") > -1){
  Rules.substitute("Backfire", "Big Stick");
  Rules.substitute("Ping", "Dark Hedges");
  Rules.substitute("Bop,Bop,Bop", rand(["Flower Pot,Magic Thistle,Flower Pot","Bop Bop,Cactus Spear,Bop Bop"]));
}
if (levelupselections.indexOf("Boosterpack:Chant,Backward Satanic Messages,Backward Satanic Messages") > -1){
  Rules.substitute("Backfire", "Sword");
  Rules.substitute("Ping", "Very Good Sword");
  Rules.substitute("Bop,Bop,Bop", "Boop,Boop,Boop");
}
if (levelupselections.indexOf("Boosterpack:Chip Socket,IC Chip,IC Chip") > -1){ //this pack is literally "bash with chip's challenge", i love it
  Rules.substitutions.set("replacewithchips","yep"); //"yep" is arbitrary. actuator called from generator just checks to see if replacewithchips exists in Rules.substitutions
  //Rules.substitute("Backfire", "Toggle Chip"); by commenting this out, i forgo a "standard" pack-based card for another chip item. ping stays an incredibly powerful pack-based card
  Rules.substitute("Ping", "Time Lapse");
  Rules.substitute("Bop,Bop,Bop", "Zoop Zoop,Chipmine,Zoop Zoop","Bop Bop,Mystical Chip,Bop Bop");
}
if (levelupselections.indexOf("Boosterpack:Sticky Cauldron,Crazy Glue,Crazy Glue") > -1){
  Rules.substitute("Backfire", "Counter Spell");
  Rules.substitute("Ping", "Seize");
  Rules.substitute("Bop,Bop,Bop", rand(["Bop Bop,Parrying Dagger,Bop Bop","Hurricane,Zoop Zoop,Hurricane"]));
}
if(self.level > 1 && levelupselections.length > 0 && levelupselections.indexOf("Boosterpack:Chip Socket,IC Chip,IC Chip") == -1) { Rules.substitutions.set("stopchipactuator","yep"); }