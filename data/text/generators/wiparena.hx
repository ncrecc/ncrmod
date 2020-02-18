//Floor 1
addfloor('go_down_now')
  .setlocation('NCRARENA')
  .generate();
  
/*
//Floor 2:
addfloor('go_down_now')
  .setlocation('NCRARENA')
  .generate();

//Floor 3:
addfloor('go_down_now')
  .setlocation('NCRARENA')
  .generate();
  
//Floor 4:
addfloor('go_down_now')
  .setlocation('NCRARENA')
  .generate();
  
//Floor 5:
addfloor('go_down_now')
  .setlocation('NCRARENA')
  .generate();
*/

//Floor 6:
var lastfloor = addfloor('arena_thing');
for (node in lastfloor.nodes) {
  node.x += 220;
  node.y -= 110;
}
lastfloor
  .setlocation('NCRGAMESHOW')
  .addotherstuff([teammate("Warrior"), teammate("Thief"), teammate("Witch"), teammate("Robot")], [])
  .addenemies(['Aoife'], [])
  .generate();
for (node in lastfloor.nodes) {
  node.x -= 220;
  node.y += 110;
}