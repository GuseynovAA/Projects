using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;

namespace Oxynet.Core
{
    public abstract class DataUnit : Unit
    {
        protected object m_lock = new object();

        public ActivationPort Activator = new ActivationPort();

        public List<DataPort> Inputs = new List<DataPort>();
        public List<DataPort> Outputs = new List<DataPort>();

        public DataUnit()
        {
            Activator.Target = this;
        }

        public DataUnit(string name)
            : base(name)
        {
        }

        protected virtual void PortReading(DataPort port, object value)
        {
        }

        protected virtual void PortWriting(DataPort port, out object value)
        {
            value = null;
        }
    }
}
