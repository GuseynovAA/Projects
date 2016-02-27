using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using Ion.Core.Ports;
using Ion.Core.Power;

namespace Ion.Core.Ports.Power
{
    public class PowerPort : Port
    {
        public PowerPort()
        {
        }

        public PowerPort(string name) : base(name)
        {
        }

        public void Push(PowerImpuls impuls)
        {
            if (m_target != null && m_target.Enabled)
                m_target.Execute(impuls);
        }
    }
}
