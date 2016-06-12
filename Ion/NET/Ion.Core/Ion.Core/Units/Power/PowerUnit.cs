using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;

using Ion.Core.Units;
using Ion.Core.Ports.Power;

namespace Ion.Core.Power
{
    public class PowerUnit : Unit
    {
        public List<PowerPort> Inputs = new List<PowerPort>();
        public List<PowerPort> Outputs = new List<PowerPort>();

        public PowerUnit()
        {
        }

        public PowerUnit(string name)
            : base(name)
        {
        }

        public override void Execute(PowerImpuls impuls)
        {
            if (Monitor.TryEnter(m_lock))
            {
                Execute();

                Monitor.Exit(m_lock);
            }
        }

        public virtual bool Execute()
        {
            return true;
        }
    }
}
