var brostep = rand([false,true]);
var brosteporshockhumour = rand(["Loud Brostep", "Shock Humour"]);
var hypertension = rand(["Hyper Beam", "Tension"]);
var glueorshame = rand(["Glue Gun", "Shame"]);
var egoorbreaking = rand(["Ego Stroke", "Breaking Point"]);

var sizetwo = ["Sharpened Rosary", "Strange Parcel", "Spin Attack", "Snatch", "Throwing Axe", "Crystallize", "Two Handed Spatula", "Gyrate Hook"];
if(!brostep) { sizetwo.push(rand(["Coil", "Jacob's Ladder"])); }
shuffle(sizetwo);
if(chance(33)) { sizetwo.push("Wand of Wishing"); shuffle(sizetwo); }

var commonlist_basic = ["Toolbox@flip", "Pocket Protector", "Welder", "Innovate"];
var commonlist_advanced = ["Talent Contest", "Blockbuster"];
var floor2basic = ["Popular Vote"];
var floor2advanced = [sizetwo.pop(), "Smart Spike"];
if(brostep) floor2advanced.push(brosteporshockhumour);
var floor3basic = [sizetwo.pop(), "Reverse Emulation", "Technology"];
var floor3advanced = [sizetwo.pop(), sizetwo.pop(), hypertension, glueorshame, "Global Thermonuclear War", egoorbreaking];
var tradeoffer = [];
var traderesult = [sizetwo.pop()];
var vampireitem = ["Steel Sword"];
var myitempools = [commonlist_basic,commonlist_advanced,floor2basic,floor2advanced,floor3basic,floor3advanced,tradeoffer,traderesult,vampireitem];
return myitempools;