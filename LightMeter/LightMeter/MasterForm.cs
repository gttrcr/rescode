using ControlChart;
using Driver;
using LightAnalyzer;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Windows.Forms;
using Point = Accord.Point;
using Timer = System.Windows.Forms.Timer;

namespace WebcamLightMeter
{
    public partial class MasterForm : Form
    {
        private Chart _chartRGB;
        private Chart _chartLightness;
        private List<double> _lightnessDataSet;
        private Dictionary<char, List<int>> _histograms;
        private List<IDriver> _driverList;
        private Dictionary<string, IDriver> _devices;
        private int _cropRefreshTime = 0;
        private double _gaussSize = 0;
        private Timer _chartRefresh;
        private Timer _cropTimer;
        private Point _gaussPosition;
        private bool _acquireData;
        private Dictionary<string, List<Tuple<string, double>>> _data;
        private string _directoryForSavingData;
        private Point _snapStart = new Point();
        private double _m_each_px = 0;

        public MasterForm()
        {
            InitializeComponent();
        }

        private void MasterForm_Load(object sender, EventArgs e)
        {
            _devices = new Dictionary<string, IDriver>();
            _driverList = new List<IDriver>();
            _driverList.Add(new GenericWebcamDriver());
            //_driverList.Add(new ASICameraDll2Driver());

            for (int i = 0; i < _driverList.Count; i++)
            {
                IDriver driver = _driverList[i];
                if (driver.GetType() == typeof(GenericWebcamDriver))
                {
                    List<string> genericDevices = driver.SearchDevices();
                    toolStripComboBoxDevices.Items.AddRange(genericDevices.ToArray());

                    for (int d = 0; d < genericDevices.Count; d++)
                        _devices.Add(genericDevices[d], _driverList[i]);
                }
                else if (driver.GetType() == typeof(ASICameraDll2Driver))
                {
                    List<string> listOfAsi = driver.SearchDevices();
                    toolStripComboBoxDevices.Items.AddRange(listOfAsi.ToArray());

                    for (int d = 0; d < listOfAsi.Count; d++)
                        _devices.Add(listOfAsi[d], _driverList[i]);
                }
            }

            ControlsEventAndBehaviour();
        }

        private void MasterForm_FormClosing(object sender, FormClosingEventArgs e)
        {
            if (toolStripComboBoxDevices.SelectedItem != null)
            {
                if (_devices[toolStripComboBoxDevices.SelectedItem.ToString()] == null)
                {
                    Application.Exit();
                    return;
                }

                if (_devices[toolStripComboBoxDevices.SelectedItem.ToString()] != null && _devices[toolStripComboBoxDevices.SelectedItem.ToString()].IsRunning())
                {
                    _devices[toolStripComboBoxDevices.SelectedItem.ToString()].Stop();
                    _chartRefresh?.Stop();
                    _cropTimer?.Stop();
                    Application.Exit();
                    return;
                }
            }

            Application.Exit();
            return;
        }

        private void CloseCamToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (toolStripComboBoxDevices.SelectedItem != null && _devices[toolStripComboBoxDevices.SelectedItem.ToString()].IsRunning())
            {
                _devices[toolStripComboBoxDevices.SelectedItem.ToString()].Stop();
                _chartRefresh?.Stop();
                _cropTimer?.Stop();
                _chartRGB.Clear();
                _chartLightness.Clear();
                pictureBoxStream.Image = null;
                pictureBoxStream.Invalidate();
                pictureBoxCrop.Image = null;
                pictureBoxCrop.Invalidate();
                Refresh();
            }
        }

