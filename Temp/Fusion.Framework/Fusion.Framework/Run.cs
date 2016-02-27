using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Fusion.Framework
{
    class Run
    {
        static void Main(string[] args)
        {
            SqlExecFactoryTest();
        }

        private static void SqlExecFactoryTest()
        {
            SqlExecFactory sqlExec = new SqlExecFactory(new System.Data.SqlClient.SqlConnection(""));

            sqlExec.Build();

            sqlExec.Run();

            string s = String.Empty;
            while (s != "Exit")
            {
                s = Console.ReadLine();

                if (s == "Impuls")
                    sqlExec.SetImpuls();

                if (s == "Debug")
                {

                }
            }
        }
    }
}
