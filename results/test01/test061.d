D [0, 42]["void", "main", "string", "s", "=", ""]
 +-D.Module [0, 42]["void", "main", "string", "s", "=", ""]
    +-D.DeclDefs [0, 42]["void", "main", "string", "s", "=", ""]
       +-D.DeclDef [11, 42]["void", "main", "string", "s", "=", ""]
          +-D.BasicType [11, 16]["void"]
          |  +-D.BasicTypeX [11, 15]["void"]
          +-D.Declarator [16, 23]["main"]
          |  +-D.Identifier [16, 20]["main"]
          +-D.FunctionBody [23, 42]["string", "s", "=", ""]
             +-D.StatementList [26, 41]["string", "s", "=", ""]
                +-D.Statement [26, 41]["string", "s", "=", ""]
                   +-D.NonEmptyStatement [26, 41]["string", "s", "=", ""]
                      +-D.DeclarationStatement [26, 41]["string", "s", "=", ""]
                         +-D.BasicType [26, 33]["string"]
                         |  +-D.IdentifierList [26, 32]["string"]
                         +-D.Declarators [33, 39]["s", "=", ""]
                            +-D.Declarator [33, 35]["s"]
                            |  +-D.Identifier [33, 35]["s"]
                            +-D.Initializer [37, 39][""]
                               +-D.MulExpression [37, 39][""]
                                  +-D.UnaryExpression [37, 39][""]
                                     +-D.PowExpression [37, 39][""]
                                        +-D.StringLiteral [37, 39][""]
