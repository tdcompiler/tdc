module source.app;

import std.stdio;
import std.file;
import std.algorithm;
import std.regex;
import std.c.stdlib : exit;

import pegged.grammar;

import source.semantic;

alias std.file.write writeFile;

enum testDir = "../tests";
enum resultParseDir = "../results/parse";
enum resultSemanticDir = "../results/semantic";

struct Work {
	ParseTree parse;
	string pathParse;
	SemantTree semant;
	string pathSemant;
}

private bool overwriteAllPassing = false;
private Work[] cases = [];

void main(string[] args) {
	/*
	 * The compiler relies on a precompiled version of the grammar, to save
	 * time. D does not allow file manipulation at compiletime and there is no
	 * dynamic loading yet, so this is a rather sad solution.
	*/
	if (precompile) return;

	auto successParse = 0;
	auto failedParse = 0;
	auto successTypecheck = 0;
	auto failedTypecheck = 0;
	string[] errorsParse = [];
	string[] errorsTypecheck = [];
	if (args.length == 1) {
		foreach (immutable string name; dirEntries(testDir, "*.d", SpanMode.depth)) {
			if (parse(name, errorsParse)) successParse++;
			else failedParse++;
			if (semantic(cases[$ - 1], errorsTypecheck)) successTypecheck++;
			else failedTypecheck++;
		}
		writeln;
		writeln("Successful testcases:\t", successParse, "\t", successTypecheck);
		writeln("Failed testcases:\t", failedParse, "\t", failedTypecheck);
		writeln;
	} else {
		foreach (immutable string name; args[1 .. $]) {
			parse(testDir ~ "/" ~ name, errorsParse, true);
			semantic(cases[$ - 1], errorsTypecheck, true);
		}
	}

	/*
	 * All errors are available to be viewed or ignored.
	 */
	foreach (immutable i, ref e; errorsParse) {
		write("View parse error ", i + 1, " - Yes, No, All yes, Quit: ");
		char reply;
		scanf("%s", &reply);
		if (reply == 'y') {
			e.writeln;
		} else if (reply == 'q') {
			return;
		} else if (reply == 'a') {
			foreach (immutable e2; errorsParse[i .. $])
				e2.writeln;
			return;
		}
	}

	foreach (immutable i, ref e; errorsTypecheck) {
		write("View typecheck error ", i + 1, " - Yes, No, All yes, Quit: ");
		char reply;
		scanf("%s", &reply);
		if (reply == 'y') {
			e.writeln;
		} else if (reply == 'q') {
			return;
		} else if (reply == 'a') {
			foreach (immutable e2; errorsTypecheck[i .. $])
				e2.writeln;
			return;
		}
	}
}

auto semantic(ref Work w, ref string[] errors, bool forceOutput = false) {
	auto tree = w.parse.typeCheck;
	w.semant = tree;
	auto treeText = tree.toString;
	auto resultParsePath = w.pathSemant;

	if (!tree.successful) {
		errors ~= tree.name ~ "\n" ~ treeText ~ "\n"
			~ tree.errors ~ "\n";
	}

	if (resultParsePath.exists) {
		/*
		 * The previous result is read and compared to the new result.
		 * If they are different, both are printed, and the user must
		 * decide which result to keep.
		 */
		if (!tree.successful) {
			return tree.successful;
		}
		auto previousFile = readText(w.pathSemant);
		if (tree.toString == previousFile) {
			if (forceOutput) {
				//writeln(name);
				//writeln(file);
				writeln("Previous result identical to current result:");
				writeln(treeText);
				//writeln(w.semant);
			}
			return tree.successful;
		}
		if (overwriteAllPassing) {
			resultParsePath.writeFile(treeText);
			return tree.successful;
		}
		//writeln(name);
		//writeln(file);
		writeln("Previous result:");
		writeln(previousFile);
		writeln("Current result:");
		writeln(tree);
		write("Overwrite - Yes, No, All yes, Quit: ");
		char reply;
		scanf("%s", &reply);
		if (reply == 'y') {
			writeln("Overwriting old file.");
			resultParsePath.writeFile(treeText);
		} else if (reply == 'a') {
			overwriteAllPassing = true;
			writeln("Overwriting all old files.");
			resultParsePath.writeFile(treeText);
		} else if (reply == 'q') {
			exit(0);
		} else {
			writeln("Preserving old file.");
		}
	} else {
		/*
		 * No previous result existed. Program and parse tree are both
		 * printed and the tree is stored.
		 */
		//writeln(name);
		//writeln(file);
		writeln("New test result:");
		//writeln(file);
		writeln(tree);
		resultParsePath.writeFile(treeText);
	}
	
	return tree.successful;
}

