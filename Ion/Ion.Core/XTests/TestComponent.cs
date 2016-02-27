using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using Ion.Core.Units.Data.Converters;
using Ion.Core.Units.Power.Generators;

namespace Ion.Core.Tests
{
    class TestConverter : Converter
    {
        public TestConverter(string name)
            : base(name)
        {
        }

        public override bool Execute()
        {
            Console.WriteLine(this.Name + " begin at  " + DateTime.Now.ToString());

            for (int i = 0; i < 500000000; i++)
            {
                double a = i / (i * i + 1 / (i + 1) + i);
            }

            Console.WriteLine(this.Name + " end at " + DateTime.Now.ToString());

            return true;
        }
    }

    class TestComponent
    {
        public TestComponent()
        {
            //ThreadPool.SetMinThreads(8, 8);

            PoolGenerator pg1 = new PoolGenerator("Generator1");
            PoolGenerator pg2 = new PoolGenerator("Generator2");
            PoolGenerator pg3 = new PoolGenerator("Generator3");
            PoolGenerator pg4 = new PoolGenerator("Generator4");
            PoolGenerator pg5 = new PoolGenerator("Generator5");
            PoolGenerator pg6 = new PoolGenerator("Generator6");
            PoolGenerator pg7 = new PoolGenerator("Generator7");
            PoolGenerator pg8 = new PoolGenerator("Generator8");

            TestConverter tc1 = new TestConverter("Converter1");
            TestConverter tc2 = new TestConverter("Converter2");
            TestConverter tc3 = new TestConverter("Converter3");
            TestConverter tc4 = new TestConverter("Converter4");
            TestConverter tc5 = new TestConverter("Converter5");
            TestConverter tc6 = new TestConverter("Converter6");
            TestConverter tc7 = new TestConverter("Converter7");
            TestConverter tc8 = new TestConverter("Converter8");

            Builders.Builder.PowerConnect(pg1, tc1);
            Builders.Builder.PowerConnect(pg2, tc2);
            Builders.Builder.PowerConnect(pg3, tc3);
            Builders.Builder.PowerConnect(pg4, tc4);
            Builders.Builder.PowerConnect(pg5, tc5);
            Builders.Builder.PowerConnect(pg6, tc6);
            Builders.Builder.PowerConnect(pg7, tc7);
            Builders.Builder.PowerConnect(pg8, tc8);

            tc1.Enable();
            tc2.Enable();
            tc3.Enable();
            tc4.Enable();
            tc5.Enable();
            tc6.Enable();
            tc7.Enable();
            tc8.Enable();

            pg1.Enable();
            pg2.Enable();
            pg3.Enable();
            pg4.Enable();
            pg5.Enable();
            pg6.Enable();
            pg7.Enable();
            pg8.Enable();
        }
    }
}
