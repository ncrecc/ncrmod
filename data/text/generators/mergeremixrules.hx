//Generate the level, and then choose remixes that go well with it.
//Does some very basic markov chaining to ensure interesting answers that can react to what you've selected
Remix.reset();

var player = getplayername();

function isenemyindungeon(enemyname){
  var enemylist = getenemylistindungeon();
  if(enemylist.indexOf(enemyname) == -1) return false;
  return true;
}

//Generic setup: define some remixes that should never occur at the same time
Remix.preventclash(['Kraken?', 'Sorceress?']); //the former effectively negates the latter due to how blind currently works with ai
Remix.preventclash(['Skeleton?', 'Rhino Beetle?']); //both directly deal damage to you. probably cruel
Remix.preventclash(['Singer', 'Marshmallow?', 'The Witch?', 'Bounty Hunter']); //can't have multiple restrictions on your rolls
Remix.preventclash(['Sorceress?', 'Cowboy?', 'Cowboy']); //neither can the enemy
Remix.preventclash(['Rat King?', 'Lady Luck']); //one upgrades a random enemy equipment, one upgrades all enemy equipment. redundancy is bad. redundancy is bad
Remix.preventclash(['Lady Luck', 'Rat King']); //Upgraded equipment + super enemies don't work together
Remix.preventclash(['Scathach?', 'Snowman', 'Baby Squid', 'Fireman']); //'More than one status effect dealer is messy' - i don't know what terry meant by 'messy', or if this is even a problem with card-affecting statuses, but better safe than sorry
Remix.preventclash(['Warlock', 'Banshee', 'Warlock?']); //Don't have both Warlock and a remix that changes to PU rules
Remix.preventclash(['Vacuum', 'Drake', 'Aoife?']); //vacuum and drake both increase enemy health, and aoife? periodically bestows shield
Remix.preventclash(['Skeleton', 'Scathach']); //This isn't a fun combination, best to prevent it
Remix.preventclash(['The Thief?', 'The Thief']); //two skillcard changes
Remix.preventclash(['The Inventor?', 'The Inventor']); //i don't actually know if blind inspiration breaks with multiple gadgets but let's just assume it does
Remix.preventclash(['Hothead', 'Fireman?']); //both ignite a dice. might not break things but it is pretty silly
Remix.preventclash(['Kraken?', 'Baby Squid']); //kraken? blinds all dice, baby squid blinds a single dice
Remix.preventclash(['Wizard', 'Cornelius?']); //mean & redundant
Remix.preventclash(['Rotten Apple?', 'Cornelius']); //-10 max hp plus a rule that deducts 1 max hp after each fight is probably cruel
Remix.preventclash(['Skeleton?', 'Cornelius']); //"take 10 damage immediately" & -10 max hp. mean
Remix.preventclash(['Singer?', 'Singer']); //the former negates the latter
Remix.preventclash(['Copycat?', 'Val']); //both involve item swaps. just in case
Remix.preventclash(['Wisp?', 'Wisp']); //when you have vanish all (i.e. regular vanish), being inflicted with finite vanish has no effect



var veryrare = ['Sorceress?', 'Kraken?', 'Warlock?', 'Sticky Hands'];
if(player != 'Witch' && player != 'Jester') veryrare.push('Copycat?'); //copycat? doesn't work with witch & jester for the same reason val doesn't work
if(player != 'Robot') veryrare.push('Wisp'); //Robot is offered Wisp elsewhere
if(player != 'Thief') veryrare.push('Crystalina'); //Thief is offered Crystalina elsewhere
if(player != 'Warrior') veryrare.push('Sneezy'); //Warrior is offered Sneezy elsewhere

if(player == 'Thief' || player == 'Jester') veryrare.push('Keymaster'); 
if(player != 'Witch' && player != 'Jester') veryrare.push('Ned'); //Jester and Witch shouldn't get Ned, Val or Yolanda
if(player != 'Witch' && player != 'Jester') veryrare.push('Yolanda'); //Jester and Witch shouldn't get Ned, Val or Yolanda
if(player != 'Witch' && player != 'Jester'){
  if(!isenemyindungeon('Drake')){ //Don't offer Val if Drake is the boss. having drake as a boss doesn't affect copycat? from showing up, since copycat? simply refuses to swap wooden stake
    veryrare.push('Val'); //Jester and Witch shouldn't get Ned, Val or Yolanda  
  }
}
veryrare = shuffle(veryrare);

var curselist = ['Dire Wolf', 'Banshee'];
var firelist = ['Buster'];
curselist = shuffle(curselist);
firelist = shuffle(firelist);

