module source.app;

import std.stdio,
	std.file,
	std.algorithm,
	std.regex,
	pegged.grammar;

alias std.file.write writeFile;

enum testDir = "../tests";
enum resultDir = "../results";

struct Work {
	ParseTree parse;
	string semant;
}

//enum grammar = findGrammar();

private bool overwriteAllPassing = false;
private Work[] cases = [];

void main(string[] args) {
	/*
	 * The compiler relies on a precompiled version of the grammar, to save
	 * time. D does not allow file manipulation at compiletime and there is no
	 * dynamic loading yet, so this is a rather sad solution.
	*/
	if (precompile) return;

	auto success = 0;
	auto failed = 0;
	string[] errors = [];
	if (args.length == 1) {
		foreach (immutable string name; dirEntries(testDir, "*.d", SpanMode.depth)) {
			if (parse(name, errors)) success++;
			else failed++;
		}
		writeln;
		writeln("Successful testcases:\t", success);
		writeln("Failed testcases:\t", failed);
		writeln;
	} else {
		foreach (immutable string name; args[1 .. $]) {
			parse(testDir ~ "/" ~ name, errors, true);
		}
	}

	/*
	 * All errors are available to be viewed or ignored.
	 */
	foreach (immutable i, ref e; errors) {
		write("View error ", i + 1, " - Yes, No, All yes, Quit: ");
		char reply;
		scanf("%s", &reply);
		if (reply == 'y') {
			e.writeln;
		} else if (reply == 'q') {
			return;
		} else if (reply == 'a') {
			foreach (immutable e2; errors[i .. $])
				e2.writeln;
			return;
		}
	}
}

string typeCheck(in ParseTree n) {
	switch (n.name) {
		case "D": return typeCheck(n.children[0]);
		case "D.Module": return typeCheck(n.children[0]);
		case "D.DeclDef": {
			if (isFunction(n)) {
				return "Definitely a function";
			} else {
				throw new Exception("Herp derp");
			}
		}
		default: string result = "";
				 foreach (const c; n.children) result ~= c.typeCheck();
				 return result;
	}
}

//struct Node {
//	bool immutable_, const_, 
//}

bool isFunction(in ParseTree n) {
	foreach (c; n.children) {
		if (c.name == "D.FunctionBody") return true;
	}
	return false;
}

auto parse(string name, ref string[] errors, bool forceOutput = false) {
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
	import precompiled_grammar;
	auto file = readText(name);
	file = file.replaceAll!(a => "\n")(regex(r"\r\n"));
	auto tree = D(file);
	Work w;
	w.parse = tree;
	w.semant = tree.typeCheck;
	cases ~= w;
	auto treeText = tree.toString;
	if (!tree.successful) {
		errors ~= name ~ "\n" ~ file ~ "\n" ~ treeText ~ "\n"
				~ tree.failMsg ~ "\n";
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
				writeln(w.semant);
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

bool precompile() {
	import std.datetime;

	SysTime sourceAccess, sourceModification, precompiledAccess, precompiledModification;

	getTimes("../source/grammar.d", sourceAccess, sourceModification);
	getTimes("../source/precompiled_grammar.d", precompiledAccess, precompiledModification);

	if (sourceModification > precompiledModification) {
		import source.grammar;

		writeln("Precompiled grammar predates current grammar. Parsing grammar...");

		asModule("precompiled_grammar", "../source/precompiled_grammar", dGrammar);

		writeln("Grammar has been modified. Please recompile.");

		return true;
	}

	return false;
}