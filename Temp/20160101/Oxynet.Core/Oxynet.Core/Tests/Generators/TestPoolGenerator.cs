using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Oxynet.Core.Tests.Generators
{
    class TestPoolGenerator
    {
        static TestPoolGenerator()
        {
            PoolGenerator g1 = new PoolGenerator("Main");
            PoolGenerator g2 = new PoolGenerator("Addition");
            PoolGenerator g3 = new PoolGenerator("Reserv");
        }
    }
}
