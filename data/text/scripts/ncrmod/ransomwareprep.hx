trace("i exist");
var myturn = false;
trace(self.name);
if(self.equipment.length > 0) {
	for(eq in self.equipment) {
		if(eq.isready(true)) {
			trace("it's my turn");
			myturn = true; break;
		}
	}
}
if(myturn) {
	var possibleransoms = [1,2,3,4,5,6];
	var activeransoms = [];
	trace(self.status);
	trace(self.status.length);
	if(self.status.length > 0) {
		for(ransom in possibleransoms) {
			for(stat in self.status) {
				trace(stat.type);
				if(stat.type == "ncr_ransom" + ransom) {
					activeransoms.push(ransom); break;
				}
			}
		}
	}
	trace("point A");
	var ransompool = [];
	if(activeransoms.length > 0) {
		for(eq in self.equipment) {
			trace(eq.name);
			trace(eq.skillcard);
			trace(eq.availablethisturn);
			trace(eq.shockedsetting);
			trace(!eq.hastag("isransomed"));
			if(
				eq.skillcard == "" &&
				eq.availablethisturn &&
				eq.shockedsetting == 0 &&
				!eq.hastag("isransomed")
			)
			{
				ransompool.push(eq);
			}
		}
	}
	trace("point B");
	if(ransompool.length > 0) {
		trace("aaa");
		trace(ransompool);
		shuffle(ransompool);
		for(ransom in possibleransoms) {
			while(getstatusself("ncr_ransom" + ransom) > 0 && ransompool.length > 0) {
				/*this might be a lot messier than it needs to be? i assumed that eq.getvar and self.getvar are just plain off limits for ai at the moment*/
				trace("point C");
				var ransomeq = ransompool[0].copy();
				var wknme = "false";
				if(ransompool[0].namemodifier == "-") {
					wknme = "true";
				}
				trace("hhiiiii");
				ransompool[0].equipmentcol = 0;
				ransompool[0].changeslots(["REQUIRE" + ransom]);
				ransompool[0].sfxoverride = "none";
				trace("point D");
				ransompool[0].fulldescription = "Unlock this equipment," + "||".substr(0,1) + "return the dice";
				ransompool[0].animate("flashandshake");
				ransompool[0].animation[ransompool[0].animation.length - 1].addcommand("textparticle", "[lock] Ransomed!", 16777215);
				sfx("_lock");
				ransompool[0].countdown = 0;
				ransompool[0].remainingcountdown = 0;
				ransompool[0].castdirection = -1;
				var origtags = ransompool[0].tags.copy();
				for(tag in ["curseavoid","weakenavoid","shockavoid","altpoisonavoid","isransomed"]) { 
					ransompool[0].addtag(tag);
				}
				trace("point E next up comes crazy ? : crap");
				function arraykludge(list,usequotes) {
					var result = "[]";
					if(list.length > 0) {
						result = "[";
						var i = 0;
						for(entry in list) {
							if(usequotes) {
								result += "\"";
							}
							result += entry;
							if(usequotes) {
								result += "\"";
							}
							i++;
							if(i != list.length) {
							result += ",";
							}
						}
						result += "]";
					}
					return(result);
				};
				var ransomeqdhkludge = arraykludge(ransomeq.dicehistory.length > 0 ? [for(dice in ransomeq.dicehistory) dice.basevalue] : [],false);
				var ransomeqgskludge = arraykludge(ransomeq.getslots(),true);
				trace("point F yay");
				var ransominfo = [ 
					ransomeq.name,
					ransomeqdhkludge,
					ransomeq.countdown,
					ransomeq.remainingcountdown,
					ransomeqgskludge,
					ransomeq.equipmentcol,
					ransomeq.displayname,
					wknme,
					arraykludge(origtags,true)
				];
				trace("point G");
				var replaceransomplaceholder = "
					bonus(1000);
					giveequipment(\"" + ransominfo[0] + "\",true,false,e);
					trace(\"point H\");
					for(eq in self.equipment) {
						trace(eq.name);
						if(eq.name == \"" + ransominfo[0] + "\") {
							trace(\"point I\");
							var ransomeqdhkludge = " + ransominfo[1] + ";
							trace(\"point J\");
							if(ransomeqdhkludge.length > 0) {
								eq.dicehistory = [for(i in 0...ransomeqdhkludge.length) new elements.Dice()];
								trace(\"point K\");
								for(i in 0...eq.dicehistory.length) {
									eq.dicehistory[i].basevalue = ransomeqdhkludge[i];
								}
							}
							trace(\"point L. anything past here is stupid trivial\");
							eq.countdown = " + ransominfo[2] + ";
							if(!simulation) eq.remainingcountdown = " + ransominfo[3] + ";
							if(self.isplayer) if(eq.getslots() != " + ransominfo[4] + ") eq.changeslots(" + ransominfo[4] + ");
							if(self.isplayer) eq.equipmentcol = " + ransominfo[5] + ";
							trace(\"you know what here's another trace\");
							if(self.isplayer) eq.displayname = \"" + ransominfo[6] + "\";
							if(" + ransominfo[7] + ") eq.downgrade();
							if(!simulation && " + ransominfo[8] + ".length > 0) for(tag in " + ransominfo[8] + ") eq.addtag(tag);
							sfx(\"_thinghappens\");
							break;
						}
					}
					trace(\"aaaa test\");
				";
				ransompool[0].script = "givedice(d);" + replaceransomplaceholder;
				if(turn == 1) trace(ransompool[0].script);
				ransompool[0].scriptbeforeexecute = "delay(1.0);";
				var replaceransomplaceholderendturn = "
					bonus(1000);
					giveequipment(\"" + ransominfo[0] + "\",true,false);
					trace(\"point H\");
					for(eq in self.equipment) {
						trace(eq.name);
						if(eq.name == \"" + ransominfo[0] + "\") {
							 for(eqq in self.equipment) {
								if(eqq.name == eq.name && eqq.hastag(\"isransomed\")) {
									eqq.name = \"deleteme\";
									removeequipment(\"deleteme\");
								}
							}
						trace(\"point I\");
						var ransomeqdhkludge = " + ransominfo[1] + ";
						trace(\"point J\");
						if(ransomeqdhkludge.length > 0) {
							 eq.dicehistory = [for(i in 0...ransomeqdhkludge.length) new elements.Dice()];
							trace(\"point K\");
							for(i in 0...eq.dicehistory.length) eq.dicehistory[i].basevalue = ransomeqdhkludge[i];
						}
						trace(\"point L. anything past here is stupid trivial\");
						eq.countdown = " + ransominfo[2] + ";
						if(!simulation) eq.remainingcountdown = " + ransominfo[3] + ";
						if(self.isplayer) if(eq.getslots() != " + ransominfo[4] + ") eq.changeslots(" + ransominfo[4] + ");
						if(self.isplayer) eq.equipmentcol = " + ransominfo[5] + ";
						trace(\"you know what here's another trace\");
						if(self.isplayer) eq.displayname = \"" + ransominfo[6] + "\";
						if(" + ransominfo[7] + ") eq.downgrade();
						if(!simulation && " + ransominfo[8] + ".length > 0) for(tag in " + ransominfo[8] + ") eq.addtag(tag);
						break;
						}
					}
					trace(\"aaaa test\");
				";
				ransompool[0].script = "givedice(d);" + replaceransomplaceholder;
				if(turn == 1) trace(ransompool[0].script);
				ransompool[0].scriptbeforeexecute = "delay(1.0);";
				ransompool[0].scriptendturn = replaceransomplaceholderendturn;
				removestatusself("ncr_ransom" + ransom);
				trace("hi mr. dj");
			}
		}
	}
}