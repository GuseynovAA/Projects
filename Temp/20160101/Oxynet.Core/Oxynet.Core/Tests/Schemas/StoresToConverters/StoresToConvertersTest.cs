using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Oxynet.Core.Tests.Schemas.StoresToConverters
{
    class StoresToConvertersTest
    {
        public static void RunStoreToConverter()
        {
            PoolGenerator gs = new PoolGenerator("GeneratorS");
            PoolGenerator gc = new PoolGenerator("GeneratorC");

            ListStorage s = new ListStorage();
            s.Enable();
            s.Name = "Store";

            MathConverter c = new MathConverter();
            c.Enable();
            c.Name = "Calculator";

            Builder.DataConnect(s, c);

            Builder.ActivationConnect(gs, s);
            Builder.ActivationConnect(gc, c);

            gs.Enable();
            gc.Enable();
        }

        public static void RunStoreToConverters()
        {
            PoolGenerator gs = new PoolGenerator("GeneratorS");
            PoolGenerator gc1 = new PoolGenerator("GeneratorC1");
            PoolGenerator gc2 = new PoolGenerator("GeneratorC2");

            ListStorage s = new ListStorage();
            s.Enable();
            s.Name = "Store";

            MathConverter c1 = new MathConverter();
            c1.Enable();
            c1.Name = "Calculator1";

            MathConverter c2 = new MathConverter();
            c2.Enable();
            c2.Name = "Calculator2";

            Builder.DataConnect(s, c1);
            Builder.DataConnect(s, c2);

            Builder.ActivationConnect(gs, s);
            Builder.ActivationConnect(gc2, c1);
            Builder.ActivationConnect(gc2, c2);

            gs.Enable();
            gc1.Enable();
            gc2.Enable();
        }

        public static void RunStoreToConvertersToStore()
        {
            PoolGenerator gs1 = new PoolGenerator("GeneratorS1");
            PoolGenerator gc1 = new PoolGenerator("GeneratorC1");
            PoolGenerator gc2 = new PoolGenerator("GeneratorC2");
            PoolGenerator gs2 = new PoolGenerator("GeneratorS2");

            ListStorage s1 = new ListStorage();
            s1.Enable();
            s1.Name = "Store1";

            MathConverter c1 = new MathConverter();
            c1.Enable();
            c1.Name = "Calculator1";

            MathConverter c2 = new MathConverter();
            c2.Enable();
            c2.Name = "Calculator2";

            ListStorage s2 = new ListStorage();
            s2.Enable();
            s2.Name = "Store2";

            Builder.DataConnect(s1, c1);
            Builder.DataConnect(s1, c2);
            Builder.DataConnect(c1, s2);
            Builder.DataConnect(c2, s2);

            Builder.ActivationConnect(gs1, s1);
            Builder.ActivationConnect(gs2, s2);
            Builder.ActivationConnect(gc1, c1);
            Builder.ActivationConnect(gc2, c2);

            gc1.Enable();
            gc2.Enable();
            gs1.Enable();
            gs2.Enable();
        }
    }
}
