import std.stdio,
	   std.file,
	   std.algorithm,
	   std.regex,
	   pegged.grammar;

alias std.file.write writeFile;

enum testDir = "../tests";
enum resultDir = "../results";

void main(string[] args) {
	if (args.length == 1) {
		foreach (string name; dirEntries(testDir, "*.d", SpanMode.depth)) {
			parse(name);
		}
	} else {
		foreach (string name; args[1 .. $]) {
			parse(testDir ~ "/" ~ name, true);
		}
	}
}

void parse(string name, bool forceOutput = false) {
	mixin(grammar(dGrammar));

	/*
	 * Replaces \ with / in path to give to unite Unix and Windows
	 * syntax for string processing. Then the file itself is stripped
	 * from the text and the middle path is preserved. If it does not
	 * exist in the result folder, it will be generated.
	 */
	name = name.replaceAll!(a => "/")(regex(r"[\\]"));
	auto resultPath = resultDir ~ name[testDir.length .. $];
	auto middlePath = resultDir
		~ name.dup[testDir.length .. $]
		.reverse.find('/').reverse;
	if (!middlePath.exists)
		middlePath.mkdirRecurse;

	/*
	 * The target file is read and parsed.
	 */
	auto file = readText(name);
	auto tree = D(file);
	auto treeText = tree.toString;

	if (resultPath.exists) {
		/*
		 * The previous result is read and compared to the new result.
		 * If they are different, both are printed, and the user must
		 * decide which result to keep.
		 */
		auto previousFile = readText(resultPath);
		if (tree.toString == previousFile) {
			if (forceOutput) {
				writeln("Previous result identical to current result:");
				writeln(treeText);
			}
			return;
		}
		writeln("Previous result:");
		writeln(previousFile);
		writeln("Current result:");
		writeln(tree);
		write("Overwrite? (y/n): ");
		char reply;
		scanf("%s", &reply);
		writeln(reply);
		if (reply == 'y') {
			writeln("Overwriting old file.");
			resultPath.writeFile(treeText);
		} else {
			writeln("Preserving old file.");
		}
	} else {
		/*
		 * No previous result existed. Program and parse tree are both
		 * printed and the tree is stored.
		 */
		writeln("New test result:");
		writeln(file);
		writeln(tree);
		resultPath.writeFile(treeText);
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

Integer <- NonZeroDigit ( Digit / "_" )*
/ Zero

Digit < Zero / NonZeroDigit

Zero <- "0"

NonZeroDigit <- [1-9]
`;
