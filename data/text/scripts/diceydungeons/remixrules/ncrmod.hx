var player = getplayername();

function isenemyindungeon(enemyname){
  var enemylist = getenemylistindungeon();
  if(enemylist.indexOf(enemyname) == -1) return false;
  return true;
}

var preventclashes = [
  ['Kraken?', 'Sorceress?'], //the former effectively negates the latter due to how blind currently works with ai
  ['Skeleton?', 'Rhino Beetle?'], //both directly deal damage to you. probably cruel
  ['Marshmallow?', 'The Witch?'], //can't have multiple restrictions on your rolls
  ['Sorceress?', 'Cowboy?'], //neither can the enemy
  ['Rat King?', 'Lady Luck'], //one upgrades a random enemy equipment, one upgrades all enemy equipment. redundancy is bad. redundancy is bad
  ['Singer?', 'The Witch?'], //singer? effectively negates dice range/stack rules since dice are immediately rerolled ignoring the normal range/stack
  ['Singer?', 'Marshmallow?'], //see above
  ['Wisp?', 'Bounty Hunter?'], //bad idea. literally only one enemy in the game cares about vanish, and vanish equipment is relatively rare in ncrmod (probably rarer than it ought to be), this along with shock equipment being uncommon means you never really see bounty hunter? do its thing
  ['Magician?', 'Loud Bird?'], //magician swaps your limit to a random limit every turn. loud bird permanently swaps your limit break to its weakened version.
  ['The Thief?', 'The Thief'], //two skillcard changes
  ['The Inventor?', 'The Inventor'], //i don't actually know if blind inspiration breaks with multiple gadgets but let's just assume it does
  ['Hothead', 'Fireman?'], //both ignite a dice. might not break things but it is pretty silly
  ['Kraken?', 'Baby Squid'], //kraken? blinds all dice, baby squid blinds a single dice
  ['Wizard', 'Cornelius?'], //mean & redundant
  ['Rotten Apple?', 'Cornelius'], //-10 max hp plus a rule that deducts 1 max hp after each fight is probably cruel
  ['Skeleton?', 'Cornelius'], //"take 10 damage immediately" & -10 max hp. mean
  ['Singer?', 'Singer'], //the former negates the latter, mostly
  ['Singer?', 'Bounty Hunter'], //could actually probably make singer? work for bounty hunter and marshmallow? by having it reroll according to *the player's dice range* rather than fair 1/2/3/4/5/6. how do you access dice range instead of just changing it tho (ed: Rules.actualdicerange, don't really care though.)
  ['Marshmallow?', 'Bounty Hunter'], //again, two dice range modifications
  ['Copycat?', 'Val'], //both involve item replacements. just in case
  ['Wisp?', 'Wisp'], //when you have vanish all (i.e. regular vanish), being inflicted with finite vanish has no effect
  //['Keymaster?', 'Crystalina'], //if this is really a problem someone else will point it out eventually
  ['Wisp?', 'Marshmallow'], //doesn't make the game explode, but very odd behavior: https://github.com/TerryCavanagh/diceydungeons.com/issues/1891
  ['Space Marine', 'Sneezy?'], //countdown speed increasing messes up sneezy? determining which countdowns would not be activated by the inserted dice
  ['Warlock', 'Warlock?'], //redundant for obvious reasons
  ['The Robot?', 'The Robot'], //a rule that affects your jackpot options does nothing once you can't jackpot anymore
  ['Drain Monster?', 'Drain Monster'] //very silly (!!!), and drain monster probably causes frequent problems with drain monster?.
];

var veryrare = ['Sorceress?', 'Kraken?', 'Warlock?'];
if(player != 'Witch' && player != 'Jester' && !isenemyindungeon('Scathach')) veryrare.push('Copycat?'); //doesn't work with witch and jester, and turns scathach into a pushover

veryrare = shuffle(veryrare);

var standardlist = ['Aurora?', 'Banshee?', 'Fireman?', 'Alchemist?'];
if(player != 'Thief') standardlist.push('Keymaster?'); //conventional thief actively benefits from keymaster?

var secondremixlist = [];

var earlytwists = ['Rat King?'];
if(chance(50)) { //these are too common
if(player == 'Thief') earlytwists.push('The Thief?'); //uptick
if(player == 'Inventor') earlytwists.push('The Inventor?'); //double scrap
if(player == 'Robot') earlytwists.push('The Robot?'); //less jackpot rewards
if(player == 'Witch') earlytwists.push('The Witch?'); //countdown
if(player == 'Jester') earlytwists.push('The Jester?'); //0.13 mechanics
if(player == 'Warrior') earlytwists.push('The Warrior?'); //shifting skillcard
}

