using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Oxynet.Core
{
    public class ActivationPort : Port
    {
        public ActivationPort()
        {
        }

        public ActivationPort(string name) :base(name)
        {
        }

        public void Push(ActivationImpuls impuls)
        {
            if (m_target != null && m_target.Enabled)
                m_target.Execute(impuls);
        }
    }
}
