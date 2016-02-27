using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;

using Ion.Core.Units.Data;
using Ion.Core.Power;
using Ion.Core.Ports.Data;

namespace Ion.Core.Units.Data.Storages
{
    public class Storage : DataUnit
    {
        public Storage()
        {
        }

        public Storage(string name)
            : base(name)
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

        

        public override bool Execute()
        {
            bool successResult = false;

            successResult = Load() || Unload();

            return successResult;
        }

        private bool result;
        private bool Load()
        {
            object resource;
            result = false;

            foreach (DataPort port in Inputs)
            {
                if (Full() || !port.Enabled)
                    return false;

                resource = null;

                if (port.HasResource)
                {
                    port.ReceiveResource(out resource);
                    ResourceReceiving(port, resource);

                    result = true;
                }
            }

            return result;
        }

        private bool Unload()
        {
            object resource;

            result = false;

            foreach (DataPort port in Outputs)
            {
                if (Empty() || !port.Enabled)
                    return false;

                resource = null;

                if (!port.HasResource)
                {
                    ResourceSending(port, out resource);
                    port.SendResource(ref resource);

                    result = true;
                }
            }

            return result;
        }
    }
}
