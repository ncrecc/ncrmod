useitempositionsforother(true); // This kludge tells the generator to use item positions for other things on the map if
                                // we don't have room for them in the normal slots. It improves the placement of various
                                // things on this mode without having to make new map files.
                                
var items = [];
var gooditems = [];
var otherstuff = [];
var goodotherstuff = [];

//Remove certain enemies that don't really work
function removeenemy(enemyname){
  if(level1enemies.indexOf(enemyname) != -1) level1enemies.remove(enemyname);
  if(level2enemies.indexOf(enemyname) != -1) level2enemies.remove(enemyname);
  if(level3enemies.indexOf(enemyname) != -1) level3enemies.remove(enemyname);
  if(level4enemies.indexOf(enemyname) != -1) level4enemies.remove(enemyname);
  if(level5enemies.indexOf(enemyname) != -1) level5enemies.remove(enemyname);
  if(level6enemies.indexOf(enemyname) != -1) level6enemies.remove(enemyname);
}

//Animations look bad/are missing
removeenemy('Kraken');       //Animation looks weird because it's cut off, blind doesn't really make sense anyway
removeenemy('Aurora');       //Doesn't make sense from reverse view, also has giveequipment issue
removeenemy('Haunted Jar');  //Animation is huge, doesn't fit on the texture
removeenemy('Madison');      //Doesn't make sense from reverse view

//Probably never going to work
removeenemy('Alchemist');    //Bear transform causes issues and distracts from the episode
removeenemy('Drake');      //Episode doesn't meaningfully have equipment, nobody could equip Wooden Stake
removeenemy('Loud Bird');    //Because the episode's dice distribution is slightly different than normal, by the time you encounter Loud Bird you only have 3 dice, not 4. Which makes them really really unfun, if not impossible.
removeenemy('Sticky Hands'); //Episode has no gold!
removeenemy('Rotten Apple'); //Can do 100 damage to Lady Luck in one blow!
removeenemy('Wisp');         //Vanish doesn't work against enemies, but if it did, it would be devestating against Lady Luck
removeenemy('Aoife');        //Aoife's tower shield badly throws off the balance of the Lady Luck fight
removeenemy('Beatrice');     //Dodge is a little too effecive against Lady Luck
removeenemy('Scathach');     //Unfortunately, Scathach with more than one dice is so overpowered as to trivialise the entire boss fight

//These ones could work with a little bit of effort, but should leave until later and do other stuff first
removeenemy('Wizard');       //Wizard is less bad thanks to lower health, but it's still very game breaking.
removeenemy('Sorceress');    //Requires a script to set equipment initially                      (could fix by having a special case in code) 
removeenemy('Copycat');      //Requires a script to set equipment initially                      (could fix by having a special case in code) 
removeenemy('Keymaster');    //Can't handle transformations, also has too much equipment         (Could fix transformations)
removeenemy('Crystalina');   //Has too much equipment, and transforms don't work                 (Could remove one crystal, fix transformations)
removeenemy('Mimic');        //Requires a before turn script to work correctly, also Mystery Box causes some problems (as above)
removeenemy('Bully');        //Once per combat items aren't handled correctly                    (Could fix once per combat items)
removeenemy('Banshee');      //Cursing Lady Luck breaks things.                                  (Could fix with alternate battle logic)
removeenemy('Skeleton');     //Cursing Lady Luck breaks things.                                  (Could fix with alternate battle logic)
removeenemy('Dire Wolf');    //Cursing Lady Luck breaks things.                                  (Could fix with alternate battle logic)
removeenemy('Snowman');      //Freezing Lady Luck breaks things.                                 (Could fix with alternate battle logic)
removeenemy('Yeti');         //Freezing Lady Luck breaks things.                                 (Could fix with alternate battle logic)
removeenemy('Paper Knight'); //Locking Lady Luck breaks things. Also, Cardboard sword status isn't saved
removeenemy('Marshmallow');  //Freezing Lady Luck breaks things.                                 (Could fix with alternate battle logic)
removeenemy('Gargoyle');     //Locking Lady Luck breaks things.                                 (Could fix with alternate battle logic)
removeenemy('Cornelius');    //This one kinda spoils the ending. Let's add special logic later to allow them to show up on repeated playthroughs.


var picktwoshops = ['ned', 'yolanda', 'val'];
shuffle(picktwoshops);
picktwoshops.pop();

//Floor 1:
otherstuff = [];
goodotherstuff = [health()];
		
addfloor("tiny")
  .addenemies([level1enemies.pop()], [level1enemies.pop()])
  .setlocation('GAMESHOW')
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();
  
//Floor 2:
otherstuff = [];
goodotherstuff = [health()];

addfloor("tiny")
  .addenemies([level2enemies.pop()], [level2enemies.pop()])
  .addotherstuff(otherstuff, goodotherstuff)
  .setlocation('GAMESHOW')
  .generate();
  
//Floor 3:
otherstuff = [health()];
var nextshop = picktwoshops.pop();
if(nextshop == 'yolanda'){
  goodotherstuff = [shop()];
}else if(nextshop == 'val'){
  goodotherstuff = [trade([],[])];
}else if(nextshop == 'ned'){
  goodotherstuff = [upgrade()];
}

addfloor("small")
  .addenemies([level3enemies.pop()], [level3enemies.pop()])
  .addotherstuff(otherstuff, goodotherstuff)
  .setlocation('GAMESHOW')
  .generate();
  
//Floor 4:
var nextshop = picktwoshops.pop();
if(nextshop == 'yolanda'){
  goodotherstuff = [health(), shop()];
}else if(nextshop == 'val'){
  goodotherstuff = [health(), trade([],[])];
}else if(nextshop == 'ned'){
  goodotherstuff = [health(), upgrade()];
}
otherstuff = [health()];

addfloor("small")
  .addenemies([level4enemies.pop()], [level5enemies.pop()])
  .addotherstuff(otherstuff, goodotherstuff)
  .setlocation('GAMESHOW')
  .generate();  

//Floor 5:
otherstuff = [health(), health()];
goodotherstuff = [health()];

addfloor("small")
  .addenemies([level5enemies.pop()], [level6enemies.pop()])
  .addotherstuff(otherstuff, goodotherstuff)
  .setlocation('GAMESHOW')
  .generate();  
  
//Floor 6:
otherstuff = [];
goodotherstuff = [];

var finalfloor = addfloor('final')
  .addenemies([], [])
  .addotherstuff(otherstuff, goodotherstuff)
  .setlocation('FINALE');  
  
finalfloor.camerax -= 280;