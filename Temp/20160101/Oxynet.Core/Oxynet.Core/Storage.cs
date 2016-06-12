using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;

namespace Oxynet.Core
{
    public class Storage : DataUnit
    {
        public Storage()
        {
        }

        public virtual bool Empty()
        {
            return false;
        }

        public virtual bool Full()
        {
            return false;
        }

        public override void Execute(ActivationImpuls impuls)
        {
            if (Monitor.TryEnter(m_lock))
            {
                bool successResult = false;

                while (Load() || Unload())
                    successResult = true;

                impuls.Result = successResult ? ImpulsResult.ExecSuccess : ImpulsResult.ExecFailed;

                Monitor.Exit(m_lock);
            }
            else
            {
                impuls.Result = ImpulsResult.EnterFailed;
            }
        }

        private object resource;
        private bool result;

        private bool Load()
        {
            resource = null;
            result = false;

            foreach (DataPort port in Inputs)
            {
                if (Full())
                    return false;

                if (port.CanRead())
                {
                    port.Read(out resource);
                    PortReading(port, resource);

                    result = true;
                }
            }

            return result;
        }

        private bool Unload()
        {
            resource = null;
            result = false;

            foreach (DataPort port in Outputs)
            {
                if (Empty())
                    return false;

                if (port.CanWrite())
                {
                    PortWriting(port, out resource);
                    port.Write(resource);

                    result = true;
                }
            }

            return result;
        }
    }
}
