D [0, 30]["int", "main", "return", "1", "+", "-", "1"]
 +-D.Module [0, 30]["int", "main", "return", "1", "+", "-", "1"]
    +-D.DeclDefs [0, 30]["int", "main", "return", "1", "+", "-", "1"]
       +-D.DeclDef [0, 30]["int", "main", "return", "1", "+", "-", "1"]
          +-D.BasicType [0, 4]["int"]
          |  +-D.BasicTypeX [0, 4]["int"]
          +-D.Declarator [4, 10]["main"]
          |  +-D.Identifier [4, 8]["main"]
          +-D.FunctionBody [10, 30]["return", "1", "+", "-", "1"]
             +-D.StatementList [13, 28]["return", "1", "+", "-", "1"]
                +-D.Statement [13, 28]["return", "1", "+", "-", "1"]
                   +-D.NonEmptyStatement [13, 28]["return", "1", "+", "-", "1"]
                      +-D.ReturnStatement [13, 28]["return", "1", "+", "-", "1"]
                         +-D.Expression [19, 26]["1", "+", "-", "1"]
                            +-D.MulExpression [20, 21]["1"]
                            |  +-D.UnaryExpression [20, 21]["1"]
                            |     +-D.PowExpression [20, 21]["1"]
                            |        +-D.IntegerLiteral [20, 21]["1"]
                            |           +-D.Integer [20, 21]["1"]
                            |              +-D.DecimalInteger [20, 21]["1"]
                            +-D.AddExpression [22, 26]["-", "1"]
                               +-D.MulExpression [22, 26]["-", "1"]
                                  +-D.UnaryExpression [22, 26]["-", "1"]
                                     +-D.PowExpression [22, 26]["-", "1"]
                                        +-D.Expression [23, 25]["-", "1"]
                                           +-D.MulExpression [23, 25]["-", "1"]
                                              +-D.UnaryExpression [23, 25]["-", "1"]
                                                 +-D.UnaryExpression [24, 25]["1"]
                                                    +-D.PowExpression [24, 25]["1"]
                                                       +-D.IntegerLiteral [24, 25]["1"]
                                                          +-D.Integer [24, 25]["1"]
                                                             +-D.DecimalInteger [24, 25]["1"]
