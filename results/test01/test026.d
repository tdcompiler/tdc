D [0, 26]["int", "main", "return", "0", "u"]
 +-D.Module [0, 26]["int", "main", "return", "0", "u"]
    +-D.DeclDefs [0, 26]["int", "main", "return", "0", "u"]
       +-D.DeclDef [0, 26]["int", "main", "return", "0", "u"]
          +-D.BasicType [0, 4]["int"]
          |  +-D.BasicTypeX [0, 3]["int"]
          +-D.Declarator [4, 10]["main"]
          |  +-D.Identifier [4, 8]["main"]
          +-D.FunctionBody [10, 26]["return", "0", "u"]
             +-D.StatementList [13, 24]["return", "0", "u"]
                +-D.Statement [13, 24]["return", "0", "u"]
                   +-D.NonEmptyStatement [13, 24]["return", "0", "u"]
                      +-D.ReturnStatement [13, 24]["return", "0", "u"]
                         +-D.Expression [20, 22]["0", "u"]
                            +-D.MulExpression [20, 22]["0", "u"]
                               +-D.UnaryExpression [20, 22]["0", "u"]
                                  +-D.PowExpression [20, 22]["0", "u"]
                                     +-D.IntegerLiteral [20, 22]["0", "u"]
                                        +-D.Integer [20, 21]["0"]
                                        |  +-D.DecimalInteger [20, 21]["0"]
                                        +-D.IntegerSuffix [21, 22]["u"]
