// icdt 2015
// author: kevin

(function ($) {

    $.fn.CommentDOM = function (options, callback) {

        var settings = $.extend({
            url: null,
            width: null,
            height: null,
            sendCommentFunc: null,
            receiveCommentFunc: null
        }, options);


        this.wrap("<div id='my-player' class='abp' style='width:" + settings.width + "; height:" + settings.height + ";'></div>").after("<div id='my-comment-stage' class='container'></div>");

        // 在窗体载入完毕后再绑定
        var CM = new CommentManager($('#my-comment-stage'));
        CM.init();
        // 先启用弹幕播放（之后可以停止）
        CM.start();
        // 开放 CM 对象到全局这样就可以在 console 终端里操控
        window.CM = CM;


        // SIGNALR Part
        var connection = $.hubConnection(settings.url, { useDefaultPath: false });

        // Creating proxy, 開頭字母要小寫
        var proxy = connection.createHubProxy('sendCommentHub');

        // CommentCore Part
        proxy.on('addNewCommentToPage', function (msg) {
            console.log(msg);
            settings.receiveCommentFunc(msg);
            var newMsg = JSON.parse(msg);
            var danmaku = {
                "mode": newMsg.mode,
                "text": newMsg.text,
                "stime": newMsg.stime,
                "size": newMsg.size,
                "color": newMsg.color,
                "dur": newMsg.dur
            };
            CM.send(danmaku);
        });

        // 註冊 signalR 連線
        connection.start()
            .done(function () {
                console.log('Now connected, connection ID=' + connection.id);

                // 執行a 理由；在signalr 建立連線後在啟動，不然會signalr無法建立連線
                if (typeof callback == 'function') { // make sure the callback is a function
                    callback.call(this); // brings the scope to the callback
                }

                if (typeof settings.sendCommentFunc == 'function') { // make sure the callback is a function
                    settings.sendCommentFunc(proxy);
                }
            })
            .fail(function (error) { console.log(error); });

    }

}(jQuery));