using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;

namespace OEIS
{
    public static class Utils
    {
        public static void SaveResult(int n, List<string> output)
        {
            string[] files = Directory.GetFiles("results").Select(x => x.Split(new string[] { "\\" }, StringSplitOptions.RemoveEmptyEntries)[1]).ToArray();
            bool contains = false;
            for (int i = 0; i < files.Length; i++)
                if (files[i] == n.ToString())
                    contains = true;

            if (!contains)
            {
                ResultsDataType res = new ResultsDataType();
                res.expressions = new List<string>();
                res.expressions.AddRange(output);
                string json = JsonConvert.SerializeObject(res);
                File.WriteAllText("results/" + n.ToString(), json);
            }
        }
    }

    public class ResultsDataType
    {
        public List<string> expressions;
    }
}