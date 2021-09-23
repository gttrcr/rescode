using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using Wolf;

namespace OEIS
{
    class ANew : A347924
    {
        public static new void GenMthGilbreathPolynomial(int start, int length)
        {
            folder = "ANew\\";
            WolframLink wolf = PrimeGCPolynomials(start, length, false);
            CreateOEISSequence(wolf).Dispose();
        }

        private static WolframLink CreateOEISSequence(WolframLink wolf = null)
        {
            if (wolf == null)
                wolf = new WolframLink();

            string[] files = Directory.GetFiles(folder);
            files = files.OrderBy(x => Convert.ToInt32(Path.GetFileNameWithoutExtension(x))).ToArray();
            List<string> polynomials = files.Select(x => File.ReadAllText(x)).ToList();
            int n = 1;
            int m = 1;
            List<string> valueAtN = wolf.Wolf(polynomials.Select(x => { m++; return "ReplaceAll[2^(" + (m - 1).ToString() + "-1) + " + x + ", n->" + n.ToString() + "]"; }).ToList());
            valueAtN.ForEach(x => Console.WriteLine(x));

            return wolf;
        }
    }
}
