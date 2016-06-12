using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Oxynet.Core
{
    class ActivationUnit : Unit
    {
        public List<ActivationPort> Inputs = new List<ActivationPort>();
        public List<ActivationPort> Outputs = new List<ActivationPort>();

        public ActivationUnit()
        {
        }

        public ActivationUnit(string name)
            : base(name)
        {

        }
    }
}
