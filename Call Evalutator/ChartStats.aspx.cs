using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Call_Evalutator
{
    public partial class ChartStats : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void callStats_Load(object sender, EventArgs e)
        {
            callStats.ChartAreas["ChartArea1"].AxisX.MajorGrid.Enabled = false;
            callStats.ChartAreas["ChartArea1"].AxisY.MajorGrid.Enabled = false;
            callStats.ChartAreas[0].AxisY.LabelStyle.ForeColor = System.Drawing.Color.White;
            callStats.ChartAreas[0].AxisX.LabelStyle.ForeColor = System.Drawing.Color.White;
            callStats.Series["Series1"].BorderWidth = 3;
        }
    }
}