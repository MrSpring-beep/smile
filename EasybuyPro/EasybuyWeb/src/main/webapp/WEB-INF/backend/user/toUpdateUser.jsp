<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <%--    <%@ include file="/WEB-INF/common/pre/header.jsp" %>--%>

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
    </style>

    <script src="${ctx}/js/backend/backend.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.8.2.min.js"></script>
    <script type="text/javascript">

        var nameIs=false;
        var passIs=false;
        var passToIs=false;
        var idCodeIs=false;
        var emailIs=false;
        var mobileIs=false;
        $(function () {

            var name="${user.loginName}";

            $("input[name='loginName']").blur(function () {
                var loginName = $("input[name='loginName']").val();
                if(loginName.trim()!=""){
                    $.post("${pageContext.request.contextPath}/login/byLoginName.do",{"loginName":loginName},function (data) {
                        if (data == "false") {
                            $("#span1").css({"color": "red"});
                            $("#span1").html("此用户名,已存在");
                            if(name!=""){
                                if(loginName.trim()==name){
                                    $("#span1").css({"color": "green"});
                                    $("#span1").html("✔");
                                    nameIs=true;
                                }
                            }
                        } else {
                            $("#span1").css({"color": "green"});
                            $("#span1").html("✔");
                            nameIs=true;
                        }
                    })
                }else{
                    $("#span1").css({"color": "red"});
                    $("#span1").html("用户名不能为空");
                }
            });

            $("input[name='userName']").blur(function () {
                if($(this).val().trim().length!=0){
                    $("#span2").css({"color": "green"});
                    $("#span2").html("✔");
                }else{
                    $("#span2").css({"color": "red"});
                    $("#span2").html("真实姓名不能为空");
                }

            });

            $("input[name='password']").blur(function () {
                var password = $("input[name='password']").val();
                if(password.trim().length<6){
                    $("#span3").css({"color":"red"});
                    $("#span3").html("密码长度不能小于6");
                }else {
                    $("#span3").css({"color": "green"});
                    $("#span3").html("✔");
                    passIs=true;
                }
            });

            $("input[name='repPassword']").blur(function () {
                var password = $("input[name='password']").val();
                var repPassword = $("input[name='repPassword']").val();
                if(repPassword.trim()!==password.trim()||repPassword.trim().length<6){
                    $("#span4").css({"color":"red"});
                    $("#span4").html("两次密码不一致");
                }else {
                    $("#span4").css({"color": "green"});
                    $("#span4").html("✔");
                    passToIs=true;
                }
            });

            $("input[name='identityCode']").blur(function () {
                var identityCode = $("input[name='identityCode']").val();
                if(identityCode.trim().length<16 || isNaN(identityCode)){
                    $("#span5").css({"color":"red"});
                    $("#span5").html("请输入正确的身份证号码,且长度必须大于等于16位");
                }else{
                    $("#span5").css({"color": "green"});
                    $("#span5").html("✔");
                    idCodeIs=true;
                }
            });


            $("input[name='email']").blur(function () {
                var email=$("input[name='email']").val();
                if(email.indexOf("@")==-1){
                    $("#span6").css({"color":"red"});
                    $("#span6").html("请输入包含@的正确邮箱");
                }else {
                    $("#span6").css({"color": "green"});
                    $("#span6").html("✔");
                    emailIs=true;
                }
            });


            $("input[name='mobile']").blur(function () {
                var mobile=$("input[name='mobile']").val();
                if(mobile.trim().length<11){
                    $("#span7").css({"color":"red"});
                    $("#span7").html("请输入正确的手机号码");
                }else {
                    $("#span7").css({"color": "green"});
                    $("#span7").html("✔");
                    mobileIs=true;                }
            });
        });

        function addUser() {
            if(nameIs && passIs && idCodeIs && emailIs && mobileIs){
                $("#userAdd").attr('action','${pageContext.request.contextPath}/userInfo/saveUserInfo.do');
                $("#userAdd").submit();
            }else {
                alert("请正确填写各项信息");
            }
        }
        function updateUserInfo() {
            $("input[name='identityCode']").blur();
            $("input[name='email']").blur();
            $("input[name='mobile']").blur();

            if(idCodeIs && emailIs && mobileIs){
                $("#userAdd").attr('action','${pageContext.request.contextPath}/userInfo/updateUserInfo.do');
                $("#userAdd").submit();
            }else {
                alert("请正确填写各项信息");
            }
        }
    </script>

