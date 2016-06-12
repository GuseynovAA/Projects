using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;

namespace Oxynet.Core
{
    public class Converter : DataUnit
    {
        private List<DataPort> failedPorts = new List<DataPort>();

        public Converter()
        {
        }

        public Converter(string name)
            : base(name)
        {
        }


        private bool load, work, unload;
        public override void Execute(ActivationImpuls impuls)
        {
            if (Monitor.TryEnter(m_lock))
            {
                bool successResult;
                do
                {
                    successResult = false;

                    if (!load && !work && !unload)
                    {
                        load = Load();
                    }

                    if (load && !work && !unload)
                    {
                        work = Work();
                    }

                    if (load && work && !unload)
                    {
                        unload = Unload();
                    }

                    if (load && work && unload)
                    {
                        successResult = true;
                        unload = work = load = false;
                    }
                }
                while (successResult);

                impuls.Result = successResult ? ImpulsResult.ExecSuccess : ImpulsResult.ExecFailed;

                Monitor.Exit(m_lock);
            }
            else
            {
                impuls.Result = ImpulsResult.EnterFailed;
            }

        }

        
        private bool Load()
        {
            object resource;

            bool failed = failedPorts.Count > 0;
            List<DataPort> ports = failed ? failedPorts : Inputs;

            foreach (DataPort port in ports.ToArray())
            {
                if (!failed && !port.Enabled)
                    continue;

                if (!port.Empty())
                {
                    port.Read(out resource);
                    PortReading(port, resource);

                    if (failed)
                        failedPorts.Remove(port);
                }
                else
                {
                    if (!failed)
                        failedPorts.Add(port);
                }
            }

            return failedPorts.Count == 0;
        }

        public virtual bool Work()
        {
            return true;
        }

        private bool Unload()
        {
            object resource;

            bool failed = failedPorts.Count > 0;
            List<DataPort> ports = failed ? failedPorts : Outputs;

            foreach (DataPort port in ports.ToArray())
            {
                if (!failed && !port.Enabled)
                    continue;

                if (port.Empty())
                {
                    PortWriting(port, out resource);
                    port.Write(resource);

                    if (failed)
                        failedPorts.Remove(port);
                }
                else
                {
                    if (!failed)
                        failedPorts.Add(port);
                }
            }

            return failedPorts.Count == 0;
        }
    }
}
