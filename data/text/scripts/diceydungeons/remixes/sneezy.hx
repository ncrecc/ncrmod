Rules.addextrascript("
self.setvar('equsedcheck',self.getvar('equsedcheck') + 1);
if(self.getvar('equsedcheck') > self.equipmentused) {
	self.setvar('equsedcheck',self.getvar('equsedcheck') - 1);
} else { 
	var availdice = []; 
	for (mydice in self.dicepool){ 
	  if (mydice.available() && !mydice.intween()){ 
		availdice.push(mydice); 
	  } 
	} 

	if(availdice.length > 0) { 
	  shuffle(availdice); 
	  availdice[0].animatereroll(rand([1,2,3,4,5,6]), self.screenposition());  
	}
}
", "playerequipmentuse");
Rules.addextrascript("self.setvar('equsedcheck',0);", "beforestartturn");