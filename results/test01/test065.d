D [0, 83]["extern", "(", "C", ")", "int", "printf", "in", "char", "*", "format", "...", "void", "main", "{", "}"]
 +-D.Module [0, 83]["extern", "(", "C", ")", "int", "printf", "in", "char", "*", "format", "...", "void", "main", "{", "}"]
    +-D.DeclDefs [0, 83]["extern", "(", "C", ")", "int", "printf", "in", "char", "*", "format", "...", "void", "main", "{", "}"]
       +-D.DeclDef [24, 69]["extern", "(", "C", ")", "int", "printf", "in", "char", "*", "format", "..."]
       |  +-D.StorageClasses [24, 34]["extern", "(", "C", ")"]
       |  |  +-D.StorageClass [24, 33]["extern", "(", "C", ")"]
       |  |     +-D.LinkageType [31, 32]["C"]
       |  +-D.Decl [34, 69]["int", "printf", "in", "char", "*", "format", "..."]
       |     +-D.BasicType [34, 38]["int"]
       |     |  +-D.BasicTypeX [34, 37]["int"]
       |     +-D.Declarators [38, 66]["printf", "in", "char", "*", "format", "..."]
       |        +-D.Declarator [38, 66]["printf", "in", "char", "*", "format", "..."]
       |           +-D.Identifier [38, 44]["printf"]
       |           +-D.DeclaratorSuffixes [44, 66]["in", "char", "*", "format", "..."]
       |              +-D.DeclaratorSuffix [44, 66]["in", "char", "*", "format", "..."]
       |                 +-D.ParameterList [45, 65]["in", "char", "*", "format", "..."]
       |                    +-D.Parameter [45, 60]["in", "char", "*", "format"]
       |                       +-D.InOut [45, 48]["in"]
       |                       +-D.BasicType [48, 52]["char"]
       |                       |  +-D.BasicTypeX [48, 52]["char"]
       |                       +-D.Declarator [52, 60]["*", "format"]
       |                          +-D.BasicType2 [52, 54]["*"]
       |                          +-D.Identifier [54, 60]["format"]
       +-D.DeclDef [69, 83]["void", "main", "{", "}"]
          +-D.BasicType [69, 74]["void"]
          |  +-D.BasicTypeX [69, 73]["void"]
          +-D.Declarator [74, 81]["main"]
          |  +-D.Identifier [74, 78]["main"]
          +-D.FunctionBody [81, 83]["{", "}"]
