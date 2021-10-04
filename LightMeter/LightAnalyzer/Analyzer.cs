using System.Collections.Generic;
using System.Drawing;
using System.Drawing.Imaging;
using System.Linq;

namespace LightAnalyzer
{
    public class Analyzer
    {
        private static double _rSquared;
        private static double _intercept;
        private static double _slope;
        private static double _sensorSize;

        public static void UseCalibration(double rSquared, double intercept, double slope, double sensorSize)
        {
            _rSquared = rSquared;
            _intercept = intercept;
            _slope = slope;
            _sensorSize = sensorSize;
        }

        public static Dictionary<char, List<int>> GetHistogramAndLightness(Image img, out double lum)
        {
            Bitmap bitmap = (Bitmap)img.Clone();
            var width = bitmap.Width;
            var height = bitmap.Height;
            var bppModifier = bitmap.PixelFormat == PixelFormat.Format24bppRgb ? 3 : 4;

            var srcData = bitmap.LockBits(new Rectangle(0, 0, bitmap.Width, bitmap.Height), ImageLockMode.ReadOnly, bitmap.PixelFormat);
            var stride = srcData.Stride;
            var scan0 = srcData.Scan0;

            List<int> rList = Enumerable.Repeat(1, 256).ToList();
            List<int> gList = Enumerable.Repeat(1, 256).ToList();
            List<int> bList = Enumerable.Repeat(1, 256).ToList();
            lum = 0;

            unsafe
            {
                byte* p = (byte*)(void*)scan0;

                for (int y = 0; y < height; y++)
                {
                    for (int x = 0; x < width; x++)
                    {
                        int idx = (y * stride) + x * bppModifier;
                        rList[p[idx + 2]]++;
                        gList[p[idx + 1]]++;
                        bList[p[idx + 0]]++;

                        lum += (0.2989 * p[idx + 2] + 0.587 * p[idx + 1] + 0.114 * p[idx]);
                    }
                }
            }

            lum /= (bitmap.Width * bitmap.Height);
            lum = _slope * lum + _intercept;
            lum /= 255.0;

            bitmap.UnlockBits(srcData);
            bitmap.Dispose();

            Dictionary<char, List<int>> ret = new Dictionary<char, List<int>>();
            ret.Add('R', rList);
            ret.Add('G', gList);
            ret.Add('B', bList);

            return ret;
        }

        public static Point FindSpotlight(Image img, out int xSize, out int ySize)
        {
            float vMax = 0;
            Point pMax = new Point();
            Image image = (Image)img.Clone();
            for (int x = 0; x < image.Width; x++)
            {
                for (int y = 0; y < image.Height; y++)
                {
                    float m = ((Bitmap)image).GetPixel(x, y).GetBrightness();
                    if (m > vMax)
                    {
                        vMax = m;
                        pMax = new Point(x, y);
                    }
                }
            }

            xSize = 0;
            float avg = 0;
            for (int x = 0; x < image.Width; x++)
                avg += ((Bitmap)image).GetPixel(x, pMax.Y).GetBrightness();
            avg /= image.Width;
            for (int x = 0; x < image.Width; x++)
                if (((Bitmap)image).GetPixel(x, pMax.Y).GetBrightness() > avg * 1.3)
                    xSize++;

            ySize = 0;
            avg = 0;
            for (int y = 0; y < image.Height; y++)
                avg += ((Bitmap)image).GetPixel(pMax.X, y).GetBrightness();
            avg /= image.Width;
            for (int y = 0; y < image.Height; y++)
                if (((Bitmap)image).GetPixel(pMax.X, y).GetBrightness() > avg * 1.3)
                    ySize++;

            return pMax;
        }
    }
}