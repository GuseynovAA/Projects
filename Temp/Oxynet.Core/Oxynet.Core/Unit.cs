using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Oxynet.Core
{
    public abstract class Unit
    {
        public string Name;
        protected bool m_enabled;

        public bool Enabled { get { return m_enabled; } }

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

        public virtual void Execute(ActivationImpuls impuls)
        {
        }
    }
}
