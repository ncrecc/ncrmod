//Generate the level, and then choose remixes that go well with it.
//Does some very basic markov chaining to ensure interesting answers that can react to what you've selected
Remix.reset();

//Making a function to check this because I'm dumb and keep getting it wrong
function isenemyindungeon(enemyname){
  var enemylist = getenemylistindungeon();
  if(enemylist.indexOf(enemyname) == -1) return false;
  return true;
}

function preventclashes(){
  //Generic setup: define some remixes that should never occur at the same time
  
  Remix.preventclash(['Kraken?', 'Sorceress?']); //the former effectively negates the latter due to how blind currently works with ai
  Remix.preventclash(['Skeleton?', 'Rhino Beetle?']); //both directly deal damage to you. probably cruel
  Remix.preventclash(['Marshmallow?', 'The Witch?']); //can't have multiple restrictions on your rolls
  Remix.preventclash(['Sorceress?', 'Cowboy?']); //neither can the enemy
  Remix.preventclash(['Rat King?', 'Lady Luck']); //one upgrades a random enemy equipment, one upgrades all enemy equipment. redundancy is bad. redundancy is bad
  Remix.preventclash(['Singer?', 'The Witch?']); //singer? effectively negates dice range/stack rules since dice are immediately rerolled ignoring the normal range/stack
  Remix.preventclash(['Singer?', 'Marshmallow?']); //see above
  Remix.preventclash(['Wisp?', 'Bounty Hunter?']); //bad idea. literally only one enemy in the game cares about vanish, and vanish equipment is relatively rare in ncrmod (probably rarer than it ought to be), this along with shock equipment being uncommon means you never really see bounty hunter? do its thing
  Remix.preventclash(['Magician?', 'Loud Bird?']); //magician swaps your limit to a random limit every turn. loud bird permanently swaps your limit break to its weakened version.
  
  Remix.preventclash(['Lady Luck', 'Rat King']); //Upgraded equipment + super enemies don't work together
  Remix.preventclash(['Snowman', 'Baby Squid', 'Fireman']); //More than one status effect dealer is messy
  Remix.preventclash(['Singer', 'Bounty Hunter']); //Avoid more than one dice roll rule change for the player
  Remix.preventclash(['Vacuum', 'Drake', 'Aoife?']); //vacuum and drake both increase enemy health, and aoife? periodically bestows shield
  Remix.preventclash(['Skeleton', 'Scathach']); //This isn't a fun combination, best to prevent it
  Remix.preventclash(['The Robot', 'Robobot']); //Robobot is a CPU rule, which doesn't work in YCYL
  
  Remix.preventclash(['The Thief?', 'The Thief']); //two skillcard changes
  Remix.preventclash(['The Inventor?', 'The Inventor']); //i don't actually know if blind inspiration breaks with multiple gadgets but let's just assume it does
  Remix.preventclash(['Hothead', 'Fireman?']); //both ignite a dice. might not break things but it is pretty silly
  Remix.preventclash(['Kraken?', 'Baby Squid']); //kraken? blinds all dice, baby squid blinds a single dice
  Remix.preventclash(['Wizard', 'Cornelius?']); //mean & redundant
  Remix.preventclash(['Rotten Apple?', 'Cornelius']); //-10 max hp plus a rule that deducts 1 max hp after each fight is probably cruel
  Remix.preventclash(['Skeleton?', 'Cornelius']); //"take 10 damage immediately" & -10 max hp. mean
  Remix.preventclash(['Singer?', 'Singer']); //the former negates the latter, mostly
  Remix.preventclash(['Singer?', 'The Witch?']); //again, dice range/stack negation
  Remix.preventclash(['Singer?', 'Marshmallow?']); //^
  Remix.preventclash(['Singer?', 'Bounty Hunter']); //could actually probably make singer? work for bounty hunter and marshmallow? by having it reroll according to *the player's dice range* rather than fair 1/2/3/4/5/6. how do you access dice range instead of just changing it tho (ed: Rules.actualdicerange, don't really care though.)
  Remix.preventclash(['Copycat?', 'Val']); //both involve item swaps. just in case
  Remix.preventclash(['Wisp?', 'Wisp']); //when you have vanish all (i.e. regular vanish), being inflicted with finite vanish has no effect
  //Remix.preventclash(['Keymaster?', 'Crystalina']); //if this is really a problem someone else will point it out eventually
  Remix.preventclash(['Wisp?', 'Marshmallow']); //doesn't make the game explode, but very odd behavior: https://github.com/TerryCavanagh/diceydungeons.com/issues/1891
  Remix.preventclash(['Wisp?', 'Bounty Hunter?']); //bad idea. literally only one enemy in the game cares about vanish, and vanish equipment is relatively rare in ncrmod (probably rarer than it ought to be), this along with shock equipment being uncommon means you never really see bounty hunter? do its thing
  Remix.preventclash(['Magician?', 'Loud Bird?']); //magician swaps your limit to a random limit every turn. loud bird permanently swaps your limit break to its weakened version.
  Remix.preventclash(['Space Marine', 'Sneezy?']); //countdown speed increasing messes up sneezy? determining which countdowns would not be activated by the inserted dice
  Remix.preventclash(['Warlock', 'Warlock?']); //redundant for obvious reasons
  Remix.preventclash(['The Robot?', 'The Robot']); //a rule that affects your jackpot options does nothing once you can't jackpot anymore
  Remix.preventclash(['Drain Monster?', 'Drain Monster']); //very silly (!!!), and drain monster probably causes frequent problems with drain monster?.

  //Don't have both Warlock and a remix that changes to PU rules...
  //...however, two PU changes are fine (e.g. Banshee + Wicker Man)
  Remix.preventclash(['Warlock', 'Banshee']); 
  Remix.preventclash(['Warlock', 'Wicker Man']);
  Remix.preventclash(['Warlock', 'Yeti']);
  Remix.preventclash(['Warlock', 'Gardener']);
  Remix.preventclash(['Warlock', 'Drain Monster']); //Drain Monster rule doesn't work that well with alt poison
  Remix.preventclash(['Warlock?', 'Banshee']); 
  Remix.preventclash(['Warlock?', 'Wicker Man']);
  Remix.preventclash(['Warlock?', 'Yeti']);
  Remix.preventclash(['Warlock?', 'Gardener']);
  Remix.preventclash(['Warlock?', 'Drain Monster']);
}

