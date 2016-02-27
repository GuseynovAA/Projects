using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using Ion.Core.Units.Data;
using Ion.Core.Power;
using Ion.Core.Ports.Data;
using Ion.Core.Ports.Power;

namespace Ion.Core.Builders
{
    public class Builder
    {
        public static void DataConnect(DataUnit source, DataUnit target)
        {
            Builder.DataConnect(source, target, String.Empty);
        }

        public static void DataConnect(DataUnit source, DataUnit target, String name)
        {
            if (source == null || target == null)
                return;
            
            DataPort port = new DataPort(String.IsNullOrEmpty(name) ? source.Name + "->" + target.Name : name);

            port.Source = source;
            port.Target = target;

            source.Outputs.Add(port);
            target.Inputs.Add(port);
        }


        public static void PowerConnect(PowerUnit source, PowerUnit target)
        {
            Builder.PowerConnect(source, target, String.Empty);
        }

        public static void PowerConnect(PowerUnit source, PowerUnit target, string name)
        {
            if (source == null || target == null)
                return;

            PowerPort port = new PowerPort(String.IsNullOrEmpty(name) ? source.Name + "->" + target.Name : name);

            port.Source = source;
            port.Target = target;

            source.Outputs.Add(port);
            target.Inputs.Add(port);
        }


        public static void PowerConnect(PowerUnit source, DataUnit target)
        {
            Builder.PowerConnect(source, target, String.Empty);
        }

        public static void PowerConnect(PowerUnit source, DataUnit target, string name)
        {
            if (source == null || target == null)
                return;

            PowerPort port = new PowerPort();

            port.Name = String.IsNullOrEmpty(name) ? source.Name + "->" + target.Name : name;

            port.Source = source;
            port.Target = target;

            source.Outputs.Add(port);
        }
    }
}
