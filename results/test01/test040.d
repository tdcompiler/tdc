D [0, 75]["void", "main", "int", "i", "=", "Abc21"]
 +-D.Module [0, 75]["void", "main", "int", "i", "=", "Abc21"]
    +-D.DeclDefs [0, 75]["void", "main", "int", "i", "=", "Abc21"]
       +-D.DeclDef [35, 75]["void", "main", "int", "i", "=", "Abc21"]
          +-D.BasicType [35, 40]["void"]
          |  +-D.BasicTypeX [35, 39]["void"]
          +-D.Declarator [40, 47]["main"]
          |  +-D.Identifier [40, 44]["main"]
          +-D.FunctionBody [47, 75]["int", "i", "=", "Abc21"]
             +-D.StatementList [50, 74]["int", "i", "=", "Abc21"]
                +-D.Statement [50, 74]["int", "i", "=", "Abc21"]
                   +-D.NonEmptyStatement [50, 74]["int", "i", "=", "Abc21"]
                      +-D.DeclarationStatement [50, 74]["int", "i", "=", "Abc21"]
                         +-D.BasicType [50, 54]["int"]
                         |  +-D.BasicTypeX [50, 53]["int"]
                         +-D.Declarators [54, 72]["i", "=", "Abc21"]
                            +-D.Declarator [54, 56]["i"]
                            |  +-D.Identifier [54, 56]["i"]
                            +-D.Initializer [58, 72]["Abc21"]
                               +-D.MulExpression [58, 72]["Abc21"]
                                  +-D.UnaryExpression [58, 72]["Abc21"]
                                     +-D.PowExpression [58, 72]["Abc21"]
                                        +-D.IntegerLiteral [58, 72]["Abc21"]
                                           +-D.Integer [58, 72]["Abc21"]
                                              +-D.HexadecimalInteger [58, 72]["Abc21"]