function fillstandardlist(){
  var standardlist = ['Snowman', 'Baby Squid', 'Rat King', 'Hothead', 'Fireman', 'Vacuum', 'Slime', 'Aurora?', 'Banshee?', 'Fireman?', 'Alchemist?'];
  var player = getplayername();
  if(player != 'Thief') standardlist.push('Keymaster?'); //conventional thief actively benefits from keymaster?
  if(player != 'Robot') standardlist.push('Singer'); //Robot shouldn't get Singer
  if(player == 'Robot') standardlist.push('Robobot'); //Robot only remix
  if(player == 'Warrior') standardlist.push('Keymaster'); //Warrior's more likely to get Keymaster
  if(player == 'Witch') standardlist.push('The Witch'); //Witch only remix, can appear commonly!

  if(isenemyindungeon('Buster')){
    standardlist.push('Buster');
  }
  
  if(!isenemyindungeon('Scathach')){
    standardlist.push('Cowboy'); //Don't offer the Cowboy rule if Scathach is the boss
  }
  
  if(player == 'Robot'){
    if(!isenemyindungeon('Wisp')) standardlist.push('Wisp'); //Robot should be *more* likely to get Wisp
    
    /*
    To do: implement The Robot rule for v1.9 (still a Work in Progress)
    if(!isenemyindungeon('Baby Squid') 
    && !isenemyindungeon('Kraken')  
    && !isenemyindungeon('Drake') 
    && !isenemyindungeon('Vacuum')
    && !isenemyindungeon('Scathach')
    && !isenemyindungeon('Copycat')){
      //Unfortunately, You Choose You Lose can't handle blind yet, so we can only consider this rule
      //if there are NO blinding enemies in the level. Also including Copycat for what's probably a 
      //good reason that I don't remember right now.
      standardlist.push('The Robot'); 
    }
    */
  }
  
  standardlist = shuffle(standardlist);
  return standardlist;
}

