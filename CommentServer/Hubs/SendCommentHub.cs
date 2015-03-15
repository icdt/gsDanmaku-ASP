using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Microsoft.AspNet.SignalR;

namespace CommentServer.Hubs
{
    public class SendCommentHub : Hub
    {
        public void SendNewComment(string message)
        {
            Clients.All.addNewCommentToPage(message);
        }
    }
}