if(player != 'Witch' && player != 'Jester'){ 
  //wisp? follows similar logic to marshmallow but more inclusive since there are no vanish-only enemies
  
  if(isenemyindungeon('Buster') || isenemyindungeon('Madison')){
    earlytwists.push('Wisp?');
  }else{
    var wispcount = 0;
    if(isenemyindungeon('Fireman')) wispcount++;
    if(isenemyindungeon('Wisp')) wispcount += 2;
    if(isenemyindungeon('Wicker Man')) wispcount++;
    if(wispcount >= 3){
      earlytwists.push('Wisp?');
    }
  }
}

//should we include sneezy? ?
if(player != 'Jester'){ //sneezy? benefits jester muuuuch less than other classes
	var sneezecount = 0;
	//gather countdown enemies. enemies who would particularly benefit from this rule count as two enemies, and bosses count as 3
	if(isenemyindungeon('Buster')) sneezecount += 3;
	if(isenemyindungeon('Beatrice')) sneezecount += 3;
	if(isenemyindungeon('Sticky Hands')) sneezecount++;
	if(isenemyindungeon('Dryad')) sneezecount++;
	if(isenemyindungeon('Wicker Man')) sneezecount++;
	if(isenemyindungeon('Sneezy')) sneezecount += 2;
	if(isenemyindungeon('Aurora')) sneezecount += 2;
	if(isenemyindungeon('Alchemist')) sneezecount += 2;
	if(isenemyindungeon('Vampire')) sneezecount++;
	if(isenemyindungeon('Rat King')) sneezecount += 2;
	if(isenemyindungeon('Crystalina')) sneezecount += 2;
	if(isenemyindungeon('Rotten Apple')) sneezecount++;
	if(isenemyindungeon('Cornelius')) sneezecount++;
	if(isenemyindungeon('Wisp')) sneezecount++;
	if(isenemyindungeon('Singer')) sneezecount++;
	if(isenemyindungeon('Audrey')) sneezecount++;
	if(isenemyindungeon('Aoife')) sneezecount++;
	if(isenemyindungeon('Cowboy')) sneezecount++;
	if(isenemyindungeon('Handyman')) sneezecount++;
	if(isenemyindungeon('Kraken')) sneezecount++;
	if(sneezecount > 5 && sneezecount < 15) { //if too many enemies would benefit from this rule, drop it. don't be cruel
		earlytwists.push('Sneezy?');
	}
}

//should we include bounty hunter? ???
var bountycounty = 0;
if(isenemyindungeon('Handyman')) bountycounty++;
if(isenemyindungeon('Pirate')) bountycounty++;
if(isenemyindungeon('Marshmallow')) bountycounty++;
if(isenemyindungeon('Fireman')) bountycounty++;
if(isenemyindungeon('Wisp')) bountycounty++;
if(isenemyindungeon('Wicker Man')) bountycounty++;
if(isenemyindungeon('Aurora')) bountycounty++;
if(isenemyindungeon('Buster')) bountycounty += 2;
if(isenemyindungeon('Beatrice')) bountycounty += 2;
if(isenemyindungeon('Madison')) bountycounty += 2;
if(bountycounty >= 4 && bountycounty <= 7){
  earlytwists.push('Bounty Hunter?');
}

//what about drain monster?? ????
var draincount = 0;
if(isenemyindungeon('Stereohead')) draincount++;
if(isenemyindungeon('Singer')) draincount++;
if(isenemyindungeon('Loud Bird')) draincount++;
if(isenemyindungeon('Dire Wolf')) draincount++;
if(isenemyindungeon('Haunted Jar')) draincount++;
if(isenemyindungeon('Audrey')) draincount += 2;
if(isenemyindungeon('Drake')) draincount++;
if(draincount >= 3 && draincount <= 6){
  earlytwists.push('Drain Monster?');
}
		
