using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    protected System.Data.DataRow chanPlayInfo;

    protected void Page_Load(object sender, EventArgs e)
    {
        //頻道播放資訊
        System.Data.DataSet chanPlayInfoDs = WebPlayerDemo.App_Code.DaObj.admGetChannelList_V1("xml", "6", Request["muid"], 0, 1);
        if (chanPlayInfoDs != null && chanPlayInfoDs.Tables["user"] != null && chanPlayInfoDs.Tables["user"].Rows.Count > 0)
        { chanPlayInfo = chanPlayInfoDs.Tables["user"].Rows[0]; }

        //test.Text = Convert.ToString(chanPlayInfo["MUID"]) + ":::" + Convert.ToString(chanPlayInfo["CAUID"]) + ":::" + Convert.ToString(chanPlayInfo["CHID"]) + ":::" + Convert.ToString(chanPlayInfo["headendProtocol"]);
        
    }
}