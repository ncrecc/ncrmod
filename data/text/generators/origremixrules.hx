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
  Remix.preventclash(['Lady Luck', 'Rat King']); //Upgraded equipment + super enemies don't work together
  Remix.preventclash(['Snowman', 'Baby Squid', 'Fireman']); //More than one status effect dealer is messy
  Remix.preventclash(['Singer', 'Bounty Hunter']); //Avoid more than one dice roll rule change for the player
  Remix.preventclash(['Vacuum', 'Drake']); //These both increase enemy health
  Remix.preventclash(['Skeleton', 'Scathach']); //This isn't a fun combination, best to prevent it
  Remix.preventclash(['The Robot', 'Robobot']); //Robobot is a CPU rule, which doesn't work in YCYL
  Remix.preventclash(['Slime', 'Rhino Beetle']); //They both deal damage at the start of a turn, nasty combo

  //Don't have both Warlock and a remix that changes to PU rules...
  //...however, two PU changes are fine (e.g. Banshee + Wicker Man)
  Remix.preventclash(['Warlock', 'Banshee']); 
  Remix.preventclash(['Warlock', 'Wicker Man']);
  Remix.preventclash(['Warlock', 'Yeti']);
  Remix.preventclash(['Warlock', 'Slime']); //Implementation is buggy here
  Remix.preventclash(['Warlock', 'Drain Monster']); //Drain Monster rule doesn't work that well with alt poison
}

function fillstandardlist(){
  var standardlist = ['Snowman', 'Baby Squid', 'Rat King', 'Hothead', 'Fireman', 'Vacuum', 'Slime'];
  var player = getplayername();
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
    standardlist.push('The Robot');
  }
  
  standardlist = shuffle(standardlist);
  return standardlist;
}

function fillearlytwists(){
  var earlytwists = ['Wolf Puppy', 'Mimic', 'Cactus', 'Rose', 'Pirate'];
  //Don't offer the Warlock rule change if Drain Monster is in the Dungeon,
  //since Drain Monster doesn't work in Parallel Universe
  if(!isenemyindungeon('Drain Monster')) earlytwists.push('Warlock'); 
  //Thief, Jester and Warrior *can* get keymaster, but it's in the veryrare list or standard lists instead
  var player = getplayername();
  if(player != 'Thief' && player != 'Jester' && player != 'Warrior') earlytwists.push('Keymaster'); 
  if(player == 'Thief') earlytwists.push('The Thief'); //Finders Keepers rules
  if(player == 'Inventor') earlytwists.push('The Inventor'); //PU Scrap rules
  
  earlytwists = shuffle(earlytwists);
  return earlytwists;
}

function fillmidtwists(){
  var midtwists = ['Alchemist']; 
  var player = getplayername();
  
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
  var latelist = ['Sorceress', 'Bully', 'Bounty Hunter', 'Kraken'];
  
  var player = getplayername();
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
  var veryhardlist = ['Cornelius', 'Drake', 'Madison', 'Beatrice', 'Rhino Beetle'];
  
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
  var veryrare = ['Sticky Hands'];
  var player = getplayername();
  
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
    standardlist = shuffle(standardlist);
  }else{
    var fireenemycountcount = 0;
    var iceenemycountcount = 0;
    
    if(isenemyindungeon('Marshmallow')) { iceenemycountcount++; fireenemycountcount++; }
    if(isenemyindungeon('Aurora')) { iceenemycountcount++; fireenemycountcount++; }
    
    if(isenemyindungeon('Yeti')) iceenemycountcount+=2;
    if(isenemyindungeon('Snowman')) iceenemycountcount+=2;
    if(isenemyindungeon('Banshee')) iceenemycountcount+=2;
    
    if(isenemyindungeon('Fireman')) fireenemycountcount+=2;
    if(isenemyindungeon('Wisp')) fireenemycountcount+=2;
    if(isenemyindungeon('Wicker Man')) fireenemycountcount+=2;
    
    if(fireenemycountcount + iceenemycountcount >= 6){
      //Witch and Jester can't support Marshmallow just yet
      if(player != 'Witch' && player != 'Jester'){
        //To increase the odds, we remove a few elements from the earlytwists
        while(earlytwists.length > 3) earlytwists.pop();
        earlytwists.push('Marshmallow');
        earlytwists = shuffle(earlytwists);
      }
    }
    
    //Lower threshold for considering these rules
    if(fireenemycountcount >= 5){
      standardlist.push('Wicker Man');
      standardlist = shuffle(standardlist);
    }
    
    if(iceenemycountcount >= 5){
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
  if(isenemyindungeon('Drake')) poisoncount+=2;
  if(poisoncount >= 2){
    //To increase the odds of our curse remix showing up, we remove a few elements from the latelist
    while(latelist.length > 3) latelist.pop();
    latelist.push('Haunted Jar');
    latelist.push('Drain Monster');
    latelist = shuffle(latelist);
  }
}

preventclashes();
var standardlist = fillstandardlist();
var latelist = filllatelist();
var veryhardlist = fillveryhardlist();
var earlytwists = fillearlytwists();
var midtwists = fillmidtwists();
var veryrare = fillveryrare();

addfireandicerules(standardlist, earlytwists);
addcurserules(latelist);
addpoisonrules(latelist);

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