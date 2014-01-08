module source.semantic;

import pegged.peg;

SemantTree typeCheck(in ParseTree n) {
	SemantTree[] children;
	children.length = n.children.length;
	foreach (immutable i, child; n.children) children[i] = child.typeCheck;
	Type type;
	switch (n.name) {
		case "D.BasicType":
			type = children[0].type;
			break;
		case "D.BasicTypeX":
			type = Type(n.matches[0]);
			break;
		default:
			type = Type("void");
			break;
	}

	return SemantTree(n.name, false, type, children);
}

struct Type {
	string name;
	
	string toString() pure {
		return name;
	}
}

struct SemantTree {
	string name;
	bool successful;
	Type type;
	SemantTree[] children;

	string toString(string tabs = "") {
		string result = name ~ " : " ~ type.toString;
		string childrenString;
		
		foreach(immutable i, child; children) {
			childrenString ~= tabs ~ " +-" ~ child.toString(tabs ~ ((i < children.length -1 ) ? " | " : "   "));
		}
		
		return result ~ "\n" ~ childrenString;
	}

}

T derp(T)(T t) {
	t.name = "D.lala";
	return t;
	//return t.children ~= ParseTree("testing");
}

/*string typeCheck(in ParseTree n) {
	switch (n.name) {
		case "D": return typeCheck(n.children[0]);
		case "D.Module": return typeCheck(n.children[0]);
		case "D.DeclDef": {
			if (isFunction(n)) {
				return "Definitely a function";
			} else {
				return "No idea what this is";
			}
		}
		default: string result = "";
				 foreach (const c; n.children) result ~= c.typeCheck();
				 return result;
	}
}*/

//struct Node {
//	bool immutable_, const_, 
//}



/*bool isFunction(in ParseTree n) {
	foreach (c; n.children) c.name.writeln;
	foreach (c; n.children) {
		if (c.name == "D.FunctionBody") return true;
	}
	return false;
}*/