using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;
using Ion.Core.Factories;
using Ion.Core.Ports.Data;
using Ion.Core.Units.Power.Generators;
using Ion.Core.Units.Data.Converters;
using Ion.Core.Units.Data.Storages;
using Ion.Core.Builders;

namespace Fusion.Framework
{
    public class SqlExecFactory : Factory
    {
        private SqlConnection m_connection;

        public SqlExecFactory(SqlConnection connection)
        {
            m_connection = connection;
        }

        private PoolGenerator generator;

        private EmptyCommandsSupplier supplier;
        private EmptyCommandsStorage storage;

        public override void Build()
        {
            generator = new PoolGenerator("Main");

            supplier = new EmptyCommandsSupplier("Supplier");
            storage = new EmptyCommandsStorage("Storage");

            Builder.DataConnect(supplier, storage);
            Builder.PowerConnect(generator, supplier);
            Builder.PowerConnect(generator, storage);
        }

        public override void Run()
        {
            supplier.Enable();
            storage.Enable();
            generator.Enable();
        }

        public void SetImpuls()
        {
            supplier.impulsPort.SendResource(new object());
        }

        private class EmptyCommandsSupplier : Converter
        {
            public DataPort impulsPort;

            public EmptyCommandsSupplier(String name) : base(name)
            {
                impulsPort = new DataPort("Impuls");
                this.Inputs.Add(impulsPort);
            }

            protected override void CanbanReceiving(DataPort port, object value)
            {
                
            }

            protected override void ResourceSending(DataPort port, out object value)
            {
                value = new SqlCommand();
            }
        }

        private class EmptyCommandsStorage : Storage
        {
            private List<SqlCommand> commands = new List<SqlCommand>();

            public EmptyCommandsStorage(String name) : base(name) { }

            public override bool Empty()
            {
                return commands.Count == 0;
            }

            public override bool Full()
            {
                return commands.Count == 10;
            }

            protected override void ResourceReceiving(DataPort port, object value)
            {
                commands.Add(value as SqlCommand);
            }
        }
    }
}
