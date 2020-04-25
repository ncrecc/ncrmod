//Floor 1
addfloor('small')
  .setlocation('NCRSPECIAL')
  .addenemies(['Magician'], [])
  .generate();
  

//Floor 2:
addfloor('go_down_now')
  .setlocation('JUNGLE')
  .generate();
/*
//Floor 3:
addfloor('go_down_now')
  .setlocation('NCRSPECIAL')
  .generate();
  
//Floor 4:
addfloor('go_down_now')
  .setlocation('NCRSPECIAL')
  .generate();
  
//Floor 5:
addfloor('go_down_now')
  .setlocation('NCRSPECIAL')
  .generate();
*/

//Floor 6:
var lastfloor = addfloor('arena_thing');
lastfloor
  .setlocation('NCRGAMESHOW')
  .addotherstuff([teammate("Warrior"), teammate("Thief"), teammate("Witch"), teammate("Robot")], [])
  .addenemies(['Beatrice'], [])
  .generate();
  
lastfloor.camerax -= 220;
lastfloor.cameray += 110;