//
//
//
// CONTAINS TRINITYCHARM/NCRECCMOD HACK
//
//
//

//Generate the level, and then choose remixes that go well with it.
//Does some very basic markov chaining to ensure interesting answers that can react to what you've selected
Remix.reset();

var player = getplayername();

//Making a function to check this because I'm dumb and keep getting it wrong
function isenemyindungeon(enemyname){
  var enemylist = getenemylistindungeon();
  if(enemylist.indexOf(enemyname) == -1) return false;
  return true;
}

//Generic setup: define some remixes that should never occur at the same time
Remix.preventclash(['Lady Luck', 'Rat King']); //Upgraded equipment + super enemies don't work together
Remix.preventclash(['Snowman', 'Baby Squid', 'Fireman']); //More than one status effect dealer is messy
Remix.preventclash(['Singer', 'Bounty Hunter']); //Avoid more than one dice roll rule change for the player
Remix.preventclash(['Warlock', 'Banshee']); //Don't have both Warlock and a remix that changes to PU rules
Remix.preventclash(['Vacuum', 'Drake']); //These both increase enemy health
Remix.preventclash(['Skeleton', 'Scathach']); //This isn't a fun combination, best to prevent it

//Some remixes are very game defining, and it's better if they only come up very occasionally
var veryrare = ['Sticky Hands'];
if(player != 'Robot') veryrare.push('Wisp'); //Robot is offered Wisp elsewhere
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

var curselist = ['Dire Wolf', 'Banshee'];
var firelist = ['Buster'];
curselist = shuffle(curselist);
firelist = shuffle(firelist);

var standardlist = ['Snowman', 'Baby Squid', 'Rat King', 'Hothead', 'Fireman', 'Vacuum', 'Slime'];
if(player != 'Robot') standardlist.push('Singer'); //Robot shouldn't get Singer
if(player == 'Robot') standardlist.push('Robobot'); //Robot only remix
if(player == 'Warrior') standardlist.push('Keymaster'); //Warrior's more likely to get Keymaster

if(isenemyindungeon('Buster')){
  standardlist.push(firelist.pop());
}

var secondremixlist = [];

var earlytwists = ['Wolf Puppy', 'Mimic', 'Cactus', 'Rose', 'Pirate', 'Warlock'];
//Thief, Jester and Warrior *can* get keymaster, but it's in the veryrare list or standard lists instead
if(player != 'Thief' && player != 'Jester' && player != 'Warrior') earlytwists.push('Keymaster'); 
if(player == 'Thief') earlytwists.push('The Thief'); //Finders Keepers rules
if(player == 'Inventor') earlytwists.push('The Inventor'); //PU Scrap rules
//if(player == 'Robot') earlytwists.push('The Robot'); //You Choose You Lose rules
//if(player == 'Witch') earlytwists.push('The Witch'); //Expect the unexpected rules

if(player != 'Witch' && player != 'Jester'){ //Let's consider adding Marshmallow
  //Witch and Jester can't support Marshmallow just yet, I still need to make sure equipment swapping
  //doesn't break on spellbooks and decks before I set it live
  //We add Marshmallow to the early twist list if
  // - Buster or Madison is the boss
  // - Or we're fighting at *least* three of the fire/ice enemies of level 3 or higher
  
  if(isenemyindungeon('Buster') || isenemyindungeon('Madison')){
    earlytwists.push('Marshmallow');
  }else{
    var marshmallowcount = 0;
    if(isenemyindungeon('Yeti')) marshmallowcount++;
    if(isenemyindungeon('Snowman')) marshmallowcount++;
    if(isenemyindungeon('Fireman')) marshmallowcount++;
    if(isenemyindungeon('Wisp')) marshmallowcount++;
    if(marshmallowcount >= 3){
      earlytwists.push('Marshmallow');
    }
  }
}

var latelist = ['Sorceress', 'Bully', 'Bounty Hunter', 'Kraken'];
if(!isenemyindungeon('Scathach')){
  standardlist.push('Cowboy'); //Don't offer the Cowboy rule if Scathach is the boss
}
if(player == 'Robot'){
  standardlist.push('Wisp'); //Robot should be *more* likely to get Wisp
}

if(player == 'Witch' || player == 'Jester'){ //Witch and Jester get offered Paper Knight in the late list
  latelist.push('Paper Knight');
}else if(player != 'Robot'){ //Everyone else (except Robot) gets offered either Skeleton or Paper Knight
  latelist.push(pick(['Skeleton', 'Paper Knight']));
}

if(player == 'Thief') latelist.push('Crystalina'); //Thief is more likely to get Crystalina
if(player == 'Warrior') latelist.push('Sneezy'); //Warrior is more likely to get Sneezy

var midtwists = ['Alchemist']; 
if(!isenemyindungeon('Scathach')){
  midtwists.push('Wizard'); //Don't offer the Wizard rule if Scathach is the boss
}
if(!isenemyindungeon('Cornelius')){
  midtwists.push('Space Marine'); //Don't offer the Space Marine rule if Cornelius is in the level, it's a bit cruel
}
if(chance(33)) midtwists.push('Loud Bird'); //Make this a bit rarer
if(chance(33)) midtwists.push('Scathach'); //Make this a bit rarer

