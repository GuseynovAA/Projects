using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Neuronet.Core
{
    class Transition
    {
        private List<Store> sourceNodes = new List<Store>();
        private List<Store> targetNodes = new List<Store>();

        public bool IsBalanced {
            get {
                return true;
            }
        }

        public void AddSource(Store node)
        {
            sourceNodes.Add(node);
        }

        public void AddTarget(Store node)
        {
            targetNodes.Add(node);
        }

        public int Run()
        {
            int availableWeight = sourceNodes.Sum(o => o.AvailableWeight);
            int freeWeight = targetNodes.Sum(o => o.FreeWeight);

            int totalWeight = availableWeight - freeWeight > 0 ? freeWeight : availableWeight;

            int weight = 0, available = 0, free = 0;
            foreach (Store node in sourceNodes)
            {
                available = (weight + node.AvailableWeight) <= totalWeight ? node.AvailableWeight : (totalWeight - weight);

                weight += available;
                node.CurrentWeight -= available;

                if (weight == totalWeight)
                    break;
            }

            foreach (Store node in targetNodes)
            {
                free = (weight - node.FreeWeight) >= 0 ? node.FreeWeight : weight;

                weight -= free;
                node.CurrentAmount += free;

                if (weight == 0)
                    break;
            }

            if (availableWeight > freeWeight)
                return -1;
            else if (availableWeight == freeWeight)
                return 0;
            else /*if (availableWeight < freeWeight)*/
                return 1;
        }
    }
}
