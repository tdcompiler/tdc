D [0, 34]["int", "main", "return", "(", "1", "2", ")", "3"]
 +-D.Module [0, 34]["int", "main", "return", "(", "1", "2", ")", "3"]
    +-D.Stms [0, 34]["int", "main", "return", "(", "1", "2", ")", "3"]
       +-D.Stm [0, 34]["int", "main", "return", "(", "1", "2", ")", "3"]
          +-D.Function [0, 34]["int", "main", "return", "(", "1", "2", ")", "3"]
             +-D.Type [0, 4]["int"]
             +-D.Name [4, 8]["main"]
             +-D.FunctionBody [10, 34]["return", "(", "1", "2", ")", "3"]
                +-D.Stms [14, 31]["return", "(", "1", "2", ")", "3"]
                   +-D.Stm [14, 31]["return", "(", "1", "2", ")", "3"]
                      +-D.ReturnStm [14, 31]["return", "(", "1", "2", ")", "3"]
                         +-D.Exp [21, 28]["(", "1", "2", ")", "3"]
                            +-D.Factor [21, 28]["(", "1", "2", ")", "3"]
                               +-D.Primary [21, 26]["(", "1", "2", ")"]
                               |  +-D.Parens [21, 26]["(", "1", "2", ")"]
                               |     +-D.Arithmetic [22, 25]["1", "2"]
                               |        +-D.Factor [22, 23]["1"]
                               |        |  +-D.Primary [22, 23]["1"]
                               |        |     +-D.Number [22, 23]["1"]
                               |        |        +-D.IntegerLiteral [22, 23]["1"]
                               |        |           +-D.Integer [22, 23]["1"]
                               |        +-D.Addition [23, 25]["2"]
                               |           +-D.Factor [24, 25]["2"]
                               |              +-D.Primary [24, 25]["2"]
                               |                 +-D.Number [24, 25]["2"]
                               |                    +-D.IntegerLiteral [24, 25]["2"]
                               |                       +-D.Integer [24, 25]["2"]
                               +-D.Multiplication [26, 28]["3"]
                                  +-D.Primary [27, 28]["3"]
                                     +-D.Number [27, 28]["3"]
                                        +-D.IntegerLiteral [27, 28]["3"]
                                           +-D.Integer [27, 28]["3"]
