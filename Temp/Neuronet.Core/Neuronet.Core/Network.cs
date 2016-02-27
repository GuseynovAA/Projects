using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Neuronet.Core
{
    class Network
    {
        public Int64 TimeValue { get; set; }

        public List<Store> Stores = new List<Store>();
        public List<Transition> Transitions = new List<Transition>();

        public object Journal { get {return new object(); } }

        public void Run()
        {
            foreach (Transition tran in Transitions)
                tran.Run();
        }


    }
}
