﻿namespace WebcamLightMeter
{
    partial class MasterForm
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(MasterForm));
            this.menuStrip = new System.Windows.Forms.MenuStrip();
            this.fileToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.filterInfoToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.toolStripComboBoxDevices = new System.Windows.Forms.ToolStripComboBox();
            this.closeCamToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.saveThePictureToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.exitToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.calibrationToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.newCalibrationToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.loadCalibrationToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.toolStripComboBoxCalibrations = new System.Windows.Forms.ToolStripComboBox();
            this.streamToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.sizeToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.toolStripTextBoxSize = new System.Windows.Forms.ToolStripTextBox();
            this.chartToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.chartRGBToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.logToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.linearToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.dataToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.splitContainer2 = new System.Windows.Forms.SplitContainer();
            this.splitContainer1 = new System.Windows.Forms.SplitContainer();
            this.pictureBoxStream = new System.Windows.Forms.PictureBox();
            this.textBoxLength = new System.Windows.Forms.TextBox();
            this.pictureBoxCrop = new System.Windows.Forms.PictureBox();
            this.splitContainer5 = new System.Windows.Forms.SplitContainer();
            this.splitContainer6 = new System.Windows.Forms.SplitContainer();
            this.splitContainer3 = new System.Windows.Forms.SplitContainer();
            this.menuStrip.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.splitContainer2)).BeginInit();
            this.splitContainer2.Panel1.SuspendLayout();
            this.splitContainer2.Panel2.SuspendLayout();
            this.splitContainer2.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.splitContainer1)).BeginInit();
            this.splitContainer1.Panel1.SuspendLayout();
            this.splitContainer1.Panel2.SuspendLayout();
            this.splitContainer1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBoxStream)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBoxCrop)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.splitContainer5)).BeginInit();
            this.splitContainer5.Panel2.SuspendLayout();
            this.splitContainer5.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.splitContainer6)).BeginInit();
            this.splitContainer6.Panel2.SuspendLayout();
            this.splitContainer6.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.splitContainer3)).BeginInit();
            this.splitContainer3.SuspendLayout();
            this.SuspendLayout();
            // 
            // menuStrip
            // 
            this.menuStrip.ImageScalingSize = new System.Drawing.Size(20, 20);
            this.menuStrip.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.fileToolStripMenuItem,
            this.calibrationToolStripMenuItem,
            this.streamToolStripMenuItem,
            this.chartToolStripMenuItem,
            this.dataToolStripMenuItem});
            this.menuStrip.Location = new System.Drawing.Point(0, 0);
            this.menuStrip.Name = "menuStrip";
            this.menuStrip.Size = new System.Drawing.Size(1023, 28);
            this.menuStrip.TabIndex = 24;
            this.menuStrip.Text = "menuStrip";
            // 
            // fileToolStripMenuItem
            // 
            this.fileToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.filterInfoToolStripMenuItem,
            this.closeCamToolStripMenuItem,
            this.saveThePictureToolStripMenuItem,
            this.exitToolStripMenuItem});
            this.fileToolStripMenuItem.Name = "fileToolStripMenuItem";
            this.fileToolStripMenuItem.Size = new System.Drawing.Size(46, 24);
            this.fileToolStripMenuItem.Text = "File";
            // 
            // filterInfoToolStripMenuItem
            // 
            this.filterInfoToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.toolStripComboBoxDevices});
            this.filterInfoToolStripMenuItem.Name = "filterInfoToolStripMenuItem";
            this.filterInfoToolStripMenuItem.Size = new System.Drawing.Size(198, 26);
            this.filterInfoToolStripMenuItem.Text = "Filter Info";
            // 
            // toolStripComboBoxDevices
            // 
            this.toolStripComboBoxDevices.Name = "toolStripComboBoxDevices";
            this.toolStripComboBoxDevices.Size = new System.Drawing.Size(121, 28);
            // 
            // closeCamToolStripMenuItem
            // 
            this.closeCamToolStripMenuItem.Name = "closeCamToolStripMenuItem";
            this.closeCamToolStripMenuItem.Size = new System.Drawing.Size(198, 26);
            this.closeCamToolStripMenuItem.Text = "Close Cam";
            this.closeCamToolStripMenuItem.Click += new System.EventHandler(this.CloseCamToolStripMenuItem_Click);
            // 
            // saveThePictureToolStripMenuItem
            // 
            this.saveThePictureToolStripMenuItem.Name = "saveThePictureToolStripMenuItem";
            this.saveThePictureToolStripMenuItem.Size = new System.Drawing.Size(198, 26);
            this.saveThePictureToolStripMenuItem.Text = "Save the picture";
            this.saveThePictureToolStripMenuItem.Click += new System.EventHandler(this.SaveThePictureToolStripMenuItem_Click);
            // 
            // exitToolStripMenuItem
            // 
            this.exitToolStripMenuItem.Name = "exitToolStripMenuItem";
            this.exitToolStripMenuItem.Size = new System.Drawing.Size(198, 26);
            this.exitToolStripMenuItem.Text = "Exit";
            this.exitToolStripMenuItem.Click += new System.EventHandler(this.ExitToolStripMenuItem_Click);
            // 
            // calibrationToolStripMenuItem
            // 
            this.calibrationToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.newCalibrationToolStripMenuItem,
            this.loadCalibrationToolStripMenuItem});
            this.calibrationToolStripMenuItem.Name = "calibrationToolStripMenuItem";
            this.calibrationToolStripMenuItem.Size = new System.Drawing.Size(96, 24);
            this.calibrationToolStripMenuItem.Text = "Calibration";
            // 
            // newCalibrationToolStripMenuItem
            // 
            this.newCalibrationToolStripMenuItem.Name = "newCalibrationToolStripMenuItem";
            this.newCalibrationToolStripMenuItem.Size = new System.Drawing.Size(200, 26);
            this.newCalibrationToolStripMenuItem.Text = "New calibration";
            this.newCalibrationToolStripMenuItem.Click += new System.EventHandler(this.StartCalibrationToolStripMenuItem_Click);
            // 
            // loadCalibrationToolStripMenuItem
            // 
            this.loadCalibrationToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.toolStripComboBoxCalibrations});
            this.loadCalibrationToolStripMenuItem.Name = "loadCalibrationToolStripMenuItem";
            this.loadCalibrationToolStripMenuItem.Size = new System.Drawing.Size(200, 26);
            this.loadCalibrationToolStripMenuItem.Text = "Load calibration";
            // 
            // toolStripComboBoxCalibrations
            // 
            this.toolStripComboBoxCalibrations.Name = "toolStripComboBoxCalibrations";
            this.toolStripComboBoxCalibrations.Size = new System.Drawing.Size(121, 28);
            // 
            // streamToolStripMenuItem
            // 
            this.streamToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.sizeToolStripMenuItem});
            this.streamToolStripMenuItem.Name = "streamToolStripMenuItem";
            this.streamToolStripMenuItem.Size = new System.Drawing.Size(70, 24);
            this.streamToolStripMenuItem.Text = "Stream";
            // 
            // sizeToolStripMenuItem
            // 
            this.sizeToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.toolStripTextBoxSize});
            this.sizeToolStripMenuItem.Name = "sizeToolStripMenuItem";
            this.sizeToolStripMenuItem.Size = new System.Drawing.Size(237, 26);
            this.sizeToolStripMenuItem.Text = "Zoom image size (px)";
            // 
            // toolStripTextBoxSize
            // 
            this.toolStripTextBoxSize.Name = "toolStripTextBoxSize";
            this.toolStripTextBoxSize.Size = new System.Drawing.Size(100, 27);
            // 
            // chartToolStripMenuItem
            // 
            this.chartToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.chartRGBToolStripMenuItem});
            this.chartToolStripMenuItem.Name = "chartToolStripMenuItem";
            this.chartToolStripMenuItem.Size = new System.Drawing.Size(58, 24);
            this.chartToolStripMenuItem.Text = "Chart";
            // 
            // chartRGBToolStripMenuItem
            // 
            this.chartRGBToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.logToolStripMenuItem,
            this.linearToolStripMenuItem});
            this.chartRGBToolStripMenuItem.Name = "chartRGBToolStripMenuItem";
            this.chartRGBToolStripMenuItem.Size = new System.Drawing.Size(159, 26);
            this.chartRGBToolStripMenuItem.Text = "Chart RGB";
            // 
            // logToolStripMenuItem
            // 
            this.logToolStripMenuItem.Name = "logToolStripMenuItem";
            this.logToolStripMenuItem.Size = new System.Drawing.Size(132, 26);
            this.logToolStripMenuItem.Text = "Log";
            // 
            // linearToolStripMenuItem
            // 
            this.linearToolStripMenuItem.Name = "linearToolStripMenuItem";
            this.linearToolStripMenuItem.Size = new System.Drawing.Size(132, 26);
            this.linearToolStripMenuItem.Text = "Linear";
            // 
            // dataToolStripMenuItem
            // 
            this.dataToolStripMenuItem.Name = "dataToolStripMenuItem";
            this.dataToolStripMenuItem.Size = new System.Drawing.Size(141, 24);
            this.dataToolStripMenuItem.Text = "Start acquire data";
            this.dataToolStripMenuItem.Click += new System.EventHandler(this.DataToolStripMenuItem_Click);
            // 
            // splitContainer2
            // 
            this.splitContainer2.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D;
            this.splitContainer2.Dock = System.Windows.Forms.DockStyle.Fill;
            this.splitContainer2.Location = new System.Drawing.Point(0, 28);
            this.splitContainer2.Name = "splitContainer2";
            // 
            // splitContainer2.Panel1
            // 
            this.splitContainer2.Panel1.Controls.Add(this.splitContainer1);
            // 
            // splitContainer2.Panel2
            // 
            this.splitContainer2.Panel2.Controls.Add(this.splitContainer5);
            this.splitContainer2.Size = new System.Drawing.Size(1023, 708);
            this.splitContainer2.SplitterDistance = 544;
            this.splitContainer2.TabIndex = 26;
            // 
            // splitContainer1
            // 
            this.splitContainer1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.splitContainer1.Location = new System.Drawing.Point(0, 0);
            this.splitContainer1.Name = "splitContainer1";
            this.splitContainer1.Orientation = System.Windows.Forms.Orientation.Horizontal;
            // 
            // splitContainer1.Panel1
            // 
            this.splitContainer1.Panel1.Controls.Add(this.pictureBoxStream);
            // 
            // splitContainer1.Panel2
            // 
            this.splitContainer1.Panel2.Controls.Add(this.textBoxLength);
            this.splitContainer1.Panel2.Controls.Add(this.pictureBoxCrop);
            this.splitContainer1.Size = new System.Drawing.Size(540, 704);
            this.splitContainer1.SplitterDistance = 240;
            this.splitContainer1.TabIndex = 0;
            // 
            // pictureBoxStream
            // 
            this.pictureBoxStream.BackColor = System.Drawing.SystemColors.ControlDarkDark;
            this.pictureBoxStream.Dock = System.Windows.Forms.DockStyle.Fill;
            this.pictureBoxStream.Location = new System.Drawing.Point(0, 0);
            this.pictureBoxStream.Margin = new System.Windows.Forms.Padding(4);
            this.pictureBoxStream.Name = "pictureBoxStream";
            this.pictureBoxStream.Size = new System.Drawing.Size(540, 240);
            this.pictureBoxStream.SizeMode = System.Windows.Forms.PictureBoxSizeMode.Zoom;
            this.pictureBoxStream.TabIndex = 10;
            this.pictureBoxStream.TabStop = false;
            // 
            // textBoxLength
            // 
            this.textBoxLength.Dock = System.Windows.Forms.DockStyle.Top;
            this.textBoxLength.Location = new System.Drawing.Point(0, 0);
            this.textBoxLength.Name = "textBoxLength";
            this.textBoxLength.ReadOnly = true;
            this.textBoxLength.Size = new System.Drawing.Size(540, 22);
            this.textBoxLength.TabIndex = 18;
            // 
            // pictureBoxCrop
            // 
            this.pictureBoxCrop.BackColor = System.Drawing.SystemColors.ControlDarkDark;
            this.pictureBoxCrop.Dock = System.Windows.Forms.DockStyle.Fill;
            this.pictureBoxCrop.Location = new System.Drawing.Point(0, 0);
            this.pictureBoxCrop.Margin = new System.Windows.Forms.Padding(4);
            this.pictureBoxCrop.Name = "pictureBoxCrop";
            this.pictureBoxCrop.Size = new System.Drawing.Size(540, 460);
            this.pictureBoxCrop.SizeMode = System.Windows.Forms.PictureBoxSizeMode.Zoom;
            this.pictureBoxCrop.TabIndex = 16;
            this.pictureBoxCrop.TabStop = false;
            // 
            // splitContainer5
            // 
            this.splitContainer5.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D;
            this.splitContainer5.Dock = System.Windows.Forms.DockStyle.Fill;
            this.splitContainer5.Location = new System.Drawing.Point(0, 0);
            this.splitContainer5.Name = "splitContainer5";
            this.splitContainer5.Orientation = System.Windows.Forms.Orientation.Horizontal;
            // 
            // splitContainer5.Panel2
            // 
            this.splitContainer5.Panel2.Controls.Add(this.splitContainer6);
            this.splitContainer5.Size = new System.Drawing.Size(475, 708);
            this.splitContainer5.SplitterDistance = 258;
            this.splitContainer5.TabIndex = 0;
            // 
            // splitContainer6
            // 
            this.splitContainer6.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D;
            this.splitContainer6.Dock = System.Windows.Forms.DockStyle.Fill;
            this.splitContainer6.Location = new System.Drawing.Point(0, 0);
            this.splitContainer6.Name = "splitContainer6";
            this.splitContainer6.Orientation = System.Windows.Forms.Orientation.Horizontal;
            // 
            // splitContainer6.Panel2
            // 
            this.splitContainer6.Panel2.Controls.Add(this.splitContainer3);
            this.splitContainer6.Size = new System.Drawing.Size(475, 446);
            this.splitContainer6.SplitterDistance = 216;
            this.splitContainer6.TabIndex = 0;
            // 
            // splitContainer3
            // 
            this.splitContainer3.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D;
            this.splitContainer3.Dock = System.Windows.Forms.DockStyle.Fill;
            this.splitContainer3.Location = new System.Drawing.Point(0, 0);
            this.splitContainer3.Name = "splitContainer3";
            this.splitContainer3.Size = new System.Drawing.Size(475, 226);
            this.splitContainer3.SplitterDistance = 227;
            this.splitContainer3.TabIndex = 0;
            // 
            // MasterForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1023, 736);
            this.Controls.Add(this.splitContainer2);
            this.Controls.Add(this.menuStrip);
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.Margin = new System.Windows.Forms.Padding(4);
            this.Name = "MasterForm";
            this.Text = "WebcamLightMeter";
            this.FormClosing += new System.Windows.Forms.FormClosingEventHandler(this.MasterForm_FormClosing);
            this.Load += new System.EventHandler(this.MasterForm_Load);
            this.menuStrip.ResumeLayout(false);
            this.menuStrip.PerformLayout();
            this.splitContainer2.Panel1.ResumeLayout(false);
            this.splitContainer2.Panel2.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.splitContainer2)).EndInit();
            this.splitContainer2.ResumeLayout(false);
            this.splitContainer1.Panel1.ResumeLayout(false);
            this.splitContainer1.Panel2.ResumeLayout(false);
            this.splitContainer1.Panel2.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.splitContainer1)).EndInit();
            this.splitContainer1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.pictureBoxStream)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBoxCrop)).EndInit();
            this.splitContainer5.Panel2.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.splitContainer5)).EndInit();
            this.splitContainer5.ResumeLayout(false);
            this.splitContainer6.Panel2.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.splitContainer6)).EndInit();
            this.splitContainer6.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.splitContainer3)).EndInit();
            this.splitContainer3.ResumeLayout(false);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion
        private System.Windows.Forms.MenuStrip menuStrip;
        private System.Windows.Forms.ToolStripMenuItem fileToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem exitToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem chartToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem chartRGBToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem logToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem linearToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem streamToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem filterInfoToolStripMenuItem;
        private System.Windows.Forms.ToolStripComboBox toolStripComboBoxDevices;
        private System.Windows.Forms.ToolStripMenuItem closeCamToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem saveThePictureToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem sizeToolStripMenuItem;
        private System.Windows.Forms.ToolStripTextBox toolStripTextBoxSize;
        private System.Windows.Forms.ToolStripMenuItem dataToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem calibrationToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem newCalibrationToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem loadCalibrationToolStripMenuItem;
        private System.Windows.Forms.ToolStripComboBox toolStripComboBoxCalibrations;
        private System.Windows.Forms.SplitContainer splitContainer2;
        private System.Windows.Forms.SplitContainer splitContainer1;
        private System.Windows.Forms.PictureBox pictureBoxStream;
        private System.Windows.Forms.PictureBox pictureBoxCrop;
        private System.Windows.Forms.SplitContainer splitContainer5;
        private System.Windows.Forms.SplitContainer splitContainer6;
        private System.Windows.Forms.SplitContainer splitContainer3;
        private System.Windows.Forms.TextBox textBoxLength;
    }
}