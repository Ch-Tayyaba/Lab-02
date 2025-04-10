using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Windows.Forms;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Healthcare_Analysis_CrystalReport
{
    public partial class uc_HospitalAdmin : UserControl
    {
        public uc_HospitalAdmin()
        {
            InitializeComponent();
        }

        private void GenerateCrystalReport(string reportFileName)
        {
            try
            {
                // Create a new form
                Form reportForm = new Form();
                reportForm.Text = "Crystal Report Viewer";
                reportForm.WindowState = FormWindowState.Maximized; // Open the form in full screen

                // Create CrystalReportViewer
                CrystalReportViewer crystalReportViewer = new CrystalReportViewer();
                crystalReportViewer.Dock = DockStyle.Fill;
                crystalReportViewer.ShowGroupTreeButton = false; // Hide group tree sidebar
                crystalReportViewer.ShowParameterPanelButton = false; // Hide parameter panel sidebar

                // Add CrystalReportViewer to the form
                reportForm.Controls.Add(crystalReportViewer);

                ReportDocument reportDocument = new ReportDocument();
                string path = Application.StartupPath;
                string reportPath = Path.Combine(path, reportFileName);

                if (!File.Exists(reportPath))
                {
                    MessageBox.Show("Report file not found. Please make sure the report file exists in the specified location.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    return;
                }

                // Load the report
                reportDocument.Load(reportPath);
                crystalReportViewer.ReportSource = reportDocument;

                // Show the form
                reportForm.ShowDialog();
            }
            catch (Exception ex)
            {
                MessageBox.Show("An error occurred while loading the report: " + ex.Message, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }
        private void button1_Click(object sender, EventArgs e)
        {
            GenerateCrystalReport("crFamousDepartment.rpt");
        }

        private void button4_Click(object sender, EventArgs e)
        {
            GenerateCrystalReport("crFamousDoctor.rpt");
        }

        private void button6_Click(object sender, EventArgs e)
        {
            GenerateCrystalReport("crCaseType.rpt");
        }

        private void button2_Click(object sender, EventArgs e)
        {
            GenerateCrystalReport("crDocorCount.rpt");
        }

        private void button3_Click(object sender, EventArgs e)
        {
            GenerateCrystalReport("crTreatmentOfDepartment.rpt");
        }

        private void button5_Click(object sender, EventArgs e)
        {
            GenerateCrystalReport("crEarningReport.rpt");
        }
    }
}
