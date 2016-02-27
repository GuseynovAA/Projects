using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Neuronet.Core
{
    class Resource
    {
        public int ID { get; set; }
        public Material Material { get; set; }
        public int Amount { get; set; }
        public int Weight { get { return Material.Density * Amount; } }

        public Resource()
        {
            this.Amount = 1;
        }
    }
}
