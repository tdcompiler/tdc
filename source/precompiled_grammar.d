
module source.precompiled_grammar;

public import pegged.peg;
import std.algorithm: startsWith;
import std.functional: toDelegate;
import source.semantic;

struct GenericD(TParseTree)
{
    import pegged.dynamic.grammar;
    struct D
    {
    enum name = "D";
    static ParseTree delegate(ParseTree)[string] before;
    static ParseTree delegate(ParseTree)[string] after;
    static ParseTree delegate(ParseTree)[string] rules;

    static this()
    {
        rules["Module"] = toDelegate(&D.Module);
        rules["DeclDefs"] = toDelegate(&D.DeclDefs);
        rules["DeclDef"] = toDelegate(&D.DeclDef);
        rules["Declaration"] = toDelegate(&D.Declaration);
        rules["Decl"] = toDelegate(&D.Decl);
        rules["BasicType"] = toDelegate(&D.BasicType);
        rules["BasicTypeX"] = toDelegate(&D.BasicTypeX);
        rules["IdentifierList"] = toDelegate(&D.IdentifierList);
        rules["StorageClasses"] = toDelegate(&D.StorageClasses);
        rules["StorageClass"] = toDelegate(&D.StorageClass);
        rules["Extern"] = toDelegate(&D.Extern);
        rules["LinkageType"] = toDelegate(&D.LinkageType);
        rules["Declarator"] = toDelegate(&D.Declarator);
        rules["DeclaratorSuffixes"] = toDelegate(&D.DeclaratorSuffixes);
        rules["DeclaratorSuffix"] = toDelegate(&D.DeclaratorSuffix);
        rules["Parameters"] = toDelegate(&D.Parameters);
        rules["ParameterList"] = toDelegate(&D.ParameterList);
        rules["Parameter"] = toDelegate(&D.Parameter);
        rules["InOut"] = toDelegate(&D.InOut);
        rules["InOutX"] = toDelegate(&D.InOutX);
        rules["Type"] = toDelegate(&D.Type);
        rules["Declarator2"] = toDelegate(&D.Declarator2);
        rules["BasicType2"] = toDelegate(&D.BasicType2);
        rules["Declarators"] = toDelegate(&D.Declarators);
        rules["DeclaratorInitializer"] = toDelegate(&D.DeclaratorInitializer);
        rules["Initializer"] = toDelegate(&D.Initializer);
        rules["NonVoidInitializer"] = toDelegate(&D.NonVoidInitializer);
        rules["AssignExpression"] = toDelegate(&D.AssignExpression);
        rules["ConditionalExpression"] = toDelegate(&D.ConditionalExpression);
        rules["OrOrExpression"] = toDelegate(&D.OrOrExpression);
        rules["AndAndExpression"] = toDelegate(&D.AndAndExpression);
        rules["OrExpression"] = toDelegate(&D.OrExpression);
        rules["XorExpression"] = toDelegate(&D.XorExpression);
        rules["AndExpression"] = toDelegate(&D.AndExpression);
        rules["ShiftExpression"] = toDelegate(&D.ShiftExpression);
        rules["AddExpression"] = toDelegate(&D.AddExpression);
        rules["MulExpression"] = toDelegate(&D.MulExpression);
        rules["UnaryExpression"] = toDelegate(&D.UnaryExpression);
        rules["PowExpression"] = toDelegate(&D.PowExpression);
        rules["PostfixExpression"] = toDelegate(&D.PostfixExpression);
        rules["PrimaryExpression"] = toDelegate(&D.PrimaryExpression);
        rules["Identifier"] = toDelegate(&D.Identifier);
        rules["FunctionBody"] = toDelegate(&D.FunctionBody);
        rules["BodyStatement"] = toDelegate(&D.BodyStatement);
        rules["BlockStatement"] = toDelegate(&D.BlockStatement);
        rules["StatementList"] = toDelegate(&D.StatementList);
        rules["Statement"] = toDelegate(&D.Statement);
        rules["NonEmptyStatement"] = toDelegate(&D.NonEmptyStatement);
        rules["NonEmptyStatementNoCaseNoDefault"] = toDelegate(&D.NonEmptyStatementNoCaseNoDefault);
        rules["DeclarationStatement"] = toDelegate(&D.DeclarationStatement);
        rules["ReturnStatement"] = toDelegate(&D.ReturnStatement);
        rules["Expression"] = toDelegate(&D.Expression);
        rules["CommaExpression"] = toDelegate(&D.CommaExpression);
        rules["Spacing"] = toDelegate(&D.Spacing);
   }

    template hooked(alias r, string name)
    {
        static ParseTree hooked(ParseTree p)
        {
            ParseTree result;

            if (name in before)
            {
                result = before[name](p);
                if (result.successful)
                    return result;
            }

            result = r(p);
            if (result.successful || name !in after)
                return result;

            result = after[name](p);
            return result;
        }

        static ParseTree hooked(string input)
        {
            return hooked!(r, name)(ParseTree("",false,[],input));
        }
    }

    static void addRuleBefore(string parentRule, string ruleSyntax)
    {
        // enum name is the current grammar name
        DynamicGrammar dg = pegged.dynamic.grammar.grammar(name ~ ": " ~ ruleSyntax, rules);
        foreach(ruleName,rule; dg.rules)
            if (ruleName != "Spacing") // Keep the local Spacing rule, do not overwrite it
                rules[ruleName] = rule;
        before[parentRule] = rules[dg.startingRule];
    }

    static void addRuleAfter(string parentRule, string ruleSyntax)
    {
        // enum name is the current grammar named
        DynamicGrammar dg = pegged.dynamic.grammar.grammar(name ~ ": " ~ ruleSyntax, rules);
        foreach(name,rule; dg.rules)
        {
            if (name != "Spacing")
                rules[name] = rule;
        }
        after[parentRule] = rules[dg.startingRule];
    }

    static bool isRule(string s)
    {
        return s.startsWith("D.");
    }
    import std.typecons:Tuple, tuple;
    static TParseTree[Tuple!(string, size_t)] memo;
    mixin decimateTree;
    static TParseTree Module(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.and!(pegged.peg.wrapAround!(Spacing, DeclDefs, Spacing), pegged.peg.wrapAround!(Spacing, eoi, Spacing)), "D.Module")(p);
        }
        else
        {
            if(auto m = tuple(`Module`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.and!(pegged.peg.wrapAround!(Spacing, DeclDefs, Spacing), pegged.peg.wrapAround!(Spacing, eoi, Spacing)), "D.Module"), "Module")(p);
                memo[tuple(`Module`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree Module(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.and!(pegged.peg.wrapAround!(Spacing, DeclDefs, Spacing), pegged.peg.wrapAround!(Spacing, eoi, Spacing)), "D.Module")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(pegged.peg.and!(pegged.peg.wrapAround!(Spacing, DeclDefs, Spacing), pegged.peg.wrapAround!(Spacing, eoi, Spacing)), "D.Module"), "Module")(TParseTree("", false,[], s));
        }
    }
    static string Module(GetName g)
    {
        return "D.Module";
    }

