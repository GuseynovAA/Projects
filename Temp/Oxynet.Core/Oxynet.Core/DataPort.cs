using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;

namespace Oxynet.Core
{
    public class DataPort : Port
    {
        public object Resource;

        public bool Empty() { return Resource == null; }

        public bool Enabled
        {
            get { return m_enabled; }
            set
            {
                if (m_enabled != value && PortValueChanged != null)
                    PortValueChanged(this.Async);

                m_enabled = value;
            }
        }

        public bool Async = true;

        public delegate void PortValueHandler(bool Async);
        public event PortValueHandler PortValueChanged;

        public DataPort()
        {

        }

        public DataPort(string name)
            : base(name)
        {

        }

        public bool CanWrite()
        {
            return Enabled && Empty();
        }

        public void Write(object resource)
        {
            Resource = resource;

            if (PortValueChanged != null)
                PortValueChanged(this.Async);
        }

        public bool Push(object resource)
        {
            if (CanWrite())
            {
                Write(resource);

                return true;
            }
            else
                return false;
        }

        public bool CanRead()
        {
            return Enabled && !Empty();
        }

        public void Read(out object resource)
        {
            resource = Resource;
            Resource = null;

            if (PortValueChanged != null)
                PortValueChanged(this.Async);
        }

        public bool Pop(out object resource)
        {
            resource = null;

            if (CanRead())
            {
                Read(out resource);

                return true;
            }
            else
                return false;
        }
    }
}
