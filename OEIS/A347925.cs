namespace OEIS
{
    //driver function
    //A347924.GenMthGilbreathPolynomial(3, 10);

    class A347925 : A347924
    {
        public static new void GenMthGilbreathPolynomial(int start, int length)
        {
            CreateOEISSequence(PrimeGCPolynomials(start, length, false), true).Dispose();
        }
    }
}