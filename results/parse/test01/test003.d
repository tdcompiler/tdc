D [0, 49]["int", "main", "return", "1", "+", "1"]
 +-D.Module [0, 49]["int", "main", "return", "1", "+", "1"]
    +-D.DeclDefs [0, 49]["int", "main", "return", "1", "+", "1"]
       +-D.DeclDef [22, 49]["int", "main", "return", "1", "+", "1"]
          +-D.Declaration [22, 49]["int", "main", "return", "1", "+", "1"]
             +-D.Decl [22, 49]["int", "main", "return", "1", "+", "1"]
                +-D.basicFunction [22, 49]["int", "main", "return", "1", "+", "1"]
                   +-D.BasicType [22, 26]["int"]
                   |  +-D.BasicTypeX [22, 25]["int"]
                   +-D.Declarator [26, 32]["main"]
                   |  +-D.Identifier [26, 30]["main"]
                   +-D.FunctionBody [32, 49]["return", "1", "+", "1"]
                      +-D.BlockStatement [32, 49]["return", "1", "+", "1"]
                         +-D.StatementList [35, 47]["return", "1", "+", "1"]
                            +-D.Statement [35, 47]["return", "1", "+", "1"]
                               +-D.NonEmptyStatement [35, 47]["return", "1", "+", "1"]
                                  +-D.NonEmptyStatementNoCaseNoDefault [35, 47]["return", "1", "+", "1"]
                                     +-D.ReturnStatement [35, 47]["return", "1", "+", "1"]
                                        +-D.Expression [42, 45]["1", "+", "1"]
                                           +-D.CommaExpression [42, 45]["1", "+", "1"]
                                              +-D.AssignExpression [42, 45]["1", "+", "1"]
                                                 +-D.ConditionalExpression [42, 45]["1", "+", "1"]
                                                    +-D.OrOrExpression [42, 45]["1", "+", "1"]
                                                       +-D.AndAndExpression [42, 45]["1", "+", "1"]
                                                          +-D.OrExpression [42, 45]["1", "+", "1"]
                                                             +-D.XorExpression [42, 45]["1", "+", "1"]
                                                                +-D.AndExpression [42, 45]["1", "+", "1"]
                                                                   +-D.ShiftExpression [42, 45]["1", "+", "1"]
                                                                      +-D.AddExpression [42, 45]["1", "+", "1"]
                                                                         +-D.MulExpression [42, 43]["1"]
                                                                         |  +-D.UnaryExpression [42, 43]["1"]
                                                                         |     +-D.PowExpression [42, 43]["1"]
                                                                         |        +-D.PostfixExpression [42, 43]["1"]
                                                                         |           +-D.PrimaryExpression [42, 43]["1"]
                                                                         |              +-D.IntegerLiteral [42, 43]["1"]
                                                                         |                 +-D.Integer [42, 43]["1"]
                                                                         |                    +-D.DecimalInteger [42, 43]["1"]
                                                                         +-D.AddExpression [44, 45]["1"]
                                                                            +-D.MulExpression [44, 45]["1"]
                                                                               +-D.UnaryExpression [44, 45]["1"]
                                                                                  +-D.PowExpression [44, 45]["1"]
                                                                                     +-D.PostfixExpression [44, 45]["1"]
                                                                                        +-D.PrimaryExpression [44, 45]["1"]
                                                                                           +-D.IntegerLiteral [44, 45]["1"]
                                                                                              +-D.Integer [44, 45]["1"]
                                                                                                 +-D.DecimalInteger [44, 45]["1"]
