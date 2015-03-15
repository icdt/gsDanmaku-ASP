<%@ Page Language="C#" AutoEventWireup="true" CodeFile="polling.aspx.cs" Inherits="polling" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <script type="text/javascript" src="Scripts/BrowserDetect.js"></script>

    <script type="text/javascript" src="http://127.0.0.1:9786/?getInfo"></script>
    <script type="text/javascript">
        
        try {
            
            var videoSrc, first_time;

            parent.document.getElementById("play").value = retChannelPlay;
            videoSrc = parent.document.getElementById("HeadEndType").value;
            first_time = parent.document.getElementById("first_time");
            parent.document.getElementById("Client_Version").value = CLIENT_VERSION;

            //fix Firefox 'F5' refresh problem
            if (BrowserDetect.browser == "Firefox") {
                if (retFileURL != "") {
                    var index = retFileURL.indexOf(":");
                    var src = retFileURL.substring(0, index);
                    videoSrc = src.toUpperCase();
                }
            }
            
            if (videoSrc == "RTMP") {

                if (retChannelPlay == 0) {
                    parent.rtmpliveplayer("stop", retFileURL);
                    
                }
                else if (retStatus == 1 || retStatus == 2) {
                    parent.rtmpliveplayer("start", retFileURL);
                    
                }
                else if (retStatus == 3) {
                    parent.rtmpliveplayer("restart", retFileURL);
                    
                }
            }

        } catch (err) {

        } finally {

        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
        </div>
    </form>
</body>
</html>