using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;

using Ion.Core.Ports.Power;
using Ion.Core.Ports.Data;
using Ion.Core.Power;

namespace Ion.Core.Units.Data
{
    public abstract class DataUnit : Unit
    {
        public List<DataPort> Inputs = new List<DataPort>();
        public List<DataPort> Outputs = new List<DataPort>();

        public DataUnit()
        {
        }

        public DataUnit(string name)
            : base(name)
        {
        }

        public sealed override void Execute(PowerImpuls impuls)
        {
            if (Monitor.TryEnter(m_lock))
            {
                impuls.Result = Execute() ? ImpulsResult.ExecSuccess : ImpulsResult.ExecFailed;
            }
            else
            {
                impuls.Result = ImpulsResult.EnterFailed;
            }
        }

        public virtual bool Execute()
        {
            return true;
        }

        protected virtual void ResourceReceiving(DataPort port, object value)
        {
        }

        protected virtual void ResourceSending(DataPort port, out object value)
        {
            value = null;
        }
    }
}
