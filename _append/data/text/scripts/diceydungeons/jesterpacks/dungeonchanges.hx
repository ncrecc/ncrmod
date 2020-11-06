if (levelupselections.indexOf("Boosterpack:Foggy Glass,Flicker,Flicker") > -1){
  Rules.substitute("Backfire", "Sceptre");
  Rules.substitute("Ping", "Scientology Pamphlet");
  Rules.substitute("Bop,Bop,Bop", rand(["Shudder,Flicker,Shudder","Zoop Zoop,Gaslighting,Zoop Zoop","Flicker,Sleight of Hand@ncrmod,Flicker","Zoop Zoop,Swamp Gas,Zoop Zoop"]));
}
if (levelupselections.indexOf("Boosterpack:Lucky Charm,Reckless Flailing,Reckless Flailing") > -1){
  Rules.substitute("Backfire", "Healer Staff");
  Rules.substitute("Ping", rand(["Fissure@ncrmod","Sheer Cold","Guillotine"]));
  Rules.substitute("Bop,Bop,Bop", rand(["Beginner's Luck,Lucky Charm,Reckless Flailing","Trinity Charm,Zoop Zoop,Trinity Charm","Delicious Fruit,Bop Bop,Delicious Fruit"]));
}
if (levelupselections.indexOf("Boosterpack:Wind Chimes,Cyclone,Cyclone") > -1){
  Rules.substitute("Backfire", "Turbine");
  Rules.substitute("Ping", "One Way Mirror");
  Rules.substitute("Bop,Bop,Bop", "Bop Bop,Blow,Bop Bop");
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
if (levelupselections.indexOf("Boosterpack:Sticky Cauldron,Crazy Glue,Crazy Glue") > -1){
  Rules.substitute("Backfire", "Counter Spell");
  Rules.substitute("Ping", "Seize");
  Rules.substitute("Bop,Bop,Bop", rand(["Bop Bop,Parrying Dagger,Bop Bop","Hurricane,Zoop Zoop,Hurricane"]));
}