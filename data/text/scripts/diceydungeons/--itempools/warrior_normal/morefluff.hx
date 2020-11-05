var warriorshops = ["Pike", "Zweihander", "Halberd", "Chakram", "Paintbrush", "Mace", "Pavise", "Natural Charm", "Loaded Dice", "Shotgun","Boomstick", "Blooplicate", "Trowel", "Mallet", "Frosted Dirk", "Spiked Sword", "Electroplating", "Trishula", "Tomahawk","Cat O' Six Tails", "Divine Blade", "Healing Shiv", "Venomous Goop", "Really Spiky Shield", "Nether Portal", "Ornamental Shield", "Execute", "Spikemail", "Hairdryer", "Shielding Potion", "Field Dressing", "Staff", "Plague Stave", "Asklepios","Shield Toss","Draining Crystal","Saxophone","Evocation","Revoke","Explosive Shield","Karambit","Molten Staff","Lockdown","Bloodclaw","Fruit Shooter","Juggernaut","Taunting Sword","Vine Whip","Differing Thorns","Mirror Coating","Shrug","Metal Slam","Solar Panel","Wooden Mallet","Holy Fire","Spearslinger","Sludge","Icicle Fall","Reinforce","Chitin Helmet","Sneksword","Freegen","Spire Shield"]; //no need to worry about the size of this list, the script in the generator shortens it to a random smaller selection since it's larger than the vanilla list

var strangeshop = ["Heckle", "Power Through", "drowS", "Expose Weakness", "Budge", "Metallicize", "Resonator",  "Leech Seed", "Panic Button", "Jade Blade", "Malediction", "Evil Eye", "Incapacitate","Chronoblade","Diamond Wall","Convergence","Shieldsplosion","Exoskeleton","First Sit","Hyena Siren"];

var awesomelist = ["Nine Iron", "Talons", "Labrys", "Targe Charge", "Canesword", "Urumi", "Crass Knuckles","Metronome"]; 

var combos = shuffle(["Boopin' Stick","Buckler", "Lantern Shield", "Iron Fist", "Bolster", "Targe Charge"]);

var floor2gooditem = [combos.pop()];

var floor3item = ["Custard Cream", "Bolster", "Finisher", combos.pop(), combos.pop(), combos.pop()];

var floor5item = ["Shammer", "Custard Cream", "Doppliduplicateinate", "Shield Scrap"];

var vampireitem = []; //more fluff keeps wooden stake as-is

var myitempools = [warriorshops, strangeshop, awesomelist, floor2gooditem, floor3item, floor5item, vampireitem];

return myitempools;