D [0, 26]["int", "main", "return", "-", "9"]
 +-D.Module [0, 26]["int", "main", "return", "-", "9"]
    +-D.DeclDefs [0, 26]["int", "main", "return", "-", "9"]
       +-D.DeclDef [0, 26]["int", "main", "return", "-", "9"]
          +-D.BasicType [0, 4]["int"]
          |  +-D.BasicTypeX [0, 4]["int"]
          +-D.Declarator [4, 10]["main"]
          |  +-D.Identifier [4, 8]["main"]
          +-D.FunctionBody [10, 26]["return", "-", "9"]
             +-D.StatementList [13, 24]["return", "-", "9"]
                +-D.Statement [13, 24]["return", "-", "9"]
                   +-D.NonEmptyStatement [13, 24]["return", "-", "9"]
                      +-D.ReturnStatement [13, 24]["return", "-", "9"]
                         +-D.Expression [19, 22]["-", "9"]
                            +-D.MulExpression [20, 22]["-", "9"]
                               +-D.UnaryExpression [20, 22]["-", "9"]
                                  +-D.UnaryExpression [21, 22]["9"]
                                     +-D.PowExpression [21, 22]["9"]
                                        +-D.IntegerLiteral [21, 22]["9"]
                                           +-D.Integer [21, 22]["9"]
                                              +-D.DecimalInteger [21, 22]["9"]
