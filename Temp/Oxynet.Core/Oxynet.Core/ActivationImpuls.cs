using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Oxynet.Core
{
    public enum ImpulsResult { Unknown, ExecSuccess, ExecFailed, EnterFailed }

    public class ActivationImpuls
    {
        public ImpulsResult Result;
    }
}
