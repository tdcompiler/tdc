D [0, 61]["void", "main", "{", "}", "long", "foo", "return", "0", "L"]
 +-D.Module [0, 61]["void", "main", "{", "}", "long", "foo", "return", "0", "L"]
    +-D.DeclDefs [0, 61]["void", "main", "{", "}", "long", "foo", "return", "0", "L"]
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
       +-D.DeclDef [35, 61]["long", "foo", "return", "0", "L"]
          +-D.Declaration [35, 61]["long", "foo", "return", "0", "L"]
             +-D.Decl [35, 61]["long", "foo", "return", "0", "L"]
                +-D.basicFunction [35, 61]["long", "foo", "return", "0", "L"]
                   +-D.BasicType [35, 40]["long"]
                   |  +-D.BasicTypeX [35, 39]["long"]
                   +-D.Declarator [40, 45]["foo"]
                   |  +-D.Identifier [40, 43]["foo"]
                   +-D.FunctionBody [45, 61]["return", "0", "L"]
                      +-D.BlockStatement [45, 61]["return", "0", "L"]
                         +-D.StatementList [48, 59]["return", "0", "L"]
                            +-D.Statement [48, 59]["return", "0", "L"]
                               +-D.NonEmptyStatement [48, 59]["return", "0", "L"]
                                  +-D.NonEmptyStatementNoCaseNoDefault [48, 59]["return", "0", "L"]
                                     +-D.ReturnStatement [48, 59]["return", "0", "L"]
                                        +-D.Expression [55, 57]["0", "L"]
                                           +-D.CommaExpression [55, 57]["0", "L"]
                                              +-D.AssignExpression [55, 57]["0", "L"]
                                                 +-D.ConditionalExpression [55, 57]["0", "L"]
                                                    +-D.OrOrExpression [55, 57]["0", "L"]
                                                       +-D.AndAndExpression [55, 57]["0", "L"]
                                                          +-D.OrExpression [55, 57]["0", "L"]
                                                             +-D.XorExpression [55, 57]["0", "L"]
                                                                +-D.AndExpression [55, 57]["0", "L"]
                                                                   +-D.ShiftExpression [55, 57]["0", "L"]
                                                                      +-D.AddExpression [55, 57]["0", "L"]
                                                                         +-D.MulExpression [55, 57]["0", "L"]
                                                                            +-D.UnaryExpression [55, 57]["0", "L"]
                                                                               +-D.PowExpression [55, 57]["0", "L"]
                                                                                  +-D.PostfixExpression [55, 57]["0", "L"]
                                                                                     +-D.PrimaryExpression [55, 57]["0", "L"]
                                                                                        +-D.IntegerLiteral [55, 57]["0", "L"]
                                                                                           +-D.integerWithSuffix [55, 57]["0", "L"]
                                                                                              +-D.Integer [55, 56]["0"]
                                                                                              |  +-D.DecimalInteger [55, 56]["0"]
                                                                                              +-D.IntegerSuffix [56, 57]["L"]