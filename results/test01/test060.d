D [0, 46]["void", "main", "string", "s", "=", "test"]
 +-D.Module [0, 46]["void", "main", "string", "s", "=", "test"]
    +-D.DeclDefs [0, 46]["void", "main", "string", "s", "=", "test"]
       +-D.DeclDef [11, 46]["void", "main", "string", "s", "=", "test"]
          +-D.Declaration [11, 46]["void", "main", "string", "s", "=", "test"]
             +-D.Decl [11, 46]["void", "main", "string", "s", "=", "test"]
                +-D.BasicType [11, 16]["void"]
                |  +-D.BasicTypeX [11, 15]["void"]
                +-D.Declarator [16, 23]["main"]
                |  +-D.Identifier [16, 20]["main"]
                +-D.FunctionBody [23, 46]["string", "s", "=", "test"]
                   +-D.BlockStatement [23, 46]["string", "s", "=", "test"]
                      +-D.StatementList [26, 45]["string", "s", "=", "test"]
                         +-D.Statement [26, 45]["string", "s", "=", "test"]
                            +-D.NonEmptyStatement [26, 45]["string", "s", "=", "test"]
                               +-D.NonEmptyStatementNoCaseNoDefault [26, 45]["string", "s", "=", "test"]
                                  +-D.DeclarationStatement [26, 45]["string", "s", "=", "test"]
                                     +-D.Declaration [26, 45]["string", "s", "=", "test"]
                                        +-D.Decl [26, 45]["string", "s", "=", "test"]
                                           +-D.BasicType [26, 33]["string"]
                                           |  +-D.IdentifierList [26, 32]["string"]
                                           |     +-D.Identifier [26, 32]["string"]
                                           +-D.Declarators [33, 43]["s", "=", "test"]
                                              +-D.DeclaratorInitializer [33, 43]["s", "=", "test"]
                                                 +-D.Declarator [33, 35]["s"]
                                                 |  +-D.Identifier [33, 35]["s"]
                                                 +-D.Initializer [37, 43]["test"]
                                                    +-D.NonVoidInitializer [37, 43]["test"]
                                                       +-D.AssignExpression [37, 43]["test"]
                                                          +-D.ConditionalExpression [37, 43]["test"]
                                                             +-D.OrOrExpression [37, 43]["test"]
                                                                +-D.AndAndExpression [37, 43]["test"]
                                                                   +-D.OrExpression [37, 43]["test"]
                                                                      +-D.XorExpression [37, 43]["test"]
                                                                         +-D.AndExpression [37, 43]["test"]
                                                                            +-D.ShiftExpression [37, 43]["test"]
                                                                               +-D.AddExpression [37, 43]["test"]
                                                                                  +-D.MulExpression [37, 43]["test"]
                                                                                     +-D.UnaryExpression [37, 43]["test"]
                                                                                        +-D.PowExpression [37, 43]["test"]
                                                                                           +-D.PostfixExpression [37, 43]["test"]
                                                                                              +-D.PrimaryExpression [37, 43]["test"]
                                                                                                 +-D.StringLiteral [37, 43]["test"]
                                                                                                    +-D.DoubleQuotedString [37, 43]["test"]
                                                                                                       +-D.DoubleQuotedCharacters [38, 42]["test"]
