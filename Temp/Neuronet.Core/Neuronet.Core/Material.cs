using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Neuronet.Core
{
    class Material
    {
        public int ID { get; set; }
        public string Name { get; set; }
        public int Density { get; set; }

        public Material()
        {
            this.Density = 1;
        }
    }
}
