D [0, 32]["int", "main", "return", "313", "LU"]
 +-D.Module [0, 32]["int", "main", "return", "313", "LU"]
    +-D.DeclDefs [0, 32]["int", "main", "return", "313", "LU"]
       +-D.DeclDef [0, 32]["int", "main", "return", "313", "LU"]
          +-D.BasicType [0, 4]["int"]
          |  +-D.BasicTypeX [0, 3]["int"]
          +-D.Declarator [4, 10]["main"]
          |  +-D.Identifier [4, 8]["main"]
          +-D.FunctionBody [10, 32]["return", "313", "LU"]
             +-D.StatementList [13, 30]["return", "313", "LU"]
                +-D.Statement [13, 30]["return", "313", "LU"]
                   +-D.NonEmptyStatement [13, 30]["return", "313", "LU"]
                      +-D.ReturnStatement [13, 30]["return", "313", "LU"]
                         +-D.Expression [20, 28]["313", "LU"]
                            +-D.MulExpression [20, 28]["313", "LU"]
                               +-D.UnaryExpression [20, 28]["313", "LU"]
                                  +-D.PowExpression [20, 28]["313", "LU"]
                                     +-D.IntegerLiteral [20, 28]["313", "LU"]
                                        +-D.Integer [20, 26]["313"]
                                        |  +-D.DecimalInteger [20, 26]["313"]
                                        +-D.IntegerSuffix [26, 28]["LU"]
