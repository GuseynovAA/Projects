namespace DXApplication3
{
    partial class Form1
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            this.dashboardViewer1 = new DevExpress.DashboardWin.DashboardViewer(this.components);
            this.realTimeSource1 = new DevExpress.Data.RealTimeSource();
            this.ionDataSet = new DXApplication3.IonDataSet();
            this.objectsBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.objectsTableAdapter = new DXApplication3.IonDataSetTableAdapters.ObjectsTableAdapter();
            ((System.ComponentModel.ISupportInitialize)(this.dashboardViewer1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.ionDataSet)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.objectsBindingSource)).BeginInit();
            this.SuspendLayout();
            // 
            // dashboardViewer1
            // 
            this.dashboardViewer1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.dashboardViewer1.Location = new System.Drawing.Point(0, 0);
            this.dashboardViewer1.Name = "dashboardViewer1";
            this.dashboardViewer1.PrintingOptions.DocumentContentOptions.FilterState = DevExpress.DashboardWin.DashboardPrintingFilterState.None;
            this.dashboardViewer1.PrintingOptions.FontInfo.GdiCharSet = ((byte)(0));
            this.dashboardViewer1.PrintingOptions.FontInfo.Name = null;
            this.dashboardViewer1.Size = new System.Drawing.Size(902, 674);
            this.dashboardViewer1.TabIndex = 0;
            // 
            // realTimeSource1
            // 
            this.realTimeSource1.DataSource = this.objectsBindingSource;
            this.realTimeSource1.DisplayableProperties = "Id;Name;ParentId;PortId";
            this.realTimeSource1.UseWeakEventHandler = true;
            // 
            // ionDataSet
            // 
            this.ionDataSet.DataSetName = "IonDataSet";
            this.ionDataSet.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema;
            // 
            // objectsBindingSource
            // 
            this.objectsBindingSource.DataMember = "Objects";
            this.objectsBindingSource.DataSource = this.ionDataSet;
            // 
            // objectsTableAdapter
            // 
            this.objectsTableAdapter.ClearBeforeFill = true;
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(902, 674);
            this.Controls.Add(this.dashboardViewer1);
            this.Name = "Form1";
            this.Text = "Form1";
            this.Load += new System.EventHandler(this.Form1_Load);
            ((System.ComponentModel.ISupportInitialize)(this.dashboardViewer1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.ionDataSet)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.objectsBindingSource)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private DevExpress.DashboardWin.DashboardViewer dashboardViewer1;
        private DevExpress.Data.RealTimeSource realTimeSource1;
        private IonDataSet ionDataSet;
        private System.Windows.Forms.BindingSource objectsBindingSource;
        private IonDataSetTableAdapters.ObjectsTableAdapter objectsTableAdapter;
    }
}