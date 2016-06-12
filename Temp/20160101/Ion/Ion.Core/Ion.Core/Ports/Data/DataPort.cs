using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;

using Ion.Core.Ports;

namespace Ion.Core.Ports.Data
{
    public class DataPort : Port
    {
        public bool Empty
        {
            get { return Resource == null; }
        }

        public bool Enabled
        {
            get { return m_enabled; }
            set
            {
                m_enabled = value;
            }
        }

        public DataPort()
        {

        }

        public DataPort(string name)
            : base(name)
        {

        }

        public void SendResource(ref object resource)
        {
            Resource = resource;
            resource = null;
        }

        public void ReceiveResource(out object resource)
        {
            resource = Resource;
            Resource = null;
        }
    }
}
