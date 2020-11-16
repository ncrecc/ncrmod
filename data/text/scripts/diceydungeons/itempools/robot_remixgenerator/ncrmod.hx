var brostep = rand([false,true]);
var brosteporshockhumour = rand(["Loud Brostep", "Shock Humour"]);
var murkorspec = rand(["Murk", "Spectral Cauldron"]);
var hypertension = rand(["Hyper Beam", "Tension"]);
var glueorshame = rand(["Glue Gun", "Shame"]);
var egoorbreaking = rand(["Ego Stroke", "Breaking Point"]);

var sizetwo = ["Sharpened Rosary", "Strange Parcel", "Blast Processing", "Spin Attack", "Snatch", "Throwing Axe", "Extreme Detail Bat", "Crystallize", "Two Handed Spatula", "Powerball", "Gyrate Hook"];
if(!brostep) { sizetwo.push(rand(["Coil", "Jacob's Ladder"])); }
shuffle(sizetwo);
if(chance(33)) { sizetwo.push("Wand of Wishing"); shuffle(sizetwo); }

var commonlist_basic = ["Toolbox@flip", "Disk Eject", "Pocket Protector", "Welder", "Innovate"];
var commonlist_advanced = ["Talent Contest", "Blockbuster"];
var floor2basic = ["Security Hole", "Popular Vote", murkorspec, "Pummel"];
var floor2advanced = [sizetwo.pop(), "Smart Spike", "Baby's First Counting Book"];
if(brostep) floor2advanced.push(brosteporshockhumour);
var floor2items = ["Heaven on Earth"];
var floor3basic = [sizetwo.pop(), "Crysis", "Reverse Emulation", "Technology", "Rosepetal Blade", "Decimate"];
var floor3advanced = [sizetwo.pop(), sizetwo.pop(), hypertension, "Penultima Weapon", glueorshame, "Global Thermonuclear War", "Manual Repair", "Handcuffs", "Talent Contest", egoorbreaking];
var tradeoffer = [];
var traderesult = [sizetwo.pop()];
var vampireitem = ["Steel Sword"];
var myitempools = [commonlist_basic,commonlist_advanced,floor2basic,floor2advanced,floor2items,floor3basic,floor3advanced,tradeoffer,traderesult,vampireitem];
return myitempools;