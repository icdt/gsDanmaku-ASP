<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RtmpLivePlayer.aspx.cs" Inherits="RtmpLivePlayer" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script type="text/javascript" src="Scripts/jwplayer.js"></script>
    <script type="text/javascript">
        jwplayer.key = "Dee408Wsla2TLfCbSLJ4G10K8KBqempr+AIr4BltE5U=";
    </script>
    <title></title>
    <script type="text/JavaScript">

        //JW Player plugin
        var flag = 0;
        var jwp;
        function sendToPlayer(action, retFileURL) {
            if (retFileURL.substr(0, 4) == "rtmp") {
                if (flag == 0 && action == "start") {
                    jwpSetup(retFileURL);
                }
                if (action == "restart") {
                    if (typeof (jwp) == 'undefined') {
                        jwpSetup(retFileURL);

                    }
                    else {

                        jwp.load([{
                            file: retFileURL
                        }]);
                        jwp.setControls(true);
                        jwp.setVolume(75);
                        jwp.play(true);

                    }
                }
                if (action == "stop") {
                    if (typeof (jwp) == "object") {

                        jwp.setControls(false);
                        jwp.stop();
                    }
                }
            }
        }

        function jwpSetup(retFileURL) {
            document.getElementById("JWP").innerHTML = "";
            flag = 1;
            jwp = jwplayer("JWP").setup({
                file: retFileURL,
                width: 640,
                height: 380,
                stretching: "exactfit",
                autostart: false,
                repeat: false
            });
            jwp.setVolume(75);
            jwp.play(true);
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div id="JWP" style="text-align: center">
            <!--embed web video player-->
            <object type="application/x-shockwave-flash"
                data="WaitAnimation.swf" width="640" height="380">
                <param name="movie" value="WaitAnimation.swf" />
                <param name="quality" value="high" />
                <param name="bgcolor" value="#ffffff" />
                <param name="scale" value="exactfit" />
                <param name="align" value="middle" />
                <param name="play" value="true" />
                <param name="loop" value="true" />
                <param name="wmode" value="transparent" />
                <!--[if !IE]>-->
                <embed src="WaitAnimation.swf" width="640" height="380" type="application/x-shockwave-flash" />
                <!--<![endif]-->
            </object>
        </div>
    </form>
</body>
</html>