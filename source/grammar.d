module source.grammar;

enum dGrammar = `
D:

Module < DeclDefs eoi

DeclDefs < DeclDef*

DeclDef < Declaration

Declaration < Decl

Decl < StorageClasses Decl
	/ BasicType Declarators :";"
	/ (BasicType Declarator FunctionBody) {basicFunction}

BasicType <- BasicTypeX
	/ IdentifierList

BasicTypeX <- "bool" / "byte" / "ubyte" / "short" / "ushort" / "int"
	/ "uint" / "long" / "ulong" / "char" / "wchar" / "dchar"
	/ "float" / "double" / "real" / "ifloat" / "idouble" / "ireal"
	/ "cfloat" / "cdouble" / "creal" / "void"

IdentifierList <- Identifier

StorageClasses <- StorageClass+

StorageClass <- Extern

Extern <- "extern" ("(" LinkageType ")")?

LinkageType <- "C"

Declarator < BasicType2? Identifier DeclaratorSuffixes?

DeclaratorSuffixes <- DeclaratorSuffix+

DeclaratorSuffix <- Parameters

Parameters < :"(" ParameterList? :")"

ParameterList < Parameter (:"," (Parameter / "..."))*
	/ "..."

Parameter < InOut? BasicType Declarator
#	/ InOut? Type Declarator?

InOut <- InOutX

InOutX <- "in"

Type <- BasicType Declarator2

Declarator2 <- BasicType2? DeclaratorSuffixes?

BasicType2 <- "*"

Declarators <- DeclaratorInitializer

DeclaratorInitializer < Declarator "=" Initializer
	/ Declarator

Initializer <- NonVoidInitializer

NonVoidInitializer <- AssignExpression

AssignExpression <- ConditionalExpression

ConditionalExpression <- OrOrExpression

OrOrExpression <- AndAndExpression

AndAndExpression <- OrExpression

OrExpression <- XorExpression

XorExpression <- AndExpression

AndExpression <- ShiftExpression

ShiftExpression <- AddExpression

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

PowExpression <- PostfixExpression

PostfixExpression <- PrimaryExpression

PrimaryExpression <- FloatLiteral 
	/ IntegerLiteral
	/ StringLiteral
	/ CharacterLiteral
	/ :"(" Expression :")"

Identifier <- identifier
#Identifier < IdentifierStart IdentifierChars?

#IdentifierStart <- "_"
#	/ Letter
#	/ UniversalAlpha

#IdentifierChars <- IdentifierChar+

#IdentifierChar <- IdentifierStart
#	/ "0"
#	/ NonZeroDigit

FunctionBody <- BlockStatement
	/ BodyStatement

BodyStatement < "body" BlockStatement

BlockStatement < "{" "}"
	/ :"{" StatementList :"}"

StatementList <- Statement+

Statement <- ";"
	/ NonEmptyStatement

NonEmptyStatement <- NonEmptyStatementNoCaseNoDefault

NonEmptyStatementNoCaseNoDefault <- DeclarationStatement
	/ ReturnStatement

DeclarationStatement <- Declaration

ReturnStatement < "return" Expression? :";"

Expression <- CommaExpression

CommaExpression <- AssignExpression

Spacing <- (Comment / spacing)*
#Spacing <- (spacing / Comment)*
#Spacing <- (Space / Comment)*
#Spacing <- (space / Comment)*

Space <- "\u0020" / "\u0009" / "\u000b" / "\u000c" / eol

Comment <: BlockComment
	/ LineComment
	/ NestingBlockComment

BlockComment <~ :"/*" (!"*/" .)* :"*/"
LineComment <~ :"//" (!eol .)* :eol
NestingBlockComment <~ :"/+" (NestingBlockComment / (!("+/" / "/+") .))* :"+/"

StringLiteral <- DoubleQuotedString

#StringLiteral <- WysiqygString
#	/ AlternateWysiwygString
#	/ DoubleQuotedString
#	/ HexString
#	/ DelimitedString
#	/ TokenString

#WysiqygString <- "r\"" WysiwygCharacters doublequote StringPostfix?

#AlternateWysiwygString <- backquote WysiwygCharacters backquote StringPostfix?

#WysiwygCharacters <- WysiwygCharacter+

#WysiwygCharacter <- Character
#	/ eol

DoubleQuotedString <- :doublequote "" :doublequote StringPostfix?
	/ :doublequote DoubleQuotedCharacters :doublequote StringPostfix?

DoubleQuotedCharacters <~ DoubleQuotedCharacter*

DoubleQuotedCharacter <- (!doublequote Character)
	/ EscapeSequence
	/ eol

EscapeSequence <- "\\'" #/ "\\\"" / "\\?" / "\\0" / "\\a" / "\\b"
	/ "\\f" / "\\n" / "\\r" / "\\t" / "\\v"
	/ "\\x" HexDigit HexDigit
	/ backslash OctalDigit
	/ backslash OctalDigit OctalDigit
	/ backslash OctalDigit OctalDigit OctalDigit
	/ "\\u" HexDigit HexDigit HexDigit HexDigit
	/ "\\U" HexDigit HexDigit HexDigit HexDigit HexDigit HexDigit HexDigit HexDigit
#	/ backslash NamedCharacterEntity

#HexString <- "x\"" HexStringChars doublequote StringPostfix?

#HexStringChars <- HexStringChar+

#HexStringChar <- HexDigit
#	/ WhiteSpace
#	/ eol

StringPostfix <- "c" / "w" / "d"

#DelimitedString <- "q\"" Delimiter WysiwygCharacters Delimiter doublequote

#TokenString <- "q{" Tokens "}"

CharacterLiteral <- :quote SingleQuotedCharacter :quote

SingleQuotedCharacter <- EscapeSequence
	/ (!quote Character)

Character <- .

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

HexExponentStart <- "p+" / "P+" / "p-" / "P-" / "p" / "P"

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

#IntegerLiteral < (BinaryInteger IntegerSuffix) {binaryIntegerSuffix}
#	/ (BinaryInteger) {binaryInteger}
#	/ (HexadecimalInteger IntegerSuffix) {hexadecimalIntegerSuffix}
#	/ (HexadecimalInteger) {hexadecimalInteger}
#	/ (DecimalInteger IntegerSuffix) {decimalIntegerSuffix}
#	/ (DecimalInteger) {decimalInteger}

IntegerLiteral <- (Integer IntegerSuffix) {integerWithSuffix}
	/ Integer

Integer <- BinaryInteger
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