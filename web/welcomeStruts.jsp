<!doctype html>
<html>
    <head>
        <title>Facebook Style Popup Design</title>
        <script type="text/javascript" src="<%=request.getContextPath()%>/Resources/jquery.min.js"></script>
        <style>
            /*            @media only screen and (max-width : 540px) 
                        {
                            .chat-sidebar
                            {
                                display: none !important;
                            }
            
                            .chat-popup
                            {
                                display: none !important;
                            }
                        }*/

            body
            {
                background-color: #e9eaed;
            }

            .chat-sidebar
            {

                position: fixed;
                height: 100%;
                right: 0px;
                top: 0px;
                padding-top: 0px;
                padding-bottom: 0px;
                border: 1px solid rgba(29, 49, 91, .3);
                float: left;
                background-color: #fce9d1;
                display: block;
            }

            .chat-sidebar
            {
                width: 15%;
            }

            .button-wrap
            {
                width: 17.75%;
                float: right;
            }

            .sidebar-name 
            {
                padding-left: 10px;
                padding-right: 10px;
                margin-bottom: 4px;
                font-size: 12px;
            }

            .sidebar-name span
            {
                padding-left: 5px;
            }

            .sidebar-name a
            {
                display: block;
                height: 100%;
                text-decoration: none;
                color: inherit;
            }

            .sidebar-name:hover
            {
                background-color:#aaffb3;
            }

            .sidebar-name img
            {
                width: 32px;
                height: 32px;
                vertical-align: middle;
            }

            .popup-box
            {
                display: none;
                position: fixed;
                bottom: 0px;
                right: 100px;
                height: 285px;
                background-color: rgb(237, 239, 244);
                width: 270px;
                border: 1px solid rgba(29, 49, 91, .3);
            }

            .popup-box .popup-head
            {
                background-color: #6d84b4;
                padding: 5px;
                color: white;
                font-weight: bold;
                font-size: 14px;
                clear: both;
            }

            .popup-box .popup-head .popup-head-left
            {
                float: left;
            }

            .popup-box .popup-head .popup-head-right
            {
                float: right;
                opacity: 0.5;
            }

            .popup-box .popup-head .popup-head-right a
            {
                text-decoration: none;
                color: inherit;
            }

            .popup-box .popup-messages1
            {
                height: 100%;
                overflow-y: scroll;
            }
            .popup-messages{
                position:absolute;
                bottom:2px;
                left:2px;
                right:2px;
            }


            .popup-messages textarea {
                width:100%;
                height:30px;
                box-sizing:border-box;
                -moz-box-sizing:border-box;
                -webkit-box-sizing:border-box;
            }
            /*            html, body {
                            width:100%;
                            height: 100%;
                        }*/

            #map {
                width: 85%;
                height: 100%;
                float: left;

            }

            .chat-collapse {
                background-color:#44c767;
                /*                -moz-border-radius:42px;
                                -webkit-border-radius:42px;
                                border-radius:42px;*/
                display:inline-block;
                cursor:pointer;
                color:#ffffff;
                font-family:Verdana;
                font-size:15px;
                font-style:italic;
                padding:32px 3px;
                text-decoration:none;
                text-shadow:0px 2px 3px #2f6627;
                float: right;
                box-shadow: 0 3px #999;
                border-radius: 70px 0px 0px 70px;

                position: absolute;

            }
            .chat-collapse:hover {
                background-color:#5cbf2a;
            }
            .chat-collapse:active {
                position:absolute;

                transform: translateY(2px);
            }
            .shout_box {
                background: #627BAE;
                width: 260px;
                overflow: hidden;
                position: fixed;
                bottom: 0;
                right: 20%;
                z-index:9;
            }
            .shout_box .header .close_btn {
                background: url(Resources/close_btn.png) no-repeat 0px 0px;
                float: right;
                width: 15px;
                height: 15px;
            }
            .shout_box .header .close_btn:hover {
                background: url(images/close_btn.png) no-repeat 0px -16px;
            }

            .shout_box .header .open_btn {
                background: url(images/close_btn.png) no-repeat 0px -32px;
                float: right;
                width: 15px;
                height: 15px;
            }
            .shout_box .header .open_btn:hover {
                background: url(images/close_btn.png) no-repeat 0px -48px;
            }
            .shout_box .header{
                padding: 5px 3px 5px 5px;
                font: 11px 'lucida grande', tahoma, verdana, arial, sans-serif;
                font-weight: bold;
                color:#fff;
                border: 1px solid rgba(0, 39, 121, .76);
                border-bottom:none;
                cursor: pointer;
            }
            .shout_box .header:hover{
                background-color: #627BAE;
            }
            .shout_box .message_box {
                background: #FFFFFF;
                height: 200px;
                overflow:auto;
                border: 1px solid #CCC;
            }
            .shout_msg{
                margin-bottom: 10px;
                display: block;
                border-bottom: 1px solid #F3F3F3;
                padding: 0px 5px 5px 5px;
                font: 11px 'lucida grande', tahoma, verdana, arial, sans-serif;
                color:#7C7C7C;
            }
            .message_box:last-child {
                border-bottom:none;
            }
            time{
                font: 11px 'lucida grande', tahoma, verdana, arial, sans-serif;
                font-weight: normal;
                float:right;
                color: #D5D5D5;
            }
            .shout_msg .username{
                margin-bottom: 10px;
                margin-top: 10px;
            }
            .user_info input {
                width: 98%;
                height: 25px;
                border: 1px solid #CCC;
                border-top: none;
                padding: 3px 0px 0px 3px;
                font: 11px 'lucida grande', tahoma, verdana, arial, sans-serif;
            }
            .shout_msg .username{
                font-weight: bold;
                display: block;
            }



        </style>

        <script>
            //this function can remove a array element.
            Array.remove = function (array, from, to) {
                var rest = array.slice((to || from) + 1 || array.length);
                array.length = from < 0 ? array.length + from : from;
                return array.push.apply(array, rest);
            };

            //this variable represents the total number of popups can be displayed according to the viewport width
            var total_popups = 0;

            //arrays of popups ids
            var popups = [];

            //this is used to close a popup
            function close_popup(id)
            {
                for (var iii = 0; iii < popups.length; iii++)
                {
                    if (id === popups[iii])
                    {
                        Array.remove(popups, iii);

                        document.getElementById(id).style.display = "none";

                        calculate_popups();

                        return;
                    }
                }
            }

            //displays the popups. Displays based on the maximum number of popups that can be displayed on the current viewport width
            function display_popups()
            {
                var right = 220;

                var iii = 0;
                for (iii; iii < total_popups; iii++)
                {
                    if (popups[iii] !== undefined)
                    {
                        var element = document.getElementById(popups[iii]);
                        element.style.right = right + "px";
                        right = right + 320;
                        element.style.display = "block";
                    }
                }

                for (var jjj = iii; jjj < popups.length; jjj++)
                {
                    var element = document.getElementById(popups[jjj]);
                    element.style.display = "none";
                }
            }

            //creates markup for a new popup. Adds the id to popups array.
            function register_popup(id, name)
            {

                for (var iii = 0; iii < popups.length; iii++)
                {
                    //already registered. Bring it to front.
                    if (id === popups[iii])
                    {
                        Array.remove(popups, iii);

                        popups.unshift(id);

                        calculate_popups();


                        return;
                    }
                }
//                    <div class="shout_box" id="' + id + '">
                var element = '<div class="popup-box chat-popup" id="' + id + '">';
                element = element + '<div class="popup-head">';
                element = element + '<div class="popup-head-left">' + name + '</div>';
                element = element + '<div class="popup-head-right"><a href="javascript:close_popup(\'' + id + '\');">&#10005;</a></div>';
                element = element + '<div style="clear: both"></div></div><div class="popup-messages" style="width: 98%; bottom: 0;"><textarea></textarea></div></div>';

                var element = '<div class="shout_box" id="' + id + '">';
                
                element = element + '<div class="header">' + name + '<div class="close_btn">&nbsp;</div></div>';
                element = element + '<div class="toggle_chat"> <div class="message_box"> </div> <div class="user_info">  ';
                element = element + '<input name="shout_message" id="shout_message" type="text" placeholder="Type Message Hit Enter" maxlength="100" /></div></div></div>';
//                element = element + '<div class="chat-input"><textarea></textarea></div>';

                document.getElementsByTagName("body")[0].innerHTML = document.getElementsByTagName("body")[0].innerHTML + element;

                popups.unshift(id);

                calculate_popups();

            }

            //calculate the total number of popups suitable and then populate the toatal_popups variable.
            function calculate_popups()
            {
                var width = window.innerWidth;
                if (width < 540)
                {
                    total_popups = 0;
                } else
                {
                    width = width - 200;
                    //320 is width of a single popup box
                    total_popups = parseInt(width / 320);
                }

                display_popups();

            }

            //recalculate when window is loaded and also when window is resized.
            window.addEventListener("resize", calculate_popups);
            window.addEventListener("load", calculate_popups);


            //Autoresize height
            var span = $('<span>').css('display', 'inline-block')
                    .css('word-break', 'break-all').appendTo('body').css('visibility', 'hidden');
            function initSpan(textarea) {
                span.text(textarea.text())
                        .width(textarea.width())
                        .css('font', textarea.css('font'));
            }
            $('textarea').on({
                input: function () {
                    var text = $(this).val();
                    span.text(text);
                    $(this).height(text ? span.height() : '1.1em');
                },
                focus: function () {
                    initSpan($(this));
                },
                keypress: function (e) {
                    if (e.which === 13)
                        e.preventDefault();
                }
            });
            $('.collapse-button').click(function () {
                $('.chat-sidebar').slideToggle('slow');
            });



            $(document).ready(function () {
                $("#coll").click(function () {
                    if (parseInt($("#sidebar").css("width")) > 10)
                    {
                        $(".button-wrap").css('width', '2.5%');
                        $("#sidebar").css('width', '0%');
                    } else
                    {
                        $(".button-wrap").css('width', '17.75%');
                        $("#sidebar").css('width', '15%');
                    }
                });
            

            

                // load messages every 1000 milliseconds from server.
//                load_data = {'fetch': 1};
//                window.setInterval(function () {
//                    $.post('shout.php', load_data, function (data) {
//                        $('.message_box').html(data);
//                        var scrolltoh = $('.message_box')[0].scrollHeight;
//                        $('.message_box').scrollTop(scrolltoh);
//                    });
//                }, 1000);

                //method to trigger when user hits enter key
//                $("#shout_message").keypress(function (evt) {
//                    if (evt.which === 13) {
//                        var iusername = $('#shout_username').val();
//                        var imessage = $('#shout_message').val();
//                        post_data = {'username': iusername, 'message': imessage};
//
//                        //send data to "shout.php" using jQuery $.post()
//                        $.post('shout.php', post_data, function (data) {
//
//                            //append data into messagebox with jQuery fade effect!
//                            $(data).hide().appendTo('.message_box').fadeIn();
//
//                            //keep scrolled to bottom of chat!
//                            var scrolltoh = $('.message_box')[0].scrollHeight;
//                            $('.message_box').scrollTop(scrolltoh);
//
//                            //reset value of message box
//                            $('#shout_message').val('');
//
//                        }).fail(function (err) {
//
//                            //alert HTTP server error
//                            alert(err.statusText);
//                        });
//                    }
//                });

                //toggle hide/show shout box
                $(".close_btn").on("click",function () {
                    //get CSS display state of .toggle_chat element
                    alert('a');
                    var toggleState = $('.toggle_chat').css('display');

                    //toggle show/hide chat box
                    $('.toggle_chat').slideToggle();

                    //use toggleState var to change close/open icon image
                    if (toggleState === 'block')
                    {
                        $(".header div").attr('class', 'open_btn');
                    } else {
                        $(".header div").attr('class', 'close_btn');
                    }


                });
                
            });
        </script>
    </head>
    <body>
        <div id="wrapper">
            <div id="map"></div>

            <div class="button-wrap" >
                <a href="#" id="coll" class="chat-collapse" name="show" >Chat</a>
            </div>
            <div class="chat-sidebar" id="sidebar">
                <div class="online-list" style="padding-top: 2px">
                    <div class="sidebar-name">
                        <!-- Pass username and display name to register popup -->
                        <a href="javascript:register_popup('Niladri lahiry', 'Niladri lahiry');">
                            <img width="30" height="30" src="<%=request.getContextPath()%>/Resources/blank-profile.png" />
                            <span>Niladri lahiry</span>
                        </a>
                    </div>
                    <div class="sidebar-name">
                        <a href="javascript:register_popup('Om Prakash Kumar', 'Om Prakash Kumar');">
                            <img width="30" height="30" src="<%=request.getContextPath()%>/Resources/blank-profile.png" />
                            <span>Om Prakash Kumar</span>
                        </a>
                    </div>
                    <div class="sidebar-name">
                        <a href="javascript:register_popup('Niha Novacaine', 'Niha Novacaine');">
                            <img width="30" height="30" src="<%=request.getContextPath()%>/Resources/blank-profile.png" />
                            <span>Niha Novacaine</span>
                        </a>
                    </div>
                    <div class="sidebar-name">
                        <a href="javascript:register_popup('Bob Dylan', 'Bob Dylan');">
                            <img width="30" height="30" src="<%=request.getContextPath()%>/Resources/blank-profile.png" />
                            <span>Bob Dylan</span>
                        </a>
                    </div>
                </div>
            </div>
        </div>

    </body>
</html>