using System.Collections.Generic;

/*
namespace OEIS
{
    public class S
    {
        public int R { get; private set; }
        public int C { get; private set; }

        public S(int r, int c)
        {
            R = r;
            C = c;
        }

        public new string ToString()
        {
            return ("s" + C + "(" + R + ")").Replace("(0)", "");
        }

        public string Value(List<List<S>> gTri)
        {
            return Value(ToString(), gTri);
        }

        public static string Value(string s, List<List<S>> gTri)
        {
            for (int r = 0; r < gTri.Count; r++)
                for (int c = 0; c < gTri[r].Count; c++)
                    if (gTri[r][c].ToString() == s)
                    {
                        if (r == 0)
                            return "(" + s.ToString() + ")";
                        if (r - 1 == 0)
                            return "(" + gTri[r - 1][c + 1].ToString() + "-" + gTri[r - 1][c].ToString() + ")";

                        return "Abs[" + gTri[r - 1][c + 1].ToString() + "-" + gTri[r - 1][c].ToString() + "]";
                    }

            return "";
        }
    }
}
*/