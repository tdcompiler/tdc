D [0, 61]["void", "main", "{", "}", "uint", "foo", "return", "0", "u"]
 +-D.Module [0, 61]["void", "main", "{", "}", "uint", "foo", "return", "0", "u"]
    +-D.DeclDefs [0, 61]["void", "main", "{", "}", "uint", "foo", "return", "0", "u"]
       +-D.DeclDef [19, 35]["void", "main", "{", "}"]
       |  +-D.Declaration [19, 35]["void", "main", "{", "}"]
       |     +-D.Decl [19, 35]["void", "main", "{", "}"]
       |        +-D.basicFunction [19, 35]["void", "main", "{", "}"]
       |           +-D.BasicType [19, 24]["void"]
       |           |  +-D.BasicTypeX [19, 23]["void"]
       |           +-D.Declarator [24, 31]["main"]
       |           |  +-D.Identifier [24, 28]["main"]
       |           +-D.FunctionBody [31, 35]["{", "}"]
       |              +-D.BlockStatement [31, 35]["{", "}"]
       +-D.DeclDef [35, 61]["uint", "foo", "return", "0", "u"]
          +-D.Declaration [35, 61]["uint", "foo", "return", "0", "u"]
             +-D.Decl [35, 61]["uint", "foo", "return", "0", "u"]
                +-D.basicFunction [35, 61]["uint", "foo", "return", "0", "u"]
                   +-D.BasicType [35, 40]["uint"]
                   |  +-D.BasicTypeX [35, 39]["uint"]
                   +-D.Declarator [40, 45]["foo"]
                   |  +-D.Identifier [40, 43]["foo"]
                   +-D.FunctionBody [45, 61]["return", "0", "u"]
                      +-D.BlockStatement [45, 61]["return", "0", "u"]
                         +-D.StatementList [48, 59]["return", "0", "u"]
                            +-D.Statement [48, 59]["return", "0", "u"]
                               +-D.NonEmptyStatement [48, 59]["return", "0", "u"]
                                  +-D.NonEmptyStatementNoCaseNoDefault [48, 59]["return", "0", "u"]
                                     +-D.ReturnStatement [48, 59]["return", "0", "u"]
                                        +-D.Expression [55, 57]["0", "u"]
                                           +-D.CommaExpression [55, 57]["0", "u"]
                                              +-D.AssignExpression [55, 57]["0", "u"]
                                                 +-D.ConditionalExpression [55, 57]["0", "u"]
                                                    +-D.OrOrExpression [55, 57]["0", "u"]
                                                       +-D.AndAndExpression [55, 57]["0", "u"]
                                                          +-D.OrExpression [55, 57]["0", "u"]
                                                             +-D.XorExpression [55, 57]["0", "u"]
                                                                +-D.AndExpression [55, 57]["0", "u"]
                                                                   +-D.ShiftExpression [55, 57]["0", "u"]
                                                                      +-D.AddExpression [55, 57]["0", "u"]
                                                                         +-D.MulExpression [55, 57]["0", "u"]
                                                                            +-D.UnaryExpression [55, 57]["0", "u"]
                                                                               +-D.PowExpression [55, 57]["0", "u"]
                                                                                  +-D.PostfixExpression [55, 57]["0", "u"]
                                                                                     +-D.PrimaryExpression [55, 57]["0", "u"]
                                                                                        +-D.IntegerLiteral [55, 57]["0", "u"]
                                                                                           +-D.integerWithSuffix [55, 57]["0", "u"]
                                                                                              +-D.Integer [55, 56]["0"]
                                                                                              |  +-D.DecimalInteger [55, 56]["0"]
                                                                                              +-D.IntegerSuffix [56, 57]["u"]
