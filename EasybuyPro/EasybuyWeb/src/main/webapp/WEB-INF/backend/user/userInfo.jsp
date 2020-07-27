<%@ page language="java" contentType="text/html; charset=utf-8"  pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <script src="${ctx}/js/backend/backend.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.8.2.min.js"></script>
    <script type="text/javascript">
        $(function () {
            $("#update").hide();
        });
        function updateUser(id) {
            $("#update").show();
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

             nameIs = true;
            passIs = true;
            passToIs = true;
            idCodeIs = true;
            emailIs = true;
            mobileIs = true;
            username=true;

            $("input[name='loginName']").blur(function () {
                var name='${sessionScope.user.loginName}';
                var loginName = $(this).val();
                $.post("${pageContext.request.contextPath}/login/byLoginName.do", {"loginName": loginName}, function (data) {
                    if (data == "true" && loginName != "") {
                        $("#span0").css({"color": "green"});
                        $("#span0").html("✔");
                        nameIs = true;
                    } else {
                        $("#span0").css({"color":"red"});
                        $("#span0").html("此用户名已被使用");
                        nameIs = false;
                        if(loginName==name){
                            $("#span0").css({"color": "green"});
                            $("#span0").html("✔");
                            nameIs=true;
                        }
                        if (loginName == null || loginName.trim() == "") {
                            $("#span0").css({"color":"red"});
                            $("#span0").html("用户名不能为空");
                            nameIs = false;
                        }
                    }
                })
            });


                $("input[name='password']").blur(function () {
                    var password = $("input[name='password']").val();
                    $.post("${pageContext.request.contextPath}/userInfo/checkPass.do",{"pass":password},function (success) {
                        // alert(success);
                        if(success=="true"){
                            $("#span3").css({"color": "green"});
                            $("#span3").html("✔");
                            passIs=true;
                        }else{
                            $("#span3").css({"color":"red"});
                            $("#span3").html("原密码不正确");
                        }
                    })
                });
            $("input[name='email']").blur(function () {
                if ($(this).val().indexOf("@") == -1) {
                    $("#span6").css({"color":"red"});
                    $("#span6").html("邮箱格式不正确");
                    emailIs = false;
                } else {
                    $("#span6").css({"color": "green"});
                    $("#span6").html("✔");
                    emailIs = true;
                }
            });

            $("input[name='mobile']").blur(function () {
                if ($(this).val().trim().length < 11 || isNaN($(this).val())) {
                    $("#span7").css({"color":"red"});
                    $("#span7").html("手机号格式不正确");
                    mobileIs = false;
                } else {
                    $("#span7").css({"color": "green"});
                    $("#span7").html("✔");
                    mobileIs = true;
                }

            });

            $("input[name='userName']").blur(function () {
                if ($(this).val().trim().length != 0) {
                    $("#spans").css({"color": "green"});
                    $("#spans").html("✔");
                    username = true;
                } else {
                    $("#spans").css({"color":"red"});
                    $("#spans").html("用户名不能为空");
                }
            });

        });



            function updateUserInfo() {
                if (nameIs && passIs && emailIs  && mobileIs && username) {

                    var pass = $("input[name='password']").val();
                    if(pass.trim().length==0){
                        alert("原密码为必填项");
                        return false;
                    }

                   var rePass = $("input[name='repPassword']").val();
                    if(rePass.trim().length!=0){
                        $("input[name='password']").val(rePass);
                    }
                    if(confirm("确定修改吗,这会使您需要从新登录")){
                        $("#userAdd").attr("action","${pageContext.request.contextPath}/userInfo/updateThisInfo.do")
                        $("#userAdd").submit();
                    }
                } else {
                    alert("请正确填写各项信息");
                    return false;
                }
            }
    </script>
</head>
<body>
<jsp:include page="/WEB-INF/common/pre/top.jsp"></jsp:include>
<jsp:include page="/WEB-INF/common/pre/trolley.jsp"></jsp:include>
<%--<%@ include file="/WEB-INF/common/backend/searchBar.jsp" %>--%>
<!--End Header End-->
<div class="i_bg bg_color">
    <!--Begin 用户中心 Begin -->
    <div class="m_content">
        <%@ include file="/WEB-INF/common/backend/leftBar.jsp"%>
        <div class="m_right" id="content">
            <div class="m_des">
                <table border="0" style="width:870px; line-height:22px;" cellspacing="0" cellpadding="0">
                    <tr valign="top">
                        <td width="115"><img src="${pageContext.request.contextPath}/images/user.jpg" width="90" height="90" /></td>
                        <td>
                            <div class="m_user">${sessionScope.user.userName}</div><br />
                            <div>是否注册人脸:
                                <c:if test="${sessionScope.user.isFaceExists==0}">
                                    <span style="color: red">否 <a href="${pageContext.request.contextPath}/faceRegist.jsp" style="color: red">现在注册</a></span>
                                </c:if>
                                <c:if test="${sessionScope.user.isFaceExists==1}">
                                    <span style="color: red">已注册</span>
                                </c:if>
                            </div>
                            <p>
                                性别:
                                <c:choose>
                                    <c:when test="${sessionScope.user.sex==1}">男</c:when>
                                    <c:otherwise>女</c:otherwise>
                                </c:choose>
                                <br /><br />
                                邮箱:${sessionScope.user.email}<br /><br />
                                电话:${sessionScope.user.mobile}<br /><br />
                            </p>
                        </td>
                    </tr>
                </table>
                <p align="left" style="margin-top: -80px">
                    <a href="javascript:void(0)" onclick="updateUser('${sessionScope.user.id}')" class="add_b">修改用户</a>
                    <br>
                </p>
            </div>
            <div id="update">
                <form method="post" id="userAdd">
                    <table border="0" class="add_tab" style="width:930px;" cellspacing="0" cellpadding="0">
                        <tr>
                            <td width="135" align="right">登录名称</td>
                            <td colspan="3" style="font-family:'宋体';">
                                <input type="text" value="${user.loginName}" class="add_ipt" name="loginName" readonly/><span id="span1"></span>
                                <input type="hidden" value="${user.id}" name="id"><span id="span0"></span>
                            </td>
                        </tr>
                        <tr>
                            <td width="135" align="right">用户姓名</td>
                            <td colspan="3" style="font-family:'宋体';">
                                <input type="text" value="${sessionScope.user.userName}" class="add_ipt" name="userName"/><span id="spans"></span>
                            </td>
                        </tr>
                        <tr>
                            <td width="135" align="right">原密码</td>
                            <td>
                                <input type="password" value="" class="add_ipt" name="password" required="required"/><span id="span3"></span>
                            </td>
                        </tr>
                        <tr>
                            <td width="135" align="right">修改密码(选择性修改)</td>
                            <td>
                                <input type="password" value="" class="add_ipt" name="repPassword"/><span id="span4"></span>
                            </td>
                        </tr>
                        <tr>
                            <td width="135" align="right">电子邮箱</td>
                            <td>
                                <input type="text" value="${user.email}" class="add_ipt" name="email" id="email"/><span id="span6"></span>
                            </td>
                        </tr>
                        <tr>
                            <td width="135" align="right">手机</td>
                            <td>
                                <input type="text" value="${user.mobile}" class="add_ipt" name="mobile" id="mobile"/><span id="span7"></span>
                            </td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>
                                <input type="button" value="修改信息" class="s_btn"  onclick="updateUserInfo();">
                            </td>
                        </tr>
                    </table>
                </form>
            </div>
        </div>

    </div>

    <%@ include file="/WEB-INF/common/pre/footer.jsp" %>
</div>
</body>
</html>


















