D [0, 60]["void", "main", "{", "}", "long", "foo", "{", "}"]
 +-D.Module [0, 60]["void", "main", "{", "}", "long", "foo", "{", "}"]
    +-D.DeclDefs [0, 60]["void", "main", "{", "}", "long", "foo", "{", "}"]
       +-D.DeclDef [29, 46]["void", "main", "{", "}"]
       |  +-D.BasicType [29, 34]["void"]
       |  |  +-D.BasicTypeX [29, 34]["void"]
       |  +-D.Declarator [34, 41]["main"]
       |  |  +-D.Identifier [34, 38]["main"]
       |  +-D.FunctionBody [41, 46]["{", "}"]
       +-D.DeclDef [46, 60]["long", "foo", "{", "}"]
          +-D.BasicType [46, 51]["long"]
          |  +-D.BasicTypeX [46, 51]["long"]
          +-D.Declarator [51, 57]["foo"]
          |  +-D.Identifier [51, 54]["foo"]
          +-D.FunctionBody [57, 60]["{", "}"]
