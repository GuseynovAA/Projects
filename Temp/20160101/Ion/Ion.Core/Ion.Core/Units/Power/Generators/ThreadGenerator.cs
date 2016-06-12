using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;

using Ion.Core.Power;
using Ion.Core.Ports.Power;

namespace Ion.Core.Units.Power.Generators
{
    public class ThreadGenerator : PowerUnit
    {
        private Thread m_Thread;
        
        public ThreadGenerator(string name):
            base(name)
        {
        }

        public void Enable()
        {
            m_Thread = new Thread(new ThreadStart(Activate));
            m_Thread.Start();
        }

        public void Disable()
        {
            m_Thread.Abort();
        }
        
        private void Activate()
        {
            while (true)
            {
                while(this.Execute());

                Thread.Sleep(1);
            }
        }

        public override bool Execute()
        {
            bool repeate = false;
            
            foreach (PowerPort port in Outputs)
            {
                PowerImpuls impuls = new PowerImpuls();

                port.Push(impuls);

                if (impuls.Result == ImpulsResult.ExecSuccess)
                    repeate = true;
            }

            return repeate;
        }
    }
}
