<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>

    <link href="Style/danmaku.css" rel="stylesheet" />

    <script type="text/javascript" src="Scripts/jquery-1.11.0.js"></script>
    <script type="text/javascript" src="Scripts/BrowserDetect.js"></script>
    <script type="text/javascript" src="Scripts/jquery.signalR-2.2.0.min.js"></script>
    <script type="text/javascript" src="Scripts/CommentCoreLibrary.js"></script>
    <script type="text/javascript" src="Scripts/CommentDOM.js"></script>
    <script type="text/JavaScript">

        
        $(document).ready(function () {
            // 生成彈幕的plugin
            $('#RtmpLivePlayer').CommentDOM({
                url: 'http://localhost:59919/signalr',
                width: '660px',
                height: '400px',
                sendCommentFunc: sendComment,
                receiveCommentFunc: receiveComment
            }, checkChanPlayInfomation);
        });

        // 使用者發送訊息method
        function sendComment(signalr_proxy) {
            $('#btnSend').click(function (e) {
                e.preventDefault();

                // 輸入空字串直接return
                if ("" == $('#msg').val()) return;

                var newComment = {
                    //danmaku part
                    "mode": Number($("#comment-animation-type option:selected").val()),
                    "text": $('#msg').val(),
                    "stime": 3000,
                    "size": Number($("#font-size option:selected").val()),
                    "color": parseInt($("#font-color option:selected").val(), 16),
                    "dur": 10000,
                    //custom part
                    "user": $('#comment-user').val()
                };
                var msgToServer = JSON.stringify(newComment);
                signalr_proxy.invoke("sendNewComment", msgToServer);
                $('#msg').val("");
            });
        }

        function receiveComment( newComment ) {

            $('#messages').append($('<li>').text(newComment));

        }

        // 重新包裹Popup執行
        function checkChanPlayInfomation() {
            eval("<%if (chanPlayInfo != null)
                    { %>");
            Popup('<%=chanPlayInfo["CAUID"] %>'
                , '<%=chanPlayInfo["CHID"] %>'
				, '<%=Session.SessionID %>'
				, '<%=chanPlayInfo["MUID"] %>'
				, '<%=chanPlayInfo["headEndProtocol"] %>');
            eval("<%} %>");
        }

        function Popup(CAUID, SYSCID, SK, MUID, TYPE) {
            var hCAUID = CAUID.replace(/-/g, "");
            hCAUID = hCAUID.toUpperCase();
            document.location.href = "starcast://switch/" + SYSCID + "?" + hCAUID + "?" + SK + "?" + MUID;
        }


        setInterval(function () {
            if (BrowserDetect.detectIE) {
                document.getElementById("polling").contentWindow.location.reload();
            } else {
                document.getElementById("polling").src = document.getElementById("polling").src;
            }
        }, 8000);

        function rtmpliveplayer(action, retFileURL) {
            document.getElementById("RtmpLivePlayer").contentWindow.sendToPlayer(action, retFileURL);

        }

        

    </script>
</head>

<body>
    Font Size:
    <select id="font-size">
        <option value="36">中</option>
        <option value="28">小</option>
        <option value="44">大</option>
    </select>
    <br />
    Font Color:
    <select id="font-color">
        <option value="00ff00">綠色</option>
        <option value="ffffff">白色</option>
        <option value="ffff00">黃色</option>
        <option value="00ffff">藍色</option>
    </select>
    <br />
    Comment Animation Type:
    <select id="comment-animation-type">
        <option value="1">頂端滾動</option>
        <option value="2">底端滾動</option>
        <option value="5">頂端漸隱</option>
        <option value="4">底端漸隱</option>
        <option value="6">逆向滾動</option>
    </select>
    <br />
    Name: <br />
    <input type="text" name="name" value=" " id="comment-user" />
    <br />
    Comment: <br />
    <textarea id="msg"></textarea>
    <br />
    <button id="btnSend">Send</button>

    <form id="form1" runat="server">
        <div>
            <asp:Label runat="server" ID="test"></asp:Label>
            <iframe id="polling" src="polling.aspx" style="width: 0; height: 0; border: 0"></iframe>
            <div id="VideoPlayZone">
                <% if (chanPlayInfo["headEndProtocol"].Equals("RTMP"))
                   { %>
                <div id="RTMP_DIV">
                    <%--<div id="my-player" class="abp" style="width: 660px; height: 400px;">--%>
                        <iframe id="RtmpLivePlayer" src="RtmpLivePlayer.aspx" style="width: 660px; height: 400px; border: 2px solid"></iframe>
                        <%--<div id="my-comment-stage" class="container"></div>--%>
                    <%--</div>--%>

                     <ul id="messages"></ul>

                        <!-- hidden field -->
                        <input type="hidden" id="ObjRtmp" value="1" /><br />
                        <input type="hidden" id="status" value="" /><br />
                        <input type="hidden" id="fileurl" value="" /><br />
                        <input type="hidden" id="play" value="" /><br />
                        <input type="hidden" id="replay" value="" /><br />
                        <input type="hidden" id="HeadEndType" value="RTMP" /><br />
                        <input type="hidden" id="errorMsg" value="" /><br />
                        <input type="hidden" id="first_time" value="1" /><br />
                        <input type="hidden" id="PlayerStatus" value="" /><br />
                        <input type="hidden" id="Client_Version" value="" /><br />
                </div>
                <%} %>
            </div>
        </div>
        <script type="text/javascript">
        </script>
    </form>
    <script type="text/javascript">

        <!--reload rtmpliveplayer iframe, if not doing this, jwplayer may not be loaded in IE and Firefox browser-->
    if ($("#ObjRtmp").val() > 0) {
        setTimeout("rtmpliveplayer_reload()", 1000);
    }

    function rtmpliveplayer_reload() {
        if (BrowserDetect.detectIE) {
            document.getElementById("RtmpLivePlayer").contentWindow.location.reload();
        } else {
            document.getElementById("RtmpLivePlayer").src = document.getElementById("RtmpLivePlayer").src;
        }
    }

    </script>

</body>
</html>
