D [0, 59]["void", "main", "float", "f", "=", "a", ".", "2", "p+", "3"]
 +-D.Module [0, 59]["void", "main", "float", "f", "=", "a", ".", "2", "p+", "3"]
    +-D.DeclDefs [0, 59]["void", "main", "float", "f", "=", "a", ".", "2", "p+", "3"]
       +-D.DeclDef [23, 59]["void", "main", "float", "f", "=", "a", ".", "2", "p+", "3"]
          +-D.Declaration [23, 59]["void", "main", "float", "f", "=", "a", ".", "2", "p+", "3"]
             +-D.Decl [23, 59]["void", "main", "float", "f", "=", "a", ".", "2", "p+", "3"]
                +-D.BasicType [23, 28]["void"]
                |  +-D.BasicTypeX [23, 27]["void"]
                +-D.Declarator [28, 35]["main"]
                |  +-D.Identifier [28, 32]["main"]
                +-D.FunctionBody [35, 59]["float", "f", "=", "a", ".", "2", "p+", "3"]
                   +-D.BlockStatement [35, 59]["float", "f", "=", "a", ".", "2", "p+", "3"]
                      +-D.StatementList [38, 58]["float", "f", "=", "a", ".", "2", "p+", "3"]
                         +-D.Statement [38, 58]["float", "f", "=", "a", ".", "2", "p+", "3"]
                            +-D.NonEmptyStatement [38, 58]["float", "f", "=", "a", ".", "2", "p+", "3"]
                               +-D.NonEmptyStatementNoCaseNoDefault [38, 58]["float", "f", "=", "a", ".", "2", "p+", "3"]
                                  +-D.DeclarationStatement [38, 58]["float", "f", "=", "a", ".", "2", "p+", "3"]
                                     +-D.Declaration [38, 58]["float", "f", "=", "a", ".", "2", "p+", "3"]
                                        +-D.Decl [38, 58]["float", "f", "=", "a", ".", "2", "p+", "3"]
                                           +-D.BasicType [38, 44]["float"]
                                           |  +-D.BasicTypeX [38, 43]["float"]
                                           +-D.Declarators [44, 56]["f", "=", "a", ".", "2", "p+", "3"]
                                              +-D.DeclaratorInitializer [44, 56]["f", "=", "a", ".", "2", "p+", "3"]
                                                 +-D.Declarator [44, 46]["f"]
                                                 |  +-D.Identifier [44, 46]["f"]
                                                 +-D.Initializer [48, 56]["a", ".", "2", "p+", "3"]
                                                    +-D.NonVoidInitializer [48, 56]["a", ".", "2", "p+", "3"]
                                                       +-D.AssignExpression [48, 56]["a", ".", "2", "p+", "3"]
                                                          +-D.ConditionalExpression [48, 56]["a", ".", "2", "p+", "3"]
                                                             +-D.OrOrExpression [48, 56]["a", ".", "2", "p+", "3"]
                                                                +-D.AndAndExpression [48, 56]["a", ".", "2", "p+", "3"]
                                                                   +-D.OrExpression [48, 56]["a", ".", "2", "p+", "3"]
                                                                      +-D.XorExpression [48, 56]["a", ".", "2", "p+", "3"]
                                                                         +-D.AndExpression [48, 56]["a", ".", "2", "p+", "3"]
                                                                            +-D.ShiftExpression [48, 56]["a", ".", "2", "p+", "3"]
                                                                               +-D.AddExpression [48, 56]["a", ".", "2", "p+", "3"]
                                                                                  +-D.MulExpression [48, 56]["a", ".", "2", "p+", "3"]
                                                                                     +-D.UnaryExpression [48, 56]["a", ".", "2", "p+", "3"]
                                                                                        +-D.PowExpression [48, 56]["a", ".", "2", "p+", "3"]
                                                                                           +-D.PostfixExpression [48, 56]["a", ".", "2", "p+", "3"]
                                                                                              +-D.PrimaryExpression [48, 56]["a", ".", "2", "p+", "3"]
                                                                                                 +-D.FloatLiteral [48, 56]["a", ".", "2", "p+", "3"]
                                                                                                    +-D.Float [48, 56]["a", ".", "2", "p+", "3"]
                                                                                                       +-D.HexFloat [48, 56]["a", ".", "2", "p+", "3"]
                                                                                                          +-D.HexDigitsNoSingleUS [50, 51]["a"]
                                                                                                          +-D.HexDigitsNoSingleUS [52, 53]["2"]
                                                                                                          +-D.HexExponent [53, 56]["p+", "3"]
                                                                                                             +-D.HexExponentStart [53, 55]["p+"]
                                                                                                             +-D.DecimalDigitsNoSingleUS [55, 56]["3"]