var standardlist = ['Aurora?', 'Banshee?', 'Fireman?', 'Alchemist?', 'Snowman', 'Baby Squid', 'Rat King', 'Hothead', 'Fireman', 'Vacuum', 'Slime'];
if(player != 'Thief') standardlist.push('Keymaster?'); //conventional thief actively benefits from keymaster?
if(player != 'Robot') standardlist.push('Singer'); //Robot shouldn't get Singer
if(player == 'Robot') standardlist.push('Robobot'); //Robot only remix
if(player == 'Warrior') standardlist.push('Keymaster'); //Warrior's more likely to get Keymaster

if(isenemyindungeon('Buster')){
  standardlist.push(firelist.pop());
}

var secondremixlist = [];

var earlytwists = ['Rat King?', 'Wolf Puppy', 'Mimic', 'Cactus', 'Rose', 'Pirate', 'Warlock'];
//these *were* too common, but the pool being larger now probably helps
if(player == 'Thief') earlytwists.push('The Thief?'); //uptick
if(player == 'Inventor') earlytwists.push('The Inventor?'); //double scrap
if(player == 'Robot') earlytwists.push('The Robot?'); //more jackpot rewards
if(player == 'Witch') earlytwists.push('The Witch?'); //countdown
//jester's is a midtwist. because i said so
if(player == 'Warrior') earlytwists.push('The Warrior?'); //shifting skillcard

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

if(player != 'Witch' && player != 'Jester'){ 
  //wisp? follows similar logic to marshmallow but more inclusive since there are no vanish-only enemies
  
  if(isenemyindungeon('Buster') || isenemyindungeon('Madison')){
    earlytwists.push('Wisp?');
  }else{
    var wispcount = 0;
    if(isenemyindungeon('Alchemist')) wispcount++;
    if(isenemyindungeon('Pirate')) wispcount++;
    if(isenemyindungeon('Marshmallow')) wispcount++;
    if(isenemyindungeon('Fireman')) wispcount++;
    if(isenemyindungeon('Wisp')) wispcount++;
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
		
var midtwists = ['Wizard?', 'Rotten Apple?', 'Cowboy?', 'Alchemist'];
if(player == 'Robot' && chance(66)) midtwists.push('Buster?'); //robot only, a little weird so odds are lowered
if(player == 'Jester') midtwists.push('The Jester?'); //swap pu cards with normal cards & vice-versa. midtwist because you're more likely to be in possession of backup cards by then
if(player != 'Jester' && player != 'Witch' && player != 'Robot') midtwists.push('Marshmallow?'); //jester and witch would get screwed over hard by this, and it wouldn't even make sense for robot. actually i don't play witch so i'm not sure how hard she would be affected by this? but it sounds like it would majorly limit her start-of-turn options
if(chance(33)) { if(chance(50)) midtwists.push('Ned?'); else midtwists.push('Val?'); } //ned and val are equally likely, so the optimal strategy is never just to only ever cross floors after putting equipment you like in the backpack/putting equipment you want upgraded in the equipped grid. also goes in midtwists instead of veryrare because this is probably not something you'd want to get early on
if(chance(33)) { midtwists.push('Yolanda?'); } //yolanda is also a midtwist as getting it later on probably makes it less likely you'll accidentally go broke

if(!isenemyindungeon('Scathach')){
  midtwists.push('Wizard'); //Don't offer the Wizard rule if Scathach is the boss
}
if(!isenemyindungeon('Cornelius')){
  midtwists.push('Space Marine'); //Don't offer the Space Marine rule if Cornelius is in the level, it's a bit cruel
}
if(chance(33)) midtwists.push('Loud Bird'); //Make this a bit rarer
if(chance(33)) midtwists.push('Scathach'); //Make this a bit rarer

var veryhardlist = ['Vacuum?', 'Cornelius?', 'Loud Bird?', 'Skeleton?', 'Cornelius', 'Drake', 'Madison', 'Beatrice'];
if(player != 'Jester') veryhardlist.push('Rhino Beetle?'); //rhino beetle would screw over jester whenever they use their limit break
if(isenemyindungeon('Beatrice')) veryhardlist.push('Handyman');

//Really simple first draft, shuffle all the lists, assign them randomly
earlytwists = shuffle(earlytwists);
standardlist.push(earlytwists.pop());
standardlist = shuffle(standardlist);

var latelist = ['Scathach?', 'Mimic?', 'Aoife?', 'Singer?', 'Sorceress', 'Bully', 'Bounty Hunter', 'Kraken'];
if(player == 'Jester' || player == 'Inventor') latelist.push('Handyman?'); //blueprints aren't as useful to other classes as they are to jester and inventor
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

Remix.offer(2, '', finaloffer2);
Remix.offer(3, '', finaloffer3);
Remix.offer(4, '', finaloffer4);
Remix.offer(5, '', finaloffer5);