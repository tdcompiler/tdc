import std.stdio,
	   std.file,
	   std.algorithm,
	   std.regex,
	   pegged.grammar;

alias std.file.write writeFile;

enum testDir = "../tests";
enum resultDir = "../results";

private bool overwriteAllPassing = false;

void main(string[] args) {
	auto success = 0;
	auto failed = 0;
	string[] errors = [];
	if (args.length == 1) {
		foreach (string name; dirEntries(testDir, "*.d", SpanMode.depth)) {
			if (parse(name, errors)) success++;
			else failed++;
		}
		writeln;
		writeln("Successful testcases:\t", success);
		writeln("Failed testcases:\t", failed);
		writeln;
	} else {
		foreach (string name; args[1 .. $]) {
			parse(testDir ~ "/" ~ name, errors, true);
		}
	}
	foreach (i, e; errors) {
		write("View error ", i + 1, " - Yes, No, All yes, Quit: ");
		char reply;
		scanf("%s", &reply);
		if (reply == 'y') {
			e.writeln;
		} else if (reply == 'q') {
			return;
		} else if (reply == 'a') {
			foreach (e2; errors[i .. $])
				e2.writeln;
			return;
		}
	}
}

auto parse(string name, ref string[] errors, bool forceOutput = false) {
	mixin(grammar(dGrammar));
	//mixin(grammar(Dgrammar));

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
	file = file.replaceAll!(a => "\n")(regex(r"\r\n"));
	auto tree = D(file);
	auto treeText = tree.toString;
	if (!tree.successful) {
		errors ~= name ~ "\n" ~ file ~ "\n" ~ treeText ~ "\n"
				~ tree.failMsg ~ "\n";
		//writeln(file);
		//writeln(treeText);
		//writeln(tree.failMsg);
	}

	if (resultPath.exists) {
		/*
		 * The previous result is read and compared to the new result.
		 * If they are different, both are printed, and the user must
		 * decide which result to keep.
		 */
		if (!tree.successful) {
			return tree.successful;
		}
		auto previousFile = readText(resultPath);
		if (tree.toString == previousFile) {
			if (forceOutput) {
				writeln(name);
				writeln(file);
				writeln("Previous result identical to current result:");
				writeln(treeText);
			}
			return tree.successful;
		}
		if (overwriteAllPassing) {
			resultPath.writeFile(treeText);
			return tree.successful;
		}
		writeln(name);
		writeln(file);
		writeln("Previous result:");
		writeln(previousFile);
		writeln("Current result:");
		writeln(tree);
		write("Overwrite - Yes, No, All yes: ");
		char reply;
		scanf("%s", &reply);
		if (reply == 'y') {
			writeln("Overwriting old file.");
			resultPath.writeFile(treeText);
		} else if (reply == 'a') {
			overwriteAllPassing = true;
			writeln("Overwriting all old files.");
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
	return tree.successful;
}

enum dGrammar = `
D:

Module < DeclDefs eoi

DeclDefs < DeclDef*

DeclDef < Declaration

Declaration < Decl

Decl < BasicType Declarators :";"
	/ BasicType Declarator FunctionBody

BasicType < BasicTypeX
	/ IdentifierList

BasicTypeX < "bool" / "byte" / "ubyte" / "short" / "ushort" / "int"
	/ "uint" / "long" / "ulong" / "char" / "wchar" / "dchar"
	/ "float" / "double" / "real" / "ifloat" / "idouble" / "ireal"
	/ "cfloat" / "cdouble" / "creal" / "void"

IdentifierList < Identifier

Declarator < Identifier DeclaratorSuffixes?

DeclaratorSuffixes < DeclaratorSuffix+

DeclaratorSuffix < Parameters

Parameters < :"(" :")"
	/ :"(" ParameterList :")"

ParameterList < Parameter+
	/ "..."

Parameter < BasicType Declarator

BasicType2 < "*"

Declarators < DeclaratorInitializer

DeclaratorInitializer < Declarator "=" Initializer
	/ Declarator

Initializer < NonVoidInitializer

NonVoidInitializer < AssignExpression

AssignExpression < ConditionalExpression

ConditionalExpression < OrOrExpression

OrOrExpression < AndAndExpression

AndAndExpression < OrExpression

OrExpression < XorExpression

XorExpression < AndExpression

AndExpression < ShiftExpression

ShiftExpression < AddExpression

AddExpression < MulExpression "+" AddExpression
	/ MulExpression "-" AddExpression
	/ MulExpression

MulExpression < UnaryExpression "*" MulExpression
	/ UnaryExpression "/" MulExpression
	/ UnaryExpression "%" MulExpression
	/ UnaryExpression

UnaryExpression < "-" UnaryExpression
	/ "+" UnaryExpression
	/ PowExpression

PowExpression < PostfixExpression

PostfixExpression < PrimaryExpression

PrimaryExpression < FloatLiteral 
	/ IntegerLiteral
	/ StringLiteral
	/ CharacterLiteral
	/ :"(" Expression :")"

Identifier < identifier
#Identifier < IdentifierStart IdentifierChars?

#IdentifierStart < "_"
#	/ Letter
#	/ UniversalAlpha

#IdentifierChars < IdentifierChar+

#IdentifierChar < IdentifierStart
#	/ "0"
#	/ NonZeroDigit

#Stms < Stm*

#Stm < qualifiedIdentifier qualifiedIdentifier :";"
#	/ :"{" Stms :"}" #TODO Needs testing
#	/ Function
#	/ ReturnStm
#	/ Comment
#	/ Assignment

#Assignment < qualifiedIdentifier qualifiedIdentifier :"=" Exp :";"

#Function < Type Name :"(" :")" FunctionBody

#Type <- qualifiedIdentifier

#Name < qualifiedIdentifier

FunctionBody < BlockStatement

BlockStatement < "{" "}"
	/ :"{" StatementList :"}"

StatementList < Statement+

Statement < ";"
	/ NonEmptyStatement

NonEmptyStatement < NonEmptyStatementNoCaseNoDefault

NonEmptyStatementNoCaseNoDefault < DeclarationStatement
	/ ReturnStatement

DeclarationStatement < Declaration

ReturnStatement <^ "return" Expression? :";"

Expression < CommaExpression

CommaExpression < AssignExpression
#CommaExpression < AssignExpression "," CommaExpression
#	/ AssignExpression

#ReturnStm < :"return" Exp? :";"

#Exp < Arithmetic
#	/ StringLiteral

#Arithmetic < Factor (Addition / Subtraction)*
#Addition < :"+" Factor
#Subtraction < :"-" Factor
#Factor < Primary (Multiplication / Division / Modulo)*
#Multiplication < :"*" Primary
#Division < :"/" Primary
#Modulo < :"%" Primary
#Primary < Parens / Negative / Positive / Number
#Parens < :"(" Arithmetic :")"
#Negative < :"-" Primary
#Positive < :"+" Primary
#Number < FloatLiteral / IntegerLiteral / CharacterLiteral

Spacing <- (Space / Comment)*

Space <- "\u0020" / "\u0009" / "\u000b" / "\u000c" / eol

Comment <: BlockComment
	/ LineComment
	/ NestingBlockComment

BlockComment <~ :"/*" (!"*/" .)* :"*/"
LineComment <~ :"//" (!eol .)* :eol
NestingBlockComment <~ :"/+" (NestingBlockComment / (!("+/" / "/+") .))* :"+/"

StringLiteral < DoubleQuotedString

#StringLiteral < WysiqygString
#	/ AlternateWysiwygString
#	/ DoubleQuotedString
#	/ HexString
#	/ DelimitedString
#	/ TokenString

#WysiqygString < "r\"" WysiwygCharacters doublequote StringPostfix?

#AlternateWysiwygString < backquote WysiwygCharacters backquote StringPostfix?

#WysiwygCharacters < WysiwygCharacter+

#WysiwygCharacter < Character
#	/ eol

DoubleQuotedString < :doublequote "" :doublequote StringPostfix?
	/ :doublequote DoubleQuotedCharacters :doublequote StringPostfix?

DoubleQuotedCharacters <~ DoubleQuotedCharacter*

DoubleQuotedCharacter < (!doublequote Character)
	/ EscapeSequence
	/ eol

EscapeSequence < "\\'" #/ "\\\"" / "\\?" / "\\0" / "\\a" / "\\b"
	/ "\\f" / "\\n" / "\\r" / "\\t" / "\\v"
	/ "\\x" HexDigit HexDigit
	/ backslash OctalDigit
	/ backslash OctalDigit OctalDigit
	/ backslash OctalDigit OctalDigit OctalDigit
	/ "\\u" HexDigit HexDigit HexDigit HexDigit
	/ "\\U" HexDigit HexDigit HexDigit HexDigit HexDigit HexDigit HexDigit HexDigit
#	/ backslash NamedCharacterEntity

#HexString < "x\"" HexStringChars doublequote StringPostfix?

#HexStringChars < HexStringChar+

#HexStringChar < HexDigit
#	/ WhiteSpace
#	/ eol

StringPostfix < "c" / "w" / "d"

#DelimitedString < "q\"" Delimiter WysiwygCharacters Delimiter doublequote

#TokenString < "q{" Tokens "}"

CharacterLiteral < :quote SingleQuotedCharacter :quote

SingleQuotedCharacter < EscapeSequence
	/ (!quote Character)

Character < .

FloatLiteral <- Float
	/ Float Suffix
	/ Integer FloatSuffix ImaginarySuffix?
	/ Integer ImaginarySuffix
	/ Integer RealSuffix ImaginarySuffix

Float <- DecimalFloat
	/ HexFloat

DecimalFloat <~ LeadingDecimal "." DecimalDigits?
	/ DecimalDigits "." DecimalDigitsNoSingleUS DecimalExponent
	/ "." DecimalInteger DecimalExponent?
	/ LeadingDecimal DecimalExponent

DecimalExponent <- DecimalExponentStart DecimalDigitsNoSingleUS

DecimalExponentStart <- "e+" / "E+" / "e-" / "E-" / "e" / "E"

HexFloat <- HexPrefix HexDigitsNoSingleUS "." HexDigitsNoSingleUS HexExponent
	/ HexPrefix "." HexDigitsNoSingleUS HexExponent
	/ HexPrefix HexDigitsNoSingleUS HexExponent

HexPrefix <: "0x" / "0X"

HexExponent <- HexExponentStart DecimalDigitsNoSingleUS

HexExponentStart < "p+" / "P+" / "p-" / "P-" / "p" / "P"

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

Integer < BinaryInteger
	/ HexadecimalInteger
	/ DecimalInteger

IntegerSuffix <- "Lu" / "LU" / "uL" / "UL" / "L" / "U" / "u"

DecimalInteger <~ "0"
	/ NonZeroDigit DecimalDigitsUS?

BinaryInteger <~ BinPrefix BinaryDigits

BinPrefix <: "0b" / "0B"

HexadecimalInteger <~ HexPrefix HexDigitsNoSingleUS

NonZeroDigit <- [1-9]

DecimalDigits <- DecimalDigit+

DecimalDigitsUS <~ DecimalDigitUS+

DecimalDigitsNoSingleUS <~ DecimalDigit DecimalDigitsUS?
	/ DecimalDigitsUS DecimalDigit

DecimalDigitNoStartingUS <- DecimalDigit DecimalDigitsUS?

DecimalDigit <- "0" / NonZeroDigit

DecimalDigitUS <- DecimalDigit / :"_"

BinaryDigitsUS <- BinaryDigitUS+

BinaryDigits <- BinaryDigitsUS

BinaryDigit <- [0-1]

BinaryDigitUS <- BinaryDigit / :"_"

OctalDigits <- OctalDigit+

OctalDigitsUS <- OctalDigitUS+

OctalDigit <- [0-7]

OctalDigitUS <- OctalDigit / :"_"

HexDigits <- HexDigit+

HexDigitsUS <- HexDigitUS+

HexDigitUS <- HexDigit / :"_"

HexDigitsNoSingleUS <~ HexDigit HexDigitsUS?
	/ HexDigitsUS HexDigit

HexDigit <- DecimalDigit
	/ HexLetter

HexLetter <- [a-f] / [A-F] / :"_"
`;
