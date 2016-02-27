using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Oxynet.Core.Tests.Schemas
{
    class ListStorage : Storage
    {
        private List<object> list = new List<object>();

        public ListStorage()
        {
            for (int i = 0; i < 1000; i++)
                list.Add(i);
        }

        public override bool Empty()
        {
            return list.Count == 0;
        }

        private int counter;
        protected override void PortWriting(DataPort port, out object value)
        {
            value = list[0];
            list.Remove(value);

            counter++;
        }

        protected override void PortReading(DataPort port, object value)
        {
            //Console.WriteLine(String.Format("Port {0}; Value {1}", port.Name, value));
        }
    }
}