</head>
<body>

<div id="content">
    <div id="disappare" style="display:none;">
        <h2 style="margin-top: 1px; font-family: 楷体">注意：</h2>
        <p  style="margin-top: 15px; font-family: 楷体" id="pp">必须先输入文章名称</p>
    </div>
</div>
<%--<%@ include file="/WEB-INF/common/backend/searchBar.jsp" %>--%>
<!--End Header End-->
<jsp:include page="/WEB-INF/common/pre/top.jsp"></jsp:include>
<jsp:include page="/WEB-INF/common/pre/trolley.jsp"></jsp:include>
<div class="i_bg bg_color">
    <!--Begin 用户中心 Begin -->
    <div class="m_content">
        <%@ include file="/WEB-INF/common/backend/leftBar.jsp" %>
        <div class="m_right" id="content">
            <div class="mem_tit">
                <c:choose>
                    <c:when test="${empty requestScope.user.id || requestScope.user.id==0}">
                        添加用户
                    </c:when>
                    <c:otherwise>
                        修改用户
                    </c:otherwise>
                </c:choose>
            </div>
            <br>
            <form method="post" id="userAdd">
                <table border="0" class="add_tab" style="width:930px;" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="135" align="right">用户姓名</td>
                        <td colspan="3" style="font-family:'宋体';">
                            <input type="text" value="${requestScope.user.loginName}" class="add_ipt" name="loginName"/><span id="span1"></span>
                            <input type="hidden" value="${requestScope.user.id}" name="id">
                        </td>
                    </tr>
                    <tr>
                        <td width="135" align="right">真实姓名</td>
                        <td>
                            <input type="text" value="${requestScope.user.userName}" class="add_ipt" name="userName"/><span id="span2"></span>
                        </td>
                    </tr>
                    <c:if test="${empty requestScope.user.id ||  requestScope.user.id==0}">
                        <tr>
                            <td width="135" align="right">密码</td>
                            <td>
                                <input type="password" value="" class="add_ipt" name="password"/><span id="span3"></span>
                            </td>
                        </tr>
                        <tr>
                            <td width="135" align="right">确认密码</td>
                            <td>
                                <input type="password" value="" class="add_ipt" name="repPassword"/><span id="span4"></span>
                            </td>
                        </tr>
                    </c:if>
                    <tr>
                        <td width="135" align="right">身份证号</td>
                        <td>
                            <input type="text" value="${requestScope.user.identityCode}" class="add_ipt" name="identityCode"
                                   id="identityCode"/><span id="span5"></span>
                        </td>
                    </tr>
                    <tr>
                        <td width="135" align="right">电子邮箱</td>
                        <td>
                            <input type="text" value="${requestScope.user.email}" class="add_ipt" name="email" id="email"/><span id="span6"></span>
                        </td>
                    </tr>
                    <tr>
                        <td width="135" align="right">手机</td>
                        <td>
                            <input type="text" value="${requestScope.user.mobile}" class="add_ipt" name="mobile" id="mobile"/><span id="span7"></span>
                        </td>
                    </tr>
                    <tr>
                        <td width="135" align="right">用户类型</td>
                        <td>
                            <select name="type">
                                <option value="1" <c:if test="${requestScope.user.type==1}">selected="selected"</c:if>>管理员</option>
                                <option value="0" <c:if test="${requestScope.user.type==0}">selected="selected"</c:if>>普通用户</option>
                            </select>
                        </td><span id="span8"></span>
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            <c:choose>
                                <c:when test="${empty requestScope.user.id || requestScope.user.id==0}">
                                    <input type="button" value="添加用户" class="s_btn" onclick="addUser();">
                                </c:when>
                                <c:otherwise>
                                    <input type="button" value="修改信息" class="s_btn"  onclick="updateUserInfo();">
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
    </div>
    <%@ include file="/WEB-INF/common/pre/footer.jsp" %>
</div>
</body>
</html>


