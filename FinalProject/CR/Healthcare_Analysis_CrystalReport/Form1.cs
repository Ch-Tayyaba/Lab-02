using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Healthcare_Analysis_CrystalReport
{
    public partial class MainForm : Form
    {
        public MainForm()
        {
            InitializeComponent();
        }
        public void loadNewForm(object usercontrol)
        {
            try
            {
                UserControl newOne = usercontrol as UserControl;
                newOne.Dock = DockStyle.Fill;
                this.uc_ChangePanel.Controls.Add(newOne);
                this.uc_ChangePanel.Tag = newOne;
                newOne.Show();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.ToString(), "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }
        private void MainForm_Load(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            this.uc_ChangePanel.Controls.Clear();
            loadNewForm(new uc_MainAdmin());
        }

        private void button2_Click(object sender, EventArgs e)
        {
            this.uc_ChangePanel.Controls.Clear();
            loadNewForm(new uc_HospitalAdmin());
        }

        private void button3_Click(object sender, EventArgs e)
        {
            this.uc_ChangePanel.Controls.Clear();
            loadNewForm(new uc_Doctor());
        }

        private void button4_Click(object sender, EventArgs e)
        {
            this.uc_ChangePanel.Controls.Clear();
            loadNewForm(new uc_Patient());
        }

        private void button5_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
