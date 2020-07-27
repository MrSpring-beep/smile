<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
    <!--[if IE 6]>
    <script src="${pageContext.request.contextPath}/js/iepng.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/js/jquery-1.8.2.min.js" type="text/javascript"></script>
        <script type="text/javascript">
           EvPNG.fix('div, ul, img, li, input, a');
        </script>
    <![endif]-->

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
            background-color: black;
            color: white;
        }
    </style>

    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.1.min_044d0927.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.bxslider_e88acd1b.js"></script>

    <script type="text/javascript" src="${pageContext.request.contextPath}/js/menu.js"></script>

    <script type="text/javascript" src="${pageContext.request.contextPath}/js/select.js"></script>

    <script type="text/javascript" src="${pageContext.request.contextPath}/js/lrscroll.js"></script>

    <script type="text/javascript" src="${pageContext.request.contextPath}/js/iban.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/fban.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/f_ban.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/mban.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/bban.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/hban.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/tban.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/lrscroll_1.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.8.2.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.validate.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/zh_CN.js"></script>

    <script type="text/javascript">
        function refreshCode() {
            var vcode = document.getElementById("vcode");
            //设置src属性  加载时间戳
            vcode.src = "${pageContext.request.contextPath}/login/checkCode.do?time=" + new Date().getTime();
            // alert(vcode.src);
        }
    </script>
    <script type="text/javascript">
        var nameIs = false;
        var passIs = false;
        var passToIs = false;
        var idCodeIs = false;
        var emailIs = false;
        var mobileIs = false;
        var codeIs = false;
        var username = false;



        $(function () {
            var name="${sessionScope.user.userName}";
            <c:if test="${sessionScope.msg!=null}">
                ${pageContext.request.getSession().removeAttribute("msg")}
                $("#pp").html("验证码不正确");
                nameIs=true;
                $("#disappare").show().delay(3000).fadeOut(300);
            </c:if>


            $("input[name='loginName']").blur(function () {
                var loginName = $(this).val();
                $.post("${pageContext.request.contextPath}/login/byLoginName.do", {"loginName": loginName}, function (data) {
                    if (data == "true" && loginName != "") {
                        $("#sp1").html("<img src='${pageContext.request.contextPath}/images/green.png' alt='可以使用'/>");
                        nameIs = true;
                    } else {
                        $("#sp1").html("<img src='${pageContext.request.contextPath}/images/red.png' alt='此用户名已被使用'/>");
                        $("#pp").html("此用户名已被使用");
                        $("#disappare").show().delay(3000).fadeOut(300);
                        nameIs = false;
                        if (loginName == null || loginName.trim() == "") {
                            $("#sp1").html("<img src='${pageContext.request.contextPath}/images/red.png' alt='用户名不能为空'/>");
                            $("#pp").html("用户名不能为空");
                            $("#disappare").show().delay(3000).fadeOut(300);
                            nameIs = false;
                        }

                    }
                })
                if(name.trim()!=""){
                    if(name.trim()==loginName.trim()){
                        nameIs=true;
                    }
                }
            });

            $("input[name='password']").blur(function () {
                var pass = $(this).val();
                if (pass.trim().length < 6) {
                    $("#sp2").html("<img src='${pageContext.request.contextPath}/images/red.png' alt='密码不能为空,且长度必须大于6位'/>");
                    $("#pp").html("密码不能为空,且长度必须大于6位");
                    $("#disappare").show().delay(3000).fadeOut(300);
                    passIs = false;
                } else {
                    $("#sp2").html("<img src='${pageContext.request.contextPath}/images/green.png' alt='可以使用'/>");
                    passIs = true;
                }
            })
            $("input[name='passwordto']").blur(function () {
                var pass = $("input[name='password']").val();
                var passto = $(this).val();
                if (passto != pass || passto == "" || passIs == false) {
                    $("#sp3").html("<img src='${pageContext.request.contextPath}/images/red.png' alt='两次密码输入不一致'/>");
                    $("#pp").html("两次密码输入不一致");
                    $("#disappare").show().delay(3000).fadeOut(300);
                    passToIs = false;
                } else {
                    $("#sp3").html("<img src='${pageContext.request.contextPath}/images/green.png' alt='可以使用'/>");
                    passToIs = true;
                }
            });
            $("input[name='identityCode']").blur(function () {
                if ($(this).val().trim().length < 18 || isNaN($(this).val())) {
                    $("#sp4").html("<img src='${pageContext.request.contextPath}/images/red.png' alt='身份证号码格式不正确'/>");
                    $("#pp").html("身份证号码格式不正确");
                    $("#disappare").show().delay(3000).fadeOut(300);
                    idCodeIs = false;
                } else {
                    $("#sp4").html("<img src='${pageContext.request.contextPath}/images/green.png' alt='可以使用'/>");
                    idCodeIs = true;
                }
            });
            $("input[name='email']").blur(function () {
                if ($(this).val().indexOf("@") == -1) {
                    $("#sp5").html("<img src='${pageContext.request.contextPath}/images/red.png' alt='邮箱格式不正确'/>");
                    $("#pp").html("邮箱格式不正确");
                    $("#disappare").show().delay(3000).fadeOut(300);
                    emailIs = false;
                } else {
                    $("#sp5").html("<img src='${pageContext.request.contextPath}/images/green.png' alt='可以使用'/>");
                    emailIs = true;
                }
            });

            $("input[name='mobile']").blur(function () {
                if ($(this).val().trim().length < 11 || isNaN($(this).val())) {
                    $("#sp6").html("<img src='${pageContext.request.contextPath}/images/red.png' alt='手机号格式不正确'/>");
                    $("#pp").html("手机号格式不正确");
                    $("#disappare").show().delay(3000).fadeOut(300);
                    mobileIs = false;
                } else {
                    $("#sp6").html("<img src='${pageContext.request.contextPath}/images/green.png' alt='可以使用'/>");
                    mobileIs = true;
                }

            });

            $("input[name='userName']").blur(function () {
                if ($(this).val().trim().length != 0) {
                    $("#spName").html("<img src='${pageContext.request.contextPath}/images/green.png' alt='可以使用'/>");
                    username = true;
                } else {
                    $("#spName").html("<img src='${pageContext.request.contextPath}/images/red.png' alt='手机号格式不正确'/>");
                    $("#pp").html("用户名不能为空");
                    $("#disappare").show().delay(3000).fadeOut(300);

                }
            });

            $("input[name='checkCode']").blur(function () {
                if ($(this).val() == null || $(this).val().trim() == "") {
                    $("#spanCheck").html("<img src='${pageContext.request.contextPath}/images/red.png' alt='验证码不能为空'/>");
                    $("#pp").html("验证码不能为空");
                    $("#disappare").show().delay(3000).fadeOut(300);
                    mobileIs = false;
                } else {
                    mobileIs = true;
                }
            });

            $(".log_btn").click(function () {
                $("input[name='password']").blur();
                $("input[name='passwordto']").blur();
                $("input[name='identityCode']").blur();
                $("input[name='email']").blur();
                $("input[name='mobile']").blur();
                $("input[name='userName']").blur();
                $("input[name='checkCode']").blur();
                if (nameIs && passIs && passToIs && emailIs && idCodeIs && mobileIs && username) {
                    $("#addUserForm").submit();
                } else {
                    alert("请正确填写各项信息");
                    return false;
                }
            })

        });
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
        	<span class="fl">你好，请<a href="${pageContext.request.contextPath}/Login.jsp">登录</a>&nbsp; <a
                    href="${pageContext.request.contextPath}/Regist.jsp"
                    style="color:#ff4e00;">免费注册</a>&nbsp; </span>
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
        <div class="logo"><a href="Index.jsp"><img src="${pageContext.request.contextPath}/images/logo.png"/></a></div>
    </div>
    <div class="regist">
        <div class="log_img"><img src="${pageContext.request.contextPath}/images/l_img.png" width="611" height="425"/>
        </div>
        <div class="reg_c">
            <form method="post" action="${pageContext.request.contextPath}/login/saveUser.do" id="addUserForm">
                <table border="0" style="width:420px; font-size:14px; margin-top:20px;" cellspacing="0" cellpadding="0">
                    <tr height="50" valign="top">
                        <td width="95">&nbsp;</td>
                        <td>
                            <span class="fl" style="font-size:24px;">注册</span>
                            <span class="fr">已有商城账号，<a href="Login.jsp" style="color:#ff4e00;">我要登录</a></span>
                        </td>
                    </tr>
                    <tr height="50">
                        <td align="right"><font color="#ff4e00">*</font>&nbsp;登录名 &nbsp;</td>
                        <td><input type="text" value="${sessionScope.user.loginName}" class="l_user" name="loginName"/>
                        </td>
                        <td><span id="sp1"></span></td>
                    </tr>
                    <tr height="50">
                        <td align="right"><font color="#ff4e00">*</font>&nbsp;用户名&nbsp;</td>
                        <td><input type="text" value="${sessionScope.user.userName}" class="l_email" name="userName"/>
                        </td>
                        <td><span id="spName"></span></td>
                    </tr>
                    <tr height="50">
                        <td align="right"><font color="#ff4e00">*</font>&nbsp;密码 &nbsp;</td>
                        <td><input type="password" value="${sessionScope.user.password}" class="l_pwd" name="password"/>
                        </td>
                        <td><span id="sp2"></span></td>
                    </tr>
                    <tr height="50">
                        <td align="right"><font color="#ff4e00">*</font>&nbsp;确认密码 &nbsp;</td>
                        <td><input type="password" value="${sessionScope.user.password}" class="l_pwd"
                                   name="passwordto"/></td>
                        <td><span id="sp3"></span></td>
                    </tr>
                    <tr height="50">
                        <td align="right"><font color="#ff4e00">*</font>&nbsp;性别 &nbsp;</td>
                        <td><input type="radio" name="sex" value="1" checked/> 男 <input type="radio" name="sex"
                                                                                        value="0"/>女
                        </td>
                    </tr>
                    <tr height="50">
                        <td align="right"><font color="#ff4e00">*</font>&nbsp;身份ID &nbsp;</td>
                        <td><input type="text" value="${sessionScope.user.identityCode}" class="l_email"
                                   name="identityCode"/></td>
                        <td><span id="sp4"></span></td>
                    </tr>
                    <td align="right"><font color="#ff4e00">*</font>&nbsp;邮箱 &nbsp;</td>
                    <td><input type="text" value="${sessionScope.user.email}" class="l_email" name="email"/></td>
                    <td><span id="sp5"></span></td>
                    </tr>
                    <tr height="50">
                        <td align="right"><font color="#ff4e00">*</font>&nbsp;手机 &nbsp;</td>
                        <td><input type="text" value="${sessionScope.user.mobile}" class="l_tel" name="mobile"/></td>
                        <td><span id="sp6"></span></td>
                    </tr>
                    <tr height="50">
                        <td align="right"><font color="#ff4e00">*</font>&nbsp;验证码 &nbsp;</td>
                        <td>
                            <input type="text" value="" class="l_ipt" name="checkCode"/>
                            <a href="JavaScript:refreshCode();" style="font-size:12px; font-family:'宋体';">
                                <img src="${pageContext.request.contextPath}/login/checkCode.do" alt="看不清换一张"
                                     id="vcode"/>
                                换一张</a><span id="spanCheck"></span>
                        </td>
                        <td><span id="spCode"></span></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td style="font-size:12px; padding-top:20px;">
                	<span style="font-family:'宋体';" class="fl">
                    	<label class="r_rad"><input type="checkbox"/></label><label class="r_txt">我已阅读并接受《用户协议》</label>
                    </span>
                        </td>
                    </tr>
                    <tr height="60">
                        <td></td>
                        <td><input type="button" value="立即注册" class="log_btn"/></td>
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
