using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Numerics;
using System.Threading;
using System.Threading.Tasks;
using Wolf; //use https://github.com/gttrcr/ParallelWolf

namespace OEIS
{
    //driver function
    //A347924.GenMthGilbreathPolynomial(3);

    class A347924
    {
        private static readonly string folder = "gilbreath_polynomials\\";

        public static void GenMthGilbreathPolynomial(int start, int length)
        {
            CreateOEISSequence(PrimeGCPolynomials(start, length)).Dispose();
        }

        protected static WolframLink PrimeGCPolynomials(int start, int delta = 1, WolframLink wolf = null)
        {
            List<BigInteger> prime = PrimeGen.GeneratePrimes(start + delta);

            if (wolf == null)
                wolf = new WolframLink();
            return GCPolynomials(prime, start, wolf);
        }

        private static readonly Mutex writeMutex = new Mutex();
        private static WolframLink GCPolynomials(List<BigInteger> seq, int start, WolframLink wolf = null)
        {
            if (wolf == null)
                wolf = new WolframLink();

            if (Directory.Exists(folder))
                Directory.Delete(folder, true);
            Console.SetBufferSize(9999, 100);
            Parallel.For(start, seq.Count, new ParallelOptions() { MaxDegreeOfParallelism = 8 }, (int i) =>
            {
                int terms = i;
                double percentage = 0;
                List<BigInteger> max = GC.MaxK(seq.GetRange(0, i), terms + 3, () =>
                {
                    writeMutex.WaitOne();
                    Console.SetCursorPosition(0, i - start);
                    Console.WriteLine((int)(100 * (++percentage / (terms + 3))));
                    writeMutex.ReleaseMutex();
                });

                string str = string.Join(",", max.Select(x => x.ToString()));
                str = "t:={" + str + "};res:=Table[t[[n]]-2^(n+" + (i - 1).ToString() + "),{n,1,Length[t]}];FindSequenceFunction[res,n]";
                str = wolf.Wolf(str);

                writeMutex.WaitOne();
                string path = folder + i.ToString() + ".txt";
                Directory.CreateDirectory(Path.GetDirectoryName(path));
                File.WriteAllText(path, str);
                writeMutex.ReleaseMutex();
            });

            Console.SetCursorPosition(0, seq.Count - start);

            return wolf;
        }

        protected static WolframLink CreateOEISSequence(WolframLink wolf = null, bool A347925 = false)
        {
            if (wolf == null)
                wolf = new WolframLink();

            string[] files = Directory.GetFiles(folder);
            files = files.OrderBy(x => Convert.ToInt32(Path.GetFileNameWithoutExtension(x))).ToArray();
            int a = 0;
            List<Tuple<string, string>> sequence = new List<Tuple<string, string>>();
            for (int i = 0; i < files.Length; i++)
            {
                int m = Convert.ToInt32(Path.GetFileNameWithoutExtension(files[i]));
                string content = File.ReadAllText(files[i]);
                string den = wolf.Wolf("Denominator[" + content + "]");
                string coeff = wolf.Wolf("CoefficientList[(" + den + ") (" + content + "), n]");
                List<string> l = wolf.ToArray(coeff);
                if (A347925)
                    sequence.Add(new Tuple<string, string>((++a).ToString(), den.ToString()));
                else
                {
                    l.ForEach(x => sequence.Add(new Tuple<string, string>((++a).ToString(), x)));
                    for (int c = l.Count; c < m; c++)
                        sequence.Add(new Tuple<string, string>((++a).ToString(), "0"));
                }
            }

            string res = "";
            sequence.ForEach(x => res += x.Item1 + " " + x.Item2 + Environment.NewLine);
            Console.WriteLine(res);
            //File.WriteAllText("..\\..\\b347360.txt", res);

            return wolf;
        }
    }
}