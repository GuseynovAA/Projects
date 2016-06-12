using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Oxynet.Core.Tests.Schemas
{
    class MathConverter : Converter
    {
        private object item;
        protected override void PortReading(DataPort port, object value)
        {
            item = value;
        }

        private double result;
        private int counter;
        public override bool Work()
        {
            result = Convert.ToDouble(item);

            for (int i = 10; i < 1000000; i++)
            {
                result += (i^3 - i^2 + i - 1)/(i^4 - i^3 - i^2 - i - 1);
            }

            counter++;

            return true;
        }

        protected override void PortWriting(DataPort port, out object value)
        {
            value = result;
        }
    }
}
