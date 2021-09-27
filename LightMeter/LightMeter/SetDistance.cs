using System;
using System.Windows.Forms;

namespace WebcamLightMeter
{
    public partial class SetDistance : Form
    {
        public double Distance { get; private set; }

        public SetDistance()
        {
            InitializeComponent();

            textBoxDistance.KeyDown += TextBoxDistance_KeyDown;
        }

        private void TextBoxDistance_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
                ButtonSave_Click(null, null);
        }

        private void ButtonSave_Click(object sender, EventArgs e)
        {
            string text = "";
            if (textBoxDistance.Text != "")
                text = textBoxDistance.Text.Replace(".", ",");
            if (double.TryParse(text, out double distance))
                Distance = distance;
            else
                MessageBox.Show("Cannot convert or save this value of distance", "WebcamLightMeter", MessageBoxButtons.OK, MessageBoxIcon.Error);

            DialogResult = DialogResult.OK;
            Close();
        }
    }
}