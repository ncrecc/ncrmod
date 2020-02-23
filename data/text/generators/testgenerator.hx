function cleanwhips(x,y) {
	switch (x) {
		case "Hamment@I":
			y.remove("Hamment@S");
		case "Hamment@S":
			y.remove("Hamment@S");
		case "Whisp@W":
			y.remove("Whisp@F");
		case "Whisp@F":
			y.remove("Whisp@W");
	}
	trace("hi");
}

addfloor("small").generate();