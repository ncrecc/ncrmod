var jester_dice_pool = ["Saving Throw", "Bumpbomb", "Hijack", "Table Flip", "Luckpick", "Welder", "Slim Jim", "Innovate", "Dime", "Coldron", "Tootsie Pop"];
shuffle(jester_dice_pool);
var floor1items = [jester_dice_pool.pop()];

var jester_damage_pool = ["Operator", "Tap", "Sharpened Rosary", "Smart Spike", rand(["Bad Damage", "Cheap Shot"]), "Breaking Point", "Prod", "Magic Cyanide", "Throwing Axe", "Supervolcano", "Spin Attack", "Sharp Straw", "Bass Guitar", "Ouija Board", "Holy Water", "Mirror on a Stick", "Ice Giant"];

var finales = ["Remaster","Passivecation Program","Survival","Finale Salad","Reissue","We Watch and We Wait","Anger","Fatal Attraction"];

var floor4items = ["Gas Lamp","Spearhead", "Mirrorang", "Doppeldfire", "Distort"];
var vampireitem = ["Steel Sword,Steel Sword"];

var myitempools = [floor1items,jester_dice_pool,jester_damage_pool,finales,floor4items,vampireitem];
return myitempools;