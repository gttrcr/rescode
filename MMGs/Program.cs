using System;
using System.Collections.Generic;
using System.Linq;

using type = System.String;

namespace MMGs
{
    class Table<T>
    {
        private List<T> _table;
        private int _x;
        private int _y;
        private int _size;
        public Table(int x, int y)
        {
            _x = x;
            _y = y;
            _size = _x * _y;
            _table = new List<T>(new T[_size]);
        }

        public T Get(int pos)
        {
            return _table[pos];
        }

        public T Get(int x, int y)
        {
            return _table[y * _x + x];
        }

        public void Set(int pos, T t)
        {
            _table[pos] = t;
        }

        public void Set(int x, int y, T t)
        {
            _table[y * _x + x] = t;
        }

        public List<T> Tbl()
        {
            return _table;
        }

        public override string ToString()
        {
            string str = "{";
            for (int y = 0; y < _y; y++)
            {
                str += "{";
                for (int x = 0; x < _x; x++)
                    str += Get(x, y).ToString() + ((x == _x - 1) ? "" : ",");
                str += "}" + ((y == _y - 1) ? "" : ",");
            }

            return str + "}";
        }

        public static Table<string> operator *(Table<T> A, Table<T> B)
        {
            int rA = A._y;
            int cA = A._x;
            int rB = B._y;
            int cB = B._x;
            Table<string> ret = new Table<type>(rA, cB);
            //if (cA != rB)
            //{
            //    Console.WriteLine("matrik can't be multiplied !!");
            //    throw new Exception();
            //}
            //else
            //{
            for (int i = 0; i < rA; i++)
            {
                for (int j = 0; j < cB; j++)
                {
                    string temp = "";
                    for (int k = 0; k < cA; k++)
                        temp += A.Get(i, k).ToString() + "*" + B.Get(k, j).ToString() + ((k == cA - 1) ? "" : "+");
                    ret.Set(i, j, Expr.Parse(temp)); // Expr.Parse(temp).ToString().Replace(" ", ""));
                }
            }

            return ret;
            //}
        }
    }

    class Program
    {
        static void Main(string[] args)
        {
            const int X = 2;
            const int Y = 2;
            List<Tuple<type, int>> allowed = new List<Tuple<type, int>>();
            allowed.Add(new Tuple<type, int>("a", 2));
            allowed.Add(new Tuple<type, int>("b", 2));

            //Create all matrices
            List<Table<type>> gen = new List<Table<type>>();
            Random rnd = new Random();
            while (gen.Count != 209)
            {
                Table<type> table = new Table<type>(X, Y);
                for (int x = 0; x < X; x++)
                    for (int y = 0; y < Y; y++)
                    {
                        int r = rnd.Next(0, 3);
                        table.Set(x, y, ((char)(r == 0 ? '0' : (r - 1) + 'a')).ToString());
                    }

                bool ko = false;
                for (int i = 0; i < allowed.Count; i++)
                    if (table.Tbl().Count(x => x == allowed[i].Item1) > allowed[i].Item2)
                    {
                        ko = true;
                        break;
                    }

                if (ko)
                    continue;

                if (!gen.Contains(table))
                    gen.Add(table);
            }

            //Play the MMG
            List<Table<type>> all = new List<Table<type>>(gen);
            int deep = 2;
            for (int i = 0; i < deep; i++)
            {
                int estimation = all.Count;
                for (int k = 0; k < estimation; k++)
                {
                    if (k % 100 == 0)
                        Console.WriteLine(100 * (double)k * (i + 1) / (estimation * deep));
                    List<Table<type>> tmpList = new List<Table<type>>();
                    for (int g = 0; g < gen.Count; g++)
                        tmpList.Add(all[0] * gen[g]);
                    all.RemoveAt(0);
                    all.AddRange(tmpList);
                }
            }
            List<Table<type>> dAll = all.Distinct().ToList();
            Console.WriteLine(all.Count + " all MMG matrices");
            Console.WriteLine(dAll.Count + " distinct all MMG matrices");
            Console.ReadLine();
        }
    }
}