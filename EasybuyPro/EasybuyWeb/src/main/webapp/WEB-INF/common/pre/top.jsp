<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" />
    <!--[if IE 6]>
    <script src="${pageContext.request.contextPath}/js/iepng.js" type="text/javascript"></script>
    <script type="text/javascript">
        EvPNG.fix('div, ul, img, li, input, a');
    </script>
    <![endif]-->
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.1.min_044d0927.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.bxslider_e88acd1b.js"></script>

    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.8.2.min.js"></script>
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
    <script type="text/javascript">
       function exit() {
           if(confirm("确定退出吗?")){
               location.href="${pageContext.request.contextPath}/logout.do";
           }
       }
    </script>
<head>
    <title>尤洪</title>
</head>
<body>

<div class="soubg">
    <div class="sou">
        <!--Begin 所在收货地区 Begin-->
        <span class="s_city_b">
        	<span class="fl">送货至：</span>
            <span class="s_city">
            	<span>四川</span>
                <div class="s_city_bg">
                	<div class="s_city_t"></div>
                    <div class="s_city_c">
                    	<h2>请选择所在的收货地区</h2>
                        <table border="0" class="c_tab" style="width:235px; margin-top:10px;" cellspacing="0" cellpadding="0">
                          <tr>
                            <th>A</th>
                            <td class="c_h"><span>安徽</span><span>澳门</span></td>
                          </tr>
                          <tr>
                            <th>B</th>
                            <td class="c_h"><span>北京</span></td>
                          </tr>
                          <tr>
                            <th>C</th>
                            <td class="c_h"><span>重庆</span></td>
                          </tr>
                          <tr>
                            <th>F</th>
                            <td class="c_h"><span>福建</span></td>
                          </tr>
                          <tr>
                            <th>G</th>
                            <td class="c_h"><span>广东</span><span>广西</span><span>贵州</span><span>甘肃</span></td>
                          </tr>
                          <tr>
                            <th>H</th>
                            <td class="c_h"><span>河北</span><span>河南</span><span>黑龙江</span><span>海南</span><span>湖北</span><span>湖南</span></td>
                          </tr>
                          <tr>
                            <th>J</th>
                            <td class="c_h"><span>江苏</span><span>吉林</span><span>江西</span></td>
                          </tr>
                          <tr>
                            <th>L</th>
                            <td class="c_h"><span>辽宁</span></td>
                          </tr>
                          <tr>
                            <th>N</th>
                            <td class="c_h"><span>内蒙古</span><span>宁夏</span></td>
                          </tr>
                          <tr>
                            <th>Q</th>
                            <td class="c_h"><span>青海</span></td>
                          </tr>
                          <tr>
                            <th>S</th>
                            <td class="c_h"><span>上海</span><span>山东</span><span>山西</span><span class="c_check">四川</span><span>陕西</span></td>
                          </tr>
                          <tr>
                            <th>T</th>
                            <td class="c_h"><span>台湾</span><span>天津</span></td>
                          </tr>
                          <tr>
                            <th>X</th>
                            <td class="c_h"><span>西藏</span><span>香港</span><span>新疆</span></td>
                          </tr>
                          <tr>
                            <th>Y</th>
                            <td class="c_h"><span>云南</span></td>
                          </tr>
                          <tr>
                            <th>Z</th>
                            <td class="c_h"><span>浙江</span></td>
                          </tr>
                        </table>
                    </div>
                </div>
            </span>
        </span>

        <!--End 所在收货地区 End-->
        <span class="fr">
            <c:if test="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.username != null}">
                <span class="fl"><a href="${pageContext.request.contextPath}/index.jsp">首页&nbsp;</a>你好，<span> ${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.username}</span>    <a href="${pageContext.request.contextPath}/order/findByUserId.do">我的订单</a></span>
                <c:if test="${sessionScope.user.type==1}">
                    <span>|<a href="${pageContext.request.contextPath}/backstage/redirectUserInfoJSP.do">后台管理</a></span>
                </c:if>
            </c:if>
            <c:if test="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.username == null}">
                <span class="fl"><a href="${pageContext.request.contextPath}/index.jsp">首页</a> 你好，请<a href="${pageContext.request.contextPath}/Login.jsp">登录</a>&nbsp; <a href="${pageContext.request.contextPath}/Regist.jsp" style="color:#ff4e00;">立即注册</a></span>
            </c:if>

            <c:if test="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.username != null}">
                <span class="fl">|&nbsp;<a href="javascript:void (0)" onclick="exit()">退出&nbsp;</a></span>
            </c:if>
        </span>
    </div>
</div>

</body>
</html>
