using System;
using System.Collections.Generic;
using System.Numerics;

namespace OEIS
{
    public static class PrimeGen
    {
        public static List<BigInteger> GeneratePrimes(int n)
        {
            List<BigInteger> ret = new List<BigInteger>();
            BigInteger i = 0;
            while (ret.Count < n)
            {
                if (IsPrime(i))
                    ret.Add(i);
                i++;
            }

            return ret;
        }

        public static bool IsPrime(BigInteger number)
        {
            if (number <= 1)
                return false;
            if (number == 2)
                return true;
            if (number % 2 == 0)
                return false;

            int boundary = (int)Math.Floor(Math.Sqrt((ulong)number));
            for (int i = 3; i <= boundary; i += 2)
                if (number % i == 0)
                    return false;

            return true;
        }
    }
}