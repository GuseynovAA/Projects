using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Oxynet.Core
{
    public abstract class Port
    {
        public object m_lock = new object();

        public string Name;

        protected Unit m_source;
        public Unit Source
        {
            get
            {
                return m_source;
            }
            set { m_source = value; }
        }

        protected Unit m_target;
        public Unit Target
        {
            get
            {
                return m_source;
            }
            set { m_target = value; }
        }

        protected bool m_enabled;

        public Port()
        {
            this.m_enabled = true;
        }

        public Port(string name)
        {
            this.m_enabled = true;
            this.Name = name;
        }
    }
}
