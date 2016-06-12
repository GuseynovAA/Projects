using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using Ion.Core.Units.Data.Converters;
using Ion.Core.Units.Power.Generators;
using Ion.Core.Units.Data.Storages;
using Ion.Core.Ports.Data;

namespace Ion.Core.Tests
{
    class SupplyStorage : Storage
    {
        private int itemsCount = 20;

        public SupplyStorage(string name)
            : base(name)
        {
        }

        public override bool Empty()
        {
            return itemsCount == 0;
        }

        protected override void ResourceSending(Ports.Data.DataPort port, out object value)
        {
            value = null;

            if (itemsCount > 0)
            {
                value = "Object:" + itemsCount.ToString();
                itemsCount--;
            }

            //Console.WriteLine("Unit:" + this.Name + " " + value);
        }
    }

    class IntermediateStorage : Storage
    {
        private System.Collections.ArrayList list = new System.Collections.ArrayList();

        public IntermediateStorage(string name)
            : base(name)
        {
        }

        public override bool Empty()
        {
            return list.Count == 0;
        }

        public override bool Full()
        {
            return list.Count == 10;
        }

        protected override void ResourceReceiving(Ports.Data.DataPort port, object value)
        {
            list.Add(value + ">" + this.Name);
        }

        protected override void ResourceSending(Ports.Data.DataPort port, out object value)
        {
            value = list[0];
            list.RemoveAt(0);
        }
    }

    class BuyerStorage : Storage
    {
        private System.Collections.ArrayList list = new System.Collections.ArrayList();

        public BuyerStorage(string name)
            : base(name)
        {
        }

        protected override void ResourceReceiving(Ports.Data.DataPort port, object value)
        {
            list.Add(value);
            Console.WriteLine(value);
        }
    }

    class TestComponent
    {
        public TestComponent()
        {
            ThreadGenerator pg1 = new ThreadGenerator("g1");

            System.Collections.Generic.List<IntermediateStorage> il = new System.Collections.Generic.List<IntermediateStorage>();

            for (int i = 0; i < 10; i++)
            {
                IntermediateStorage ist = new IntermediateStorage("i" + i.ToString());
                il.Add(ist);

                Builders.Builder.PowerConnect(pg1, ist);
                ist.Enable();
            }

            foreach (IntermediateStorage x in il)
                foreach (IntermediateStorage y in il)
                //if(!Object.Equals(x, y))
                    Builders.Builder.DataConnect(x, y);

            SupplyStorage ss = new SupplyStorage("s1");
            Builders.Builder.PowerConnect(pg1, ss);
            Builders.Builder.DataConnect(ss, il[0]);
            ss.Enable();

            BuyerStorage bs = new BuyerStorage("b1");
            Builders.Builder.PowerConnect(pg1, bs);
            Builders.Builder.DataConnect(il[0], bs);
            bs.Enable();


            //SupplyStorage ss = new SupplyStorage("Supplier");
            //BuyerStorage bs = new BuyerStorage("Buyer");

            //Builders.Builder.PowerConnect(pg1, ss);
            //Builders.Builder.PowerConnect(pg1, bs);

            //Builders.Builder.DataConnect(ss, bs);
            //Builders.Builder.DataConnect(ss, bs);

            //bs.Enable();
            //ss.Enable();

            pg1.Enable();
        }
    }
}
