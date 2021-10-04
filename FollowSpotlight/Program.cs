using Accord.Video.FFMPEG;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Linq;

namespace FollowSpotlight
{
    class Program
    {
        private static List<Point> avgPeak = new List<Point>();

        static int Main(string[] args)
        {
            if (args.Length != 1)
            {
                Console.WriteLine("Usage example " + AppDomain.CurrentDomain.FriendlyName + " path_and_name_of_video");
                return 0;
            }

            VideoFileReader vfr = new VideoFileReader();
            vfr.Open(args[0]);
            Console.WriteLine("Video name: " + args[0]);
            Console.WriteLine("Height: " + vfr.Height);
            Console.WriteLine("Width: " + vfr.Width);
            Console.WriteLine("Bitrate: " + vfr.BitRate);
            Console.WriteLine("CodecName: " + vfr.CodecName);
            Console.WriteLine("Number of frames: " + vfr.FrameCount);
            Console.WriteLine("Frame rate: " + vfr.FrameRate);

            //List<List<Tuple<float, Point>>> frames = new List<List<Tuple<float, Point>>>();
            Console.Write("Loading... ");
            for (int i = 0; i < vfr.FrameCount; i++)
            {
                Bitmap bmp = vfr.ReadVideoFrame(i);
                ProcessFrame(ref bmp);
                Console.Write((float)i * 100.0 / vfr.FrameCount);
                Console.CursorLeft = 11;
            }

            Console.WriteLine();
            string dump = "deltax(px) " + (avgPeak.Max(x => x.X) - avgPeak.Min(x => x.X)) + Environment.NewLine;
            dump += "deltay(px) " + (avgPeak.Max(x => x.Y) - avgPeak.Min(x => x.Y)) + Environment.NewLine;
            Console.WriteLine(dump);
            dump += string.Join(Environment.NewLine, avgPeak.Select(x => x.X + " " + x.Y));
            string path = Directory.GetParent(args[0]).FullName + "\\dump.txt";
            File.WriteAllText(path, dump);

            return 0;
        }

        private static void ProcessFrame(ref Bitmap bmp)
        {
            List<Tuple<double, Point>> points = GetHistogramAndLightness(ref bmp);
            double avgBright = points.Average(x => x.Item1);
            List<Point> pointsAbove = points.Where(x => x.Item1 > avgBright).Select(x => x.Item2).ToList();
            int avgX = (int)pointsAbove.Average(x => (double)x.X);
            int avgY = (int)pointsAbove.Average(x => (double)x.Y);
            avgPeak.Add(new Point(avgX, avgY));
        }

        public static List<Tuple<double, Point>> GetHistogramAndLightness(ref Bitmap img)
        {
            var width = img.Width;
            var height = img.Height;
            var bppModifier = img.PixelFormat == PixelFormat.Format24bppRgb ? 3 : 4;

            var srcData = img.LockBits(new Rectangle(0, 0, img.Width, img.Height), ImageLockMode.ReadOnly, img.PixelFormat);
            var stride = srcData.Stride;
            var scan0 = srcData.Scan0;
            double lum = 0;

            List<Tuple<double, Point>> points = new List<Tuple<double, Point>>();

            unsafe
            {
                byte* p = (byte*)(void*)scan0;

                for (int y = 0; y < height; y++)
                {
                    for (int x = 0; x < width; x++)
                    {
                        int idx = (y * stride) + x * bppModifier;
                        lum = (0.2989 * p[idx + 2] + 0.587 * p[idx + 1] + 0.114 * p[idx]);
                        points.Add(new Tuple<double, Point>(lum, new Point(x, y)));
                    }
                }
            }

            img.UnlockBits(srcData);
            img.Dispose();

            return points;
        }
    }
}