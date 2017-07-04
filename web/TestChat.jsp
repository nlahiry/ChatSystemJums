<%-- 
    Document   : TestChat
    Created on : 8 Jun, 2017, 11:35:11 AM
    Author     : User
--%>
<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>


<!DOCTYPE html>

<html>
    <head>

        <script type="text/javascript" src="<%=request.getContextPath()%>/Resources/jquery.min.js"></script>
        <title>Metro Chat</title>
    </head>
    <html:html>
        <body>
            <div class="chat-button" style="font-size:14px;cursor:pointer; float: right">
                <span  onclick="openNav()">&#9776; Chat</span>
            </div>
            <div>
                <input id="chat-username" type="hidden" value=''>
                <input id="chat-id" type="hidden" value=''>
                <input type="button" value ="test" onclick="getNewChat()">
            </div>
            <div class="chat-system">
                <div id="mySidenav" class="sidenav">
                    <div class="navbar-header" style="background-color: #eafff3; padding: 5px">
                        <label for="navbar-header-text">Employee List</label>
                        <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
                    </div>
                    <br/>
                    <div class="chat-name-list">
                        <!--                        <div class='online-status' id="userid-list" style="background-color: #3aff8f "></div><a href="#" onclick="pop('neal', 'Neal')">Neal</a>
                                                <div class='online-status' id="userid-list" style="background-color: #3aff8f "></div><a href="#" onclick="pop('Om', 'Om Prakash')">Om Prakash</a>
                                                <div class='online-status' id="userid-list" style="background-color: grey "></div><a href="#" onclick="pop('Sumail', 'Sumail')">Sumail</a>
                                                <div class='online-status' id="userid-list" style="background-color: #3aff8f "></div><a href="#" onclick="pop('Sundar', 'Sundar')">Sundar</a>-->
                    </div>
                </div>




                <div class="chatboxes" >
                    <!--                    <div class="chat-popup-box" id="userid">
                    
                                            <div class="chat-header" >
                                                ChatBox 
                                                <input class="buttonclose" id="userid" type="button" value="&#10060" style="float: right" onclick="close('userid')">
                                                <input class="buttonmin" id="userid" type="button"  value="➖" style="float: right" onclick="maxmin('userid')" >
                    
                                            </div>
                                            <div class="minimize-container" id="user">
                                                <div class="list-container">
                                                    <ul id="chat-message-list" style="list-style: none;"></ul>
                    
                                                </div>
                                                <div class="chat-input">
                                                    <input type="text" id="chat-input-box" placeholder="Enter Your chat message" />
                                                </div>
                    
                                            </div>
                                        </div>-->
                    <div class="typing-indicator"><span></span><span></span><span></span></div>
                </div>
            </div>

        </body>
    </html:html>
    <script>
        getNameList();
        getName();
        getStatusList();
        setInterval(getStatusList, 5000);
        setInterval(getNewChat, 10000);
        var window_list = new Array();
        var name_list_map = new Object();


        var audioElement = document.createElement('audio');
        audioElement.setAttribute('src', '<%=request.getContextPath()%>/Resources/chat.mp3');

        function pop(id, name)
        {
//            alert(('#' + id));

            if (jQuery.inArray(id, window_list) < 0)
            {
                loadchat(id);

                $('.chatboxes').prepend('<div class="chat-popup-box ' + id + '" id="' + id + '"><div class="chat-header" id="' + id + '" >' + name + '<input class="buttonclose" id="' + id + '" type="button" value="&#10060" style="float: right"><input class="buttonmin" id="' + id + '" type="button"  value="➖" style="float: right"></div><div class="minimize-container" id="user"><div class="list-container"><ul class="chat-message-list ' + id + '" id="chat-message-list ' + id + '" style="list-style: none;"></ul></div><div class="chat-input"><input autofocus type="text" class="chat-input-box ' + id + '" id="' + id + '" placeholder="Enter Your chat message" /></div></div></div>');
                window_list.push(id);
                scrolltobottom();
            } else
            {
                $("div#" + id).focus();
            }

        }
        $(document.body).on('click', '.name-button', function () {
            pop(this.id, $(this).text());
        });
        function closeold() {
            $(".chatboxes div:last-child").fadeOut();
        }

        $(document.body).on('click', '.buttonclose', function () {

            var id = $(this).parent().parent().attr('id');
            $(this).parent().parent().remove();
            window_list.splice($.inArray(id, window_list), 1);
            return false;
        });
        $(document.body).on('click', '.buttonmin', function () {

            var height = $(this).parent().parent().height();
            if (height > 100)
            {
                $(this).parent().parent().css('height', '27');
                $(this).attr('value', '➕');
            } else
            {

                $(this).parent().parent().css('height', '300');
                $(this).attr('value', '➖');
            }

        });
        function getStatusList()
        {
            $.ajax({
                type: 'GET',
                url: "<%=request.getContextPath()%>/ChatServer.do?method=getOnlineStatus",
                success: function (data) {
                    var parsed = JSON.parse(data);
                    var i = 0;
                    while ((parsed[i].user_status !== null || parsed[i].user_status !== '') && (parsed[i].user_id !== null || parsed[i].user_id !== ''))
                    {
                        if (parsed[i].user_status === "o")
                        {
                            //alert(parsed[i].user_id);
                            $('div#' + parsed[i].user_id).css('background-color', '#3aff8f');
                        } else
                        {
                            $('div#' + parsed[i].user_id).css('background-color', 'grey');
                        }

                        i++;
                    }
                }
            });
            //getStatusList();

        }


        function getNameList()
        {
            $.ajax({
                type: 'GET',
                url: "<%=request.getContextPath()%>/ChatServer.do?method=getChatNameList",
                success: function (data) {
                    var parsed = JSON.parse(data);
                    var i = 0;
                    while ((parsed[i].user_name !== null || parsed[i].user_name !== '') && (parsed[i].user_id !== null || parsed[i].user_id !== ''))
                    {
                        if ((parsed[i].user_name !== $('#chat-username').val()))
                        {

                            $(".chat-name-list").append('<div class="online-status" id="' + parsed[i].user_id + '" style="background-color: grey "></div><a href="#" class="name-button" id="' + parsed[i].user_id + '" value="' + parsed[i].user_name + '">' + parsed[i].user_name + '</a>');
                            name_list_map[parsed[i].user_id] = parsed[i].user_name;
                        }

                        i++;
                    }
                }
            });
        }

        function update_delivery_status(chat_id)
        {
            $.ajax({
                type: 'GET',
                data: {status_id: chat_id},
                url: "<%=request.getContextPath()%>/ChatServer.do?method=deliveryreportChat",
                success: function (data)
                {
                    if(data.toString()=== "update")
                    {
                        $('ul.' + chat_id + ' li:last div.' + chat_id).css('background-color', '#fcfcab');
                        $('ul.' + chat_id + ' li:last div.' + chat_id).removeClass('right-top').addClass('right-top-sent');
                    }
                }
            });
        }
        function sendChat(from_id, to_id, message)
        {

            //alert(from_name + ':' + to_name + ':' + message);
            if ((from_id === null || from_id === '') && (to_id === null || to_id === ''))
                location.reload();
            else {
                $.ajax({
                    type: 'GET',
                    data: {chat_user_id_from: from_id, chat_user_id_to: to_id, chat_text: message},
                    url: "<%=request.getContextPath()%>/ChatServer.do?method=sendChat",
                    success: function (data) {
//                        $('ul.' + to_id).append('<li style="float: right; color: #90949c; font-size: 10px;">&#10003 Sent</li>');
                        $('ul.' + to_id + ' li:last div.' + to_id).css('background-color', '#fcfcab');
                        $('ul.' + to_id + ' li:last div.' + to_id).removeClass('right-top').addClass('right-top-sent');
                    },
                    error: function (xhr, textStatus, errorThrown) {
                        if (textStatus == 'timeout') {
                            this.tryCount++;
                            if (this.tryCount <= this.retryLimit) {
                                //try again
                                $.ajax(this);
                                return;
                            }
                            return;
                        }
                        if (xhr.status == 500) {
                            //handle error
                        } else {
                            //handle error
                        }
                    }
                });
            }
        }

        function loadchat(pop_id) {
            var id = $("#chat-id").val();
            var id_to = pop_id;

            $.ajax({
                type: 'GET',
                data: {chat_user_id_from: id, chat_user_id_to: id_to},
                url: "<%=request.getContextPath()%>/ChatServer.do?method=loadChatHistory",
                success: function (data) {
                    //alert(data.toString());
                    var parsed = JSON.parse(data);
                    var i = 0;
                    var dNow = new Date();
                    var localdate = dNow.getDate() + '/' + (dNow.getMonth() + 1) + '/' + dNow.getFullYear() + ' ' + dNow.getHours() + ':' + dNow.getMinutes();
                    while ((parsed[i].text !== null || parsed[i].text !== ''))
                    {


                        if (parsed[i].alignment === "1")
                        {
                            if (parsed[i].status === "u")
                            {
                                $("ul." + id_to + '#chat-message-list li:last-child').remove();
                                $('ul.' + id_to).append('<li ><div class="talk-bubble tri-right right-top-sent" style="background-color: #fcfcab "><div class="talktext"><p>' + parsed[i].text + '</p></div></div></li>');
                            } else
                            {
                                $("ul." + id_to + '#chat-message-list li:last-child').remove();
                                $('ul.' + id_to).append('<li ><div class="talk-bubble tri-right right-top"><div class="talktext"><p>' + parsed[i].text + '</p></div></div></li>');
                            }
                            scrolltobottom();
                        } else
                        {
                            $("ul." + id_to + '#chat-message-list li:last-child').remove();
                            $('ul.' + id_to).append('<li ><div class="talk-bubble tri-right left-top-sent" style="background-color: #4286f4"><div class="talktext"><p>' + parsed[i].text + '</p></div></div></li>');

                            scrolltobottom();
                        }

                        i++;
                    }
                    $('ul.' + id_to).append('<li style="float: right; color: #90949c; font-size: 10px;">Message Recieved : ' + localdate + '</li>');
                }
            });
        }

        function getNewChat()
        {
            var id = $("#chat-id").val();
            $.ajax({
                type: 'GET',
                data: {chat_user_id_from: id},
                url: "<%=request.getContextPath()%>/ChatServer.do?method=getNewChat",
                success: function (data) {
                    var parsed = JSON.parse(data);
                    var i = 0;
                    while ((parsed[i].user !== null || parsed[i].user !== ''))
                    {

                        var dNow = new Date();
                        var localdate = dNow.getDate() + '/' + (dNow.getMonth() + 1) + '/' + dNow.getFullYear() + ' ' + dNow.getHours() + ':' + dNow.getMinutes();
                        if (jQuery.inArray(id, window_list) < 0)
                        {
                            //alert(name_list_map[parsed[i].user]);
                            pop(parsed[i].user, name_list_map[parsed[i].user]);
                            $("." + parsed[i].user + '#chat-message-list li:last-child').remove();
                            $('ul.' + parsed[i].user).append('<li ><div class="talk-bubble tri-right left-top-sent" style="background-color: #4286f4"><div class="talktext"><p>' + parsed[i].text + '</p></div></div></li>');

                            $('div.chat-header#' + parsed[i].user).addClass('glowWorm');
                            scrolltobottom();
                            audioElement.play();
                            coders(name_list_map[parsed[i].user] + " Messeged You", 20);
                        } else
                        {
                            $("." + parsed[i].user + '#chat-message-list li:last-child').remove();
                            $('ul.' + parsed[i].user).append('<li ><div class="talk-bubble tri-right left-top-sent" style="background-color: #4286f4"><div class="talktext"><p>' + parsed[i].text + '</p></div></div></li>');

                            scrolltobottom();
                            audioElement.play();
                            coders("New Message from " + name_list_map[parsed[i].user], 20);
                        }
                        $('ul.' + parsed[i].user).append('<li style="float: right; color: #90949c; font-size: 10px;">Message Recieved : ' + localdate + '</li>');
                        scrolltobottom();
                        i++;
                    }
                },
                error: function (data) {
                    $('ul.' + parsed[i].user).append('<li style="float: right; color: red; font-size: 10px;">Some Error Happened</li>');
                }
            });
        }

        function getName() {
            var txt;
            var user_self = prompt("Please enter your name:", "Neal");
            var user_id = prompt("Please enter your id:", "1");
            if (user_self === null || user_self === "") {
                txt = "User cancelled the prompt.";
            } else {

                $("#chat-username").val(user_self);
                $("#chat-id").val(user_id);
            }

        }

        $("body").delegate(".chat-input-box", "keyup", function (e) {
            var id_chat = this.id;
            if (e.which === 13 && !e.shiftKey) {

                var message = $('.chat-input-box.' + id_chat).val();
                alert(id_chat);
                alert(message);
                $('input.' + id_chat).val('');
                if (message !== '' && message !== null && message !== '\n') {
                    $('ul.' + id_chat + ' li:last-child').remove();
                    message = message.replace(/\r?\n/g, '<br/>');
                    $('ul.' + id_chat).append('<li ><div class="talk-bubble tri-right right-top-unsent ' + this.id + '" style="background-color: #ff8e8e"><div class="talktext"><p>' + message + '</p></div></div></li>');
                    sendChat($('#chat-id').val(), this.id, message);
                    scrolltobottom();
                }
            }
        });
        function scrolltobottom()
        {
            var scroll = $('.list-container');
            var height = scroll[0].scrollHeight;
            scroll.scrollTop(height);
        }

        function openNav() {
            document.getElementById("mySidenav").style.width = "250px";
            //$("#chat-popup-box").toggleClass("moved");
            $('.chatboxes').animate({right: '270px'}, 300);
        }

        function closeNav() {
            document.getElementById("mySidenav").style.width = "0";
            $('.chatboxes').animate({right: '20px'}, 300);
        }

        (function () {

            var original = document.title;
            var timeout;
            alert(original);

            window.coders = function (newMsg, howManyTimes) {
                function step() {
                    document.title = (document.title === original) ? newMsg : original;

                    if (--howManyTimes > 0) {
                        timeout = setTimeout(step, 1000);
                    }
                    ;
                }
                ;

                howManyTimes = parseInt(howManyTimes);

                if (isNaN(howManyTimes)) {
                    howManyTimes = 5;
                }
                ;

                cancelcoders(timeout);
                step();
            };

            window.cancelcoders = function () {
                clearTimeout(timeout);
                document.title = original;
            };

        }());


    </script>
    <style>
        body{
            /*            background:#ffffff url("123.jpg") no-repeat right top;*/
            background-color:#f1f1f1;
            font-family: "Ubuntu-Italic", "Lucida Sans", helvetica, sans;
            background-color: white;
        }

        /* container */
        .container {
            padding: 1% 1%;
        }
        /*online status block*/
        .online-status {
            float: left;
            width: 5px;
            height: 15px;
            margin: 5px;
            border: 1px solid rgba(0, 0, 0, .2);
        }

        /* CSS talk bubble */
        .talk-bubble {
            margin: 10px;
            display:list-item;
            position: relative;
            width: auto;
            height: auto;
            right: 5%;
            background-color: #a3ffb3;
            word-wrap: break-word;
            border-radius: 10px;
            box-shadow: 0 0 2px #7c7c7c;

        }
        .border{
            border: 8px solid #666;
        }
        .round{
            border-radius: 10px;
            -webkit-border-radius: 30px;
            -moz-border-radius: 30px;

        }

        /* Right triangle placed top left flush. */
        .tri-right.border.left-top:before {
            content: ' ';
            position: absolute;
            width: 0;
            height: 0;
            left: -40px;
            right: auto;
            top: -8px;
            bottom: auto;
            border: 32px solid;
            border-color: #666 transparent transparent transparent;
        }
        .tri-right.left-top:after{
            content: ' ';
            position: absolute;
            width: 0;
            height: 0;
            left: -20px;
            right: auto;
            top: 0px;
            bottom: auto;
            border: 22px solid;
            border-color: #a3ffb3 transparent transparent transparent;

        }
        .tri-right.left-top-sent:after{
            content: ' ';
            position: absolute;
            width: 0;
            height: 0;
            left: -20px;
            right: auto;
            top: 0px;
            bottom: auto;
            border: 22px solid;
            border-color: #4286f4 transparent transparent transparent;

        }

        /* Right triangle, left side slightly down */
        .tri-right.border.left-in:before {
            content: ' ';
            position: absolute;
            width: 0;
            height: 0;
            left: -40px;
            right: auto;
            top: 30px;
            bottom: auto;
            border: 20px solid;
            border-color: #666 #666 transparent transparent;
        }
        .tri-right.left-in:after{
            content: ' ';
            position: absolute;
            width: 0;
            height: 0;
            left: -20px;
            right: auto;
            top: 38px;
            bottom: auto;
            border: 12px solid;
            border-color: #afbaea #afbaea transparent transparent;
        }

        /*Right triangle, placed bottom left side slightly in*/
        .tri-right.border.btm-left:before {
            content: ' ';
            position: absolute;
            width: 0;
            height: 0;
            left: -8px;
            right: auto;
            top: auto;
            bottom: -40px;
            border: 32px solid;
            border-color: transparent transparent transparent #666;
        }
        .tri-right.btm-left:after{
            content: ' ';
            position: absolute;
            width: 0;
            height: 0;
            left: 0px;
            right: auto;
            top: auto;
            bottom: -20px;
            border: 22px solid;
            border-color: transparent transparent transparent #afbaea;
        }

        /*Right triangle, placed bottom left side slightly in*/
        .tri-right.border.btm-left-in:before {
            content: ' ';
            position: absolute;
            width: 0;
            height: 0;
            left: 30px;
            right: auto;
            top: auto;
            bottom: -40px;
            border: 20px solid;
            border-color: #666 transparent transparent #666;
        }
        .tri-right.btm-left-in:after{
            content: ' ';
            position: absolute;
            width: 0;
            height: 0;
            left: 38px;
            right: auto;
            top: auto;
            bottom: -20px;
            border: 12px solid;
            border-color: #afbaea transparent transparent #afbaea;
        }

        /*Right triangle, placed bottom right side slightly in*/
        .tri-right.border.btm-right-in:before {
            content: ' ';
            position: absolute;
            width: 0;
            height: 0;
            left: auto;
            right: 30px;
            bottom: -40px;
            border: 20px solid;
            border-color: #666 #666 transparent transparent;
        }
        .tri-right.btm-right-in:after{
            content: ' ';
            position: absolute;
            width: 0;
            height: 0;
            left: auto;
            right: 38px;
            bottom: -20px;
            border: 12px solid;
            border-color: #afbaea #afbaea transparent transparent;
        }
        /*Right triangle, placed bottom right side slightly in*/
        .tri-right.border.btm-right:before {
            content: ' ';
            position: absolute;
            width: 0;
            height: 0;
            left: auto;
            right: -8px;
            bottom: -40px;
            border: 20px solid;
            border-color: #666 #666 transparent transparent;
        }
        .tri-right.btm-right:after{
            content: ' ';
            position: absolute;
            width: 0;
            height: 0;
            left: auto;
            right: 0px;
            bottom: -20px;
            border: 12px solid;
            border-color: #afbaea #afbaea transparent transparent;
        }

        /* Right triangle, right side slightly down*/
        .tri-right.border.right-in:before {
            content: ' ';
            position: absolute;
            width: 0;
            height: 0;
            left: auto;
            right: -40px;
            top: 30px;
            bottom: auto;
            border: 20px solid;
            border-color: #666 transparent transparent #666;
        }
        .tri-right.right-in:after{
            content: ' ';
            position: absolute;
            width: 0;
            height: 0;
            left: auto;
            right: -20px;
            top: 38px;
            bottom: auto;
            border: 12px solid;
            border-color: #afbaea transparent transparent #afbaea;
        }

        /* Right triangle placed top right flush. */
        .tri-right.border.right-top:before {
            content: ' ';
            position: absolute;
            width: 0;
            height: 0;
            left: auto;
            right: -40px;
            top: -8px;
            bottom: auto;
            border: 32px solid;
            border-color: #666 transparent transparent transparent;
        }
        .tri-right.right-top:after{
            content: ' ';
            position: absolute;
            width: 0;
            height: 0;
            left: auto;
            right: -20px;
            top: 0px;
            bottom: auto;
            border: 20px solid;
            border-color: #a3ffb3 transparent transparent transparent;
        }
        .tri-right.right-top-unsent:after{
            content: ' ';
            position: absolute;
            width: 0;
            height: 0;
            left: auto;
            right: -20px;
            top: 0px;
            bottom: auto;
            border: 20px solid;
            border-color: #ff8e8e transparent transparent transparent;
        }

        .tri-right.right-top-sent:after{
            content: ' ';
            position: absolute;
            width: 0;
            height: 0;
            left: auto;
            right: -20px;
            top: 0px;
            bottom: auto;
            border: 20px solid;
            border-color: #fcfcab transparent transparent transparent;
        }

        /* talk bubble contents */
        .talktext{
            padding: 1em;
            text-align: left;
            line-height: 1.5em;
        }
        .talktext p{
            /* remove webkit p margins */
            -webkit-margin-before: 0em;
            -webkit-margin-after: 0em;
        }
        .chatboxes{
            position:absolute;
            bottom: 0;
            right:10px;
            z-index: 1;


        }

        .chat-popup-box
        {
            border-radius: 5px 5px 0px 0px;
            width: 280px;
            height: 300px;

            bottom: 0;
            box-shadow: 0 0 5px #7c7c7c;
            overflow-y:hidden;
            background-color: white;
            z-index: 1;
            float: right;

            margin-right: 10px;

        }

        .chat-input-box{
            display: block;
            margin: 2px;
            bottom: 0px;
            width: 97%;
            height: auto;
            max-height: 100px;
        }
        .list-container
        {
            overflow-y: auto;
            padding: 1px;
            height: 245px;
        }

        .chat-header{
            background-color: #ffc37f;
            box-shadow: 0 0 5px #7c7c7c;
            font-family : sans-serif ;
            font-size:medium;
            padding: 5px;
        }
        .buttonmin,.buttonclose {
            background-color: Transparent;
            background-repeat:no-repeat;
            border: none;
            cursor:pointer;
            overflow: hidden;
            outline:none;
            color: black;
        }

        .buttonmin:hover{
            color:white;
        }
        .buttonclose:hover
        {
            color: white;
        }

        .chat-system{
            display: flex;
        }
        .sidenav {
            height: 100%;
            width: 0;
            position: fixed;
            z-index: 2;
            top: 0;
            right: 0;
            background-color: #111;
            overflow-x: hidden;
            transition: 0.5s;
            padding-top: 15px;
            box-shadow: 0 0 5px #7c7c7c;
        }

        .sidenav a {
            padding: 8px 8px 8px 32px;
            text-decoration: none;
            font-size: 12px;
            color: #818181;
            display: block;
            transition: 0.3s;
        }

        .sidenav a:hover, .offcanvas a:focus{
            color: #f1f1f1;
        }

        .sidenav .closebtn {
            position: absolute;
            top: 0;
            right: 25px;
            font-size: 36px;
            margin-left: 50px;
        }

        @media screen and (max-height: 450px) {
            .sidenav {padding-top: 15px;}
            .sidenav a {font-size: 18px;}
        }
        .moved {
            left:20px;
        }
        .glowWorm	{
            -webkit-animation: monofader 1s infinite;
            animation: monofader 1s infinite;
        }
        @-webkit-keyframes monofader 
        {
            50% {opacity: 0.4;}
        }

        @keyframes monofader {
            50% {opacity: 0.4;}
        }

        .typing-indicator {
            background-color: #E6E7ED;
            width: auto;
            border-radius: 20px;
            padding: 10px;
            display: table;
            margin: 0 auto;
            position: relative;
            -webkit-animation: 2s bulge infinite ease-out;
            animation: 2s bulge infinite ease-out;
        }
        .typing-indicator:before, .typing-indicator:after {
            content: '';
            position: absolute;
            bottom: -2px;
            left: -2px;
            height: 20px;
            width: 20px;
            border-radius: 50%;
            background-color: #E6E7ED;
        }
        .typing-indicator:after {
            height: 10px;
            width: 10px;
            left: -10px;
            bottom: -10px;
        }
        .typing-indicator span {
            height: 5px;
            width: 5px;
            float: left;
            margin: 0 1px;
            background-color: #9E9EA1;
            display: block;
            border-radius: 50%;
            opacity: 0.4;
        }
        .typing-indicator span:nth-of-type(1) {
            -webkit-animation: 1s blink infinite 0.3333s;
            animation: 1s blink infinite 0.3333s;
        }
        .typing-indicator span:nth-of-type(2) {
            -webkit-animation: 1s blink infinite 0.6666s;
            animation: 1s blink infinite 0.6666s;
        }
        .typing-indicator span:nth-of-type(3) {
            -webkit-animation: 1s blink infinite 0.9999s;
            animation: 1s blink infinite 0.9999s;
        }

        @-webkit-keyframes blink {
            50% {
                opacity: 1;
            }
        }

        @keyframes blink {
            50% {
                opacity: 1;
            }
        }
        @-webkit-keyframes bulge {
            50% {
                -webkit-transform: scale(1.05);
                transform: scale(1.05);
            }
        }
        @keyframes bulge {
            50% {
                -webkit-transform: scale(1.05);
                transform: scale(1.05);
            }
        }
        /*        html {
                    display: table;
                    height: 100%;
                    width: 100%;
                }
        
                body {
                    display: table-cell;
                    vertical-align: middle;
                }*/

    </style>
</html>
