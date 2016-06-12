using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Oxynet.Core
{
    class Builder
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


        public static void ActivationConnect(ActivationUnit source, ActivationUnit target)
        {
            Builder.ActivationConnect(source, target, String.Empty);
        }

        public static void ActivationConnect(ActivationUnit source, ActivationUnit target, string name)
        {
            if (source == null || target == null)
                return;

            ActivationPort port = new ActivationPort(String.IsNullOrEmpty(name) ? source.Name + "->" + target.Name : name);

            port.Source = source;
            port.Target = target;

            source.Outputs.Add(port);
            target.Inputs.Add(port);
        }


        public static void ActivationConnect(ActivationUnit source, DataUnit target)
        {
            Builder.ActivationConnect(source, target, String.Empty);
        }

        public static void ActivationConnect(ActivationUnit source, DataUnit target, string name)
        {
            if (source == null || target == null)
                return;

            ActivationPort port = target.Activator;

            port.Name = String.IsNullOrEmpty(name) ? source.Name + "->" + target.Name : name;

            port.Source = source;

            source.Outputs.Add(port);
        }
    }
}
