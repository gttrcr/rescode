using Wolf; //use https://github.com/gttrcr/ParallelWolf

namespace OEIS
{
    //driver function
    //A347924.GenMthGilbreathPolynomial(3);
    
    class A347925 : A347924
    {
        public static new WolframLink GenMthGilbreathPolynomial(int m)
        {
            return CreateOEISSequence(PrimeGCPolynomials(m), true);
        }
    }
}