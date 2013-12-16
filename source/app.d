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
				writeln(name);
				writeln(file);
				writeln("Previous result identical to current result:");
				writeln(treeText);
			}
			return;
		}
		writeln(name);
		writeln(file);
		writeln("Previous result:");
		writeln(previousFile);
		writeln("Current result:");
		writeln(tree);
		write("Overwrite? (y/n): ");
		char reply;
		scanf("%s", &reply);
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
		writeln(name);
		writeln(file);
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

Stm < qualifiedIdentifier qualifiedIdentifier :";"
	/ "{" Stms "}"
	/ Function
	/ ReturnStm
	/ Comment
	/ Assignment

Assignment < qualifiedIdentifier qualifiedIdentifier "=" Exp ";"

Function < Type Name :"(" :")" FunctionBody

Type <- qualifiedIdentifier

Name < qualifiedIdentifier

FunctionBody < :"{" Stms :"}"

ReturnStm < "return" Exp? :";"

Exp < Arithmetic

Arithmetic < Factor (Addition / Subtraction)*
Addition < :"+" Factor
Subtraction < :"-" Factor
Factor < Primary (Multiplication / Division / Modulo)*
Multiplication < :"*" Primary
Division < :"/" Primary
Modulo < :"%" Primary
Primary < Parens / Negative / Positive / Number
Parens < "(" Arithmetic ")"
Negative < :"-" Primary
Positive < :"+" Primary
Number < IntegerLiteral / FloatLiteral

# <: discards nodes. Replace with < to see nodes in tree
Comment <: BlockComment
	/ LineComment
	/ NestingBlockComment

BlockComment <~ :"/*" (!"*/" .)* :"*/"
LineComment <~ :"//" (!eol .)* :eol
NestingBlockComment <~ :"/+" (NestingBlockComment / (!("+/" / "/+") .))* :"+/"

FloatLiteral <- Float
	/ Float Suffix
	/ Integer ImaginarySuffix
	/ Integer FloatSuffix ImaginarySuffix
	/ Integer RealSuffix ImaginarySuffix

Float <- DecimalFloat
	/ HexFloat

DecimalFloat <- LeadingDecimal "." DecimalDigits?
	/ DecimalDigits "." DecimalDigitsNoSingleUS DecimalExponent
	/ "." DecimalInteger DecimalExponent?
	/ LeadingDecimal DecimalExponent

DecimalExponent <- DecimalExponentStart DecimalDigitsNoSingleUS

DecimalExponentStart <- "e" / "E" / "e+" / "E+" / "e-" / "E-"

HexFloat <- HexPrefix HexDigitsNoSingleUS "." HexDigitsNoSingleUS HexExponent
	/ HexPrefix "." HexDigitsNoSingleUS HexExponent
	/ HexPrefix HexDigitsNoSingleUS HexExponent

HexPrefix <- "0x" / "0X"

HexExponent <- HexExponentStart DecimalDigitsNoSingleUS

HexExponentStart <- "p" / "P" / "p+" / "P+" / "p-" / "P-"

Suffix <- FloatSuffix
	/ RealSuffix
	/ ImaginarySuffix
	/ FloatSuffix ImaginarySuffix
	/ RealSuffix ImaginarySuffix

FloatSuffix <- "f" / "F"

RealSuffix <- "L"

ImaginarySuffix <- "i"

LeadingDecimal <- DecimalInteger
	/ "0" DecimalDigitsNoSingleUS

IntegerLiteral <- Integer IntegerSuffix?

Integer <~ DecimalInteger
	/ BinaryInteger
	/ HexadecimalInteger

IntegerSuffix <- "L" / "u" / "U" / "Lu" / "LU" / "uL" / "UL"

DecimalInteger <- "0"
	/ NonZeroDigit DecimalDigitsUS?

BinaryInteger <- BinPrefix BinaryDigits

BinPrefix <- "0b" / "0B"

HexadecimalInteger < HexPrefix HexDigitsNoSingleUS

NonZeroDigit <- [1-9]

DecimalDigits <- DecimalDigit+

DecimalDigitsUS <~ DecimalDigitUS+

DecimalDigitsNoSingleUS <- DecimalDigit DecimalDigitsUS?
	/ DecimalDigitsUS DecimalDigit

DecimalDigitNoStartingUS <- DecimalDigit DecimalDigitsUS?

DecimalDigit <- "0" / NonZeroDigit

DecimalDigitUS <- DecimalDigit / :"_"

BinaryDigitsUS <- BinaryDigitUS+

BinaryDigits <- BinaryDigit+

BinaryDigit <- [0-1]

BinaryDigitUS <- BinaryDigit / :"_"

OctalDigits <- OctalDigit+

OctalDigitsUS <- OctalDigit+

OctalDigit <- [0-7]

OctalDigitUS <- OctalDigit / :"_"

HexDigits <- HexDigit+

HexDigitsUS <- HexDigitUS+

HexDigitUS <- HexDigit / :"_"

HexDigitsNoSingleUS <- HexDigit HexDigitsUS?
	/ HexDigitsUS HexDigit

HexDigit <- DecimalDigit
	/ HexLetter

HexLetter <- [a-f] / [A-F] / :"_"
`;
