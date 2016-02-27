using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Neuronet.Core
{
    class Store
    {
        public Resource Resource { get; set; }

        public bool IsAsync { get; set; }

        public int EmptyAmount { get; set; }
        public int CurrentAmount { get; set; }
        public int FullAmount { get; set; }
        public int AvailableAmount { get { return CurrentAmount - EmptyAmount; } }
        public int FreeAmount { get { return FullAmount - CurrentAmount; } }

        public int EmptyWeight
        {
            get
            {
                return EmptyAmount * Resource.Weight;
            }
        }
        public int CurrentWeight
        {
            get
            {
                return CurrentAmount * Resource.Weight;
            }
            set
            {
                CurrentAmount = value / Resource.Weight;
            }
        }
        public int FullWeight { get { return FullAmount * Resource.Weight; } }
        public int AvailableWeight { get { return AvailableAmount * Resource.Weight; } }
        public int FreeWeight { get { return FreeAmount * Resource.Weight; } }

        public Store()
        {
            this.EmptyAmount = 0;
            this.CurrentAmount = 0;
            this.FullAmount = int.MaxValue;
        }

        public int Add(int amount)
        {
            int excess = amount - FreeAmount;

            CurrentAmount = excess >= 0 ? FullAmount : (CurrentAmount + amount);

            return excess > 0 ? excess : 0;
        }

        public int Remove(int amount)
        {
            int lack = amount - AvailableAmount;

            CurrentAmount = lack >= 0 ? EmptyAmount : (CurrentAmount - amount);

            return lack > 0 ? lack : 0;
        }
    }
}
 