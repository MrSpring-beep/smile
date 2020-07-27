<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<style type="text/css">
    #disappare {
        /*border: 3px solid #ccc;*/
        border-radius: 5px;
        background: #fff;
        font-size: 20px;
        width: 260px;
        height: 85px;
        position: fixed;
        top: 35%;
        left: 42%;
        text-align: center;
        background-color: #ffffff;
        color: #ff5d0b;
    }

    #video {
        /*margin-top: -40px;*/
        margin-left: 70px;
    }

    #snap {
        /*margin-top: -20px;*/
        width: 100px;
        height: 25px;
        color: white;
        border: none;
        background-color: orangered;
        /*margin-bottom: 900px;*/
        margin-left: 70px;
    }

    #check {
        width: 100px;
        height: 25px;
        color: white;
        border: none;
        margin-top: -25px;
        background-color: orangered;
        /*margin-bottom: 900px;*/
        margin-left: 280px;
    }

    #canvas {
        margin-left: 70px;
        margin-top: -310px;
        /*display: none;*/
    }
</style>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
    <!--[if IE 6]>
    <script src=" ${pageContext.request.contextPath}/js/iepng.js" type="text/javascript"></script>
        <script type="text/javascript">
           EvPNG.fix('div, ul, img, li, input, a'); 
        </script>
    <![endif]-->
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.1.min_044d0927.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.bxslider_e88acd1b.js"></script>


    <script type="text/javascript" src="${pageContext.request.contextPath}/js/menu.js"></script>

    <script type="text/javascript" src="${pageContext.request.contextPath}/js/select.js"></script>

    <script type="text/javascript" src="${pageContext.request.contextPath}/js/lrscroll.js"></script>

    <script type="text/javascript" src="${pageContext.request.contextPath}/js/num.js">
        var jq = jQuery.noConflict();
    </script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/iban.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/fban.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/f_ban.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/mban.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/bban.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/hban.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/tban.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/lrscroll_1.js"></script>
    <script type="text/javascript" src="https://cdn.bootcss.com/jquery/1.10.2/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/shade.js"></script>
    <script type="text/javascript">
        var error = "${param.error}"
        var user = "${param.data}"
        $(function () {

            $("#face").hide();
            if (error != "") {
                if (error == "true") {
                    var url=window.location.href;                    //获取当前页面的url
                    if(url.indexOf("?")!=-1) {                        //判断是否存在参数
                        url = url.replace(/(\?|#)[^'"]*/, '');           //去除参数
                        window.history.pushState({}, 0, url);
                    }
                    error="";
                    $("#pp").html("密码不正确");
                    $("#disappare").show().delay(3000).fadeOut(300);
                }
            }
            if (user != "") {
                var K = user.indexOf("K");
                var username = user.substring(0, K);
                var password = user.substring(K + 1);
                $("input[name='username']").val(username);
                $("input[name='password']").val(password);
                $("#userAdmin").submit();
            }
        })

        function cut() {
            $("#userAdmin").hide();
            $("#face").show();
            // $("#face").load("www.baidu.com");
        }

        function account() {
            var isExist = $("input[name='username']").val();
            $.post("${pageContext.request.contextPath}/login/byLoginName.do", {"loginName": isExist}, function (success) {
                if (success == "true") {
                    $("#pp").html("用户不存在");
                    $("#disappare").show().delay(3000).fadeOut(300);
                } else {
                    $("#userAdmin").submit();
                }
            })
        }
        document.onkeydown=function (e) {
            if (e.keyCode==13){
                account();
            }
        }
    </script>
    <title>尤洪</title>
</head>
<body>

<div id="content">
    <div id="disappare" style="display:none;">
        <h2 style="margin-top: 1px; font-family: 楷体">注意：</h2>
        <p style="margin-top: 15px; font-family: 楷体" id="pp">必须先输入文章名称</p>
    </div>
</div>
<!--Begin Header Begin-->
<div class="soubg">
    <div class="sou">
        <span class="fr">
        	<span class="fl">你好，请<a href="Login.jsp">登录</a>&nbsp; <a href="Regist.jsp" style="color:#ff4e00;">免费注册</a>&nbsp; </span>
            <span class="fl">|&nbsp;关注我们：</span>
            <span class="s_sh"><a href="#" class="sh1">新浪</a><a href="#" class="sh2">微信</a></span>
            <span class="fr">|&nbsp;<a href="#">手机版&nbsp;<img src="${pageContext.request.contextPath}/images/s_tel.png"
                                                              align="absmiddle"/></a></span>
        </span>
    </div>
</div>

<!--End Header End-->
<!--Begin Login Begin-->
<div class="log_bg">
    <div class="top">
        <div class="logo"><a href="index.jsp"><img src="${pageContext.request.contextPath}/images/logo.png"/></a></div>
    </div>
    <div class="login">
        <div class="log_img"><img src="${pageContext.request.contextPath}/images/l_img.png" width="611" height="425"/>
        </div>
        <div class="log_c">
            <div id="face">
                <h3 id="tit" style="z-index: 10;text-align: center">请将面部保持摄像头中央</h3>
                <%@include file="/face.jsp" %>
            </div>
            <form method="post" action="${pageContext.request.contextPath}/login.do" id="userAdmin">
                <table border="0" style="width:370px; font-size:14px; margin-top:30px;" cellspacing="0" cellpadding="0">
                    <tr height="50" valign="top">
                        <td width="55">&nbsp;</td>
                        <td>
                            <span class="fl" style="font-size:24px;">登录</span> <span style="color:#ff4e00"><a
                                href="javascript:void(0)" onclick="cut()">人脸登录</a></span>
                            <span class="fr">还没有商城账号，<a href="${pageContext.request.contextPath}/Regist.jsp" style="color:#ff4e00;">立即注册</a></span>
                        </td>
                    </tr>
                    <tr height="70">
                        <td>用户名</td>
                        <td><input type="text" value="" class="l_user" name="username"/></td>
                    </tr>
                    <tr height="70">
                        <td>密&nbsp; &nbsp; 码</td>
                        <td><input type="password" value="" class="l_pwd" name="password"/></td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td style="font-size:12px; padding-top:20px;">
                            <span class="fr"><a href="${pageContext.request.contextPath}/logout.do"
                                                style="color:#ff4e00;">忘记密码</a></span>
                        </td>
                    </tr>
                    <tr height="60">
                        <td>&nbsp;</td>
                        <td><input type="button" value="登录" class="log_btn" onclick="account()"/></td>
                    </tr>
                </table>
            </form>
        </div>
    </div>

</div>
<!--End Login End-->
<!--Begin Footer Begin-->
<div class="btmbg">
    <div class="btm">
        备案/许可证编号：蜀ICP备12009302号-1-www.dingguagua.com Copyright © 2015-2018 尤洪商城网 All Rights Reserved. 复制必究 , Technical
        Support: Dgg Group <br/>
        <img src="${pageContext.request.contextPath}/images/b_1.gif" width="98" height="33"/><img
            src="${pageContext.request.contextPath}/images/b_2.gif" width="98" height="33"/><img
            src="${pageContext.request.contextPath}/images/b_3.gif" width="98" height="33"/><img
            src="${pageContext.request.contextPath}/images/b_4.gif" width="98" height="33"/><img
            src="${pageContext.request.contextPath}/images/b_5.gif" width="98" height="33"/><img
            src="${pageContext.request.contextPath}/images/b_6.gif" width="98" height="33"/>
    </div>
</div>


<!--End Footer End -->

</body>


<!--[if IE 6]>
<script src="//letskillie6.googlecode.com/svn/trunk/2/zh_CN.js"></script>
<![endif]-->
</html>