auto parse(string name, ref string[] errors, bool forceOutput = false) {
	/*
	 * Replaces \ with / in path to give to unite Unix and Windows
	 * syntax for string processing. Then the file itself is stripped
	 * from the text and the middle path is preserved. If it does not
	 * exist in the result folder, it will be generated.
	 */
	import std.string;

	name = name.replaceAll!(a => "/")(regex(r"[\\]"));
	auto resultParsePath = resultParseDir ~ name[testDir.length .. $];
	auto middleParsePath = resultParseDir ~ name[testDir.length .. name.lastIndexOf('/')];
	if (!middleParsePath.exists)
		middleParsePath.mkdirRecurse;
	auto resultSemanticPath = resultSemanticDir ~ name[testDir.length .. $];
	auto middleSemanticPath = resultSemanticDir ~ name[testDir.length .. name.lastIndexOf('/')];
	if (!middleSemanticPath.exists)
		middleSemanticPath.mkdirRecurse;

	/*
	 * The target file is read and parsed.
	 */
	import source.precompiled_grammar;
	auto file = readText(name);
	file = file.replaceAll!(a => "\n")(regex(r"\r\n"));
	auto tree = D(file);
	Work w;
	w.parse = tree;
	w.pathParse = resultParseDir;
	w.pathSemant = resultSemanticPath;
	cases ~= w;
	auto treeText = tree.toString;
	if (!tree.successful) {
		errors ~= name ~ "\n" ~ file ~ "\n" ~ treeText ~ "\n"
				~ tree.failMsg ~ "\n";
	}

	if (resultParsePath.exists) {
		/*
		 * The previous result is read and compared to the new result.
		 * If they are different, both are printed, and the user must
		 * decide which result to keep.
		 */
		if (!tree.successful) {
			return tree.successful;
		}
		auto previousFile = readText(resultParsePath);
		if (tree.toString == previousFile) {
			if (forceOutput) {
				writeln(name);
				writeln(file);
				writeln("Previous result identical to current result:");
				writeln(treeText);
				writeln(w.semant);
			}
			return tree.successful;
		}
		if (overwriteAllPassing) {
			resultParsePath.writeFile(treeText);
			return tree.successful;
		}
		writeln(name);
		writeln(file);
		writeln("Previous result:");
		writeln(previousFile);
		writeln("Current result:");
		writeln(tree);
		write("Overwrite - Yes, No, All yes, Quit: ");
		char reply;
		scanf("%s", &reply);
		if (reply == 'y') {
			writeln("Overwriting old file.");
			resultParsePath.writeFile(treeText);
		} else if (reply == 'a') {
			overwriteAllPassing = true;
			writeln("Overwriting all old files.");
			resultParsePath.writeFile(treeText);
		} else if (reply == 'q') {
			exit(0);
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
		resultParsePath.writeFile(treeText);
	}

	return tree.successful;
}

bool precompile() {
	import std.datetime;

	SysTime sourceAccess, sourceModification, precompiledAccess, precompiledModification;

	getTimes("../source/grammar.d", sourceAccess, sourceModification);

	if (!"../source/precompiled_grammar.d".exists) {
		import source.grammar;

		writeln("Can't find precompiled grammar. Parsing grammar...");

		saveGrammar;

		return true;
	}

	getTimes("../source/precompiled_grammar.d", precompiledAccess, precompiledModification);

	if (sourceModification > precompiledModification) {
		import source.grammar;

		writeln("Precompiled grammar predates current grammar. Parsing grammar...");

		saveGrammar;

		writeln("Grammar has been modified. Please recompile.");

		return true;
	}

	return false;
}

void saveGrammar() {
	string grammar = `
module source.precompiled_grammar;

public import pegged.peg;
import std.algorithm: startsWith;
import std.functional: toDelegate;
import source.semantic;

` ~ grammar(source.grammar.dGrammar);
	"../source/precompiled_grammar.d".writeFile(grammar);
}