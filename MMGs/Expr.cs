using System;
using System.Collections.Generic;
using System.Linq;

namespace MMGs
{
    static class Expr
    {
        public static string Parse(string expr)
        {
            //find until +
            //.+?(?=\+)
            List<Tuple<char, string>> tokens = new List<Tuple<char, string>>();
            int start = 0;
            for (int i = 0; i < expr.Length; i++)
            {
                if (start == 0 && expr[i] != '-' && i == 0)
                {
                    tokens.Add(new Tuple<char, string>('+', ""));
                    start = i;
                }
                else if ((expr[i] == '+' || expr[i] == '-'))
                {
                    tokens[tokens.Count - 1] = new Tuple<char, string>(tokens.Last().Item1, expr.Substring(start, i));
                    start = i;
                }
                else if ((expr[i] == '+' || expr[i] == '-'))
                {
                    tokens[tokens.Count - 1] = new Tuple<char, string>(tokens.Last().Item1, expr.Substring(start, i));
                    tokens.Add(new Tuple<char, string>(expr[i], ""));
                    start = i;
                }
            }
            
            //Solve multiplication
            for (int i = 0; i < tokens.Count; i++)
            {
                List<string> splitMD = tokens[i].Item2.Split('*').ToList();
                splitMD = splitMD.OrderBy(x => x).ToList();
                if (splitMD.TrueForAll(x => x == splitMD[0]))
                {
                    //tokens[i] = tokens[0].Item2 + "^" + tokens[i]..Count;
                    continue;
                }

                if (splitMD.IndexOf("0") != -1)
                {
                    //tokens[i] = "0";
                    continue;
                }

                //tokens[i] = string.Join("*", splitMD);
            }

            //expr = "";
            //if (splitPM.TrueForAll(x => x == splitPM[0]))
            //    expr = splitPM.Count.ToString() + splitPM[0];

            return expr;
        }
    }
}