D [0, 68]["void", "main", "float", "f", "=", "42", "L", "i"]
 +-D.Module [0, 68]["void", "main", "float", "f", "=", "42", "L", "i"]
    +-D.DeclDefs [0, 68]["void", "main", "float", "f", "=", "42", "L", "i"]
       +-D.DeclDef [36, 68]["void", "main", "float", "f", "=", "42", "L", "i"]
          +-D.Declaration [36, 68]["void", "main", "float", "f", "=", "42", "L", "i"]
             +-D.Decl [36, 68]["void", "main", "float", "f", "=", "42", "L", "i"]
                +-D.BasicType [36, 41]["void"]
                |  +-D.BasicTypeX [36, 40]["void"]
                +-D.Declarator [41, 48]["main"]
                |  +-D.Identifier [41, 45]["main"]
                +-D.FunctionBody [48, 68]["float", "f", "=", "42", "L", "i"]
                   +-D.BlockStatement [48, 68]["float", "f", "=", "42", "L", "i"]
                      +-D.StatementList [51, 67]["float", "f", "=", "42", "L", "i"]
                         +-D.Statement [51, 67]["float", "f", "=", "42", "L", "i"]
                            +-D.NonEmptyStatement [51, 67]["float", "f", "=", "42", "L", "i"]
                               +-D.NonEmptyStatementNoCaseNoDefault [51, 67]["float", "f", "=", "42", "L", "i"]
                                  +-D.DeclarationStatement [51, 67]["float", "f", "=", "42", "L", "i"]
                                     +-D.Declaration [51, 67]["float", "f", "=", "42", "L", "i"]
                                        +-D.Decl [51, 67]["float", "f", "=", "42", "L", "i"]
                                           +-D.BasicType [51, 57]["float"]
                                           |  +-D.BasicTypeX [51, 56]["float"]
                                           +-D.Declarators [57, 65]["f", "=", "42", "L", "i"]
                                              +-D.DeclaratorInitializer [57, 65]["f", "=", "42", "L", "i"]
                                                 +-D.Declarator [57, 59]["f"]
                                                 |  +-D.Identifier [57, 59]["f"]
                                                 +-D.Initializer [61, 65]["42", "L", "i"]
                                                    +-D.NonVoidInitializer [61, 65]["42", "L", "i"]
                                                       +-D.AssignExpression [61, 65]["42", "L", "i"]
                                                          +-D.ConditionalExpression [61, 65]["42", "L", "i"]
                                                             +-D.OrOrExpression [61, 65]["42", "L", "i"]
                                                                +-D.AndAndExpression [61, 65]["42", "L", "i"]
                                                                   +-D.OrExpression [61, 65]["42", "L", "i"]
                                                                      +-D.XorExpression [61, 65]["42", "L", "i"]
                                                                         +-D.AndExpression [61, 65]["42", "L", "i"]
                                                                            +-D.ShiftExpression [61, 65]["42", "L", "i"]
                                                                               +-D.AddExpression [61, 65]["42", "L", "i"]
                                                                                  +-D.MulExpression [61, 65]["42", "L", "i"]
                                                                                     +-D.UnaryExpression [61, 65]["42", "L", "i"]
                                                                                        +-D.PowExpression [61, 65]["42", "L", "i"]
                                                                                           +-D.PostfixExpression [61, 65]["42", "L", "i"]
                                                                                              +-D.PrimaryExpression [61, 65]["42", "L", "i"]
                                                                                                 +-D.FloatLiteral [61, 65]["42", "L", "i"]
                                                                                                    +-D.Integer [61, 63]["42"]
                                                                                                    |  +-D.DecimalInteger [61, 63]["42"]
                                                                                                    +-D.RealSuffix [63, 64]["L"]
                                                                                                    +-D.ImaginarySuffix [64, 65]["i"]
