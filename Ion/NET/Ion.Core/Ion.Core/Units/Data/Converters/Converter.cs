using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;

using Ion.Core.Units.Data;
using Ion.Core.Power;
using Ion.Core.Ports.Data;

namespace Ion.Core.Units.Data.Converters
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
        public override bool Execute()
        {
            bool successResult = false;

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

            return successResult;
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

                resource = null;

                if (port.HasResource)
                {
                    port.ReceiveResource(out resource);
                    ResourceReceiving(port, resource);

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

                resource = null;

                if (!port.HasResource)
                {
                    ResourceSending(port, out resource);
                    port.SendResource(resource);

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
