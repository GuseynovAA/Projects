using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using Ion.Core.Units;

namespace Ion.Core.Factories
{
    public class Factory
    {
        protected List<Unit> Units = new List<Unit>();

        public Factory()
        {

        }

        public virtual void Build()
        {
            //  Строительство всех дочерних фабрик
        }

        public virtual void Run()
        {
            
        }

        public virtual void Stop()
        {

        }

        public virtual void Destroy()
        {
            //  Разрушение всех дочерних фабрик
        }
    }
}
