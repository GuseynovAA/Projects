using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using Ion.Core.Units;

namespace Ion.Core.Ports
{
    public abstract class Port
    {
        private object m_lock = new object();

        public string Name;
        
        protected object Resource;

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
                return m_target;
            }
            set { m_target = value; }
        }

        protected bool m_enabled;


        public Port()
        {
            m_enabled = true;
        }

        public Port(string name)
        {
            m_enabled = true;
            Name = name;
        }

        public bool HasResource
        {
            get { return Resource != null; }
        }

        public bool IsInput(Unit unit)
        {
            return m_source == unit;
        }

        public bool IsOutput(Unit unit)
        {
            return m_target == unit;
        }
    }
}
