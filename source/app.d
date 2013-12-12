import std.stdio, std.file, pegged.grammar;

void main(string[] args) {
	mixin(grammar(dGrammar));
	foreach (string name; dirEntries("../tests", "*.d", SpanMode.depth)) {
		auto file = readText(name);
		auto tree = D(file);
		//writeln(file);
		//writeln(tree);
		writeln(name," ",tree.successful);
	}
}

enum dGrammar = `
D:

Module <- ModuleDecl? Stms

ModuleDecl < "module" qualifiedIdentifier ";"

Stms < Stm*

Stm < qualifiedIdentifier qualifiedIdentifier ";"
	/ "{" Stms "}"
	/ Function
	/ ReturnStm
	/ Comment

Function < Type Name "(" ")" FunctionBody

Type < qualifiedIdentifier

Name < qualifiedIdentifier

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
Number < IntegerLiteral

Comment <: BlockComment # <: discards nodes. Replace with < to see nodes in tree
	/ LineComment
	/ NestingBlockComment

BlockComment <~ :"/*" (!"*/" .)* :"*/"
LineComment <~ :"//" (!eol .)* :eol
NestingBlockComment <~ :"/+" (NestingBlockComment / (!("+/" / "/+") .))* :"+/"

IntegerLiteral <- DecimalInteger

DecimalInteger < Integer IntegerSuffix?

IntegerSuffix <- "L" / "u" / "U" / "Lu" / "LU" / "uL" / "UL"

Integer <- Digit ( Digit / "_" )*

Digit < Zero / NonZeroDigit

Zero <- "0"

NonZeroDigit <- [1-9]
`;