function fillearlytwists(){
  var earlytwists = ['Wolf Puppy', 'Mimic', 'Cactus', 'Rose', 'Pirate', 'Rat King?'];
  //Don't offer the Warlock rule change if Drain Monster is in the Dungeon,
  //since Drain Monster doesn't work in Parallel Universe
  if(!isenemyindungeon('Drain Monster')) earlytwists.push('Warlock');
  if(!isenemyindungeon('Drain Monster')) earlytwists.push('Warlock?');
  //Thief, Jester and Warrior *can* get keymaster, but it's in the veryrare list or standard lists instead
  var player = getplayername();
  if(player != 'Thief' && player != 'Jester' && player != 'Warrior') earlytwists.push('Keymaster'); 
  if(player == 'Thief') earlytwists.push('The Thief'); //Finders Keepers rules
  if(player == 'Inventor') earlytwists.push('The Inventor'); //PU Scrap rules
  if(player == 'Thief') earlytwists.push('The Thief?'); //uptick
  if(player == 'Inventor') earlytwists.push('The Inventor?'); //double scrap
  if(player == 'Robot') earlytwists.push('The Robot?'); //less jackpot rewards
  if(player == 'Witch') earlytwists.push('The Witch?'); //countdown
  //jester's is a midtwist. because i said so
  //if(player == 'Warrior') earlytwists.push('The Warrior?'); //stop shifting skillcard
  
  earlytwists = shuffle(earlytwists);
  return earlytwists;
}

function fillmidtwists(){
  var midtwists = ['Alchemist', 'Mimic?', 'Wizard?', 'Rotten Apple?', 'Cowboy?', 'Magician?', 'Sneezy?']; 
  var player = getplayername();
  
  if(player == 'Jester') midtwists.push('The Jester?'); //swap pu cards with normal cards & vice-versa. midtwist because you're more likely to be in possession of backup cards by then
  if(player != 'Jester' && player != 'Witch' && player != 'Robot') midtwists.push('Marshmallow?'); //jester and witch would get screwed over hard by this, and it wouldn't even make sense for robot. actually i don't play witch so i'm not sure how hard she would be affected by this? but it sounds like it would majorly limit her start-of-turn options
  if(chance(33)) { if(chance(50)) midtwists.push('Ned?'); else midtwists.push('Val?'); } //ned and val are equally likely, so the optimal strategy is never just to only ever cross floors after putting equipment you like in the backpack/putting equipment you want upgraded in the equipped grid. also goes in midtwists instead of veryrare because this is probably not something you'd want to get early on
  if(chance(33)) { midtwists.push('Yolanda?'); } //yolanda is also a midtwist as getting it later on probably makes it less likely you'll accidentally go broke
  
  if(player != 'Robot' && player != 'Jester'){ 
    //Magician can't handle Robot's locked slots, e.g. Short Circuit, Ruby Weapon
    //It also causes problems for Call for Backup cards for Jester
    midtwists.push('Magician'); 
  }
  
  if(!isenemyindungeon('Scathach')){
    midtwists.push('Wizard'); //Don't offer the Wizard rule if Scathach is the boss
  }
  
  if(!isenemyindungeon('Cornelius')){
    midtwists.push('Space Marine'); //Don't offer the Space Marine rule if Cornelius is in the level, it's a bit cruel
  }
  if(chance(33)) midtwists.push('Loud Bird'); //Make this a bit rarer
  if(chance(33)) midtwists.push('Scathach'); //Make this a bit rarer
  
  midtwists = shuffle(midtwists);
  return midtwists;
}

function filllatelist(){
  var latelist = ['Sorceress', 'Bully', 'Bounty Hunter', 'Kraken', 'Buster?', 'Aoife?', 'Singer?'];
  
  var player = getplayername();
  
  if(player == 'Jester' || player == 'Inventor') latelist.push('Handyman?'); //blueprints aren't as useful to other classes as they are to jester and inventor
  if(player != 'Jester' && player != 'Robot') latelist.push('Scathach?'); //shouldn't silenece these two!
  
  if(player == 'Witch' || player == 'Jester'){ //Witch and Jester get offered Paper Knight in the late list
    latelist.push('Paper Knight');
  }else if(player != 'Robot'){ //Everyone else (except Robot) gets offered either Skeleton or Paper Knight
    latelist.push(pick(['Skeleton', 'Paper Knight']));
  }

  if(player == 'Thief') latelist.push('Crystalina'); //Thief is more likely to get Crystalina
  if(player == 'Warrior') latelist.push('Sneezy'); //Warrior is more likely to get Sneezy
  
  latelist = shuffle(latelist);
  return latelist;
}

function fillveryhardlist(){
  var veryhardlist = ['Cornelius', 'Drake', 'Madison', 'Beatrice', 'Rhino Beetle', 'Vacuum?', 'Loud Bird?', 'Skeleton?'];
  
  var player = getplayername();
  
  if(player != 'Jester') veryhardlist.push('Rhino Beetle?'); //rhino beetle would screw over jester whenever they use their limit break
  
  if(!isenemyindungeon('Scathach')){ //this would be mean, like wizard rule
    veryhardlist.push('Cornelius?');
  }
  
  if(isenemyindungeon('Beatrice')){
    veryhardlist.push('Handyman');
  }
  
  if(!isenemyindungeon('Drake')){
    veryhardlist.push("Frog");
  }
  
  veryhardlist = shuffle(veryhardlist);
  return veryhardlist;
}

