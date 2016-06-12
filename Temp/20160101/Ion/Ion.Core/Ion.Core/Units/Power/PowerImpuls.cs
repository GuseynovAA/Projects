using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Ion.Core.Power
{
    public enum ImpulsResult { Unknown, ExecSuccess, ExecFailed, EnterFailed }

    public class PowerImpuls
    {
        public ImpulsResult Result;
    }
}
