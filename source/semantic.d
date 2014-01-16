module source.semantic;

import std.algorithm;
import std.conv;
import std.stdio;
import std.string;

import pegged.peg;

enum semanticArray = ["basicFunction", "integerWithSuffix"];

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
	string errors = "";
	foreach (child; children) errors ~= child.errors;
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

		case "D.integerWithSuffix":
			Type rawType = children[0].type;
			auto suffix = children[1].original.matches.join;
			bool isLong = rawType == Type("long") || suffix.indexOf('l', CaseSensitive.no) != -1;
			bool isUnsigned = suffix.indexOf('u', CaseSensitive.no) != -1;
			if (isLong && isUnsigned) {
				type = Type("ulong");
			} else if (isUnsigned) {
				type = Type("uint");
			} else if (isLong) {
				type = Type("long");
			} else {
				type = Type("int");
			}
			break;

		case "D.StatementList":
			Type[] types;
			foreach (child; children) {
				if (child.dfs("D.ReturnStatement")) types ~= child.type;
			}
			if (types.length == 0) type = Type("void");
			else {
				type = types[0];
				foreach (t; types) {
					if (t != type) {
						errors ~= "Return statements are different types: "
							~ type.toString ~ " != " ~ t.toString ~ "\n"
							~ to!string(n.children[0].begin) ~ " " ~ to!string(n.end);
						type = Type("error");
						break;
					}
				}
			}
			break;

		case "D.basicFunction":
			Type declaredType = children[0].type;
			Type actualType = children[2].type;
			if (!declaredType.equalType(actualType)) {
				successful = false;
				errors ~= "Declared and actual type of function don't match: "
					~ declaredType.toString ~ " != " ~ actualType.toString ~ "\n"
					~ to!string(n.children[0].begin) ~ " " ~ to!string(n.end);
				type = Type("error");
			} else {
				type = declaredType;
			}
			break;

		case "D.Decl":
			type = Type("void");
			break;

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

	return SemantTree(n.name, successful, type, children, n, errors);
}

bool equalType(Type t1, Type t2) {
	if (t1.name == t2.name) return true;
	if (t1.name == "long" && t2.name == "int") return true;
	return false;
}

bool dfs(SemantTree n, string s) {
	if (n.name == s) return true;
	foreach (child; n.children) if (child.dfs(s)) return true;
	return false;
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
	string errors;

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
}