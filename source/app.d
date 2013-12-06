import std.stdio, std.file, pegged.grammar;

void main(string[] args) {
	mixin(grammar(dGrammar));
	foreach (string name; dirEntries("../tests", "*.d", SpanMode.depth)) {
		auto file = readText(name);
		auto tree = D(file);
		writeln(file);
		writeln(tree);
		//writeln(r.successful);
	}
}

enum dGrammar = `
D:

Module <- ModuleDecl? Stms?

ModuleDecl < "module" qualifiedIdentifier ";"

Stms < Stm+

Stm < qualifiedIdentifier qualifiedIdentifier ";"
	/ "{" Stms "}"
	/ Function
	/ ReturnStm

Function < Type Name "(" ")" FunctionBody

Type < "int"

Name < "main"

FunctionBody < "{" Stms "}"

ReturnStm < "return" Exp? ";"

Exp < Arithmetic

Arithmetic < Factor (Addition / Subtraction)*
Addition < "+" Factor
Subtraction < "-" Factor
Factor < Primary (Multiplication / Division / Modulo)*
Multiplication < "*" Primary
Division < "/" Primary
Modulo < "%" Primary
Primary < Parens / Negative / Positive / Number
Parens < "(" Arithmetic ")"
Negative < "-" Primary
Positive < "+" Primary
Number < Integer

Integer < digit (digit / "_")*
`;
