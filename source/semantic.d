module source.semantic;

import std.algorithm;
import std.conv;
import std.stdio;
import std.string;

import pegged.peg;

enum semanticArray = ["basicFunction", "binaryIntegerSuffix", "binaryInteger", "hexadecimalIntegerSuffix",
	"hexadecimalInteger", "decimalIntegerSuffix", "decimalInteger"];

mixin(semanticArray.map!(a => `T ` ~ a ~ `(T)(T t) {
	t.name = "D." ~ "` ~ a ~ `";
	return t;
}`).join());

SemantTree typeCheck(ParseTree n) {
	SemantTree[] children;
	children.length = n.children.length;
	foreach (immutable i, child; n.children) children[i] = child.typeCheck;
	bool successful = true;
	foreach (child; children) if (!child.successful) successful = false;
	Type type;
	switch (n.name) {
		case "D.BasicType":
			type = children[0].type;
			break;
		case "D.BasicTypeX":
			type = Type(n.matches[0]);
			break;
		case "D.DecimalInteger":
			type = parseInteger(n.matches.join, 10);
			break;
		case "D.HexadecimalInteger":
			type = parseInteger(n.matches.join, 16);
			break;
		case "D.BinaryInteger":
			type = parseInteger(n.matches.join, 2);
			break;
		case "D.basicFunction":
			Type declaredType = children[0].type;
			Type actualType = children[2].type;
			if (declaredType != actualType) {
				successful = false;
				writeln("Declared and actual type of function don't match: ",
				        declaredType.toString, " != ", actualType.toString);
				writeln(n.children[0].begin, " ", n.end);
				type = Type("error");
			} else {
				type = declaredType;
			}
			break;
		/*case "D.Decl":
			type = Type("void");
			break;*/
		case "D.Module":
			type = Type("");
			break;
		default:
			if (children.length == 0) {
				type = Type("void");
			} else {
				type = children[0].type;
			}
			break;
	}

	return SemantTree(n.name, successful, type, children, n);
}

Type parseInteger(string s, ushort radix) {
	scope (failure) {
		return Type("error");
	}
	auto value = parse!ulong(s, radix);
	if (value < 2_147_483_647) return Type("int");
	else return Type("long");
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
	ParseTree original;

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