        private void SaveThePictureToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (pictureBoxStream.Image != null)
            {
                SaveFileDialog saveFileDialog = new SaveFileDialog();
                saveFileDialog.Filter = "Bitmap Image (.bmp)|*.bmp|Gif Image (.gif)|*.gif|JPEG Image (.jpeg)|*.jpeg|Png Image (.png)|*.png|Tiff Image (.tiff)|*.tiff|Wmf Image (.wmf)|*.wmf";
                if (saveFileDialog.ShowDialog() == DialogResult.OK)
                    pictureBoxStream.Image.Save(saveFileDialog.FileName);
                else
                    MessageBox.Show("Error during save the photo", "WebcamLightMeter", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void PictureBoxStream_Click(object sender, EventArgs e)
        {
            if (pictureBoxStream.Image == null)
                return;

            //Calculate the position on bitmap
            float x0 = 0;
            float y0 = 0;
            float bitmapW = pictureBoxStream.Width;
            float bitmapH = pictureBoxStream.Height;
            if (pictureBoxStream.Width / (float)pictureBoxStream.Height < pictureBoxStream.Image.Width / (float)pictureBoxStream.Image.Height)
            {
                bitmapW = pictureBoxStream.Width;
                bitmapH = bitmapW * pictureBoxStream.Image.Height / pictureBoxStream.Image.Width;
                y0 = (float)(pictureBoxStream.Height - bitmapH) / 2;
            }
            else if (pictureBoxStream.Width / (float)pictureBoxStream.Height > pictureBoxStream.Image.Width / (float)pictureBoxStream.Image.Height)
            {
                bitmapH = pictureBoxStream.Height;
                bitmapW = bitmapH * pictureBoxStream.Image.Width / pictureBoxStream.Image.Height;
                x0 = (float)(pictureBoxStream.Width - bitmapW) / 2;
            }

            float x = ((MouseEventArgs)e).Location.X - x0;
            float y = ((MouseEventArgs)e).Location.Y - y0;

            //Real coordinate in image
            x *= pictureBoxStream.Image.Width / bitmapW;
            y *= pictureBoxStream.Image.Height / bitmapH;

            _gaussPosition = new Point((int)x, (int)y);
            ChangeTimerGaussParameters((int)x, (int)y);
        }

        private void DataToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (dataToolStripMenuItem.Text == "Start acquire data")
            {
                FolderBrowserDialog folderBrowserDialog = new FolderBrowserDialog();
                if (folderBrowserDialog.ShowDialog() == DialogResult.OK)
                {
                    _directoryForSavingData = folderBrowserDialog.SelectedPath;
                    dataToolStripMenuItem.Text = "Stop acquire data";

                    _acquireData = true;
                    _data = new Dictionary<string, List<Tuple<string, double>>>();
                }
            }
            else if (dataToolStripMenuItem.Text == "Stop acquire data")
            {
                _acquireData = false;
                dataToolStripMenuItem.Text = "Saving...";

                for (int k = 0; k < _data.Keys.Count; k++)
                {
                    string strData = "";
                    for (int i = 0; i < _data[_data.Keys.ElementAt(k)].Count; i++)
                        strData += _data[_data.Keys.ElementAt(k)][i].Item1 + "#" + _data[_data.Keys.ElementAt(k)][i].Item2 + Environment.NewLine;

                    File.WriteAllText(_directoryForSavingData + "\\" + _data.Keys.ElementAt(k) + ".txt", strData);
                }

                dataToolStripMenuItem.Text = "Start acquire data";
            }
        }

        private void StartCalibrationToolStripMenuItem_Click(object sender, EventArgs e)
        {
            CalibrationForm calibrationForm = new CalibrationForm(pictureBoxStream, toolStripComboBoxCalibrations);
            calibrationForm.Show();
        }

        private void ExitToolStripMenuItem_Click(object sender, EventArgs e)
        {
            MasterForm_FormClosing(null, null);
        }

        private void ChangeTimerGaussParameters(float x, float y)
        {
            _cropTimer?.Stop();
            _cropTimer?.Dispose();
            _cropTimer = new Timer();
            _cropTimer.Interval = _cropRefreshTime;
            _cropTimer.Tick += (s, ea) =>
            {   
                //Refresh crop
                Bitmap cropImage = new Bitmap(pictureBoxStream.Image);
                Rectangle rect = new Rectangle((int)((x - _gaussSize / 2) < 0 ? 0 : (x - _gaussSize / 2)), (int)((y - _gaussSize / 2) < 0 ? 0 : (y - _gaussSize / 2)), (int)_gaussSize, (int)_gaussSize);
                if (rect.X + rect.Width > pictureBoxStream.Image.Width || rect.Y + rect.Height > pictureBoxStream.Image.Height)
                {
                    rect.Width = Math.Min(pictureBoxStream.Image.Width - rect.X, pictureBoxStream.Image.Height - rect.Y);
                    rect.Height = rect.Width;
                    _gaussSize = rect.Height;
                }
                cropImage = cropImage.Clone(rect, cropImage.PixelFormat);
                pictureBoxCrop.Image = cropImage;
            };
            _cropTimer.Start();
        }

        private void DelegateMethodDriver(object obj1, Bitmap obj2)
        {
            pictureBoxStream.Image = obj2;
            _histograms = Analyzer.GetHistogramAndLightness((Bitmap)pictureBoxStream.Image, out double lightness);
            
            _lightnessDataSet.Add(lightness);
            if (_lightnessDataSet.Count > 300)
                _lightnessDataSet.RemoveAt(0);

            if (_acquireData)
            {
                Utils.AddOrUpdateDictionary(ref _data, "Lightness", lightness);
                Utils.AddOrUpdateDictionary(ref _data, "MaxR", _histograms['R'].Max());
                Utils.AddOrUpdateDictionary(ref _data, "MaxG", _histograms['G'].Max());
                Utils.AddOrUpdateDictionary(ref _data, "MaxB", _histograms['B'].Max());
            }
        }

        private void ControlsEventAndBehaviour()
        {
            WindowState = FormWindowState.Maximized;
            StartPosition = FormStartPosition.CenterScreen;

            toolStripComboBoxDevices.SelectedIndexChanged += (sender, e) =>
            {
                CloseCamToolStripMenuItem_Click(null, null);
                _devices[toolStripComboBoxDevices.SelectedItem.ToString()].Start(((ToolStripComboBox)sender).SelectedItem, DelegateMethodDriver);
                fileToolStripMenuItem.HideDropDown();
                _chartRefresh.Start();
            };

            toolStripTextBoxRefresh.KeyDown += (sender, e) =>
            {
                if (e.KeyCode == Keys.Enter)
                {
                    if (int.TryParse(toolStripTextBoxRefresh.Text, out int val))
                    {
                        if (_cropTimer != null)
                            _cropTimer.Interval = val;
                        streamToolStripMenuItem.HideDropDown();
                        _cropRefreshTime = val;
                    }
                    else
                        MessageBox.Show("Cannot parse value from refresh time", "WebcamLightMeter", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
            };

            toolStripTextBoxSize.KeyDown += (sender, e) =>
            {
                if (e.KeyCode == Keys.Enter)
                {
                    if (double.TryParse(toolStripTextBoxSize.Text, out double val))
                    {
                        _gaussSize = val;
                        streamToolStripMenuItem.HideDropDown();
                        ChangeTimerGaussParameters(_gaussPosition.X, _gaussPosition.Y);
                    }
                    else
                        MessageBox.Show("Cannot parse value for size", "WebcamLightMeter", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
            };

            splitContainer2.SplitterDistance = splitContainer2.ClientSize.Width / 2;
            splitContainer3.SplitterDistance = splitContainer3.ClientSize.Width / 2;
            splitContainer5.SplitterDistance = splitContainer5.ClientSize.Height / 3;
            splitContainer6.SplitterDistance = splitContainer6.ClientSize.Height / 2;
            pictureBoxStream.Click += PictureBoxStream_Click;

            toolStripTextBoxRefresh.Text = "500";
            toolStripTextBoxSize.Text = "200";
            _cropRefreshTime = 500;
            _gaussSize = 200;

            toolStripComboBoxCalibrations.SelectedIndexChanged += (sender, e) =>
            {
                string calibrationName = ((ToolStripComboBox)sender).SelectedItem.ToString();
                if (calibrationName == NameAndDefine.defaultCalibrationName)
                    Analyzer.UseCalibration(1, 0, 1, 1);

                if (File.Exists(NameAndDefine.calibrationFile))
                {
                    string[] cals = File.ReadAllLines(NameAndDefine.calibrationFile);
                    List<string[]> calsComplete = cals.Select(x => x.Split('#')).ToList();
                    for (int i = 0; i < calsComplete.Count; i++)
                        if (calsComplete[i][0] == calibrationName)
                        {
                            if (double.TryParse(calsComplete[i][1], out double rSquared) &&
                            double.TryParse(calsComplete[i][2], out double intercept) &&
                            double.TryParse(calsComplete[i][3], out double slope) &&
                            double.TryParse(calsComplete[i][4], out double sensorSize))
                            {
                                Analyzer.UseCalibration(rSquared, intercept, slope, sensorSize);
                                MessageBox.Show("Calibration \"" + calibrationName + "\" applied", "WebcamLightMeter", MessageBoxButtons.OK, MessageBoxIcon.Information);
                            }
                        }
                }

                calibrationToolStripMenuItem.HideDropDown();
            };

            toolStripComboBoxCalibrations.Items.Clear();
            toolStripComboBoxCalibrations.Items.Add(NameAndDefine.defaultCalibrationName);
            if (File.Exists(NameAndDefine.calibrationFile))
            {
                string[] cals = File.ReadAllLines(NameAndDefine.calibrationFile);
                List<string[]> calsComplete = cals.Select(x => x.Split('#')).ToList();
                toolStripComboBoxCalibrations.Items.Clear();
                toolStripComboBoxCalibrations.Items.Add(NameAndDefine.defaultCalibrationName);
                for (int i = 0; i < calsComplete.Count; i++)
                    toolStripComboBoxCalibrations.Items.Add(calsComplete[i][0]);
            }

            toolStripComboBoxCalibrations.SelectedIndex = 0;

            _chartRGB = new Chart(splitContainer5.Panel1.ClientSize.Width, splitContainer5.Panel1.ClientSize.Height)
            {
                Dock = DockStyle.Fill,
                LegendX = "Pixel value",
                LegendY = "Intensity",
                Title = "RGB histogram",
                AxisPen = new Pen(Color.Black, 1),
                DataPen = new List<Pen>() { new Pen(Color.Red, 2), new Pen(Color.Green, 2), new Pen(Color.Blue, 2) }
            };

            _lightnessDataSet = new List<double>();
            _chartLightness = new Chart(splitContainer6.Panel1.ClientSize.Width, splitContainer6.Panel1.ClientSize.Height)
            {
                Dock = DockStyle.Fill,
                LegendX = "measurement",
                LegendY = "Intensity",
                Title = "Lightness intensity",
                AxisPen = new Pen(Color.Black, 1),
                DataPen = new List<Pen>() { new Pen(Color.LightBlue, 2) }
            };

            logToolStripMenuItem.Click += (sender, e) =>
            {
                logToolStripMenuItem.Checked = true;
                linearToolStripMenuItem.Checked = false;
                _chartRGB.IsLogarithmic = true;
            };

            linearToolStripMenuItem.Click += (sender, e) =>
            {
                linearToolStripMenuItem.Checked = true;
                logToolStripMenuItem.Checked = false;
                _chartRGB.IsLogarithmic = false;
            };

            linearToolStripMenuItem.PerformClick();

            _chartRefresh = new Timer();
            _chartRefresh.Interval = 200;
            _chartRefresh.Tick += (sender, e) =>
            {
                if (_histograms != null && rGBHistogramToolStripMenuItem.Tag.ToString() == "1")
                {
                    _chartRGB.Clear();
                    List<List<double>> input = new List<List<double>>();
                    input.Add(_histograms['R'].Select(x => (double)x).ToList());
                    input.Add(_histograms['G'].Select(x => (double)x).ToList());
                    input.Add(_histograms['B'].Select(x => (double)x).ToList());
                    _chartRGB.Values = input;
                    _chartRGB.Draw();
                    splitContainer5.Panel1.Controls.Clear();
                    splitContainer5.Panel1.Controls.Add(_chartRGB);
                }

                if (_lightnessDataSet != null && _lightnessDataSet.Count != 0 && lightnessIntensityToolStripMenuItem.Tag.ToString() == "1")
                {
                    _chartLightness.Clear();
                    List<List<double>> input = new List<List<double>>();
                    input.Add(_lightnessDataSet);
                    _chartLightness.Values = input;
                    _chartLightness.Draw();
                    splitContainer6.Panel1.Controls.Clear();
                    splitContainer6.Panel1.Controls.Add(_chartLightness);
                }
            };
            _chartRefresh.Start();

            //with mouse left key set the scale, with mouse right key measure
            pictureBoxCrop.MouseDown += (sender, e) => _snapStart = new Point(e.Location.X, e.Location.Y);
            pictureBoxCrop.MouseUp += (sender, e) =>
            {
                if (e.Button == MouseButtons.Left)
                {
                    Point _stop = new Point(e.Location.X, e.Location.Y);
                    if (_snapStart != new Point() && _snapStart != _stop)
                    {
                        double pxDistance = _snapStart.DistanceTo(_stop);
                        SetDistance setDistance = new SetDistance();
                        if (setDistance.ShowDialog() == DialogResult.OK)
                        {
                            double mDistance = setDistance.Distance;
                            _m_each_px = mDistance / pxDistance;
                        }
                    }
                }
            };
            pictureBoxCrop.MouseMove += (sender, e) =>
            {
                if (e.Button == MouseButtons.Right)
                {
                    Point _stop = new Point(e.Location.X, e.Location.Y);
                    double pxDistance = _snapStart.DistanceTo(_stop);
                    double mDistance = pxDistance * _m_each_px;
                    textBoxLength.Text = mDistance.ToString();
                }
            };

            rGBHistogramToolStripMenuItem.Click += (sender, e) =>
            {
                if (rGBHistogramToolStripMenuItem.Tag.ToString() == "1")
                {
                    rGBHistogramToolStripMenuItem.Tag = "0";
                    rGBHistogramToolStripMenuItem.Text = "RGB histogram ON";
                    _chartRGB.Clear();
                }
                else if (rGBHistogramToolStripMenuItem.Tag.ToString() == "0")
                {
                    rGBHistogramToolStripMenuItem.Tag = "1";
                    rGBHistogramToolStripMenuItem.Text = "RGB histogram OFF";
                }
            };

            lightnessIntensityToolStripMenuItem.Click += (sender, e) =>
            {
                if (lightnessIntensityToolStripMenuItem.Tag.ToString() == "1")
                {
                    lightnessIntensityToolStripMenuItem.Tag = "0";
                    lightnessIntensityToolStripMenuItem.Text = "Lightness intensity ON";
                    _chartLightness.Clear();
                }
                else if (lightnessIntensityToolStripMenuItem.Tag.ToString() == "0")
                {
                    lightnessIntensityToolStripMenuItem.Tag = "1";
                    lightnessIntensityToolStripMenuItem.Text = "Lightness intensity OFF";
                }
            };
        }
    }
}