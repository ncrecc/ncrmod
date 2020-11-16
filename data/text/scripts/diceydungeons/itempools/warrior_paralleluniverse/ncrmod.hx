var dicemanip = ["Keyhole", "Innovate", "Virtue Grip"]; //new manip, essentially chance 100
var chance75manip = ["Crucible", "Illuminate", "Cauldron", "Table Slam", "Spanner", "Gold Cauldron", "Silver Cauldron", "Gumball Machine", "Ungeradedice", "Giant Spatula"]; //specific dice manip that not many classes receive
var chance50manip = ["Doppeldice", "Hall of Mirrors", "Berlin Key"]; //common/simple dice manip that warrior doesn't get
var chance25manip = ["Bump", "Spatula", "Sine Wave"]; //already warrior dice manip

function chancepush(pushto,pushfrom,pushchance) {
	for(item in pushfrom) {
		if(pushchance) {
			pushto.push(item);
		}
	}
}

chancepush(dicemanip,chance75manip,75);
chancepush(dicemanip,chance50manip,50);
chancepush(dicemanip,chance25manip,25);
dicemanip = shuffle(dicemanip);

var newdicemanipulator = [dicemanip.pop()];

var warriorshops = [rand(["Shiked Spield@sword", "Shiked Spield@shield"]), "Sharp Straw", "Retreat", "Warhammer", "Swing Me Another 6", "Pocket Protector", "Big Knife", "Vanity Mirror", "Sleight of Hand@ncrmod", "Wail Bat", "Energy Ball", "Whipcrack", "Circuit Breaker", "Pummel"];
if(chance(25)) { warriorshops.remove("Circuit Breaker"); warriorshops.push("Strange Apparatus"); }
var strangeshop = [dicemanip.pop(), "Uberbump", rand(["Humility", "Charity"]), "Bizarro Blade", "Doppeldfire", "Undermine", chance(80) ? "Fuel Bat" : "Katsuhiro Bat"];
var awesomelist = ["Shiny Nunchucks", "Heavenly Nectar", "Bone Club", "Sap Gloves", "Halligan Bar", "Smart Spike", "Sceptre"];
var floor2gooditem = [dicemanip.pop()];
if(dicemanip.length == 0) dicemanip.push("Hall of Mirrors");
var floor3item = [dicemanip.pop(), "Rainmaking", "Kale Bat", "Snare Drum", "Ice Nine", "Echochamber", "Plasma Rifle", "Shame"];
var floor5item = ["Biohazard", "Russian Roulette", "Wrongo", "Strychnine", "Red Hot Dagger", "Spin Attack"];
var vampireitem = ["Steel Sword"];

var myitempools = [warriorshops, strangeshop, awesomelist, floor2gooditem, floor3item, floor5item, vampireitem];
return myitempools;