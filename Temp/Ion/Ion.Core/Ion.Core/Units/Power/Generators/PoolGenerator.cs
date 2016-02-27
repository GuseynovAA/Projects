using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;

using Ion.Core.Power;
using Ion.Core.Ports.Power;

namespace Ion.Core.Units.Power.Generators
{
    public class PoolGenerator : PowerUnit
    {
        private static object m_stlock = new object();
        private static Thread m_GeneratationThread;

        static PoolGenerator()
        {
            m_GeneratationThread = new Thread(new ThreadStart(Activate));
            m_GeneratationThread.Start();
        }

        private static List<PoolGenerator> m_Generators = new List<PoolGenerator>();
        private static void Activate()
        {
            WaitCallback callback = new WaitCallback(ActivateAsync);

            while(true)
            {
                lock (m_stlock)
                {
                    foreach (PoolGenerator generator in m_Generators)
                        if (generator.Enabled)
                            ThreadPool.QueueUserWorkItem(callback, generator);
                }

                Thread.Sleep(1);
            }
        }

        private static void ActivateAsync(object generator)
        {
            PoolGenerator gn = (generator as PoolGenerator);
            gn.Execute(null);
        }

        private static void Register(PoolGenerator generator)
        {
            lock (m_stlock)
                m_Generators.Add(generator);
        }

        private static void Unregister(PoolGenerator generator)
        {
            lock (m_stlock)
                m_Generators.Remove(generator);
        }

        public PoolGenerator()
        {
            PoolGenerator.Register(this);
        }

        ~PoolGenerator()
        {
            PoolGenerator.Unregister(this);
        }

        public PoolGenerator(string name)
            : base(name)
        {
            PoolGenerator.Register(this);
        }

        public override bool Execute()
        {
            bool repeate;

            do
            {
                repeate = false;

                foreach (PowerPort port in Outputs)
                {
                    PowerImpuls impuls = new PowerImpuls();

                    port.Push(impuls);

                    if (impuls.Result == ImpulsResult.ExecSuccess)
                        repeate = true;
                }

            }
            while (repeate);

            return true;
        }
    }
}