function fillveryrare(){
  //Some remixes are very game defining, and it's better if they only come up very occasionally
  var veryrare = ['Sticky Hands', 'Sorceress?', 'Kraken?', 'Warlock?'];
  var player = getplayername();
  
  if(player != 'Witch') veryrare.push('Copycat?'); //witch can *only* have size 1 equipment!
  
  if(player != 'Robot' && !isenemyindungeon('Wisp')) veryrare.push('Wisp'); //Robot is offered Wisp elsewhere
  if(player != 'Thief') veryrare.push('Crystalina'); //Thief is offered Crystalina elsewhere
  if(player != 'Warrior') veryrare.push('Sneezy'); //Warrior is offered Sneezy elsewhere

  if(player == 'Thief' || player == 'Jester') veryrare.push('Keymaster'); 
  if(player != 'Witch' && player != 'Jester') veryrare.push('Ned'); //Jester and Witch shouldn't get Ned, Val or Yolanda
  if(player != 'Witch' && player != 'Jester') veryrare.push('Yolanda'); //Jester and Witch shouldn't get Ned, Val or Yolanda
  if(player != 'Witch' && player != 'Jester'){
    if(!isenemyindungeon('Drake')){ //Don't offer Val if Drake is the boss
      veryrare.push('Val'); //Jester and Witch shouldn't get Ned, Val or Yolanda  
    }
  }
  
  veryrare = shuffle(veryrare);
  return veryrare;
}

function addfireandicerules(standardlist, earlytwists){
  //We add Marshmallow to the early twist list if
  // - Buster or Madison is the boss
  // - Or we're fighting at *least* three of the fire/ice enemies of level 3 or higher
  //If we add Marshmallow to the early twist list, also add Wicker Man and Yeti
  var player = getplayername();
  if(isenemyindungeon('Buster') || isenemyindungeon('Madison')){
    //Witch and Jester can't support Marshmallow just yet, I still need to make sure equipment swapping
    //doesn't break on spellbooks and decks before I set it live
    if(player != 'Witch' && player != 'Jester'){
      //To increase the odds, we remove a few elements from the earlytwists
      while(earlytwists.length > 3) earlytwists.pop();
      earlytwists.push('Marshmallow');
      earlytwists = shuffle(earlytwists);
    }
    standardlist.push('Wicker Man');
    standardlist.push('Yeti');
    standardlist = shuffle(standardlist);
  }else{
    var marshmallowcount = 0;
    if(isenemyindungeon('Yeti')) marshmallowcount++;
    if(isenemyindungeon('Snowman')) marshmallowcount++;
    if(isenemyindungeon('Fireman')) marshmallowcount++;
    if(isenemyindungeon('Wisp')) marshmallowcount++;
    if(marshmallowcount >= 3){
      //Witch and Jester can't support Marshmallow just yet
      var player = getplayername();
      if(player != 'Witch' && player != 'Jester'){
        //To increase the odds, we remove a few elements from the earlytwists
        while(earlytwists.length > 3) earlytwists.pop();
        earlytwists.push('Marshmallow');
        earlytwists = shuffle(earlytwists);
      }
    }
    if(marshmallowcount >= 2){
      //Lower threshold for considering these rules
      standardlist.push('Wicker Man');
      standardlist.push('Yeti');
      standardlist = shuffle(standardlist);
    }
  }
}

function addcurserules(latelist){
  var cursecount = 0;
  if(isenemyindungeon('Banshee')) cursecount++;
  if(isenemyindungeon('Dire Wolf')) cursecount++;
  if(isenemyindungeon('Kraken')) cursecount++;
  if(isenemyindungeon('Skeleton')) cursecount++;
  if(cursecount >= 3 || isenemyindungeon('Scathach')){ //If there are more than 3 curse enemies or Scathach is the boss, offer a curse remix
    //To increase the odds of our curse remix showing up, we remove a few elements from the latelist
    while(latelist.length > 3) latelist.pop();
    latelist.push('Dire Wolf');
    latelist.push('Banshee');
    latelist = shuffle(latelist);
  }
}

