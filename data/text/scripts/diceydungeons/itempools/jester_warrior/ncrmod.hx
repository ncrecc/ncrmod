var jesterwarriorshops = ["Whipcrack", "Circuit Breaker","Shiny Nunchucks", "Sap Gloves", "Smart Spike", "Sceptre"];
if(chance(25)) { jesterwarriorshops.remove("Circuit Breaker"); jesterwarriorshops.push("Strange Apparatus"); }
var strangeshop = ["Russian Roulette", "Uberbump", "Mars Fly Trap", "Spin Attack", "Sleight of Hand@ncrmod", "Prod", "Energy Ball", chance(80) ? "Snare Drum" : "Loud Yelling", "Tap"];
var weaklist_attack = [
  "Breaking Point,Innovate",
  "Sap Gloves,Buzzsaw",
  "Bass Guitar,Electric Guitar"
];
var weaklist_manipulate = [
  "Leather Armor,Doppeldfire",
  "Vise Grip,Virtue Grip",
  "Spatula,Giant Spatula",
  "Silver Cauldron,Gold Cauldron"
];
var awesomelist = [
  "Sharp Straw,Sharp Straw",
  "Swing Me Another 6,Spear",
  "Rainmaking,Virtue Grip",
  "Vanity Mirror,Innovate"
];
var vampireitem = ["Steel Sword"];

var myitempools = [jesterwarriorshops,strangeshop,weaklist_attack,weaklist_manipulate,awesomelist,vampireitem];
return myitempools;