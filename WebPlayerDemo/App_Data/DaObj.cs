using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;

namespace WebPlayerDemo.App_Code
{
    public class DaObj
    {
        public static System.Data.DataSet admGetChannelList_V1(String format, String type, String pattern, int pageIndex, int pageSize)
        {
            System.Data.DataSet ds = new DataSet();
            ds.ReadXml(LibConfig.admGetChannelList_V1 +
                 String.Format("?OutputFormat={0}&SearchType={1}&SearchPattern={2}&PageIndex={3}&NumPerPage={4}"
                 , format, type, pattern, pageIndex, pageSize));
            return ds;
        }

    }
}