    static TParseTree DeclDefs(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.zeroOrMore!(pegged.peg.wrapAround!(Spacing, DeclDef, Spacing)), "D.DeclDefs")(p);
        }
        else
        {
            if(auto m = tuple(`DeclDefs`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.zeroOrMore!(pegged.peg.wrapAround!(Spacing, DeclDef, Spacing)), "D.DeclDefs"), "DeclDefs")(p);
                memo[tuple(`DeclDefs`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree DeclDefs(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.zeroOrMore!(pegged.peg.wrapAround!(Spacing, DeclDef, Spacing)), "D.DeclDefs")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(pegged.peg.zeroOrMore!(pegged.peg.wrapAround!(Spacing, DeclDef, Spacing)), "D.DeclDefs"), "DeclDefs")(TParseTree("", false,[], s));
        }
    }
    static string DeclDefs(GetName g)
    {
        return "D.DeclDefs";
    }

    static TParseTree DeclDef(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.wrapAround!(Spacing, Declaration, Spacing), "D.DeclDef")(p);
        }
        else
        {
            if(auto m = tuple(`DeclDef`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.wrapAround!(Spacing, Declaration, Spacing), "D.DeclDef"), "DeclDef")(p);
                memo[tuple(`DeclDef`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree DeclDef(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.wrapAround!(Spacing, Declaration, Spacing), "D.DeclDef")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(pegged.peg.wrapAround!(Spacing, Declaration, Spacing), "D.DeclDef"), "DeclDef")(TParseTree("", false,[], s));
        }
    }
    static string DeclDef(GetName g)
    {
        return "D.DeclDef";
    }

    static TParseTree Declaration(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.wrapAround!(Spacing, Decl, Spacing), "D.Declaration")(p);
        }
        else
        {
            if(auto m = tuple(`Declaration`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.wrapAround!(Spacing, Decl, Spacing), "D.Declaration"), "Declaration")(p);
                memo[tuple(`Declaration`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree Declaration(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.wrapAround!(Spacing, Decl, Spacing), "D.Declaration")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(pegged.peg.wrapAround!(Spacing, Decl, Spacing), "D.Declaration"), "Declaration")(TParseTree("", false,[], s));
        }
    }
    static string Declaration(GetName g)
    {
        return "D.Declaration";
    }

    static TParseTree Decl(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.or!(pegged.peg.and!(pegged.peg.wrapAround!(Spacing, StorageClasses, Spacing), pegged.peg.wrapAround!(Spacing, Decl, Spacing)), pegged.peg.and!(pegged.peg.wrapAround!(Spacing, BasicType, Spacing), pegged.peg.wrapAround!(Spacing, Declarators, Spacing), pegged.peg.discard!(pegged.peg.wrapAround!(Spacing, pegged.peg.literal!(";"), Spacing))), pegged.peg.action!(pegged.peg.wrapAround!(Spacing, pegged.peg.and!(pegged.peg.wrapAround!(Spacing, BasicType, Spacing), pegged.peg.wrapAround!(Spacing, Declarator, Spacing), pegged.peg.wrapAround!(Spacing, FunctionBody, Spacing)), Spacing), basicFunction)), "D.Decl")(p);
        }
        else
        {
            if(auto m = tuple(`Decl`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.or!(pegged.peg.and!(pegged.peg.wrapAround!(Spacing, StorageClasses, Spacing), pegged.peg.wrapAround!(Spacing, Decl, Spacing)), pegged.peg.and!(pegged.peg.wrapAround!(Spacing, BasicType, Spacing), pegged.peg.wrapAround!(Spacing, Declarators, Spacing), pegged.peg.discard!(pegged.peg.wrapAround!(Spacing, pegged.peg.literal!(";"), Spacing))), pegged.peg.action!(pegged.peg.wrapAround!(Spacing, pegged.peg.and!(pegged.peg.wrapAround!(Spacing, BasicType, Spacing), pegged.peg.wrapAround!(Spacing, Declarator, Spacing), pegged.peg.wrapAround!(Spacing, FunctionBody, Spacing)), Spacing), basicFunction)), "D.Decl"), "Decl")(p);
                memo[tuple(`Decl`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree Decl(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.or!(pegged.peg.and!(pegged.peg.wrapAround!(Spacing, StorageClasses, Spacing), pegged.peg.wrapAround!(Spacing, Decl, Spacing)), pegged.peg.and!(pegged.peg.wrapAround!(Spacing, BasicType, Spacing), pegged.peg.wrapAround!(Spacing, Declarators, Spacing), pegged.peg.discard!(pegged.peg.wrapAround!(Spacing, pegged.peg.literal!(";"), Spacing))), pegged.peg.action!(pegged.peg.wrapAround!(Spacing, pegged.peg.and!(pegged.peg.wrapAround!(Spacing, BasicType, Spacing), pegged.peg.wrapAround!(Spacing, Declarator, Spacing), pegged.peg.wrapAround!(Spacing, FunctionBody, Spacing)), Spacing), basicFunction)), "D.Decl")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(pegged.peg.or!(pegged.peg.and!(pegged.peg.wrapAround!(Spacing, StorageClasses, Spacing), pegged.peg.wrapAround!(Spacing, Decl, Spacing)), pegged.peg.and!(pegged.peg.wrapAround!(Spacing, BasicType, Spacing), pegged.peg.wrapAround!(Spacing, Declarators, Spacing), pegged.peg.discard!(pegged.peg.wrapAround!(Spacing, pegged.peg.literal!(";"), Spacing))), pegged.peg.action!(pegged.peg.wrapAround!(Spacing, pegged.peg.and!(pegged.peg.wrapAround!(Spacing, BasicType, Spacing), pegged.peg.wrapAround!(Spacing, Declarator, Spacing), pegged.peg.wrapAround!(Spacing, FunctionBody, Spacing)), Spacing), basicFunction)), "D.Decl"), "Decl")(TParseTree("", false,[], s));
        }
    }
    static string Decl(GetName g)
    {
        return "D.Decl";
    }

    static TParseTree BasicType(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.or!(BasicTypeX, IdentifierList), "D.BasicType")(p);
        }
        else
        {
            if(auto m = tuple(`BasicType`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.or!(BasicTypeX, IdentifierList), "D.BasicType"), "BasicType")(p);
                memo[tuple(`BasicType`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree BasicType(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.or!(BasicTypeX, IdentifierList), "D.BasicType")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(pegged.peg.or!(BasicTypeX, IdentifierList), "D.BasicType"), "BasicType")(TParseTree("", false,[], s));
        }
    }
    static string BasicType(GetName g)
    {
        return "D.BasicType";
    }

    static TParseTree BasicTypeX(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.keywords!("bool", "byte", "ubyte", "short", "ushort", "int", "uint", "long", "ulong", "char", "wchar", "dchar", "float", "double", "real", "ifloat", "idouble", "ireal", "cfloat", "cdouble", "creal", "void"), "D.BasicTypeX")(p);
        }
        else
        {
            if(auto m = tuple(`BasicTypeX`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.keywords!("bool", "byte", "ubyte", "short", "ushort", "int", "uint", "long", "ulong", "char", "wchar", "dchar", "float", "double", "real", "ifloat", "idouble", "ireal", "cfloat", "cdouble", "creal", "void"), "D.BasicTypeX"), "BasicTypeX")(p);
                memo[tuple(`BasicTypeX`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree BasicTypeX(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.keywords!("bool", "byte", "ubyte", "short", "ushort", "int", "uint", "long", "ulong", "char", "wchar", "dchar", "float", "double", "real", "ifloat", "idouble", "ireal", "cfloat", "cdouble", "creal", "void"), "D.BasicTypeX")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(pegged.peg.keywords!("bool", "byte", "ubyte", "short", "ushort", "int", "uint", "long", "ulong", "char", "wchar", "dchar", "float", "double", "real", "ifloat", "idouble", "ireal", "cfloat", "cdouble", "creal", "void"), "D.BasicTypeX"), "BasicTypeX")(TParseTree("", false,[], s));
        }
    }
    static string BasicTypeX(GetName g)
    {
        return "D.BasicTypeX";
    }

    static TParseTree IdentifierList(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(Identifier, "D.IdentifierList")(p);
        }
        else
        {
            if(auto m = tuple(`IdentifierList`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(Identifier, "D.IdentifierList"), "IdentifierList")(p);
                memo[tuple(`IdentifierList`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree IdentifierList(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(Identifier, "D.IdentifierList")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(Identifier, "D.IdentifierList"), "IdentifierList")(TParseTree("", false,[], s));
        }
    }
    static string IdentifierList(GetName g)
    {
        return "D.IdentifierList";
    }

    static TParseTree StorageClasses(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.oneOrMore!(StorageClass), "D.StorageClasses")(p);
        }
        else
        {
            if(auto m = tuple(`StorageClasses`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.oneOrMore!(StorageClass), "D.StorageClasses"), "StorageClasses")(p);
                memo[tuple(`StorageClasses`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree StorageClasses(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.oneOrMore!(StorageClass), "D.StorageClasses")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(pegged.peg.oneOrMore!(StorageClass), "D.StorageClasses"), "StorageClasses")(TParseTree("", false,[], s));
        }
    }
    static string StorageClasses(GetName g)
    {
        return "D.StorageClasses";
    }

    static TParseTree StorageClass(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(Extern, "D.StorageClass")(p);
        }
        else
        {
            if(auto m = tuple(`StorageClass`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(Extern, "D.StorageClass"), "StorageClass")(p);
                memo[tuple(`StorageClass`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree StorageClass(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(Extern, "D.StorageClass")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(Extern, "D.StorageClass"), "StorageClass")(TParseTree("", false,[], s));
        }
    }
    static string StorageClass(GetName g)
    {
        return "D.StorageClass";
    }

    static TParseTree Extern(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.and!(pegged.peg.literal!("extern"), pegged.peg.option!(pegged.peg.and!(pegged.peg.literal!("("), LinkageType, pegged.peg.literal!(")")))), "D.Extern")(p);
        }
        else
        {
            if(auto m = tuple(`Extern`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.and!(pegged.peg.literal!("extern"), pegged.peg.option!(pegged.peg.and!(pegged.peg.literal!("("), LinkageType, pegged.peg.literal!(")")))), "D.Extern"), "Extern")(p);
                memo[tuple(`Extern`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree Extern(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.and!(pegged.peg.literal!("extern"), pegged.peg.option!(pegged.peg.and!(pegged.peg.literal!("("), LinkageType, pegged.peg.literal!(")")))), "D.Extern")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(pegged.peg.and!(pegged.peg.literal!("extern"), pegged.peg.option!(pegged.peg.and!(pegged.peg.literal!("("), LinkageType, pegged.peg.literal!(")")))), "D.Extern"), "Extern")(TParseTree("", false,[], s));
        }
    }
    static string Extern(GetName g)
    {
        return "D.Extern";
    }

    static TParseTree LinkageType(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.literal!("C"), "D.LinkageType")(p);
        }
        else
        {
            if(auto m = tuple(`LinkageType`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.literal!("C"), "D.LinkageType"), "LinkageType")(p);
                memo[tuple(`LinkageType`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree LinkageType(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.literal!("C"), "D.LinkageType")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(pegged.peg.literal!("C"), "D.LinkageType"), "LinkageType")(TParseTree("", false,[], s));
        }
    }
    static string LinkageType(GetName g)
    {
        return "D.LinkageType";
    }

    static TParseTree Declarator(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.and!(pegged.peg.option!(pegged.peg.wrapAround!(Spacing, BasicType2, Spacing)), pegged.peg.wrapAround!(Spacing, Identifier, Spacing), pegged.peg.option!(pegged.peg.wrapAround!(Spacing, DeclaratorSuffixes, Spacing))), "D.Declarator")(p);
        }
        else
        {
            if(auto m = tuple(`Declarator`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.and!(pegged.peg.option!(pegged.peg.wrapAround!(Spacing, BasicType2, Spacing)), pegged.peg.wrapAround!(Spacing, Identifier, Spacing), pegged.peg.option!(pegged.peg.wrapAround!(Spacing, DeclaratorSuffixes, Spacing))), "D.Declarator"), "Declarator")(p);
                memo[tuple(`Declarator`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree Declarator(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.and!(pegged.peg.option!(pegged.peg.wrapAround!(Spacing, BasicType2, Spacing)), pegged.peg.wrapAround!(Spacing, Identifier, Spacing), pegged.peg.option!(pegged.peg.wrapAround!(Spacing, DeclaratorSuffixes, Spacing))), "D.Declarator")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(pegged.peg.and!(pegged.peg.option!(pegged.peg.wrapAround!(Spacing, BasicType2, Spacing)), pegged.peg.wrapAround!(Spacing, Identifier, Spacing), pegged.peg.option!(pegged.peg.wrapAround!(Spacing, DeclaratorSuffixes, Spacing))), "D.Declarator"), "Declarator")(TParseTree("", false,[], s));
        }
    }
    static string Declarator(GetName g)
    {
        return "D.Declarator";
    }

    static TParseTree DeclaratorSuffixes(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.oneOrMore!(DeclaratorSuffix), "D.DeclaratorSuffixes")(p);
        }
        else
        {
            if(auto m = tuple(`DeclaratorSuffixes`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.oneOrMore!(DeclaratorSuffix), "D.DeclaratorSuffixes"), "DeclaratorSuffixes")(p);
                memo[tuple(`DeclaratorSuffixes`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree DeclaratorSuffixes(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.oneOrMore!(DeclaratorSuffix), "D.DeclaratorSuffixes")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(pegged.peg.oneOrMore!(DeclaratorSuffix), "D.DeclaratorSuffixes"), "DeclaratorSuffixes")(TParseTree("", false,[], s));
        }
    }
    static string DeclaratorSuffixes(GetName g)
    {
        return "D.DeclaratorSuffixes";
    }

    static TParseTree DeclaratorSuffix(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(Parameters, "D.DeclaratorSuffix")(p);
        }
        else
        {
            if(auto m = tuple(`DeclaratorSuffix`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(Parameters, "D.DeclaratorSuffix"), "DeclaratorSuffix")(p);
                memo[tuple(`DeclaratorSuffix`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree DeclaratorSuffix(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(Parameters, "D.DeclaratorSuffix")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(Parameters, "D.DeclaratorSuffix"), "DeclaratorSuffix")(TParseTree("", false,[], s));
        }
    }
    static string DeclaratorSuffix(GetName g)
    {
        return "D.DeclaratorSuffix";
    }

    static TParseTree Parameters(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.and!(pegged.peg.discard!(pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("("), Spacing)), pegged.peg.option!(pegged.peg.wrapAround!(Spacing, ParameterList, Spacing)), pegged.peg.discard!(pegged.peg.wrapAround!(Spacing, pegged.peg.literal!(")"), Spacing))), "D.Parameters")(p);
        }
        else
        {
            if(auto m = tuple(`Parameters`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.and!(pegged.peg.discard!(pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("("), Spacing)), pegged.peg.option!(pegged.peg.wrapAround!(Spacing, ParameterList, Spacing)), pegged.peg.discard!(pegged.peg.wrapAround!(Spacing, pegged.peg.literal!(")"), Spacing))), "D.Parameters"), "Parameters")(p);
                memo[tuple(`Parameters`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree Parameters(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.and!(pegged.peg.discard!(pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("("), Spacing)), pegged.peg.option!(pegged.peg.wrapAround!(Spacing, ParameterList, Spacing)), pegged.peg.discard!(pegged.peg.wrapAround!(Spacing, pegged.peg.literal!(")"), Spacing))), "D.Parameters")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(pegged.peg.and!(pegged.peg.discard!(pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("("), Spacing)), pegged.peg.option!(pegged.peg.wrapAround!(Spacing, ParameterList, Spacing)), pegged.peg.discard!(pegged.peg.wrapAround!(Spacing, pegged.peg.literal!(")"), Spacing))), "D.Parameters"), "Parameters")(TParseTree("", false,[], s));
        }
    }
    static string Parameters(GetName g)
    {
        return "D.Parameters";
    }

    static TParseTree ParameterList(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.or!(pegged.peg.and!(pegged.peg.wrapAround!(Spacing, Parameter, Spacing), pegged.peg.zeroOrMore!(pegged.peg.wrapAround!(Spacing, pegged.peg.and!(pegged.peg.discard!(pegged.peg.wrapAround!(Spacing, pegged.peg.literal!(","), Spacing)), pegged.peg.wrapAround!(Spacing, pegged.peg.or!(pegged.peg.wrapAround!(Spacing, Parameter, Spacing), pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("..."), Spacing)), Spacing)), Spacing))), pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("..."), Spacing)), "D.ParameterList")(p);
        }
        else
        {
            if(auto m = tuple(`ParameterList`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.or!(pegged.peg.and!(pegged.peg.wrapAround!(Spacing, Parameter, Spacing), pegged.peg.zeroOrMore!(pegged.peg.wrapAround!(Spacing, pegged.peg.and!(pegged.peg.discard!(pegged.peg.wrapAround!(Spacing, pegged.peg.literal!(","), Spacing)), pegged.peg.wrapAround!(Spacing, pegged.peg.or!(pegged.peg.wrapAround!(Spacing, Parameter, Spacing), pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("..."), Spacing)), Spacing)), Spacing))), pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("..."), Spacing)), "D.ParameterList"), "ParameterList")(p);
                memo[tuple(`ParameterList`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree ParameterList(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.or!(pegged.peg.and!(pegged.peg.wrapAround!(Spacing, Parameter, Spacing), pegged.peg.zeroOrMore!(pegged.peg.wrapAround!(Spacing, pegged.peg.and!(pegged.peg.discard!(pegged.peg.wrapAround!(Spacing, pegged.peg.literal!(","), Spacing)), pegged.peg.wrapAround!(Spacing, pegged.peg.or!(pegged.peg.wrapAround!(Spacing, Parameter, Spacing), pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("..."), Spacing)), Spacing)), Spacing))), pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("..."), Spacing)), "D.ParameterList")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(pegged.peg.or!(pegged.peg.and!(pegged.peg.wrapAround!(Spacing, Parameter, Spacing), pegged.peg.zeroOrMore!(pegged.peg.wrapAround!(Spacing, pegged.peg.and!(pegged.peg.discard!(pegged.peg.wrapAround!(Spacing, pegged.peg.literal!(","), Spacing)), pegged.peg.wrapAround!(Spacing, pegged.peg.or!(pegged.peg.wrapAround!(Spacing, Parameter, Spacing), pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("..."), Spacing)), Spacing)), Spacing))), pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("..."), Spacing)), "D.ParameterList"), "ParameterList")(TParseTree("", false,[], s));
        }
    }
    static string ParameterList(GetName g)
    {
        return "D.ParameterList";
    }

    static TParseTree Parameter(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.and!(pegged.peg.option!(pegged.peg.wrapAround!(Spacing, InOut, Spacing)), pegged.peg.wrapAround!(Spacing, BasicType, Spacing), pegged.peg.wrapAround!(Spacing, Declarator, Spacing)), "D.Parameter")(p);
        }
        else
        {
            if(auto m = tuple(`Parameter`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.and!(pegged.peg.option!(pegged.peg.wrapAround!(Spacing, InOut, Spacing)), pegged.peg.wrapAround!(Spacing, BasicType, Spacing), pegged.peg.wrapAround!(Spacing, Declarator, Spacing)), "D.Parameter"), "Parameter")(p);
                memo[tuple(`Parameter`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree Parameter(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.and!(pegged.peg.option!(pegged.peg.wrapAround!(Spacing, InOut, Spacing)), pegged.peg.wrapAround!(Spacing, BasicType, Spacing), pegged.peg.wrapAround!(Spacing, Declarator, Spacing)), "D.Parameter")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(pegged.peg.and!(pegged.peg.option!(pegged.peg.wrapAround!(Spacing, InOut, Spacing)), pegged.peg.wrapAround!(Spacing, BasicType, Spacing), pegged.peg.wrapAround!(Spacing, Declarator, Spacing)), "D.Parameter"), "Parameter")(TParseTree("", false,[], s));
        }
    }
    static string Parameter(GetName g)
    {
        return "D.Parameter";
    }

    static TParseTree InOut(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(InOutX, "D.InOut")(p);
        }
        else
        {
            if(auto m = tuple(`InOut`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(InOutX, "D.InOut"), "InOut")(p);
                memo[tuple(`InOut`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree InOut(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(InOutX, "D.InOut")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(InOutX, "D.InOut"), "InOut")(TParseTree("", false,[], s));
        }
    }
    static string InOut(GetName g)
    {
        return "D.InOut";
    }

    static TParseTree InOutX(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.literal!("in"), "D.InOutX")(p);
        }
        else
        {
            if(auto m = tuple(`InOutX`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.literal!("in"), "D.InOutX"), "InOutX")(p);
                memo[tuple(`InOutX`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree InOutX(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.literal!("in"), "D.InOutX")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(pegged.peg.literal!("in"), "D.InOutX"), "InOutX")(TParseTree("", false,[], s));
        }
    }
    static string InOutX(GetName g)
    {
        return "D.InOutX";
    }

    static TParseTree Type(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.and!(BasicType, Declarator2), "D.Type")(p);
        }
        else
        {
            if(auto m = tuple(`Type`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.and!(BasicType, Declarator2), "D.Type"), "Type")(p);
                memo[tuple(`Type`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree Type(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.and!(BasicType, Declarator2), "D.Type")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(pegged.peg.and!(BasicType, Declarator2), "D.Type"), "Type")(TParseTree("", false,[], s));
        }
    }
    static string Type(GetName g)
    {
        return "D.Type";
    }

    static TParseTree Declarator2(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.and!(pegged.peg.option!(BasicType2), pegged.peg.option!(DeclaratorSuffixes)), "D.Declarator2")(p);
        }
        else
        {
            if(auto m = tuple(`Declarator2`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.and!(pegged.peg.option!(BasicType2), pegged.peg.option!(DeclaratorSuffixes)), "D.Declarator2"), "Declarator2")(p);
                memo[tuple(`Declarator2`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree Declarator2(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.and!(pegged.peg.option!(BasicType2), pegged.peg.option!(DeclaratorSuffixes)), "D.Declarator2")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(pegged.peg.and!(pegged.peg.option!(BasicType2), pegged.peg.option!(DeclaratorSuffixes)), "D.Declarator2"), "Declarator2")(TParseTree("", false,[], s));
        }
    }
    static string Declarator2(GetName g)
    {
        return "D.Declarator2";
    }

    static TParseTree BasicType2(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.literal!("*"), "D.BasicType2")(p);
        }
        else
        {
            if(auto m = tuple(`BasicType2`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.literal!("*"), "D.BasicType2"), "BasicType2")(p);
                memo[tuple(`BasicType2`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree BasicType2(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.literal!("*"), "D.BasicType2")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(pegged.peg.literal!("*"), "D.BasicType2"), "BasicType2")(TParseTree("", false,[], s));
        }
    }
    static string BasicType2(GetName g)
    {
        return "D.BasicType2";
    }

    static TParseTree Declarators(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(DeclaratorInitializer, "D.Declarators")(p);
        }
        else
        {
            if(auto m = tuple(`Declarators`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(DeclaratorInitializer, "D.Declarators"), "Declarators")(p);
                memo[tuple(`Declarators`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree Declarators(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(DeclaratorInitializer, "D.Declarators")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(DeclaratorInitializer, "D.Declarators"), "Declarators")(TParseTree("", false,[], s));
        }
    }
    static string Declarators(GetName g)
    {
        return "D.Declarators";
    }

    static TParseTree DeclaratorInitializer(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.or!(pegged.peg.and!(pegged.peg.wrapAround!(Spacing, Declarator, Spacing), pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("="), Spacing), pegged.peg.wrapAround!(Spacing, Initializer, Spacing)), pegged.peg.wrapAround!(Spacing, Declarator, Spacing)), "D.DeclaratorInitializer")(p);
        }
        else
        {
            if(auto m = tuple(`DeclaratorInitializer`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.or!(pegged.peg.and!(pegged.peg.wrapAround!(Spacing, Declarator, Spacing), pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("="), Spacing), pegged.peg.wrapAround!(Spacing, Initializer, Spacing)), pegged.peg.wrapAround!(Spacing, Declarator, Spacing)), "D.DeclaratorInitializer"), "DeclaratorInitializer")(p);
                memo[tuple(`DeclaratorInitializer`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree DeclaratorInitializer(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.or!(pegged.peg.and!(pegged.peg.wrapAround!(Spacing, Declarator, Spacing), pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("="), Spacing), pegged.peg.wrapAround!(Spacing, Initializer, Spacing)), pegged.peg.wrapAround!(Spacing, Declarator, Spacing)), "D.DeclaratorInitializer")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(pegged.peg.or!(pegged.peg.and!(pegged.peg.wrapAround!(Spacing, Declarator, Spacing), pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("="), Spacing), pegged.peg.wrapAround!(Spacing, Initializer, Spacing)), pegged.peg.wrapAround!(Spacing, Declarator, Spacing)), "D.DeclaratorInitializer"), "DeclaratorInitializer")(TParseTree("", false,[], s));
        }
    }
    static string DeclaratorInitializer(GetName g)
    {
        return "D.DeclaratorInitializer";
    }

    static TParseTree Initializer(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(NonVoidInitializer, "D.Initializer")(p);
        }
        else
        {
            if(auto m = tuple(`Initializer`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(NonVoidInitializer, "D.Initializer"), "Initializer")(p);
                memo[tuple(`Initializer`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree Initializer(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(NonVoidInitializer, "D.Initializer")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(NonVoidInitializer, "D.Initializer"), "Initializer")(TParseTree("", false,[], s));
        }
    }
    static string Initializer(GetName g)
    {
        return "D.Initializer";
    }

    static TParseTree NonVoidInitializer(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(AssignExpression, "D.NonVoidInitializer")(p);
        }
        else
        {
            if(auto m = tuple(`NonVoidInitializer`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(AssignExpression, "D.NonVoidInitializer"), "NonVoidInitializer")(p);
                memo[tuple(`NonVoidInitializer`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree NonVoidInitializer(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(AssignExpression, "D.NonVoidInitializer")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(AssignExpression, "D.NonVoidInitializer"), "NonVoidInitializer")(TParseTree("", false,[], s));
        }
    }
    static string NonVoidInitializer(GetName g)
    {
        return "D.NonVoidInitializer";
    }

    static TParseTree AssignExpression(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(ConditionalExpression, "D.AssignExpression")(p);
        }
        else
        {
            if(auto m = tuple(`AssignExpression`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(ConditionalExpression, "D.AssignExpression"), "AssignExpression")(p);
                memo[tuple(`AssignExpression`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree AssignExpression(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(ConditionalExpression, "D.AssignExpression")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(ConditionalExpression, "D.AssignExpression"), "AssignExpression")(TParseTree("", false,[], s));
        }
    }
    static string AssignExpression(GetName g)
    {
        return "D.AssignExpression";
    }

    static TParseTree ConditionalExpression(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(OrOrExpression, "D.ConditionalExpression")(p);
        }
        else
        {
            if(auto m = tuple(`ConditionalExpression`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(OrOrExpression, "D.ConditionalExpression"), "ConditionalExpression")(p);
                memo[tuple(`ConditionalExpression`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree ConditionalExpression(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(OrOrExpression, "D.ConditionalExpression")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(OrOrExpression, "D.ConditionalExpression"), "ConditionalExpression")(TParseTree("", false,[], s));
        }
    }
    static string ConditionalExpression(GetName g)
    {
        return "D.ConditionalExpression";
    }

    static TParseTree OrOrExpression(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(AndAndExpression, "D.OrOrExpression")(p);
        }
        else
        {
            if(auto m = tuple(`OrOrExpression`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(AndAndExpression, "D.OrOrExpression"), "OrOrExpression")(p);
                memo[tuple(`OrOrExpression`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree OrOrExpression(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(AndAndExpression, "D.OrOrExpression")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(AndAndExpression, "D.OrOrExpression"), "OrOrExpression")(TParseTree("", false,[], s));
        }
    }
    static string OrOrExpression(GetName g)
    {
        return "D.OrOrExpression";
    }

    static TParseTree AndAndExpression(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(OrExpression, "D.AndAndExpression")(p);
        }
        else
        {
            if(auto m = tuple(`AndAndExpression`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(OrExpression, "D.AndAndExpression"), "AndAndExpression")(p);
                memo[tuple(`AndAndExpression`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree AndAndExpression(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(OrExpression, "D.AndAndExpression")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(OrExpression, "D.AndAndExpression"), "AndAndExpression")(TParseTree("", false,[], s));
        }
    }
    static string AndAndExpression(GetName g)
    {
        return "D.AndAndExpression";
    }

    static TParseTree OrExpression(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(XorExpression, "D.OrExpression")(p);
        }
        else
        {
            if(auto m = tuple(`OrExpression`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(XorExpression, "D.OrExpression"), "OrExpression")(p);
                memo[tuple(`OrExpression`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree OrExpression(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(XorExpression, "D.OrExpression")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(XorExpression, "D.OrExpression"), "OrExpression")(TParseTree("", false,[], s));
        }
    }
    static string OrExpression(GetName g)
    {
        return "D.OrExpression";
    }

    static TParseTree XorExpression(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(AndExpression, "D.XorExpression")(p);
        }
        else
        {
            if(auto m = tuple(`XorExpression`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(AndExpression, "D.XorExpression"), "XorExpression")(p);
                memo[tuple(`XorExpression`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree XorExpression(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(AndExpression, "D.XorExpression")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(AndExpression, "D.XorExpression"), "XorExpression")(TParseTree("", false,[], s));
        }
    }
    static string XorExpression(GetName g)
    {
        return "D.XorExpression";
    }

    static TParseTree AndExpression(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(ShiftExpression, "D.AndExpression")(p);
        }
        else
        {
            if(auto m = tuple(`AndExpression`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(ShiftExpression, "D.AndExpression"), "AndExpression")(p);
                memo[tuple(`AndExpression`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree AndExpression(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(ShiftExpression, "D.AndExpression")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(ShiftExpression, "D.AndExpression"), "AndExpression")(TParseTree("", false,[], s));
        }
    }
    static string AndExpression(GetName g)
    {
        return "D.AndExpression";
    }

    static TParseTree ShiftExpression(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(AddExpression, "D.ShiftExpression")(p);
        }
        else
        {
            if(auto m = tuple(`ShiftExpression`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(AddExpression, "D.ShiftExpression"), "ShiftExpression")(p);
                memo[tuple(`ShiftExpression`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree ShiftExpression(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(AddExpression, "D.ShiftExpression")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(AddExpression, "D.ShiftExpression"), "ShiftExpression")(TParseTree("", false,[], s));
        }
    }
    static string ShiftExpression(GetName g)
    {
        return "D.ShiftExpression";
    }

    static TParseTree AddExpression(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.or!(pegged.peg.and!(pegged.peg.wrapAround!(Spacing, MulExpression, Spacing), pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("+"), Spacing), pegged.peg.wrapAround!(Spacing, AddExpression, Spacing)), pegged.peg.and!(pegged.peg.wrapAround!(Spacing, MulExpression, Spacing), pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("-"), Spacing), pegged.peg.wrapAround!(Spacing, AddExpression, Spacing)), pegged.peg.wrapAround!(Spacing, MulExpression, Spacing)), "D.AddExpression")(p);
        }
        else
        {
            if(auto m = tuple(`AddExpression`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.or!(pegged.peg.and!(pegged.peg.wrapAround!(Spacing, MulExpression, Spacing), pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("+"), Spacing), pegged.peg.wrapAround!(Spacing, AddExpression, Spacing)), pegged.peg.and!(pegged.peg.wrapAround!(Spacing, MulExpression, Spacing), pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("-"), Spacing), pegged.peg.wrapAround!(Spacing, AddExpression, Spacing)), pegged.peg.wrapAround!(Spacing, MulExpression, Spacing)), "D.AddExpression"), "AddExpression")(p);
                memo[tuple(`AddExpression`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree AddExpression(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.or!(pegged.peg.and!(pegged.peg.wrapAround!(Spacing, MulExpression, Spacing), pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("+"), Spacing), pegged.peg.wrapAround!(Spacing, AddExpression, Spacing)), pegged.peg.and!(pegged.peg.wrapAround!(Spacing, MulExpression, Spacing), pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("-"), Spacing), pegged.peg.wrapAround!(Spacing, AddExpression, Spacing)), pegged.peg.wrapAround!(Spacing, MulExpression, Spacing)), "D.AddExpression")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(pegged.peg.or!(pegged.peg.and!(pegged.peg.wrapAround!(Spacing, MulExpression, Spacing), pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("+"), Spacing), pegged.peg.wrapAround!(Spacing, AddExpression, Spacing)), pegged.peg.and!(pegged.peg.wrapAround!(Spacing, MulExpression, Spacing), pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("-"), Spacing), pegged.peg.wrapAround!(Spacing, AddExpression, Spacing)), pegged.peg.wrapAround!(Spacing, MulExpression, Spacing)), "D.AddExpression"), "AddExpression")(TParseTree("", false,[], s));
        }
    }
    static string AddExpression(GetName g)
    {
        return "D.AddExpression";
    }

    static TParseTree MulExpression(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.or!(pegged.peg.and!(pegged.peg.wrapAround!(Spacing, UnaryExpression, Spacing), pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("*"), Spacing), pegged.peg.wrapAround!(Spacing, MulExpression, Spacing)), pegged.peg.and!(pegged.peg.wrapAround!(Spacing, UnaryExpression, Spacing), pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("/"), Spacing), pegged.peg.wrapAround!(Spacing, MulExpression, Spacing)), pegged.peg.and!(pegged.peg.wrapAround!(Spacing, UnaryExpression, Spacing), pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("%"), Spacing), pegged.peg.wrapAround!(Spacing, MulExpression, Spacing)), pegged.peg.wrapAround!(Spacing, UnaryExpression, Spacing)), "D.MulExpression")(p);
        }
        else
        {
            if(auto m = tuple(`MulExpression`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.or!(pegged.peg.and!(pegged.peg.wrapAround!(Spacing, UnaryExpression, Spacing), pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("*"), Spacing), pegged.peg.wrapAround!(Spacing, MulExpression, Spacing)), pegged.peg.and!(pegged.peg.wrapAround!(Spacing, UnaryExpression, Spacing), pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("/"), Spacing), pegged.peg.wrapAround!(Spacing, MulExpression, Spacing)), pegged.peg.and!(pegged.peg.wrapAround!(Spacing, UnaryExpression, Spacing), pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("%"), Spacing), pegged.peg.wrapAround!(Spacing, MulExpression, Spacing)), pegged.peg.wrapAround!(Spacing, UnaryExpression, Spacing)), "D.MulExpression"), "MulExpression")(p);
                memo[tuple(`MulExpression`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree MulExpression(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.or!(pegged.peg.and!(pegged.peg.wrapAround!(Spacing, UnaryExpression, Spacing), pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("*"), Spacing), pegged.peg.wrapAround!(Spacing, MulExpression, Spacing)), pegged.peg.and!(pegged.peg.wrapAround!(Spacing, UnaryExpression, Spacing), pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("/"), Spacing), pegged.peg.wrapAround!(Spacing, MulExpression, Spacing)), pegged.peg.and!(pegged.peg.wrapAround!(Spacing, UnaryExpression, Spacing), pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("%"), Spacing), pegged.peg.wrapAround!(Spacing, MulExpression, Spacing)), pegged.peg.wrapAround!(Spacing, UnaryExpression, Spacing)), "D.MulExpression")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(pegged.peg.or!(pegged.peg.and!(pegged.peg.wrapAround!(Spacing, UnaryExpression, Spacing), pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("*"), Spacing), pegged.peg.wrapAround!(Spacing, MulExpression, Spacing)), pegged.peg.and!(pegged.peg.wrapAround!(Spacing, UnaryExpression, Spacing), pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("/"), Spacing), pegged.peg.wrapAround!(Spacing, MulExpression, Spacing)), pegged.peg.and!(pegged.peg.wrapAround!(Spacing, UnaryExpression, Spacing), pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("%"), Spacing), pegged.peg.wrapAround!(Spacing, MulExpression, Spacing)), pegged.peg.wrapAround!(Spacing, UnaryExpression, Spacing)), "D.MulExpression"), "MulExpression")(TParseTree("", false,[], s));
        }
    }
    static string MulExpression(GetName g)
    {
        return "D.MulExpression";
    }

    static TParseTree UnaryExpression(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.or!(pegged.peg.and!(pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("-"), Spacing), pegged.peg.wrapAround!(Spacing, UnaryExpression, Spacing)), pegged.peg.and!(pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("+"), Spacing), pegged.peg.wrapAround!(Spacing, UnaryExpression, Spacing)), pegged.peg.wrapAround!(Spacing, PowExpression, Spacing)), "D.UnaryExpression")(p);
        }
        else
        {
            if(auto m = tuple(`UnaryExpression`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.or!(pegged.peg.and!(pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("-"), Spacing), pegged.peg.wrapAround!(Spacing, UnaryExpression, Spacing)), pegged.peg.and!(pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("+"), Spacing), pegged.peg.wrapAround!(Spacing, UnaryExpression, Spacing)), pegged.peg.wrapAround!(Spacing, PowExpression, Spacing)), "D.UnaryExpression"), "UnaryExpression")(p);
                memo[tuple(`UnaryExpression`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree UnaryExpression(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.or!(pegged.peg.and!(pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("-"), Spacing), pegged.peg.wrapAround!(Spacing, UnaryExpression, Spacing)), pegged.peg.and!(pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("+"), Spacing), pegged.peg.wrapAround!(Spacing, UnaryExpression, Spacing)), pegged.peg.wrapAround!(Spacing, PowExpression, Spacing)), "D.UnaryExpression")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(pegged.peg.or!(pegged.peg.and!(pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("-"), Spacing), pegged.peg.wrapAround!(Spacing, UnaryExpression, Spacing)), pegged.peg.and!(pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("+"), Spacing), pegged.peg.wrapAround!(Spacing, UnaryExpression, Spacing)), pegged.peg.wrapAround!(Spacing, PowExpression, Spacing)), "D.UnaryExpression"), "UnaryExpression")(TParseTree("", false,[], s));
        }
    }
    static string UnaryExpression(GetName g)
    {
        return "D.UnaryExpression";
    }

    static TParseTree PowExpression(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(PostfixExpression, "D.PowExpression")(p);
        }
        else
        {
            if(auto m = tuple(`PowExpression`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(PostfixExpression, "D.PowExpression"), "PowExpression")(p);
                memo[tuple(`PowExpression`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree PowExpression(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(PostfixExpression, "D.PowExpression")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(PostfixExpression, "D.PowExpression"), "PowExpression")(TParseTree("", false,[], s));
        }
    }
    static string PowExpression(GetName g)
    {
        return "D.PowExpression";
    }

    static TParseTree PostfixExpression(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(PrimaryExpression, "D.PostfixExpression")(p);
        }
        else
        {
            if(auto m = tuple(`PostfixExpression`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(PrimaryExpression, "D.PostfixExpression"), "PostfixExpression")(p);
                memo[tuple(`PostfixExpression`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree PostfixExpression(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(PrimaryExpression, "D.PostfixExpression")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(PrimaryExpression, "D.PostfixExpression"), "PostfixExpression")(TParseTree("", false,[], s));
        }
    }
    static string PostfixExpression(GetName g)
    {
        return "D.PostfixExpression";
    }

    static TParseTree PrimaryExpression(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.or!(FloatLiteral, IntegerLiteral, StringLiteral, CharacterLiteral, pegged.peg.and!(pegged.peg.discard!(pegged.peg.literal!("(")), Expression, pegged.peg.discard!(pegged.peg.literal!(")")))), "D.PrimaryExpression")(p);
        }
        else
        {
            if(auto m = tuple(`PrimaryExpression`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.or!(FloatLiteral, IntegerLiteral, StringLiteral, CharacterLiteral, pegged.peg.and!(pegged.peg.discard!(pegged.peg.literal!("(")), Expression, pegged.peg.discard!(pegged.peg.literal!(")")))), "D.PrimaryExpression"), "PrimaryExpression")(p);
                memo[tuple(`PrimaryExpression`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree PrimaryExpression(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.or!(FloatLiteral, IntegerLiteral, StringLiteral, CharacterLiteral, pegged.peg.and!(pegged.peg.discard!(pegged.peg.literal!("(")), Expression, pegged.peg.discard!(pegged.peg.literal!(")")))), "D.PrimaryExpression")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(pegged.peg.or!(FloatLiteral, IntegerLiteral, StringLiteral, CharacterLiteral, pegged.peg.and!(pegged.peg.discard!(pegged.peg.literal!("(")), Expression, pegged.peg.discard!(pegged.peg.literal!(")")))), "D.PrimaryExpression"), "PrimaryExpression")(TParseTree("", false,[], s));
        }
    }
    static string PrimaryExpression(GetName g)
    {
        return "D.PrimaryExpression";
    }

    static TParseTree Identifier(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(identifier, "D.Identifier")(p);
        }
        else
        {
            if(auto m = tuple(`Identifier`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(identifier, "D.Identifier"), "Identifier")(p);
                memo[tuple(`Identifier`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree Identifier(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(identifier, "D.Identifier")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(identifier, "D.Identifier"), "Identifier")(TParseTree("", false,[], s));
        }
    }
    static string Identifier(GetName g)
    {
        return "D.Identifier";
    }

    static TParseTree FunctionBody(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.or!(BlockStatement, BodyStatement), "D.FunctionBody")(p);
        }
        else
        {
            if(auto m = tuple(`FunctionBody`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.or!(BlockStatement, BodyStatement), "D.FunctionBody"), "FunctionBody")(p);
                memo[tuple(`FunctionBody`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree FunctionBody(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.or!(BlockStatement, BodyStatement), "D.FunctionBody")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(pegged.peg.or!(BlockStatement, BodyStatement), "D.FunctionBody"), "FunctionBody")(TParseTree("", false,[], s));
        }
    }
    static string FunctionBody(GetName g)
    {
        return "D.FunctionBody";
    }

    static TParseTree BodyStatement(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.and!(pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("body"), Spacing), pegged.peg.wrapAround!(Spacing, BlockStatement, Spacing)), "D.BodyStatement")(p);
        }
        else
        {
            if(auto m = tuple(`BodyStatement`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.and!(pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("body"), Spacing), pegged.peg.wrapAround!(Spacing, BlockStatement, Spacing)), "D.BodyStatement"), "BodyStatement")(p);
                memo[tuple(`BodyStatement`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree BodyStatement(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.and!(pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("body"), Spacing), pegged.peg.wrapAround!(Spacing, BlockStatement, Spacing)), "D.BodyStatement")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(pegged.peg.and!(pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("body"), Spacing), pegged.peg.wrapAround!(Spacing, BlockStatement, Spacing)), "D.BodyStatement"), "BodyStatement")(TParseTree("", false,[], s));
        }
    }
    static string BodyStatement(GetName g)
    {
        return "D.BodyStatement";
    }

    static TParseTree BlockStatement(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.or!(pegged.peg.and!(pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("{"), Spacing), pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("}"), Spacing)), pegged.peg.and!(pegged.peg.discard!(pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("{"), Spacing)), pegged.peg.wrapAround!(Spacing, StatementList, Spacing), pegged.peg.discard!(pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("}"), Spacing)))), "D.BlockStatement")(p);
        }
        else
        {
            if(auto m = tuple(`BlockStatement`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.or!(pegged.peg.and!(pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("{"), Spacing), pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("}"), Spacing)), pegged.peg.and!(pegged.peg.discard!(pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("{"), Spacing)), pegged.peg.wrapAround!(Spacing, StatementList, Spacing), pegged.peg.discard!(pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("}"), Spacing)))), "D.BlockStatement"), "BlockStatement")(p);
                memo[tuple(`BlockStatement`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree BlockStatement(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.or!(pegged.peg.and!(pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("{"), Spacing), pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("}"), Spacing)), pegged.peg.and!(pegged.peg.discard!(pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("{"), Spacing)), pegged.peg.wrapAround!(Spacing, StatementList, Spacing), pegged.peg.discard!(pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("}"), Spacing)))), "D.BlockStatement")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(pegged.peg.or!(pegged.peg.and!(pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("{"), Spacing), pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("}"), Spacing)), pegged.peg.and!(pegged.peg.discard!(pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("{"), Spacing)), pegged.peg.wrapAround!(Spacing, StatementList, Spacing), pegged.peg.discard!(pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("}"), Spacing)))), "D.BlockStatement"), "BlockStatement")(TParseTree("", false,[], s));
        }
    }
    static string BlockStatement(GetName g)
    {
        return "D.BlockStatement";
    }

    static TParseTree StatementList(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.oneOrMore!(Statement), "D.StatementList")(p);
        }
        else
        {
            if(auto m = tuple(`StatementList`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.oneOrMore!(Statement), "D.StatementList"), "StatementList")(p);
                memo[tuple(`StatementList`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree StatementList(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.oneOrMore!(Statement), "D.StatementList")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(pegged.peg.oneOrMore!(Statement), "D.StatementList"), "StatementList")(TParseTree("", false,[], s));
        }
    }
    static string StatementList(GetName g)
    {
        return "D.StatementList";
    }

    static TParseTree Statement(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.or!(pegged.peg.literal!(";"), NonEmptyStatement), "D.Statement")(p);
        }
        else
        {
            if(auto m = tuple(`Statement`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.or!(pegged.peg.literal!(";"), NonEmptyStatement), "D.Statement"), "Statement")(p);
                memo[tuple(`Statement`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree Statement(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.or!(pegged.peg.literal!(";"), NonEmptyStatement), "D.Statement")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(pegged.peg.or!(pegged.peg.literal!(";"), NonEmptyStatement), "D.Statement"), "Statement")(TParseTree("", false,[], s));
        }
    }
    static string Statement(GetName g)
    {
        return "D.Statement";
    }

    static TParseTree NonEmptyStatement(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(NonEmptyStatementNoCaseNoDefault, "D.NonEmptyStatement")(p);
        }
        else
        {
            if(auto m = tuple(`NonEmptyStatement`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(NonEmptyStatementNoCaseNoDefault, "D.NonEmptyStatement"), "NonEmptyStatement")(p);
                memo[tuple(`NonEmptyStatement`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree NonEmptyStatement(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(NonEmptyStatementNoCaseNoDefault, "D.NonEmptyStatement")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(NonEmptyStatementNoCaseNoDefault, "D.NonEmptyStatement"), "NonEmptyStatement")(TParseTree("", false,[], s));
        }
    }
    static string NonEmptyStatement(GetName g)
    {
        return "D.NonEmptyStatement";
    }

    static TParseTree NonEmptyStatementNoCaseNoDefault(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.or!(DeclarationStatement, ReturnStatement), "D.NonEmptyStatementNoCaseNoDefault")(p);
        }
        else
        {
            if(auto m = tuple(`NonEmptyStatementNoCaseNoDefault`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.or!(DeclarationStatement, ReturnStatement), "D.NonEmptyStatementNoCaseNoDefault"), "NonEmptyStatementNoCaseNoDefault")(p);
                memo[tuple(`NonEmptyStatementNoCaseNoDefault`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree NonEmptyStatementNoCaseNoDefault(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.or!(DeclarationStatement, ReturnStatement), "D.NonEmptyStatementNoCaseNoDefault")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(pegged.peg.or!(DeclarationStatement, ReturnStatement), "D.NonEmptyStatementNoCaseNoDefault"), "NonEmptyStatementNoCaseNoDefault")(TParseTree("", false,[], s));
        }
    }
    static string NonEmptyStatementNoCaseNoDefault(GetName g)
    {
        return "D.NonEmptyStatementNoCaseNoDefault";
    }

    static TParseTree DeclarationStatement(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(Declaration, "D.DeclarationStatement")(p);
        }
        else
        {
            if(auto m = tuple(`DeclarationStatement`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(Declaration, "D.DeclarationStatement"), "DeclarationStatement")(p);
                memo[tuple(`DeclarationStatement`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree DeclarationStatement(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(Declaration, "D.DeclarationStatement")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(Declaration, "D.DeclarationStatement"), "DeclarationStatement")(TParseTree("", false,[], s));
        }
    }
    static string DeclarationStatement(GetName g)
    {
        return "D.DeclarationStatement";
    }

    static TParseTree ReturnStatement(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.and!(pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("return"), Spacing), pegged.peg.option!(pegged.peg.wrapAround!(Spacing, Expression, Spacing)), pegged.peg.discard!(pegged.peg.wrapAround!(Spacing, pegged.peg.literal!(";"), Spacing))), "D.ReturnStatement")(p);
        }
        else
        {
            if(auto m = tuple(`ReturnStatement`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.and!(pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("return"), Spacing), pegged.peg.option!(pegged.peg.wrapAround!(Spacing, Expression, Spacing)), pegged.peg.discard!(pegged.peg.wrapAround!(Spacing, pegged.peg.literal!(";"), Spacing))), "D.ReturnStatement"), "ReturnStatement")(p);
                memo[tuple(`ReturnStatement`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree ReturnStatement(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.and!(pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("return"), Spacing), pegged.peg.option!(pegged.peg.wrapAround!(Spacing, Expression, Spacing)), pegged.peg.discard!(pegged.peg.wrapAround!(Spacing, pegged.peg.literal!(";"), Spacing))), "D.ReturnStatement")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(pegged.peg.and!(pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("return"), Spacing), pegged.peg.option!(pegged.peg.wrapAround!(Spacing, Expression, Spacing)), pegged.peg.discard!(pegged.peg.wrapAround!(Spacing, pegged.peg.literal!(";"), Spacing))), "D.ReturnStatement"), "ReturnStatement")(TParseTree("", false,[], s));
        }
    }
    static string ReturnStatement(GetName g)
    {
        return "D.ReturnStatement";
    }

    static TParseTree Expression(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(CommaExpression, "D.Expression")(p);
        }
        else
        {
            if(auto m = tuple(`Expression`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(CommaExpression, "D.Expression"), "Expression")(p);
                memo[tuple(`Expression`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree Expression(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(CommaExpression, "D.Expression")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(CommaExpression, "D.Expression"), "Expression")(TParseTree("", false,[], s));
        }
    }
    static string Expression(GetName g)
    {
        return "D.Expression";
    }

    static TParseTree CommaExpression(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(AssignExpression, "D.CommaExpression")(p);
        }
        else
        {
            if(auto m = tuple(`CommaExpression`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(AssignExpression, "D.CommaExpression"), "CommaExpression")(p);
                memo[tuple(`CommaExpression`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree CommaExpression(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(AssignExpression, "D.CommaExpression")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(AssignExpression, "D.CommaExpression"), "CommaExpression")(TParseTree("", false,[], s));
        }
    }
    static string CommaExpression(GetName g)
    {
        return "D.CommaExpression";
    }

    static TParseTree Spacing(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.zeroOrMore!(pegged.peg.or!(Comment, spacing)), "D.Spacing")(p);
        }
        else
        {
            if(auto m = tuple(`Spacing`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.zeroOrMore!(pegged.peg.or!(Comment, spacing)), "D.Spacing"), "Spacing")(p);
                memo[tuple(`Spacing`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree Spacing(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.zeroOrMore!(pegged.peg.or!(Comment, spacing)), "D.Spacing")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(pegged.peg.zeroOrMore!(pegged.peg.or!(Comment, spacing)), "D.Spacing"), "Spacing")(TParseTree("", false,[], s));
        }
    }
    static string Spacing(GetName g)
    {
        return "D.Spacing";
    }

    static TParseTree Space(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.or!(pegged.peg.literal!("\u0020"), pegged.peg.literal!("\u0009"), pegged.peg.literal!("\u000b"), pegged.peg.literal!("\u000c"), eol), "D.Space")(p);
        }
        else
        {
            if(auto m = tuple(`Space`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.or!(pegged.peg.literal!("\u0020"), pegged.peg.literal!("\u0009"), pegged.peg.literal!("\u000b"), pegged.peg.literal!("\u000c"), eol), "D.Space"), "Space")(p);
                memo[tuple(`Space`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree Space(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.or!(pegged.peg.literal!("\u0020"), pegged.peg.literal!("\u0009"), pegged.peg.literal!("\u000b"), pegged.peg.literal!("\u000c"), eol), "D.Space")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(pegged.peg.or!(pegged.peg.literal!("\u0020"), pegged.peg.literal!("\u0009"), pegged.peg.literal!("\u000b"), pegged.peg.literal!("\u000c"), eol), "D.Space"), "Space")(TParseTree("", false,[], s));
        }
    }
    static string Space(GetName g)
    {
        return "D.Space";
    }

    static TParseTree Comment(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.discard!(pegged.peg.or!(BlockComment, LineComment, NestingBlockComment)), "D.Comment")(p);
        }
        else
        {
            if(auto m = tuple(`Comment`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.discard!(pegged.peg.or!(BlockComment, LineComment, NestingBlockComment)), "D.Comment"), "Comment")(p);
                memo[tuple(`Comment`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree Comment(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.discard!(pegged.peg.or!(BlockComment, LineComment, NestingBlockComment)), "D.Comment")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(pegged.peg.discard!(pegged.peg.or!(BlockComment, LineComment, NestingBlockComment)), "D.Comment"), "Comment")(TParseTree("", false,[], s));
        }
    }
    static string Comment(GetName g)
    {
        return "D.Comment";
    }

    static TParseTree BlockComment(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.fuse!(pegged.peg.and!(pegged.peg.discard!(pegged.peg.literal!("/*")), pegged.peg.zeroOrMore!(pegged.peg.and!(pegged.peg.negLookahead!(pegged.peg.literal!("*/")), pegged.peg.any)), pegged.peg.discard!(pegged.peg.literal!("*/")))), "D.BlockComment")(p);
        }
        else
        {
            if(auto m = tuple(`BlockComment`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.fuse!(pegged.peg.and!(pegged.peg.discard!(pegged.peg.literal!("/*")), pegged.peg.zeroOrMore!(pegged.peg.and!(pegged.peg.negLookahead!(pegged.peg.literal!("*/")), pegged.peg.any)), pegged.peg.discard!(pegged.peg.literal!("*/")))), "D.BlockComment"), "BlockComment")(p);
                memo[tuple(`BlockComment`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree BlockComment(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.fuse!(pegged.peg.and!(pegged.peg.discard!(pegged.peg.literal!("/*")), pegged.peg.zeroOrMore!(pegged.peg.and!(pegged.peg.negLookahead!(pegged.peg.literal!("*/")), pegged.peg.any)), pegged.peg.discard!(pegged.peg.literal!("*/")))), "D.BlockComment")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(pegged.peg.fuse!(pegged.peg.and!(pegged.peg.discard!(pegged.peg.literal!("/*")), pegged.peg.zeroOrMore!(pegged.peg.and!(pegged.peg.negLookahead!(pegged.peg.literal!("*/")), pegged.peg.any)), pegged.peg.discard!(pegged.peg.literal!("*/")))), "D.BlockComment"), "BlockComment")(TParseTree("", false,[], s));
        }
    }
    static string BlockComment(GetName g)
    {
        return "D.BlockComment";
    }

    static TParseTree LineComment(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.fuse!(pegged.peg.and!(pegged.peg.discard!(pegged.peg.literal!("//")), pegged.peg.zeroOrMore!(pegged.peg.and!(pegged.peg.negLookahead!(eol), pegged.peg.any)), pegged.peg.discard!(eol))), "D.LineComment")(p);
        }
        else
        {
            if(auto m = tuple(`LineComment`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.fuse!(pegged.peg.and!(pegged.peg.discard!(pegged.peg.literal!("//")), pegged.peg.zeroOrMore!(pegged.peg.and!(pegged.peg.negLookahead!(eol), pegged.peg.any)), pegged.peg.discard!(eol))), "D.LineComment"), "LineComment")(p);
                memo[tuple(`LineComment`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree LineComment(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.fuse!(pegged.peg.and!(pegged.peg.discard!(pegged.peg.literal!("//")), pegged.peg.zeroOrMore!(pegged.peg.and!(pegged.peg.negLookahead!(eol), pegged.peg.any)), pegged.peg.discard!(eol))), "D.LineComment")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(pegged.peg.fuse!(pegged.peg.and!(pegged.peg.discard!(pegged.peg.literal!("//")), pegged.peg.zeroOrMore!(pegged.peg.and!(pegged.peg.negLookahead!(eol), pegged.peg.any)), pegged.peg.discard!(eol))), "D.LineComment"), "LineComment")(TParseTree("", false,[], s));
        }
    }
    static string LineComment(GetName g)
    {
        return "D.LineComment";
    }

    static TParseTree NestingBlockComment(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.fuse!(pegged.peg.and!(pegged.peg.discard!(pegged.peg.literal!("/+")), pegged.peg.zeroOrMore!(pegged.peg.or!(NestingBlockComment, pegged.peg.and!(pegged.peg.negLookahead!(pegged.peg.keywords!("+/", "/+")), pegged.peg.any))), pegged.peg.discard!(pegged.peg.literal!("+/")))), "D.NestingBlockComment")(p);
        }
        else
        {
            if(auto m = tuple(`NestingBlockComment`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.fuse!(pegged.peg.and!(pegged.peg.discard!(pegged.peg.literal!("/+")), pegged.peg.zeroOrMore!(pegged.peg.or!(NestingBlockComment, pegged.peg.and!(pegged.peg.negLookahead!(pegged.peg.keywords!("+/", "/+")), pegged.peg.any))), pegged.peg.discard!(pegged.peg.literal!("+/")))), "D.NestingBlockComment"), "NestingBlockComment")(p);
                memo[tuple(`NestingBlockComment`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree NestingBlockComment(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.fuse!(pegged.peg.and!(pegged.peg.discard!(pegged.peg.literal!("/+")), pegged.peg.zeroOrMore!(pegged.peg.or!(NestingBlockComment, pegged.peg.and!(pegged.peg.negLookahead!(pegged.peg.keywords!("+/", "/+")), pegged.peg.any))), pegged.peg.discard!(pegged.peg.literal!("+/")))), "D.NestingBlockComment")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(pegged.peg.fuse!(pegged.peg.and!(pegged.peg.discard!(pegged.peg.literal!("/+")), pegged.peg.zeroOrMore!(pegged.peg.or!(NestingBlockComment, pegged.peg.and!(pegged.peg.negLookahead!(pegged.peg.keywords!("+/", "/+")), pegged.peg.any))), pegged.peg.discard!(pegged.peg.literal!("+/")))), "D.NestingBlockComment"), "NestingBlockComment")(TParseTree("", false,[], s));
        }
    }
    static string NestingBlockComment(GetName g)
    {
        return "D.NestingBlockComment";
    }

    static TParseTree StringLiteral(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(DoubleQuotedString, "D.StringLiteral")(p);
        }
        else
        {
            if(auto m = tuple(`StringLiteral`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(DoubleQuotedString, "D.StringLiteral"), "StringLiteral")(p);
                memo[tuple(`StringLiteral`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree StringLiteral(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(DoubleQuotedString, "D.StringLiteral")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(DoubleQuotedString, "D.StringLiteral"), "StringLiteral")(TParseTree("", false,[], s));
        }
    }
    static string StringLiteral(GetName g)
    {
        return "D.StringLiteral";
    }

    static TParseTree DoubleQuotedString(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.or!(pegged.peg.and!(pegged.peg.discard!(doublequote), pegged.peg.literal!(``), pegged.peg.discard!(doublequote), pegged.peg.option!(StringPostfix)), pegged.peg.and!(pegged.peg.discard!(doublequote), DoubleQuotedCharacters, pegged.peg.discard!(doublequote), pegged.peg.option!(StringPostfix))), "D.DoubleQuotedString")(p);
        }
        else
        {
            if(auto m = tuple(`DoubleQuotedString`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.or!(pegged.peg.and!(pegged.peg.discard!(doublequote), pegged.peg.literal!(``), pegged.peg.discard!(doublequote), pegged.peg.option!(StringPostfix)), pegged.peg.and!(pegged.peg.discard!(doublequote), DoubleQuotedCharacters, pegged.peg.discard!(doublequote), pegged.peg.option!(StringPostfix))), "D.DoubleQuotedString"), "DoubleQuotedString")(p);
                memo[tuple(`DoubleQuotedString`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree DoubleQuotedString(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.or!(pegged.peg.and!(pegged.peg.discard!(doublequote), pegged.peg.literal!(``), pegged.peg.discard!(doublequote), pegged.peg.option!(StringPostfix)), pegged.peg.and!(pegged.peg.discard!(doublequote), DoubleQuotedCharacters, pegged.peg.discard!(doublequote), pegged.peg.option!(StringPostfix))), "D.DoubleQuotedString")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(pegged.peg.or!(pegged.peg.and!(pegged.peg.discard!(doublequote), pegged.peg.literal!(``), pegged.peg.discard!(doublequote), pegged.peg.option!(StringPostfix)), pegged.peg.and!(pegged.peg.discard!(doublequote), DoubleQuotedCharacters, pegged.peg.discard!(doublequote), pegged.peg.option!(StringPostfix))), "D.DoubleQuotedString"), "DoubleQuotedString")(TParseTree("", false,[], s));
        }
    }
    static string DoubleQuotedString(GetName g)
    {
        return "D.DoubleQuotedString";
    }

    static TParseTree DoubleQuotedCharacters(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.fuse!(pegged.peg.zeroOrMore!(DoubleQuotedCharacter)), "D.DoubleQuotedCharacters")(p);
        }
        else
        {
            if(auto m = tuple(`DoubleQuotedCharacters`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.fuse!(pegged.peg.zeroOrMore!(DoubleQuotedCharacter)), "D.DoubleQuotedCharacters"), "DoubleQuotedCharacters")(p);
                memo[tuple(`DoubleQuotedCharacters`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree DoubleQuotedCharacters(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.fuse!(pegged.peg.zeroOrMore!(DoubleQuotedCharacter)), "D.DoubleQuotedCharacters")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(pegged.peg.fuse!(pegged.peg.zeroOrMore!(DoubleQuotedCharacter)), "D.DoubleQuotedCharacters"), "DoubleQuotedCharacters")(TParseTree("", false,[], s));
        }
    }
    static string DoubleQuotedCharacters(GetName g)
    {
        return "D.DoubleQuotedCharacters";
    }

    static TParseTree DoubleQuotedCharacter(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.or!(pegged.peg.and!(pegged.peg.negLookahead!(doublequote), Character), EscapeSequence, eol), "D.DoubleQuotedCharacter")(p);
        }
        else
        {
            if(auto m = tuple(`DoubleQuotedCharacter`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.or!(pegged.peg.and!(pegged.peg.negLookahead!(doublequote), Character), EscapeSequence, eol), "D.DoubleQuotedCharacter"), "DoubleQuotedCharacter")(p);
                memo[tuple(`DoubleQuotedCharacter`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree DoubleQuotedCharacter(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.or!(pegged.peg.and!(pegged.peg.negLookahead!(doublequote), Character), EscapeSequence, eol), "D.DoubleQuotedCharacter")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(pegged.peg.or!(pegged.peg.and!(pegged.peg.negLookahead!(doublequote), Character), EscapeSequence, eol), "D.DoubleQuotedCharacter"), "DoubleQuotedCharacter")(TParseTree("", false,[], s));
        }
    }
    static string DoubleQuotedCharacter(GetName g)
    {
        return "D.DoubleQuotedCharacter";
    }

    static TParseTree EscapeSequence(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.or!(pegged.peg.literal!("\\'"), pegged.peg.literal!("\\f"), pegged.peg.literal!("\\n"), pegged.peg.literal!("\\r"), pegged.peg.literal!("\\t"), pegged.peg.literal!("\\v"), pegged.peg.and!(pegged.peg.literal!("\\x"), HexDigit, HexDigit), pegged.peg.and!(backslash, OctalDigit), pegged.peg.and!(backslash, OctalDigit, OctalDigit), pegged.peg.and!(backslash, OctalDigit, OctalDigit, OctalDigit), pegged.peg.and!(pegged.peg.literal!("\\u"), HexDigit, HexDigit, HexDigit, HexDigit), pegged.peg.and!(pegged.peg.literal!("\\U"), HexDigit, HexDigit, HexDigit, HexDigit, HexDigit, HexDigit, HexDigit, HexDigit)), "D.EscapeSequence")(p);
        }
        else
        {
            if(auto m = tuple(`EscapeSequence`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.or!(pegged.peg.literal!("\\'"), pegged.peg.literal!("\\f"), pegged.peg.literal!("\\n"), pegged.peg.literal!("\\r"), pegged.peg.literal!("\\t"), pegged.peg.literal!("\\v"), pegged.peg.and!(pegged.peg.literal!("\\x"), HexDigit, HexDigit), pegged.peg.and!(backslash, OctalDigit), pegged.peg.and!(backslash, OctalDigit, OctalDigit), pegged.peg.and!(backslash, OctalDigit, OctalDigit, OctalDigit), pegged.peg.and!(pegged.peg.literal!("\\u"), HexDigit, HexDigit, HexDigit, HexDigit), pegged.peg.and!(pegged.peg.literal!("\\U"), HexDigit, HexDigit, HexDigit, HexDigit, HexDigit, HexDigit, HexDigit, HexDigit)), "D.EscapeSequence"), "EscapeSequence")(p);
                memo[tuple(`EscapeSequence`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree EscapeSequence(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.or!(pegged.peg.literal!("\\'"), pegged.peg.literal!("\\f"), pegged.peg.literal!("\\n"), pegged.peg.literal!("\\r"), pegged.peg.literal!("\\t"), pegged.peg.literal!("\\v"), pegged.peg.and!(pegged.peg.literal!("\\x"), HexDigit, HexDigit), pegged.peg.and!(backslash, OctalDigit), pegged.peg.and!(backslash, OctalDigit, OctalDigit), pegged.peg.and!(backslash, OctalDigit, OctalDigit, OctalDigit), pegged.peg.and!(pegged.peg.literal!("\\u"), HexDigit, HexDigit, HexDigit, HexDigit), pegged.peg.and!(pegged.peg.literal!("\\U"), HexDigit, HexDigit, HexDigit, HexDigit, HexDigit, HexDigit, HexDigit, HexDigit)), "D.EscapeSequence")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(pegged.peg.or!(pegged.peg.literal!("\\'"), pegged.peg.literal!("\\f"), pegged.peg.literal!("\\n"), pegged.peg.literal!("\\r"), pegged.peg.literal!("\\t"), pegged.peg.literal!("\\v"), pegged.peg.and!(pegged.peg.literal!("\\x"), HexDigit, HexDigit), pegged.peg.and!(backslash, OctalDigit), pegged.peg.and!(backslash, OctalDigit, OctalDigit), pegged.peg.and!(backslash, OctalDigit, OctalDigit, OctalDigit), pegged.peg.and!(pegged.peg.literal!("\\u"), HexDigit, HexDigit, HexDigit, HexDigit), pegged.peg.and!(pegged.peg.literal!("\\U"), HexDigit, HexDigit, HexDigit, HexDigit, HexDigit, HexDigit, HexDigit, HexDigit)), "D.EscapeSequence"), "EscapeSequence")(TParseTree("", false,[], s));
        }
    }
    static string EscapeSequence(GetName g)
    {
        return "D.EscapeSequence";
    }

    static TParseTree StringPostfix(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.keywords!("c", "w", "d"), "D.StringPostfix")(p);
        }
        else
        {
            if(auto m = tuple(`StringPostfix`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.keywords!("c", "w", "d"), "D.StringPostfix"), "StringPostfix")(p);
                memo[tuple(`StringPostfix`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree StringPostfix(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.keywords!("c", "w", "d"), "D.StringPostfix")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(pegged.peg.keywords!("c", "w", "d"), "D.StringPostfix"), "StringPostfix")(TParseTree("", false,[], s));
        }
    }
    static string StringPostfix(GetName g)
    {
        return "D.StringPostfix";
    }

    static TParseTree CharacterLiteral(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.and!(pegged.peg.discard!(quote), SingleQuotedCharacter, pegged.peg.discard!(quote)), "D.CharacterLiteral")(p);
        }
        else
        {
            if(auto m = tuple(`CharacterLiteral`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.and!(pegged.peg.discard!(quote), SingleQuotedCharacter, pegged.peg.discard!(quote)), "D.CharacterLiteral"), "CharacterLiteral")(p);
                memo[tuple(`CharacterLiteral`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree CharacterLiteral(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.and!(pegged.peg.discard!(quote), SingleQuotedCharacter, pegged.peg.discard!(quote)), "D.CharacterLiteral")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(pegged.peg.and!(pegged.peg.discard!(quote), SingleQuotedCharacter, pegged.peg.discard!(quote)), "D.CharacterLiteral"), "CharacterLiteral")(TParseTree("", false,[], s));
        }
    }
    static string CharacterLiteral(GetName g)
    {
        return "D.CharacterLiteral";
    }

    static TParseTree SingleQuotedCharacter(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.or!(EscapeSequence, pegged.peg.and!(pegged.peg.negLookahead!(quote), Character)), "D.SingleQuotedCharacter")(p);
        }
        else
        {
            if(auto m = tuple(`SingleQuotedCharacter`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.or!(EscapeSequence, pegged.peg.and!(pegged.peg.negLookahead!(quote), Character)), "D.SingleQuotedCharacter"), "SingleQuotedCharacter")(p);
                memo[tuple(`SingleQuotedCharacter`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree SingleQuotedCharacter(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.or!(EscapeSequence, pegged.peg.and!(pegged.peg.negLookahead!(quote), Character)), "D.SingleQuotedCharacter")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(pegged.peg.or!(EscapeSequence, pegged.peg.and!(pegged.peg.negLookahead!(quote), Character)), "D.SingleQuotedCharacter"), "SingleQuotedCharacter")(TParseTree("", false,[], s));
        }
    }
    static string SingleQuotedCharacter(GetName g)
    {
        return "D.SingleQuotedCharacter";
    }

    static TParseTree Character(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.any, "D.Character")(p);
        }
        else
        {
            if(auto m = tuple(`Character`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.any, "D.Character"), "Character")(p);
                memo[tuple(`Character`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree Character(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.any, "D.Character")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(pegged.peg.any, "D.Character"), "Character")(TParseTree("", false,[], s));
        }
    }
    static string Character(GetName g)
    {
        return "D.Character";
    }

    static TParseTree FloatLiteral(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.or!(Float, pegged.peg.and!(Float, Suffix), pegged.peg.and!(Integer, FloatSuffix, pegged.peg.option!(ImaginarySuffix)), pegged.peg.and!(Integer, ImaginarySuffix), pegged.peg.and!(Integer, RealSuffix, ImaginarySuffix)), "D.FloatLiteral")(p);
        }
        else
        {
            if(auto m = tuple(`FloatLiteral`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.or!(Float, pegged.peg.and!(Float, Suffix), pegged.peg.and!(Integer, FloatSuffix, pegged.peg.option!(ImaginarySuffix)), pegged.peg.and!(Integer, ImaginarySuffix), pegged.peg.and!(Integer, RealSuffix, ImaginarySuffix)), "D.FloatLiteral"), "FloatLiteral")(p);
                memo[tuple(`FloatLiteral`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree FloatLiteral(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.or!(Float, pegged.peg.and!(Float, Suffix), pegged.peg.and!(Integer, FloatSuffix, pegged.peg.option!(ImaginarySuffix)), pegged.peg.and!(Integer, ImaginarySuffix), pegged.peg.and!(Integer, RealSuffix, ImaginarySuffix)), "D.FloatLiteral")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(pegged.peg.or!(Float, pegged.peg.and!(Float, Suffix), pegged.peg.and!(Integer, FloatSuffix, pegged.peg.option!(ImaginarySuffix)), pegged.peg.and!(Integer, ImaginarySuffix), pegged.peg.and!(Integer, RealSuffix, ImaginarySuffix)), "D.FloatLiteral"), "FloatLiteral")(TParseTree("", false,[], s));
        }
    }
    static string FloatLiteral(GetName g)
    {
        return "D.FloatLiteral";
    }

    static TParseTree Float(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.or!(DecimalFloat, HexFloat), "D.Float")(p);
        }
        else
        {
            if(auto m = tuple(`Float`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.or!(DecimalFloat, HexFloat), "D.Float"), "Float")(p);
                memo[tuple(`Float`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree Float(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.or!(DecimalFloat, HexFloat), "D.Float")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(pegged.peg.or!(DecimalFloat, HexFloat), "D.Float"), "Float")(TParseTree("", false,[], s));
        }
    }
    static string Float(GetName g)
    {
        return "D.Float";
    }

    static TParseTree DecimalFloat(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.fuse!(pegged.peg.or!(pegged.peg.and!(LeadingDecimal, pegged.peg.literal!("."), pegged.peg.option!(DecimalDigits)), pegged.peg.and!(DecimalDigits, pegged.peg.literal!("."), DecimalDigitsNoSingleUS, DecimalExponent), pegged.peg.and!(pegged.peg.literal!("."), DecimalInteger, pegged.peg.option!(DecimalExponent)), pegged.peg.and!(LeadingDecimal, DecimalExponent))), "D.DecimalFloat")(p);
        }
        else
        {
            if(auto m = tuple(`DecimalFloat`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.fuse!(pegged.peg.or!(pegged.peg.and!(LeadingDecimal, pegged.peg.literal!("."), pegged.peg.option!(DecimalDigits)), pegged.peg.and!(DecimalDigits, pegged.peg.literal!("."), DecimalDigitsNoSingleUS, DecimalExponent), pegged.peg.and!(pegged.peg.literal!("."), DecimalInteger, pegged.peg.option!(DecimalExponent)), pegged.peg.and!(LeadingDecimal, DecimalExponent))), "D.DecimalFloat"), "DecimalFloat")(p);
                memo[tuple(`DecimalFloat`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree DecimalFloat(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.fuse!(pegged.peg.or!(pegged.peg.and!(LeadingDecimal, pegged.peg.literal!("."), pegged.peg.option!(DecimalDigits)), pegged.peg.and!(DecimalDigits, pegged.peg.literal!("."), DecimalDigitsNoSingleUS, DecimalExponent), pegged.peg.and!(pegged.peg.literal!("."), DecimalInteger, pegged.peg.option!(DecimalExponent)), pegged.peg.and!(LeadingDecimal, DecimalExponent))), "D.DecimalFloat")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(pegged.peg.fuse!(pegged.peg.or!(pegged.peg.and!(LeadingDecimal, pegged.peg.literal!("."), pegged.peg.option!(DecimalDigits)), pegged.peg.and!(DecimalDigits, pegged.peg.literal!("."), DecimalDigitsNoSingleUS, DecimalExponent), pegged.peg.and!(pegged.peg.literal!("."), DecimalInteger, pegged.peg.option!(DecimalExponent)), pegged.peg.and!(LeadingDecimal, DecimalExponent))), "D.DecimalFloat"), "DecimalFloat")(TParseTree("", false,[], s));
        }
    }
    static string DecimalFloat(GetName g)
    {
        return "D.DecimalFloat";
    }

    static TParseTree DecimalExponent(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.and!(DecimalExponentStart, DecimalDigitsNoSingleUS), "D.DecimalExponent")(p);
        }
        else
        {
            if(auto m = tuple(`DecimalExponent`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.and!(DecimalExponentStart, DecimalDigitsNoSingleUS), "D.DecimalExponent"), "DecimalExponent")(p);
                memo[tuple(`DecimalExponent`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree DecimalExponent(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.and!(DecimalExponentStart, DecimalDigitsNoSingleUS), "D.DecimalExponent")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(pegged.peg.and!(DecimalExponentStart, DecimalDigitsNoSingleUS), "D.DecimalExponent"), "DecimalExponent")(TParseTree("", false,[], s));
        }
    }
    static string DecimalExponent(GetName g)
    {
        return "D.DecimalExponent";
    }

    static TParseTree DecimalExponentStart(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.keywords!("e+", "E+", "e-", "E-", "e", "E"), "D.DecimalExponentStart")(p);
        }
        else
        {
            if(auto m = tuple(`DecimalExponentStart`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.keywords!("e+", "E+", "e-", "E-", "e", "E"), "D.DecimalExponentStart"), "DecimalExponentStart")(p);
                memo[tuple(`DecimalExponentStart`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree DecimalExponentStart(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.keywords!("e+", "E+", "e-", "E-", "e", "E"), "D.DecimalExponentStart")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(pegged.peg.keywords!("e+", "E+", "e-", "E-", "e", "E"), "D.DecimalExponentStart"), "DecimalExponentStart")(TParseTree("", false,[], s));
        }
    }
    static string DecimalExponentStart(GetName g)
    {
        return "D.DecimalExponentStart";
    }

    static TParseTree HexFloat(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.or!(pegged.peg.and!(HexPrefix, HexDigitsNoSingleUS, pegged.peg.literal!("."), HexDigitsNoSingleUS, HexExponent), pegged.peg.and!(HexPrefix, pegged.peg.literal!("."), HexDigitsNoSingleUS, HexExponent), pegged.peg.and!(HexPrefix, HexDigitsNoSingleUS, HexExponent)), "D.HexFloat")(p);
        }
        else
        {
            if(auto m = tuple(`HexFloat`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.or!(pegged.peg.and!(HexPrefix, HexDigitsNoSingleUS, pegged.peg.literal!("."), HexDigitsNoSingleUS, HexExponent), pegged.peg.and!(HexPrefix, pegged.peg.literal!("."), HexDigitsNoSingleUS, HexExponent), pegged.peg.and!(HexPrefix, HexDigitsNoSingleUS, HexExponent)), "D.HexFloat"), "HexFloat")(p);
                memo[tuple(`HexFloat`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree HexFloat(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.or!(pegged.peg.and!(HexPrefix, HexDigitsNoSingleUS, pegged.peg.literal!("."), HexDigitsNoSingleUS, HexExponent), pegged.peg.and!(HexPrefix, pegged.peg.literal!("."), HexDigitsNoSingleUS, HexExponent), pegged.peg.and!(HexPrefix, HexDigitsNoSingleUS, HexExponent)), "D.HexFloat")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(pegged.peg.or!(pegged.peg.and!(HexPrefix, HexDigitsNoSingleUS, pegged.peg.literal!("."), HexDigitsNoSingleUS, HexExponent), pegged.peg.and!(HexPrefix, pegged.peg.literal!("."), HexDigitsNoSingleUS, HexExponent), pegged.peg.and!(HexPrefix, HexDigitsNoSingleUS, HexExponent)), "D.HexFloat"), "HexFloat")(TParseTree("", false,[], s));
        }
    }
    static string HexFloat(GetName g)
    {
        return "D.HexFloat";
    }

    static TParseTree HexPrefix(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.discard!(pegged.peg.keywords!("0x", "0X")), "D.HexPrefix")(p);
        }
        else
        {
            if(auto m = tuple(`HexPrefix`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.discard!(pegged.peg.keywords!("0x", "0X")), "D.HexPrefix"), "HexPrefix")(p);
                memo[tuple(`HexPrefix`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree HexPrefix(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.discard!(pegged.peg.keywords!("0x", "0X")), "D.HexPrefix")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(pegged.peg.discard!(pegged.peg.keywords!("0x", "0X")), "D.HexPrefix"), "HexPrefix")(TParseTree("", false,[], s));
        }
    }
    static string HexPrefix(GetName g)
    {
        return "D.HexPrefix";
    }

    static TParseTree HexExponent(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.and!(HexExponentStart, DecimalDigitsNoSingleUS), "D.HexExponent")(p);
        }
        else
        {
            if(auto m = tuple(`HexExponent`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.and!(HexExponentStart, DecimalDigitsNoSingleUS), "D.HexExponent"), "HexExponent")(p);
                memo[tuple(`HexExponent`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree HexExponent(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.and!(HexExponentStart, DecimalDigitsNoSingleUS), "D.HexExponent")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(pegged.peg.and!(HexExponentStart, DecimalDigitsNoSingleUS), "D.HexExponent"), "HexExponent")(TParseTree("", false,[], s));
        }
    }
    static string HexExponent(GetName g)
    {
        return "D.HexExponent";
    }

    static TParseTree HexExponentStart(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.keywords!("p+", "P+", "p-", "P-", "p", "P"), "D.HexExponentStart")(p);
        }
        else
        {
            if(auto m = tuple(`HexExponentStart`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.keywords!("p+", "P+", "p-", "P-", "p", "P"), "D.HexExponentStart"), "HexExponentStart")(p);
                memo[tuple(`HexExponentStart`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree HexExponentStart(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.keywords!("p+", "P+", "p-", "P-", "p", "P"), "D.HexExponentStart")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(pegged.peg.keywords!("p+", "P+", "p-", "P-", "p", "P"), "D.HexExponentStart"), "HexExponentStart")(TParseTree("", false,[], s));
        }
    }
    static string HexExponentStart(GetName g)
    {
        return "D.HexExponentStart";
    }

    static TParseTree Suffix(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.or!(FloatSuffix, RealSuffix, ImaginarySuffix, pegged.peg.and!(FloatSuffix, ImaginarySuffix), pegged.peg.and!(RealSuffix, ImaginarySuffix)), "D.Suffix")(p);
        }
        else
        {
            if(auto m = tuple(`Suffix`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.or!(FloatSuffix, RealSuffix, ImaginarySuffix, pegged.peg.and!(FloatSuffix, ImaginarySuffix), pegged.peg.and!(RealSuffix, ImaginarySuffix)), "D.Suffix"), "Suffix")(p);
                memo[tuple(`Suffix`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree Suffix(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.or!(FloatSuffix, RealSuffix, ImaginarySuffix, pegged.peg.and!(FloatSuffix, ImaginarySuffix), pegged.peg.and!(RealSuffix, ImaginarySuffix)), "D.Suffix")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(pegged.peg.or!(FloatSuffix, RealSuffix, ImaginarySuffix, pegged.peg.and!(FloatSuffix, ImaginarySuffix), pegged.peg.and!(RealSuffix, ImaginarySuffix)), "D.Suffix"), "Suffix")(TParseTree("", false,[], s));
        }
    }
    static string Suffix(GetName g)
    {
        return "D.Suffix";
    }

    static TParseTree FloatSuffix(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.keywords!("f", "F"), "D.FloatSuffix")(p);
        }
        else
        {
            if(auto m = tuple(`FloatSuffix`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.keywords!("f", "F"), "D.FloatSuffix"), "FloatSuffix")(p);
                memo[tuple(`FloatSuffix`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree FloatSuffix(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.keywords!("f", "F"), "D.FloatSuffix")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(pegged.peg.keywords!("f", "F"), "D.FloatSuffix"), "FloatSuffix")(TParseTree("", false,[], s));
        }
    }
    static string FloatSuffix(GetName g)
    {
        return "D.FloatSuffix";
    }

    static TParseTree RealSuffix(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.literal!("L"), "D.RealSuffix")(p);
        }
        else
        {
            if(auto m = tuple(`RealSuffix`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.literal!("L"), "D.RealSuffix"), "RealSuffix")(p);
                memo[tuple(`RealSuffix`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree RealSuffix(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.literal!("L"), "D.RealSuffix")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(pegged.peg.literal!("L"), "D.RealSuffix"), "RealSuffix")(TParseTree("", false,[], s));
        }
    }
    static string RealSuffix(GetName g)
    {
        return "D.RealSuffix";
    }

    static TParseTree ImaginarySuffix(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.literal!("i"), "D.ImaginarySuffix")(p);
        }
        else
        {
            if(auto m = tuple(`ImaginarySuffix`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.literal!("i"), "D.ImaginarySuffix"), "ImaginarySuffix")(p);
                memo[tuple(`ImaginarySuffix`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree ImaginarySuffix(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.literal!("i"), "D.ImaginarySuffix")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(pegged.peg.literal!("i"), "D.ImaginarySuffix"), "ImaginarySuffix")(TParseTree("", false,[], s));
        }
    }
    static string ImaginarySuffix(GetName g)
    {
        return "D.ImaginarySuffix";
    }

    static TParseTree LeadingDecimal(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.or!(DecimalInteger, pegged.peg.and!(pegged.peg.literal!("0"), DecimalDigitsNoSingleUS)), "D.LeadingDecimal")(p);
        }
        else
        {
            if(auto m = tuple(`LeadingDecimal`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.or!(DecimalInteger, pegged.peg.and!(pegged.peg.literal!("0"), DecimalDigitsNoSingleUS)), "D.LeadingDecimal"), "LeadingDecimal")(p);
                memo[tuple(`LeadingDecimal`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree LeadingDecimal(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.or!(DecimalInteger, pegged.peg.and!(pegged.peg.literal!("0"), DecimalDigitsNoSingleUS)), "D.LeadingDecimal")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(pegged.peg.or!(DecimalInteger, pegged.peg.and!(pegged.peg.literal!("0"), DecimalDigitsNoSingleUS)), "D.LeadingDecimal"), "LeadingDecimal")(TParseTree("", false,[], s));
        }
    }
    static string LeadingDecimal(GetName g)
    {
        return "D.LeadingDecimal";
    }

    static TParseTree IntegerLiteral(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.or!(pegged.peg.action!(pegged.peg.and!(Integer, IntegerSuffix), integerWithSuffix), Integer), "D.IntegerLiteral")(p);
        }
        else
        {
            if(auto m = tuple(`IntegerLiteral`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.or!(pegged.peg.action!(pegged.peg.and!(Integer, IntegerSuffix), integerWithSuffix), Integer), "D.IntegerLiteral"), "IntegerLiteral")(p);
                memo[tuple(`IntegerLiteral`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree IntegerLiteral(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.or!(pegged.peg.action!(pegged.peg.and!(Integer, IntegerSuffix), integerWithSuffix), Integer), "D.IntegerLiteral")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(pegged.peg.or!(pegged.peg.action!(pegged.peg.and!(Integer, IntegerSuffix), integerWithSuffix), Integer), "D.IntegerLiteral"), "IntegerLiteral")(TParseTree("", false,[], s));
        }
    }
    static string IntegerLiteral(GetName g)
    {
        return "D.IntegerLiteral";
    }

    static TParseTree Integer(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.or!(BinaryInteger, HexadecimalInteger, DecimalInteger), "D.Integer")(p);
        }
        else
        {
            if(auto m = tuple(`Integer`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.or!(BinaryInteger, HexadecimalInteger, DecimalInteger), "D.Integer"), "Integer")(p);
                memo[tuple(`Integer`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree Integer(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.or!(BinaryInteger, HexadecimalInteger, DecimalInteger), "D.Integer")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(pegged.peg.or!(BinaryInteger, HexadecimalInteger, DecimalInteger), "D.Integer"), "Integer")(TParseTree("", false,[], s));
        }
    }
    static string Integer(GetName g)
    {
        return "D.Integer";
    }

    static TParseTree IntegerSuffix(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.keywords!("Lu", "LU", "uL", "UL", "L", "U", "u"), "D.IntegerSuffix")(p);
        }
        else
        {
            if(auto m = tuple(`IntegerSuffix`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.keywords!("Lu", "LU", "uL", "UL", "L", "U", "u"), "D.IntegerSuffix"), "IntegerSuffix")(p);
                memo[tuple(`IntegerSuffix`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree IntegerSuffix(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.keywords!("Lu", "LU", "uL", "UL", "L", "U", "u"), "D.IntegerSuffix")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(pegged.peg.keywords!("Lu", "LU", "uL", "UL", "L", "U", "u"), "D.IntegerSuffix"), "IntegerSuffix")(TParseTree("", false,[], s));
        }
    }
    static string IntegerSuffix(GetName g)
    {
        return "D.IntegerSuffix";
    }

    static TParseTree DecimalInteger(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.fuse!(pegged.peg.or!(pegged.peg.literal!("0"), pegged.peg.and!(NonZeroDigit, pegged.peg.option!(DecimalDigitsUS)))), "D.DecimalInteger")(p);
        }
        else
        {
            if(auto m = tuple(`DecimalInteger`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.fuse!(pegged.peg.or!(pegged.peg.literal!("0"), pegged.peg.and!(NonZeroDigit, pegged.peg.option!(DecimalDigitsUS)))), "D.DecimalInteger"), "DecimalInteger")(p);
                memo[tuple(`DecimalInteger`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree DecimalInteger(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.fuse!(pegged.peg.or!(pegged.peg.literal!("0"), pegged.peg.and!(NonZeroDigit, pegged.peg.option!(DecimalDigitsUS)))), "D.DecimalInteger")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(pegged.peg.fuse!(pegged.peg.or!(pegged.peg.literal!("0"), pegged.peg.and!(NonZeroDigit, pegged.peg.option!(DecimalDigitsUS)))), "D.DecimalInteger"), "DecimalInteger")(TParseTree("", false,[], s));
        }
    }
    static string DecimalInteger(GetName g)
    {
        return "D.DecimalInteger";
    }

    static TParseTree BinaryInteger(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.fuse!(pegged.peg.and!(BinPrefix, BinaryDigits)), "D.BinaryInteger")(p);
        }
        else
        {
            if(auto m = tuple(`BinaryInteger`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.fuse!(pegged.peg.and!(BinPrefix, BinaryDigits)), "D.BinaryInteger"), "BinaryInteger")(p);
                memo[tuple(`BinaryInteger`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree BinaryInteger(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.fuse!(pegged.peg.and!(BinPrefix, BinaryDigits)), "D.BinaryInteger")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(pegged.peg.fuse!(pegged.peg.and!(BinPrefix, BinaryDigits)), "D.BinaryInteger"), "BinaryInteger")(TParseTree("", false,[], s));
        }
    }
    static string BinaryInteger(GetName g)
    {
        return "D.BinaryInteger";
    }

    static TParseTree BinPrefix(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.discard!(pegged.peg.keywords!("0b", "0B")), "D.BinPrefix")(p);
        }
        else
        {
            if(auto m = tuple(`BinPrefix`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.discard!(pegged.peg.keywords!("0b", "0B")), "D.BinPrefix"), "BinPrefix")(p);
                memo[tuple(`BinPrefix`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree BinPrefix(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.discard!(pegged.peg.keywords!("0b", "0B")), "D.BinPrefix")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(pegged.peg.discard!(pegged.peg.keywords!("0b", "0B")), "D.BinPrefix"), "BinPrefix")(TParseTree("", false,[], s));
        }
    }
    static string BinPrefix(GetName g)
    {
        return "D.BinPrefix";
    }

    static TParseTree HexadecimalInteger(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.fuse!(pegged.peg.and!(HexPrefix, HexDigitsNoSingleUS)), "D.HexadecimalInteger")(p);
        }
        else
        {
            if(auto m = tuple(`HexadecimalInteger`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.fuse!(pegged.peg.and!(HexPrefix, HexDigitsNoSingleUS)), "D.HexadecimalInteger"), "HexadecimalInteger")(p);
                memo[tuple(`HexadecimalInteger`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree HexadecimalInteger(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.fuse!(pegged.peg.and!(HexPrefix, HexDigitsNoSingleUS)), "D.HexadecimalInteger")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(pegged.peg.fuse!(pegged.peg.and!(HexPrefix, HexDigitsNoSingleUS)), "D.HexadecimalInteger"), "HexadecimalInteger")(TParseTree("", false,[], s));
        }
    }
    static string HexadecimalInteger(GetName g)
    {
        return "D.HexadecimalInteger";
    }

    static TParseTree NonZeroDigit(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.charRange!('1', '9'), "D.NonZeroDigit")(p);
        }
        else
        {
            if(auto m = tuple(`NonZeroDigit`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.charRange!('1', '9'), "D.NonZeroDigit"), "NonZeroDigit")(p);
                memo[tuple(`NonZeroDigit`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree NonZeroDigit(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.charRange!('1', '9'), "D.NonZeroDigit")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(pegged.peg.charRange!('1', '9'), "D.NonZeroDigit"), "NonZeroDigit")(TParseTree("", false,[], s));
        }
    }
    static string NonZeroDigit(GetName g)
    {
        return "D.NonZeroDigit";
    }

    static TParseTree DecimalDigits(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.oneOrMore!(DecimalDigit), "D.DecimalDigits")(p);
        }
        else
        {
            if(auto m = tuple(`DecimalDigits`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.oneOrMore!(DecimalDigit), "D.DecimalDigits"), "DecimalDigits")(p);
                memo[tuple(`DecimalDigits`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree DecimalDigits(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.oneOrMore!(DecimalDigit), "D.DecimalDigits")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(pegged.peg.oneOrMore!(DecimalDigit), "D.DecimalDigits"), "DecimalDigits")(TParseTree("", false,[], s));
        }
    }
    static string DecimalDigits(GetName g)
    {
        return "D.DecimalDigits";
    }

    static TParseTree DecimalDigitsUS(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.fuse!(pegged.peg.oneOrMore!(DecimalDigitUS)), "D.DecimalDigitsUS")(p);
        }
        else
        {
            if(auto m = tuple(`DecimalDigitsUS`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.fuse!(pegged.peg.oneOrMore!(DecimalDigitUS)), "D.DecimalDigitsUS"), "DecimalDigitsUS")(p);
                memo[tuple(`DecimalDigitsUS`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree DecimalDigitsUS(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.fuse!(pegged.peg.oneOrMore!(DecimalDigitUS)), "D.DecimalDigitsUS")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(pegged.peg.fuse!(pegged.peg.oneOrMore!(DecimalDigitUS)), "D.DecimalDigitsUS"), "DecimalDigitsUS")(TParseTree("", false,[], s));
        }
    }
    static string DecimalDigitsUS(GetName g)
    {
        return "D.DecimalDigitsUS";
    }

    static TParseTree DecimalDigitsNoSingleUS(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.fuse!(pegged.peg.or!(pegged.peg.and!(DecimalDigit, pegged.peg.option!(DecimalDigitsUS)), pegged.peg.and!(DecimalDigitsUS, DecimalDigit))), "D.DecimalDigitsNoSingleUS")(p);
        }
        else
        {
            if(auto m = tuple(`DecimalDigitsNoSingleUS`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.fuse!(pegged.peg.or!(pegged.peg.and!(DecimalDigit, pegged.peg.option!(DecimalDigitsUS)), pegged.peg.and!(DecimalDigitsUS, DecimalDigit))), "D.DecimalDigitsNoSingleUS"), "DecimalDigitsNoSingleUS")(p);
                memo[tuple(`DecimalDigitsNoSingleUS`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree DecimalDigitsNoSingleUS(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.fuse!(pegged.peg.or!(pegged.peg.and!(DecimalDigit, pegged.peg.option!(DecimalDigitsUS)), pegged.peg.and!(DecimalDigitsUS, DecimalDigit))), "D.DecimalDigitsNoSingleUS")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(pegged.peg.fuse!(pegged.peg.or!(pegged.peg.and!(DecimalDigit, pegged.peg.option!(DecimalDigitsUS)), pegged.peg.and!(DecimalDigitsUS, DecimalDigit))), "D.DecimalDigitsNoSingleUS"), "DecimalDigitsNoSingleUS")(TParseTree("", false,[], s));
        }
    }
    static string DecimalDigitsNoSingleUS(GetName g)
    {
        return "D.DecimalDigitsNoSingleUS";
    }

    static TParseTree DecimalDigitNoStartingUS(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.and!(DecimalDigit, pegged.peg.option!(DecimalDigitsUS)), "D.DecimalDigitNoStartingUS")(p);
        }
        else
        {
            if(auto m = tuple(`DecimalDigitNoStartingUS`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.and!(DecimalDigit, pegged.peg.option!(DecimalDigitsUS)), "D.DecimalDigitNoStartingUS"), "DecimalDigitNoStartingUS")(p);
                memo[tuple(`DecimalDigitNoStartingUS`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree DecimalDigitNoStartingUS(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.and!(DecimalDigit, pegged.peg.option!(DecimalDigitsUS)), "D.DecimalDigitNoStartingUS")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(pegged.peg.and!(DecimalDigit, pegged.peg.option!(DecimalDigitsUS)), "D.DecimalDigitNoStartingUS"), "DecimalDigitNoStartingUS")(TParseTree("", false,[], s));
        }
    }
    static string DecimalDigitNoStartingUS(GetName g)
    {
        return "D.DecimalDigitNoStartingUS";
    }

    static TParseTree DecimalDigit(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.or!(pegged.peg.literal!("0"), NonZeroDigit), "D.DecimalDigit")(p);
        }
        else
        {
            if(auto m = tuple(`DecimalDigit`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.or!(pegged.peg.literal!("0"), NonZeroDigit), "D.DecimalDigit"), "DecimalDigit")(p);
                memo[tuple(`DecimalDigit`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree DecimalDigit(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.or!(pegged.peg.literal!("0"), NonZeroDigit), "D.DecimalDigit")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(pegged.peg.or!(pegged.peg.literal!("0"), NonZeroDigit), "D.DecimalDigit"), "DecimalDigit")(TParseTree("", false,[], s));
        }
    }
    static string DecimalDigit(GetName g)
    {
        return "D.DecimalDigit";
    }

    static TParseTree DecimalDigitUS(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.or!(DecimalDigit, pegged.peg.discard!(pegged.peg.literal!("_"))), "D.DecimalDigitUS")(p);
        }
        else
        {
            if(auto m = tuple(`DecimalDigitUS`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.or!(DecimalDigit, pegged.peg.discard!(pegged.peg.literal!("_"))), "D.DecimalDigitUS"), "DecimalDigitUS")(p);
                memo[tuple(`DecimalDigitUS`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree DecimalDigitUS(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.or!(DecimalDigit, pegged.peg.discard!(pegged.peg.literal!("_"))), "D.DecimalDigitUS")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(pegged.peg.or!(DecimalDigit, pegged.peg.discard!(pegged.peg.literal!("_"))), "D.DecimalDigitUS"), "DecimalDigitUS")(TParseTree("", false,[], s));
        }
    }
    static string DecimalDigitUS(GetName g)
    {
        return "D.DecimalDigitUS";
    }

    static TParseTree BinaryDigitsUS(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.oneOrMore!(BinaryDigitUS), "D.BinaryDigitsUS")(p);
        }
        else
        {
            if(auto m = tuple(`BinaryDigitsUS`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.oneOrMore!(BinaryDigitUS), "D.BinaryDigitsUS"), "BinaryDigitsUS")(p);
                memo[tuple(`BinaryDigitsUS`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree BinaryDigitsUS(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.oneOrMore!(BinaryDigitUS), "D.BinaryDigitsUS")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(pegged.peg.oneOrMore!(BinaryDigitUS), "D.BinaryDigitsUS"), "BinaryDigitsUS")(TParseTree("", false,[], s));
        }
    }
    static string BinaryDigitsUS(GetName g)
    {
        return "D.BinaryDigitsUS";
    }

    static TParseTree BinaryDigits(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(BinaryDigitsUS, "D.BinaryDigits")(p);
        }
        else
        {
            if(auto m = tuple(`BinaryDigits`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(BinaryDigitsUS, "D.BinaryDigits"), "BinaryDigits")(p);
                memo[tuple(`BinaryDigits`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree BinaryDigits(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(BinaryDigitsUS, "D.BinaryDigits")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(BinaryDigitsUS, "D.BinaryDigits"), "BinaryDigits")(TParseTree("", false,[], s));
        }
    }
    static string BinaryDigits(GetName g)
    {
        return "D.BinaryDigits";
    }

    static TParseTree BinaryDigit(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.charRange!('0', '1'), "D.BinaryDigit")(p);
        }
        else
        {
            if(auto m = tuple(`BinaryDigit`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.charRange!('0', '1'), "D.BinaryDigit"), "BinaryDigit")(p);
                memo[tuple(`BinaryDigit`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree BinaryDigit(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.charRange!('0', '1'), "D.BinaryDigit")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(pegged.peg.charRange!('0', '1'), "D.BinaryDigit"), "BinaryDigit")(TParseTree("", false,[], s));
        }
    }
    static string BinaryDigit(GetName g)
    {
        return "D.BinaryDigit";
    }

    static TParseTree BinaryDigitUS(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.or!(BinaryDigit, pegged.peg.discard!(pegged.peg.literal!("_"))), "D.BinaryDigitUS")(p);
        }
        else
        {
            if(auto m = tuple(`BinaryDigitUS`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.or!(BinaryDigit, pegged.peg.discard!(pegged.peg.literal!("_"))), "D.BinaryDigitUS"), "BinaryDigitUS")(p);
                memo[tuple(`BinaryDigitUS`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree BinaryDigitUS(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.or!(BinaryDigit, pegged.peg.discard!(pegged.peg.literal!("_"))), "D.BinaryDigitUS")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(pegged.peg.or!(BinaryDigit, pegged.peg.discard!(pegged.peg.literal!("_"))), "D.BinaryDigitUS"), "BinaryDigitUS")(TParseTree("", false,[], s));
        }
    }
    static string BinaryDigitUS(GetName g)
    {
        return "D.BinaryDigitUS";
    }

    static TParseTree OctalDigits(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.oneOrMore!(OctalDigit), "D.OctalDigits")(p);
        }
        else
        {
            if(auto m = tuple(`OctalDigits`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.oneOrMore!(OctalDigit), "D.OctalDigits"), "OctalDigits")(p);
                memo[tuple(`OctalDigits`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree OctalDigits(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.oneOrMore!(OctalDigit), "D.OctalDigits")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(pegged.peg.oneOrMore!(OctalDigit), "D.OctalDigits"), "OctalDigits")(TParseTree("", false,[], s));
        }
    }
    static string OctalDigits(GetName g)
    {
        return "D.OctalDigits";
    }

    static TParseTree OctalDigitsUS(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.oneOrMore!(OctalDigitUS), "D.OctalDigitsUS")(p);
        }
        else
        {
            if(auto m = tuple(`OctalDigitsUS`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.oneOrMore!(OctalDigitUS), "D.OctalDigitsUS"), "OctalDigitsUS")(p);
                memo[tuple(`OctalDigitsUS`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree OctalDigitsUS(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.oneOrMore!(OctalDigitUS), "D.OctalDigitsUS")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(pegged.peg.oneOrMore!(OctalDigitUS), "D.OctalDigitsUS"), "OctalDigitsUS")(TParseTree("", false,[], s));
        }
    }
    static string OctalDigitsUS(GetName g)
    {
        return "D.OctalDigitsUS";
    }

    static TParseTree OctalDigit(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.charRange!('0', '7'), "D.OctalDigit")(p);
        }
        else
        {
            if(auto m = tuple(`OctalDigit`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.charRange!('0', '7'), "D.OctalDigit"), "OctalDigit")(p);
                memo[tuple(`OctalDigit`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree OctalDigit(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.charRange!('0', '7'), "D.OctalDigit")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(pegged.peg.charRange!('0', '7'), "D.OctalDigit"), "OctalDigit")(TParseTree("", false,[], s));
        }
    }
    static string OctalDigit(GetName g)
    {
        return "D.OctalDigit";
    }

    static TParseTree OctalDigitUS(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.or!(OctalDigit, pegged.peg.discard!(pegged.peg.literal!("_"))), "D.OctalDigitUS")(p);
        }
        else
        {
            if(auto m = tuple(`OctalDigitUS`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.or!(OctalDigit, pegged.peg.discard!(pegged.peg.literal!("_"))), "D.OctalDigitUS"), "OctalDigitUS")(p);
                memo[tuple(`OctalDigitUS`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree OctalDigitUS(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.or!(OctalDigit, pegged.peg.discard!(pegged.peg.literal!("_"))), "D.OctalDigitUS")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(pegged.peg.or!(OctalDigit, pegged.peg.discard!(pegged.peg.literal!("_"))), "D.OctalDigitUS"), "OctalDigitUS")(TParseTree("", false,[], s));
        }
    }
    static string OctalDigitUS(GetName g)
    {
        return "D.OctalDigitUS";
    }

    static TParseTree HexDigits(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.oneOrMore!(HexDigit), "D.HexDigits")(p);
        }
        else
        {
            if(auto m = tuple(`HexDigits`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.oneOrMore!(HexDigit), "D.HexDigits"), "HexDigits")(p);
                memo[tuple(`HexDigits`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree HexDigits(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.oneOrMore!(HexDigit), "D.HexDigits")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(pegged.peg.oneOrMore!(HexDigit), "D.HexDigits"), "HexDigits")(TParseTree("", false,[], s));
        }
    }
    static string HexDigits(GetName g)
    {
        return "D.HexDigits";
    }

    static TParseTree HexDigitsUS(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.oneOrMore!(HexDigitUS), "D.HexDigitsUS")(p);
        }
        else
        {
            if(auto m = tuple(`HexDigitsUS`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.oneOrMore!(HexDigitUS), "D.HexDigitsUS"), "HexDigitsUS")(p);
                memo[tuple(`HexDigitsUS`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree HexDigitsUS(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.oneOrMore!(HexDigitUS), "D.HexDigitsUS")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(pegged.peg.oneOrMore!(HexDigitUS), "D.HexDigitsUS"), "HexDigitsUS")(TParseTree("", false,[], s));
        }
    }
    static string HexDigitsUS(GetName g)
    {
        return "D.HexDigitsUS";
    }

    static TParseTree HexDigitUS(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.or!(HexDigit, pegged.peg.discard!(pegged.peg.literal!("_"))), "D.HexDigitUS")(p);
        }
        else
        {
            if(auto m = tuple(`HexDigitUS`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.or!(HexDigit, pegged.peg.discard!(pegged.peg.literal!("_"))), "D.HexDigitUS"), "HexDigitUS")(p);
                memo[tuple(`HexDigitUS`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree HexDigitUS(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.or!(HexDigit, pegged.peg.discard!(pegged.peg.literal!("_"))), "D.HexDigitUS")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(pegged.peg.or!(HexDigit, pegged.peg.discard!(pegged.peg.literal!("_"))), "D.HexDigitUS"), "HexDigitUS")(TParseTree("", false,[], s));
        }
    }
    static string HexDigitUS(GetName g)
    {
        return "D.HexDigitUS";
    }

    static TParseTree HexDigitsNoSingleUS(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.fuse!(pegged.peg.or!(pegged.peg.and!(HexDigit, pegged.peg.option!(HexDigitsUS)), pegged.peg.and!(HexDigitsUS, HexDigit))), "D.HexDigitsNoSingleUS")(p);
        }
        else
        {
            if(auto m = tuple(`HexDigitsNoSingleUS`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.fuse!(pegged.peg.or!(pegged.peg.and!(HexDigit, pegged.peg.option!(HexDigitsUS)), pegged.peg.and!(HexDigitsUS, HexDigit))), "D.HexDigitsNoSingleUS"), "HexDigitsNoSingleUS")(p);
                memo[tuple(`HexDigitsNoSingleUS`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree HexDigitsNoSingleUS(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.fuse!(pegged.peg.or!(pegged.peg.and!(HexDigit, pegged.peg.option!(HexDigitsUS)), pegged.peg.and!(HexDigitsUS, HexDigit))), "D.HexDigitsNoSingleUS")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(pegged.peg.fuse!(pegged.peg.or!(pegged.peg.and!(HexDigit, pegged.peg.option!(HexDigitsUS)), pegged.peg.and!(HexDigitsUS, HexDigit))), "D.HexDigitsNoSingleUS"), "HexDigitsNoSingleUS")(TParseTree("", false,[], s));
        }
    }
    static string HexDigitsNoSingleUS(GetName g)
    {
        return "D.HexDigitsNoSingleUS";
    }

    static TParseTree HexDigit(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.or!(DecimalDigit, HexLetter), "D.HexDigit")(p);
        }
        else
        {
            if(auto m = tuple(`HexDigit`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.or!(DecimalDigit, HexLetter), "D.HexDigit"), "HexDigit")(p);
                memo[tuple(`HexDigit`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree HexDigit(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.or!(DecimalDigit, HexLetter), "D.HexDigit")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(pegged.peg.or!(DecimalDigit, HexLetter), "D.HexDigit"), "HexDigit")(TParseTree("", false,[], s));
        }
    }
    static string HexDigit(GetName g)
    {
        return "D.HexDigit";
    }

    static TParseTree HexLetter(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.or!(pegged.peg.charRange!('a', 'f'), pegged.peg.charRange!('A', 'F'), pegged.peg.discard!(pegged.peg.literal!("_"))), "D.HexLetter")(p);
        }
        else
        {
            if(auto m = tuple(`HexLetter`,p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.or!(pegged.peg.charRange!('a', 'f'), pegged.peg.charRange!('A', 'F'), pegged.peg.discard!(pegged.peg.literal!("_"))), "D.HexLetter"), "HexLetter")(p);
                memo[tuple(`HexLetter`,p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree HexLetter(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.or!(pegged.peg.charRange!('a', 'f'), pegged.peg.charRange!('A', 'F'), pegged.peg.discard!(pegged.peg.literal!("_"))), "D.HexLetter")(TParseTree("", false,[], s));
        }
        else
        {
            memo = null;
            return hooked!(pegged.peg.defined!(pegged.peg.or!(pegged.peg.charRange!('a', 'f'), pegged.peg.charRange!('A', 'F'), pegged.peg.discard!(pegged.peg.literal!("_"))), "D.HexLetter"), "HexLetter")(TParseTree("", false,[], s));
        }
    }
    static string HexLetter(GetName g)
    {
        return "D.HexLetter";
    }

    static TParseTree opCall(TParseTree p)
    {
        TParseTree result = decimateTree(Module(p));
        result.children = [result];
        result.name = "D";
        return result;
    }

    static TParseTree opCall(string input)
    {
        if(__ctfe)
        {
            return D(TParseTree(``, false, [], input, 0, 0));
        }
        else
        {
            memo = null;
            return D(TParseTree(``, false, [], input, 0, 0));
        }
    }
    static string opCall(GetName g)
    {
        return "D";
    }

    }
}

alias GenericD!(ParseTree).D D;

