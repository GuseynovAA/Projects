using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Ion.Core.Power;

namespace Ion.Core.Units
{
    public abstract class Unit
    {
        public string Name;
        protected bool m_enabled;

        protected object m_lock = new object();

        public bool Enabled
        {
            get { return m_enabled; }
            set { m_enabled = value; }
        }

        public Unit()
        {
        }

        public Unit(string name)
        {
            this.Name = name;
        }

        public void Enable()
        {
            m_enabled = true;
        }

        public void Disable()
        {
            m_enabled = false;
        }

        public virtual void Execute(PowerImpuls impuls)
        {
        }
    }
}
