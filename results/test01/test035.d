D [0, 30]["int", "main", "return", "10"]
 +-D.Module [0, 30]["int", "main", "return", "10"]
    +-D.DeclDefs [0, 30]["int", "main", "return", "10"]
       +-D.DeclDef [0, 30]["int", "main", "return", "10"]
          +-D.BasicType [0, 4]["int"]
          |  +-D.BasicTypeX [0, 4]["int"]
          +-D.Declarator [4, 10]["main"]
          |  +-D.Identifier [4, 8]["main"]
          +-D.FunctionBody [10, 30]["return", "10"]
             +-D.StatementList [13, 28]["return", "10"]
                +-D.Statement [13, 28]["return", "10"]
                   +-D.NonEmptyStatement [13, 28]["return", "10"]
                      +-D.ReturnStatement [13, 28]["return", "10"]
                         +-D.Expression [19, 26]["10"]
                            +-D.MulExpression [20, 26]["10"]
                               +-D.UnaryExpression [20, 26]["10"]
                                  +-D.PowExpression [20, 26]["10"]
                                     +-D.IntegerLiteral [20, 26]["10"]
                                        +-D.Integer [20, 26]["10"]
                                           +-D.BinaryInteger [20, 26]["10"]
