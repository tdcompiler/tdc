D [0, 60]["void", "main", "float", "f", "=", "4", "F", "i"]
 +-D.Module [0, 60]["void", "main", "float", "f", "=", "4", "F", "i"]
    +-D.DeclDefs [0, 60]["void", "main", "float", "f", "=", "4", "F", "i"]
       +-D.DeclDef [29, 60]["void", "main", "float", "f", "=", "4", "F", "i"]
          +-D.BasicType [29, 34]["void"]
          |  +-D.BasicTypeX [29, 33]["void"]
          +-D.Declarator [34, 41]["main"]
          |  +-D.Identifier [34, 38]["main"]
          +-D.FunctionBody [41, 60]["float", "f", "=", "4", "F", "i"]
             +-D.StatementList [44, 59]["float", "f", "=", "4", "F", "i"]
                +-D.Statement [44, 59]["float", "f", "=", "4", "F", "i"]
                   +-D.NonEmptyStatement [44, 59]["float", "f", "=", "4", "F", "i"]
                      +-D.DeclarationStatement [44, 59]["float", "f", "=", "4", "F", "i"]
                         +-D.BasicType [44, 50]["float"]
                         |  +-D.BasicTypeX [44, 49]["float"]
                         +-D.Declarators [50, 57]["f", "=", "4", "F", "i"]
                            +-D.Declarator [50, 52]["f"]
                            |  +-D.Identifier [50, 52]["f"]
                            +-D.Initializer [54, 57]["4", "F", "i"]
                               +-D.MulExpression [54, 57]["4", "F", "i"]
                                  +-D.UnaryExpression [54, 57]["4", "F", "i"]
                                     +-D.PowExpression [54, 57]["4", "F", "i"]
                                        +-D.FloatLiteral [54, 57]["4", "F", "i"]
                                           +-D.Integer [54, 55]["4"]
                                           |  +-D.DecimalInteger [54, 55]["4"]
                                           +-D.FloatSuffix [55, 56]["F"]
                                           +-D.ImaginarySuffix [56, 57]["i"]