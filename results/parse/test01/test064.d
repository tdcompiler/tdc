D [0, 149]["void", "main", "{", "}", "long", "foo", "in", "t", "i", "return", "1", "int", "bar", "char", "c", "long", "l", "return", "2", "void", "baz", "bool", "b", "double", "d", "byte", "by", "return"]
 +-D.Module [0, 149]["void", "main", "{", "}", "long", "foo", "in", "t", "i", "return", "1", "int", "bar", "char", "c", "long", "l", "return", "2", "void", "baz", "bool", "b", "double", "d", "byte", "by", "return"]
    +-D.DeclDefs [0, 149]["void", "main", "{", "}", "long", "foo", "in", "t", "i", "return", "1", "int", "bar", "char", "c", "long", "l", "return", "2", "void", "baz", "bool", "b", "double", "d", "byte", "by", "return"]
       +-D.DeclDef [13, 29]["void", "main", "{", "}"]
       |  +-D.Declaration [13, 29]["void", "main", "{", "}"]
       |     +-D.Decl [13, 29]["void", "main", "{", "}"]
       |        +-D.basicFunction [13, 29]["void", "main", "{", "}"]
       |           +-D.BasicType [13, 18]["void"]
       |           |  +-D.BasicTypeX [13, 17]["void"]
       |           +-D.Declarator [18, 25]["main"]
       |           |  +-D.Identifier [18, 22]["main"]
       |           +-D.FunctionBody [25, 29]["{", "}"]
       |              +-D.BlockStatement [25, 29]["{", "}"]
       +-D.DeclDef [29, 61]["long", "foo", "in", "t", "i", "return", "1"]
       |  +-D.Declaration [29, 61]["long", "foo", "in", "t", "i", "return", "1"]
       |     +-D.Decl [29, 61]["long", "foo", "in", "t", "i", "return", "1"]
       |        +-D.basicFunction [29, 61]["long", "foo", "in", "t", "i", "return", "1"]
       |           +-D.BasicType [29, 34]["long"]
       |           |  +-D.BasicTypeX [29, 33]["long"]
       |           +-D.Declarator [34, 45]["foo", "in", "t", "i"]
       |           |  +-D.Identifier [34, 37]["foo"]
       |           |  +-D.DeclaratorSuffixes [37, 45]["in", "t", "i"]
       |           |     +-D.DeclaratorSuffix [37, 45]["in", "t", "i"]
       |           |        +-D.Parameters [37, 45]["in", "t", "i"]
       |           |           +-D.ParameterList [38, 43]["in", "t", "i"]
       |           |              +-D.Parameter [38, 43]["in", "t", "i"]
       |           |                 +-D.InOut [38, 40]["in"]
       |           |                 |  +-D.InOutX [38, 40]["in"]
       |           |                 +-D.BasicType [40, 42]["t"]
       |           |                 |  +-D.IdentifierList [40, 41]["t"]
       |           |                 |     +-D.Identifier [40, 41]["t"]
       |           |                 +-D.Declarator [42, 43]["i"]
       |           |                    +-D.Identifier [42, 43]["i"]
       |           +-D.FunctionBody [45, 61]["return", "1"]
       |              +-D.BlockStatement [45, 61]["return", "1"]
       |                 +-D.StatementList [48, 58]["return", "1"]
       |                    +-D.Statement [48, 58]["return", "1"]
       |                       +-D.NonEmptyStatement [48, 58]["return", "1"]
       |                          +-D.NonEmptyStatementNoCaseNoDefault [48, 58]["return", "1"]
       |                             +-D.ReturnStatement [48, 58]["return", "1"]
       |                                +-D.Expression [55, 56]["1"]
       |                                   +-D.CommaExpression [55, 56]["1"]
       |                                      +-D.AssignExpression [55, 56]["1"]
       |                                         +-D.ConditionalExpression [55, 56]["1"]
       |                                            +-D.OrOrExpression [55, 56]["1"]
       |                                               +-D.AndAndExpression [55, 56]["1"]
       |                                                  +-D.OrExpression [55, 56]["1"]
       |                                                     +-D.XorExpression [55, 56]["1"]
       |                                                        +-D.AndExpression [55, 56]["1"]
       |                                                           +-D.ShiftExpression [55, 56]["1"]
       |                                                              +-D.AddExpression [55, 56]["1"]
       |                                                                 +-D.MulExpression [55, 56]["1"]
       |                                                                    +-D.UnaryExpression [55, 56]["1"]
       |                                                                       +-D.PowExpression [55, 56]["1"]
       |                                                                          +-D.PostfixExpression [55, 56]["1"]
       |                                                                             +-D.PrimaryExpression [55, 56]["1"]
       |                                                                                +-D.IntegerLiteral [55, 56]["1"]
       |                                                                                   +-D.Integer [55, 56]["1"]
       |                                                                                      +-D.DecimalInteger [55, 56]["1"]
       +-D.DeclDef [61, 101]["int", "bar", "char", "c", "long", "l", "return", "2"]
       |  +-D.Declaration [61, 101]["int", "bar", "char", "c", "long", "l", "return", "2"]
       |     +-D.Decl [61, 101]["int", "bar", "char", "c", "long", "l", "return", "2"]
       |        +-D.basicFunction [61, 101]["int", "bar", "char", "c", "long", "l", "return", "2"]
       |           +-D.BasicType [61, 65]["int"]
       |           |  +-D.BasicTypeX [61, 64]["int"]
       |           +-D.Declarator [65, 85]["bar", "char", "c", "long", "l"]
       |           |  +-D.Identifier [65, 68]["bar"]
       |           |  +-D.DeclaratorSuffixes [68, 85]["char", "c", "long", "l"]
       |           |     +-D.DeclaratorSuffix [68, 85]["char", "c", "long", "l"]
       |           |        +-D.Parameters [68, 85]["char", "c", "long", "l"]
       |           |           +-D.ParameterList [69, 83]["char", "c", "long", "l"]
       |           |              +-D.Parameter [69, 75]["char", "c"]
       |           |              |  +-D.BasicType [69, 74]["char"]
       |           |              |  |  +-D.BasicTypeX [69, 73]["char"]
       |           |              |  +-D.Declarator [74, 75]["c"]
       |           |              |     +-D.Identifier [74, 75]["c"]
       |           |              +-D.Parameter [77, 83]["long", "l"]
       |           |                 +-D.BasicType [77, 82]["long"]
       |           |                 |  +-D.BasicTypeX [77, 81]["long"]
       |           |                 +-D.Declarator [82, 83]["l"]
       |           |                    +-D.Identifier [82, 83]["l"]
       |           +-D.FunctionBody [85, 101]["return", "2"]
       |              +-D.BlockStatement [85, 101]["return", "2"]
       |                 +-D.StatementList [88, 98]["return", "2"]
       |                    +-D.Statement [88, 98]["return", "2"]
       |                       +-D.NonEmptyStatement [88, 98]["return", "2"]
       |                          +-D.NonEmptyStatementNoCaseNoDefault [88, 98]["return", "2"]
       |                             +-D.ReturnStatement [88, 98]["return", "2"]
       |                                +-D.Expression [95, 96]["2"]
       |                                   +-D.CommaExpression [95, 96]["2"]
       |                                      +-D.AssignExpression [95, 96]["2"]
       |                                         +-D.ConditionalExpression [95, 96]["2"]
       |                                            +-D.OrOrExpression [95, 96]["2"]
       |                                               +-D.AndAndExpression [95, 96]["2"]
       |                                                  +-D.OrExpression [95, 96]["2"]
       |                                                     +-D.XorExpression [95, 96]["2"]
       |                                                        +-D.AndExpression [95, 96]["2"]
       |                                                           +-D.ShiftExpression [95, 96]["2"]
       |                                                              +-D.AddExpression [95, 96]["2"]
       |                                                                 +-D.MulExpression [95, 96]["2"]
       |                                                                    +-D.UnaryExpression [95, 96]["2"]
       |                                                                       +-D.PowExpression [95, 96]["2"]
       |                                                                          +-D.PostfixExpression [95, 96]["2"]
       |                                                                             +-D.PrimaryExpression [95, 96]["2"]
       |                                                                                +-D.IntegerLiteral [95, 96]["2"]
       |                                                                                   +-D.Integer [95, 96]["2"]
       |                                                                                      +-D.DecimalInteger [95, 96]["2"]
       +-D.DeclDef [101, 149]["void", "baz", "bool", "b", "double", "d", "byte", "by", "return"]
          +-D.Declaration [101, 149]["void", "baz", "bool", "b", "double", "d", "byte", "by", "return"]
             +-D.Decl [101, 149]["void", "baz", "bool", "b", "double", "d", "byte", "by", "return"]
                +-D.basicFunction [101, 149]["void", "baz", "bool", "b", "double", "d", "byte", "by", "return"]
                   +-D.BasicType [101, 106]["void"]
                   |  +-D.BasicTypeX [101, 105]["void"]
                   +-D.Declarator [106, 137]["baz", "bool", "b", "double", "d", "byte", "by"]
                   |  +-D.Identifier [106, 109]["baz"]
                   |  +-D.DeclaratorSuffixes [109, 137]["bool", "b", "double", "d", "byte", "by"]
                   |     +-D.DeclaratorSuffix [109, 137]["bool", "b", "double", "d", "byte", "by"]
                   |        +-D.Parameters [109, 137]["bool", "b", "double", "d", "byte", "by"]
                   |           +-D.ParameterList [110, 135]["bool", "b", "double", "d", "byte", "by"]
                   |              +-D.Parameter [110, 116]["bool", "b"]
                   |              |  +-D.BasicType [110, 115]["bool"]
                   |              |  |  +-D.BasicTypeX [110, 114]["bool"]
                   |              |  +-D.Declarator [115, 116]["b"]
                   |              |     +-D.Identifier [115, 116]["b"]
                   |              +-D.Parameter [118, 126]["double", "d"]
                   |              |  +-D.BasicType [118, 125]["double"]
                   |              |  |  +-D.BasicTypeX [118, 124]["double"]
                   |              |  +-D.Declarator [125, 126]["d"]
                   |              |     +-D.Identifier [125, 126]["d"]
                   |              +-D.Parameter [128, 135]["byte", "by"]
                   |                 +-D.BasicType [128, 133]["byte"]
                   |                 |  +-D.BasicTypeX [128, 132]["byte"]
                   |                 +-D.Declarator [133, 135]["by"]
                   |                    +-D.Identifier [133, 135]["by"]
                   +-D.FunctionBody [137, 149]["return"]
                      +-D.BlockStatement [137, 149]["return"]
                         +-D.StatementList [140, 148]["return"]
                            +-D.Statement [140, 148]["return"]
                               +-D.NonEmptyStatement [140, 148]["return"]
                                  +-D.NonEmptyStatementNoCaseNoDefault [140, 148]["return"]
                                     +-D.ReturnStatement [140, 148]["return"]