//Frog needs to exclude enemy equipment before it can be included, also a better plan for inventor limits

var cursecount = 0;
if(isenemyindungeon('Banshee')) cursecount++;
if(isenemyindungeon('Dire Wolf')) cursecount++;
if(isenemyindungeon('Kraken')) cursecount++;
if(isenemyindungeon('Skeleton')) cursecount++;
if(cursecount >= 3 || isenemyindungeon('Scathach')){ //If there are more than 3 curse enemies or Scathach is the boss, offer a curse remix
  latelist.push(curselist.pop());
}

var poisoncount = 0;
if(isenemyindungeon('Haunted Jar')) poisoncount++;
if(isenemyindungeon('Rat King')) poisoncount++;
if(isenemyindungeon('Drain Monster')) poisoncount++;
if(isenemyindungeon('Dire Wolf')) poisoncount++;
if(isenemyindungeon('Drake')) poisoncount++;
if(poisoncount >= 2){
  latelist.push('Haunted Jar');
}

var veryhardlist = ['Cornelius', 'Drake', 'Madison', 'Beatrice'];
if(isenemyindungeon('Beatrice')) veryhardlist.push('Handyman');

//Really simple first draft, shuffle all the lists, assign them randomly
earlytwists = shuffle(earlytwists);
standardlist.push(earlytwists.pop());
standardlist = shuffle(standardlist);

midtwists = shuffle(midtwists);
latelist.push(midtwists.pop());
latelist.push(midtwists.pop()); //Add an extra mid twist to the late list to make it more interesting
latelist = shuffle(latelist);

veryhardlist = shuffle(veryhardlist);

//Figure out the final rule offerings
//var finaloffer2 = [standardlist.pop(), standardlist.pop(), earlytwists.pop()];
var finaloffer2 = ['Warlock', 'Marshmallow'];
//^ THIS IS THE NCRECCHACK
//
//Add some stuff we don't want to appear in the first remix, e.g. curse and poison related things
for(r in standardlist){
  secondremixlist.push(r);
}
if(chance(25)){
  secondremixlist.push('Rotten Apple'); //This one is brutal, keep it rare!
}
if(secondremixlist.indexOf('Rat King') > -1) secondremixlist.remove('Rat King'); //Rat King needs to appear as the first remix
secondremixlist = shuffle(secondremixlist);
//var finaloffer3 = [secondremixlist.pop(), secondremixlist.pop()];
var finaloffer3 = ['Marshmallow', 'Warlock'];
var finaloffer4 = [latelist.pop(), latelist.pop(), latelist.pop()];
while(latelist.length > 0) veryhardlist.push(latelist.pop());
veryhardlist = shuffle(veryhardlist);
var finaloffer5 = [veryhardlist.pop(), veryhardlist.pop(), veryhardlist.pop()];

////Insert twists!
//if(chance(80)){
//  //80% chance of seeing a twist
//  if(chance(66)){
//    if(chance(33)){
//      finaloffer2.insert(0, earlytwists.pop());
//    }else{
//      finaloffer2.insert(1, earlytwists.pop());
//    }
//  }else{
//    if(chance(66)){
//      finaloffer2.insert(0, veryrare.pop());
//    }else{
//      finaloffer2.insert(1, veryrare.pop());
//    }
//  }
//}
//does haxe have multiple-line comments?
//i probably look dumb

//To ensure we never run out, fill up the arrays with the rest of the options
//if(midtwists.length > 0) finaloffer3.push(midtwists.pop());
//if(standardlist.length > 0) finaloffer2.push(standardlist.pop());
//if(standardlist.length > 0) finaloffer3.push(standardlist.pop());
//if(standardlist.length > 0) finaloffer2.push(standardlist.pop());
//if(standardlist.length > 0) finaloffer3.push(standardlist.pop());
//if(earlytwists.length > 0) finaloffer2.push(earlytwists.pop());
//if(earlytwists.length > 0) finaloffer3.push(earlytwists.pop());
if(midtwists.length > 0) finaloffer4.push(midtwists.pop());
if(midtwists.length > 0) finaloffer5.push(midtwists.pop());
if(veryhardlist.length > 0) finaloffer4.push(veryhardlist.pop());
if(veryhardlist.length > 0) finaloffer5.push(veryhardlist.pop());
if(veryhardlist.length > 0) finaloffer4.push(veryhardlist.pop());
if(veryhardlist.length > 0) finaloffer5.push(veryhardlist.pop());
if(standardlist.length > 0) finaloffer4.push(standardlist.pop());
if(standardlist.length > 0) finaloffer5.push(standardlist.pop());

Remix.offer(2, '', finaloffer2);
Remix.offer(3, '', finaloffer3);
Remix.offer(4, '', finaloffer4);
Remix.offer(5, '', finaloffer5);