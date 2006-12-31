using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using System.Reflection;

using Sofia.ViewHost.WindowsForm.Properties;

using Sofia.Core.Plugins;

#if GTK
using Sofia.Core.Plugins.Gtk;
#else
using Sofia.Core.Plugins.WindowsForm;
#endif

namespace Sofia.ViewHost.WindowsForm
{
    public partial class MainForm : ViewHostBase
    {

        public MainForm() : base(Settings.Default.PluginsPath)
        {
            InitializeComponent();          
            PluginManager.AutoRegister();
            Insert(PluginManager["Sofia.Plugins.General.Contact.Plugin"], "");
        }

        public override void Insert(IPlugin plugin, string destination)
        {
            base.Insert(plugin, destination);
            TabPage tabPage = new TabPage("Contact");
            tabPage.Controls.Add(plugin.View.Control as Control);
            _Pages.Controls.Add(tabPage);
        }
    }
}