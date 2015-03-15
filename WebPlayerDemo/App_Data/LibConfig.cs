using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Configuration;

namespace WebPlayerDemo.App_Code
{
    public class LibConfig
    {
        public static String ApiIpAddress = ConfigurationManager.AppSettings["DataHandlerApiUrl"];

        public static String admGetChannelList_V1 { get { return LibConfig.ApiIpAddress + "/admGetChannelList_V1.aspx"; } }

    }
}