var midtwists = ['Mimic?', 'Wizard?', 'Rotten Apple?', 'Cowboy?', 'Magician?'];
if(player != 'Jester' && player != 'Witch' && player != 'Robot') midtwists.push('Marshmallow?'); //jester and witch would get screwed over hard by this, and it wouldn't even make sense for robot. actually i don't play witch so i'm not sure how hard she would be affected by this? but it sounds like it would majorly limit her start-of-turn options
if(chance(33)) { if(chance(50)) midtwists.push('Ned?'); else midtwists.push('Val?'); } //ned and val are equally likely, so the optimal strategy is never just to only ever cross floors after putting equipment you like in the backpack/putting equipment you want upgraded in the equipped grid. also goes in midtwists instead of veryrare because this is probably not something you'd want to get early on
if(chance(33)) { midtwists.push('Yolanda?'); } //yolanda is also a midtwist as getting it later on probably makes it less likely you'll accidentally go broke

var veryhardlist = ['Vacuum?', 'Cornelius?', 'Loud Bird?', 'Skeleton?'];
if(player != 'Jester') veryhardlist.push('Rhino Beetle?'); //rhino beetle would screw over jester whenever they use their limit break

//Really simple first draft, shuffle all the lists, assign them randomly
earlytwists = shuffle(earlytwists);
standardlist.push(earlytwists.pop());
standardlist = shuffle(standardlist);

var latelist = ['Aoife?', 'Singer?'];
if(player != 'Jester') latelist.push('Buster?'); //managed to get the jester deck to progress properly when a card is errored, but even then this practically does nothing to jester. at worst a nice card you were hoping to see later in the pile gets errored, at best something weak like zoop zoop gets errored
if(player == 'Jester' || player == 'Inventor') latelist.push('Handyman?'); //blueprints aren't as useful to other classes as they are to jester and inventor
if(player != 'Jester' && player != 'Robot') latelist.push('Scathach?'); 

midtwists = shuffle(midtwists);
latelist.push(midtwists.pop());
latelist.push(midtwists.pop()); //Add an extra mid twist to the late list to make it more interesting
latelist = shuffle(latelist);

veryhardlist = shuffle(veryhardlist);

//Figure out the final rule offerings
var finaloffer2 = [standardlist.pop(), standardlist.pop(), earlytwists.pop()];
//Add some stuff we don't want to appear in the first remix, e.g. curse and poison related things
for(r in standardlist){
  secondremixlist.push(r);
}

secondremixlist = shuffle(secondremixlist);
var finaloffer3 = [secondremixlist.pop(), secondremixlist.pop()];
var finaloffer4 = [latelist.pop(), latelist.pop(), latelist.pop()];
while(latelist.length > 0) veryhardlist.push(latelist.pop());
veryhardlist = shuffle(veryhardlist);
var finaloffer5 = [veryhardlist.pop(), veryhardlist.pop(), veryhardlist.pop()];

//Insert twists!
if(chance(80)){
  //80% chance of seeing a twist
  if(chance(66)){
    if(chance(33)){
      if(earlytwists.length > 0) finaloffer2.insert(0, earlytwists.pop());
    }else{
      if(earlytwists.length > 0) finaloffer2.insert(1, earlytwists.pop());
    }
  }else{
    if(chance(66)){
      if(veryrare.length > 0) finaloffer2.insert(0, veryrare.pop());
    }else{
      if(veryrare.length > 0) finaloffer2.insert(1, veryrare.pop());
    }
  }
}

//To ensure we never run out, fill up the arrays with the rest of the options
if(midtwists.length > 0) finaloffer3.push(midtwists.pop());
if(standardlist.length > 0) finaloffer2.push(standardlist.pop());
if(standardlist.length > 0) finaloffer3.push(standardlist.pop());
if(standardlist.length > 0) finaloffer2.push(standardlist.pop());
if(standardlist.length > 0) finaloffer3.push(standardlist.pop());
if(earlytwists.length > 0) finaloffer2.push(earlytwists.pop());
if(earlytwists.length > 0) finaloffer3.push(earlytwists.pop());
if(midtwists.length > 0) finaloffer4.push(midtwists.pop());
if(midtwists.length > 0) finaloffer5.push(midtwists.pop());
if(veryhardlist.length > 0) finaloffer4.push(veryhardlist.pop());
if(veryhardlist.length > 0) finaloffer5.push(veryhardlist.pop());
if(veryhardlist.length > 0) finaloffer4.push(veryhardlist.pop());
if(veryhardlist.length > 0) finaloffer5.push(veryhardlist.pop());
if(standardlist.length > 0) finaloffer4.push(standardlist.pop());
if(standardlist.length > 0) finaloffer5.push(standardlist.pop());

return [preventclashes,[finaloffer2,finaloffer3,finaloffer4,finaloffer5]];