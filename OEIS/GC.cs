using System;
using System.Collections.Generic;
using System.Numerics;

namespace OEIS
{
    public static class GC
    {
        private static List<BigInteger> ReducedG(List<BigInteger> list)
        {
            List<BigInteger> tmp = new List<BigInteger>();
            int count = list.Count;
            for (int i = 1; i < count; i++)
                tmp.Add(BigInteger.Abs(list[i] - list[i - 1]));

            return tmp;
        }

        public static bool IsG(List<BigInteger> list)
        {
            while (list.Count > 1)
            {
                list = ReducedG(list);
                if (list[0] != 1)
                    return false;
            }

            if (list[0] == 1)
                return true;

            return false;
        }

        public static List<BigInteger> MaxK(List<BigInteger> lInput, int n = 1, Action newGenerationCallback = null)
        {
            List<BigInteger> list = new List<BigInteger>(lInput);
            List<BigInteger> append = new List<BigInteger>();
            for (int i = 0; i < n; i++)
            {
                BigInteger max = MaxK(list);
                if (newGenerationCallback != null)
                    newGenerationCallback();
                append.Add(max);
                list.Add(max);
            }

            return append;
        }

        private static BigInteger MaxK(List<BigInteger> lInput)
        {
            List<BigInteger> list = new List<BigInteger>(lInput);
            if (list.Count == 1)
                return list[0] + 1;

            list.Add(list[list.Count - 1]);

            //define great bound
            int count, i = 0;
            List<BigInteger> tmpList = new List<BigInteger>(list);
            while (!(IsG(list) && !IsG(tmpList)))
            {
                count = 0;
                while (IsG(list))
                    list[list.Count - 1] += BigInteger.Pow(2, (int)(1 + count++ / Math.Pow(2, i)));

                //refine
                count = 0;
                while (!IsG(list))
                    list[list.Count - 1] -= BigInteger.Pow(2, (int)(1 + count++ / Math.Pow(2, i)));

                i++;
                tmpList.Clear();
                tmpList.AddRange(list);
                tmpList[tmpList.Count - 1] += 2;
            }

            return list[list.Count - 1];
        }

        private static BigInteger MinK(List<BigInteger> lInput)
        {
            return BigInteger.Zero;
        }

        public static List<BigInteger> RandomSequence(out bool ok, int length = 10)
        {
            List<BigInteger> ret = new List<BigInteger>();
            Random rnd = new Random();
            ret.Add(rnd.Next(0, 100));
            bool even = ((ret[0] % 2) == 0);
            BigInteger maxK = MaxK(ret);
            BigInteger minK = MinK(ret);
            ret.Add(rnd.Next(0, 2) == 0 ? minK : maxK);
            while (ret.Count < length)
            {
                maxK = MaxK(ret);
                minK = MinK(ret);
                int element = rnd.Next((int)minK, (int)maxK + 1);
                if (!(((!even && (element % 2 == 0)) || (even && element % 2 != 0))))
                {
                    if (element - 1 >= minK)
                        element--;
                    else if (element + 1 <= maxK)
                        element++;
                }
                ret.Add(element);
            }

            ok = IsG(ret);
            return ret;
        }
    }
}