D [0, 30]["int", "main", "return", "1", "(", "1", ")"]
 +-D.Module [0, 30]["int", "main", "return", "1", "(", "1", ")"]
    +-D.Stms [0, 30]["int", "main", "return", "1", "(", "1", ")"]
       +-D.Stm [0, 30]["int", "main", "return", "1", "(", "1", ")"]
          +-D.Function [0, 30]["int", "main", "return", "1", "(", "1", ")"]
             +-D.Type [0, 4]["int"]
             +-D.Name [4, 8]["main"]
             +-D.FunctionBody [10, 30]["return", "1", "(", "1", ")"]
                +-D.Stms [13, 28]["return", "1", "(", "1", ")"]
                   +-D.Stm [13, 28]["return", "1", "(", "1", ")"]
                      +-D.ReturnStm [13, 28]["return", "1", "(", "1", ")"]
                         +-D.Exp [20, 26]["1", "(", "1", ")"]
                            +-D.Factor [20, 21]["1"]
                            |  +-D.Primary [20, 21]["1"]
                            |     +-D.Number [20, 21]["1"]
                            |        +-D.IntegerLiteral [20, 21]["1"]
                            |           +-D.Integer [20, 21]["1"]
                            +-D.Addition [21, 26]["(", "1", ")"]
                               +-D.Factor [22, 26]["(", "1", ")"]
                                  +-D.Primary [22, 26]["(", "1", ")"]
                                     +-D.Parens [22, 26]["(", "1", ")"]
                                        +-D.Arithmetic [23, 25]["1"]
                                           +-D.Factor [23, 25]["1"]
                                              +-D.Primary [23, 25]["1"]
                                                 +-D.Negative [23, 25]["1"]
                                                    +-D.Primary [24, 25]["1"]
                                                       +-D.Number [24, 25]["1"]
                                                          +-D.IntegerLiteral [24, 25]["1"]
                                                             +-D.Integer [24, 25]["1"]