function addpoisonrules(latelist){
  var poisoncount = 0;
  if(isenemyindungeon('Haunted Jar')) poisoncount++;
  if(isenemyindungeon('Rat King')) poisoncount++;
  if(isenemyindungeon('Drain Monster')) poisoncount++;
  if(isenemyindungeon('Dire Wolf')) poisoncount++;
  if(isenemyindungeon('Drain Monster')) poisoncount++;
  if(isenemyindungeon('Drake')) poisoncount++;
  if(poisoncount >= 2){
    //To increase the odds of our curse remix showing up, we remove a few elements from the latelist
    while(latelist.length > 3) latelist.pop();
    latelist.push('Haunted Jar');
    latelist.push('Drain Monster');
    latelist = shuffle(latelist);
  }
}

function addweakenrules(standardlist){
  var weakencount = 0;
  if(isenemyindungeon('Stereohead')) weakencount++;
  if(isenemyindungeon('Singer')) weakencount++;
  if(isenemyindungeon('Drain Monster')) weakencount++;
  if(isenemyindungeon('Loud Bird')) weakencount++;
  if(weakencount >= 2 || isenemyindungeon('Audrey')){ //If there are 2 or more weaken enemies or Audrey is the boss, offer the Gardener remix
    //To increase the odds of our weaken remix showing up, we remove a few elements from the standardlist
    while(standardlist.length > 4) standardlist.pop();
    standardlist.push('Gardener');
    standardlist = shuffle(standardlist);
  }
}

function addvanishrules(earlytwists){
  //We add Wisp? to the early twist list if Buster, Madison, or Wisp show up
  var player = getplayername();
  if(isenemyindungeon('Buster') || isenemyindungeon('Madison') || isenemyindungeon('Wisp')){
    //Witch and Jester can't support Marshmallow just yet, I still need to make sure equipment swapping
    //doesn't break on spellbooks and decks before I set it live
    if(player != 'Witch' && player != 'Jester'){
      //To increase the odds, we remove a few elements from the earlytwists
      while(earlytwists.length > 3) earlytwists.pop();
      earlytwists.push('Wisp?');
      earlytwists = shuffle(earlytwists);
    }
  }
}
  
function addfireshockintermingle(earlytwists) {
  //add bounty hunter? if a significant number of enemies would be different as a result of it, but not *too* many
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
}
  
function addpoisonweakenintermingle(earlytwists) {
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
}

preventclashes();
var standardlist = fillstandardlist();
var latelist = filllatelist();
var veryhardlist = fillveryhardlist();
var earlytwists = fillearlytwists();
var midtwists = fillmidtwists();
var veryrare = fillveryrare();

addweakenrules(standardlist);
addfireandicerules(standardlist, earlytwists);
addcurserules(latelist);
addpoisonrules(latelist);
addvanishrules(earlytwists);
addfireshockintermingle(earlytwists);
addpoisonweakenintermingle(earlytwists);

//Really simple first draft, shuffle all the lists, assign them randomly
earlytwists = shuffle(earlytwists);
standardlist.push(earlytwists.pop());
standardlist = shuffle(standardlist);

midtwists = shuffle(midtwists);
latelist.push(midtwists.pop());
latelist.push(midtwists.pop()); //Add an extra mid twist to the late list to make it more interesting
latelist = shuffle(latelist);

//Figure out the final rule offerings
var finaloffer2 = [standardlist.pop(), standardlist.pop(), earlytwists.pop()];

if(standardlist.indexOf('The Robot') > -1) standardlist.remove('The Robot'); //Equipment substitutions mean this ideally shouldn't appear after the first offer

//Add some stuff we don't want to appear in the first remix, e.g. curse and poison related things
var secondremixlist = [];
for(r in standardlist){
  secondremixlist.push(r);
}
if(chance(25)){
  secondremixlist.push('Rotten Apple'); //This one is brutal, keep it rare!
}
if(secondremixlist.indexOf('Rat King') > -1) secondremixlist.remove('Rat King'); //Rat King needs to appear as the first remix
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
      finaloffer2.insert(0, earlytwists.pop());
    }else{
      finaloffer2.insert(1, earlytwists.pop());
    }
  }else{
    if(chance(66)){
      finaloffer2.insert(0, veryrare.pop());
    }else{
      finaloffer2.insert(1, veryrare.pop());
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

//This remix can't appear as the third or forth remix because it
//messes with the level up rewards, so remove it
if(finaloffer4.indexOf('The Witch') > -1) finaloffer4.remove('The Witch');
if(finaloffer5.indexOf('The Witch') > -1) finaloffer5.remove('The Witch');

Remix.offer(2, '', finaloffer2);
Remix.offer(3, '', finaloffer3);
Remix.offer(4, '', finaloffer4);
Remix.offer(5, '', finaloffer5);