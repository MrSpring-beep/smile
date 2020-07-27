<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <META HTTP-EQUIV="pragma" CONTENT="no-cache">
    <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate">
    <META HTTP-EQUIV="expires" CONTENT="Wed, 26 Feb 1997 08:21:57 GMT">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
    <!--[if IE 6]>
    <script src="${pageContext.request.contextPath}/js/iepng.js" type="text/javascript"></script>
        <script type="text/javascript">
           EvPNG.fix('div, ul, img, li, input, a'); 
        </script>
    <![endif]-->

    <style type="text/css">
        *{
            font-family: 楷体;
        }
    </style>

    <script language="javascript">
        //防止页面后退
        history.pushState(null, null, document.URL);
        window.addEventListener('popstate', function () {
            history.pushState(null, null, document.URL);
        });
    </script>

    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.8.2.min.js"></script>
    <script type="text/javascript">
        $(function () {
            $("[name='address1']").focus(function () {
                $("#newAddress").prop("checked",true);
            });
            $("[name='remark']").focus(function () {
                $("#newAddress").prop("checked",true);
            });

        });
        function affirmOrder() {
            var addressId = $("[name='addressId']:checked").val();
            if(addressId==undefined){
                alert("请选择地址");
                return;
            }
            if(addressId=="0"){
                var address = $("[name='address1']").val();
                if(address.trim().length==0){
                    alert("请输入新地址");
                    return;
                }
                var remark = $("[name='remark']").val();
                if(remark.trim().length==0){
                    alert("请输入新地址备注");
                    return;
                }
            }

            var go = Go();

            $("#form").submit();


        }

       /**
        * @return {boolean}
        */
     function Go() {
            location.href="${pageContext.request.contextPath}/indexs.jsp";
            return true;
        }
    </script>
    <script type="text/javascript">

    </script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/menu.js"></script>

    <script type="text/javascript" src="${pageContext.request.contextPath}/js/n_nav.js"></script>

    <script type="text/javascript" src="${pageContext.request.contextPath}/js/select.js"></script>

    <script type="text/javascript" src="${pageContext.request.contextPath}/js/num.js">
        var jq = jQuery.noConflict();
    </script>

    <script type="text/javascript" src="${pageContext.request.contextPath}/js/shade.js"></script>

    <title>尤洪</title>
</head>
<body>
<!--Begin Header Begin-->
<jsp:include page="../common/pre/top.jsp"></jsp:include>

<div id="content">
    <div id="disappare" style="display:none;">
        <h2 style="margin-top: 1px; font-family: 楷体">注意：</h2>
        <p style="margin-top: 15px; font-family: 楷体" id="pp">必须先输入文章名称</p>
    </div>
</div>

<div class="top">
    <div class="logo"><a href="${pageContext.request.contextPath}/index.jsp"><img src="${pageContext.request.contextPath}/images/logo.png"/></a></div>
    <div class="search">
        <form method="post" action="${pageContext.request.contextPath}/productController/findByProductName.do">
            <input type="text" value="" name="name" class="s_ipt" />
            <input type="submit" value="搜索" class="s_btn" />
        </form>
        <span class="fl"><a href="#">咖啡</a><a href="#">iphone 6S</a><a href="#">新鲜美食</a><a href="#">蛋糕</a><a href="#">日用品</a><a
                href="#">连衣裙</a></span>
    </div>
    <div class="i_car">
        <div class="car_t">购物车 [ <span>${productList.size()}</span> ]</div>
        <div class="car_bg">
            <!--Begin 购物车未登录 Begin-->
            <c:if test="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.username != null}">
                <div class="un_login">查看我的购物车！</div>
            </c:if>
            <c:if test="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.username == null}">
                <div class="un_login">还未登录！<a href="${pageContext.request.contextPath}/Login.jsp"
                                              style="color:#ff4e00;">马上登录</a> 查看购物车！
                </div>
            </c:if>
            <!--End 购物车未登录 End-->
            <!--Begin 购物车已登录 Begin-->
            <ul class="cars">
                <c:forEach items="${productList}" var="product">
                    <li>
                        <div class="img"><a href="#"><img
                                src="${pageContext.request.contextPath}/images/${product.fileName}"
                                width="58" height="58"/></a></div>
                        <div class="name"><a href="#">${product.name}</a></div>
                        <div class="price"><font color="#ff4e00">￥${product.price}</font> X${product.count}</div>
                    </li>
                </c:forEach>

            </ul>
            <c:if test="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.username != null}">
                <c:if test="${productList.size()==0}">
                    <div align="center" style="height: 20px;line-height: 20px;font-size: 20px;color: orangered;margin-bottom: 50px; font-family: 楷体;"><b>这里空空如也</b></div>
                </c:if>
                <c:if test="${productList.size()!=0}">
                    <div class="price_sum">共计&nbsp; <font color="#ff4e00">￥</font><span>${totalPrice}</span></div>
                    <div class="price_a"><a href="${pageContext.request.contextPath}/trolley/closeAnAccount.do">去购物车结算</a></div>
                </c:if>
            </c:if>
            <!--End 购物车已登录 End-->
        </div>
    </div>
</div>

<!--End Header End-->
<!--Begin Menu Begin-->
<div class="menu_bg">
    <div class="menu">
        <!--Begin 商品分类详情 Begin-->
        <div class="nav">
            <div class="nav_t">全部商品分类</div>
            <div class="leftNav none">
                <ul id="menu">
                    <c:forEach items="${category1}" var="categroyOne" varStatus="index">
                        <li>
                            <div class="fj">
                                <span class="n_img"><span></span><img
                                        src="${pageContext.request.contextPath}/images/nav${index.count}.png"/></span>
                                <span class="fl">${categroyOne.name}</span>
                            </div>
                            <div class="zj" style="top: -${index.index*40 }px;">
                                <div class="zj_l">
                                    <c:forEach items="${category2}" var="categroyTwo" varStatus="index2">
                                        <c:if test="${categroyTwo.parentId==categroyOne.id}">
                                            <div class="zj_l_c">
                                                <h2><a href="${pageContext.request.contextPath}/product/findByParenCategoryId.do?cateGoryId=${categroyTwo.id}">${categroyTwo.name}</a></h2>
                                                <c:forEach items="${category3}" var="categoryThree" varStatus="index2">
                                                    <c:if test="${categoryThree.parentId==categroyTwo.id}">
                                                        <a href="${pageContext.request.contextPath}/product/findByCategory3Id.do?category3Id=${categoryThree.id}">${categoryThree.name}</a>
                                                    </c:if>
                                                </c:forEach>
                                            </div>
                                        </c:if>
                                    </c:forEach>
                                </div>
                            </div>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </div>
        <!--End 商品分类详情 End-->
        <ul class="menu_r">
            <li><a href="${pageContext.request.contextPath}/index.jsp">首页</a></li>
            <li><a href="${pageContext.request.contextPath}/index.jsp">美食</a></li>
            <li><a href="${pageContext.request.contextPath}/index.jsp">生鲜</a></li>
            <li><a href="${pageContext.request.contextPath}/index.jsp">家居</a></li>
            <li><a href="${pageContext.request.contextPath}/index.jsp">女装</a></li>
            <li><a href="${pageContext.request.contextPath}/index.jsp">美妆</a></li>
            <li><a href="${pageContext.request.contextPath}/index.jsp">数码</a></li>
            <li><a href="${pageContext.request.contextPath}/index.jsp">团购</a></li>
        </ul>
        <div class="m_ad">中秋送好礼！</div>
    </div>
</div>
<!--End Menu End-->
<div class="i_bg">
    <div class="content mar_20">
        <img src="${pageContext.request.contextPath}/images/img2.jpg"/>
    </div>

    <!--Begin 第二步：确认订单信息 Begin -->
    <div class="content mar_20">
        <div class="two_bg">
            <div class="two_t">
                <span class="fr"><a href="${pageContext.request.contextPath}/trolley/closeAnAccount.do">修改</a></span>商品列表
            </div>
            <form action="${pageContext.request.contextPath}/alipaySuccess/submit.do" method="post" id="form">
            <table border="0" class="car_tab" style="width:1110px;" cellspacing="0" cellpadding="0">
                <tr>
                    <td class="car_th" width="550">商品名称</td>
                    <td class="car_th" width="140">属性</td>
                    <td class="car_th" width="150">购买数量</td>
                    <td class="car_th" width="130">小计</td>
                    <td class="car_th" width="140">返还积分</td>
                </tr>
                <c:forEach items="${productList}" var="product">
                    <tr>
                        <td>
                            <div class="c_s_img"><img
                                    src="${pageContext.request.contextPath}/images/${product.fileName}" width="73"
                                    height="73"/></div>
                                ${product.name}
                        </td>
                        <td align="center">颜色：灰色</td>
                        <td align="center">${product.count}</td>
                        <td align="center" style="color:#ff4e00;">￥${product.price*product.count}</td>
                        <td align="center">${product.stock}</td>
                    </tr>
                </c:forEach>
            </table>


            <div class="two_t">
                <span class="fr"></span>收货人信息
            </div>
            <table border="0" class="peo_tab" style="width:1110px;" cellspacing="0" cellpadding="0">
                <tr>
                    <td class="p_td" width="160">用户名称</td>
                    <td width="395">
                        ${sessionScope.user.userName}
                    </td>
                    <td class="p_td" width="160">电子邮件</td>
                    <td width="395" id="temail">${sessionScope.user.email}</td>
                </tr>
                <tr>
                    <td class="p_td">手机</td>
                    <td name="phone">${sessionScope.user.mobile}</td>
                    <td class="p_td">登录名称</td>
                    <td>${sessionScope.user.loginName}</td>
                </tr>
            </table>

                <div class="two_t">
                    <span class="fr"></span>选择地址
                </div>
                <table border="0" class="peo_tab" style="width:1110px;" cellspacing="0" cellpadding="0">
                    <c:forEach items="${userAddress}" var="addres">
                        <tr>
                            <td class="p_td" width="100">${addres.remark}<input type="radio" name="addressId" <c:if test="${addres.isDefault==1}"> checked </c:if> value="${addres.id}"/></td>
                            <td width="395">
                                   <input maxlength="500" style="width: 400px;border: 0 white;outline:medium" readonly name="address" value="${addres.address}"/>
                            </td>
                        </tr>
                    </c:forEach>

                    <c:if test="${userAddress==null or userAddress.size()==0}">
                         <tr>
                            <td class="p_td">新地址<input type="radio" name="addressId"  checked value="0"/></td>
                            <td id="taddress" >地址:<input type="text" name="address1" />&nbsp;&nbsp;备注:<input type="text" name="remark"/></td>
                        </tr>
                    </c:if>
                    <c:if test="${userAddress==null or userAddress.size()!=0}">
                        <tr>
                            <td class="p_td">新地址<input type="radio" name="addressId"  value="0"/></td>
                            <td id="taddress" >地址:<input type="text" name="address1" />&nbsp;&nbsp;备注:<input type="text" name="remark"/></td>
                        </tr>
                    </c:if>
                </table>



            <div class="two_t">
                支付方式
            </div>
            <ul class="pay">
                <li class="checked">支付宝
                    <div class="ch_img"></div>
                </li>

            </ul>

            <table border="0" style="width:900px; margin-top:20px;" cellspacing="0" cellpadding="0">
<%--                <tr>--%>
<%--                    <td align="right">--%>
<%--                        该订单完成后，您将获得 <font color="#ff4e00">1815</font> 积分 ，以及价值 <font color="#ff4e00">￥0.00</font> 的红包--%>
<%--                        <br/>--%>
<%--                        商品总价: <font color="#ff4e00">￥1815.00</font> + 配送费用: <font color="#ff4e00">￥15.00</font>--%>
<%--                    </td>--%>
<%--                </tr>--%>
                <tr height="70">
                    <td align="right">
                        <b style="font-size:14px;">应付款金额：<span
                                style="font-size:22px; color:#ff4e00;">￥${totalPrice}</span></b>
                    </td>
                    <input type="hidden" name="totalPrice" value="${totalPrice}" />
                </tr>
                <tr height="70">
                    <td align="right"><a href="javascript:void(0)" onclick="affirmOrder()"><img
                            src="${pageContext.request.contextPath}/images/btn_sure.gif"/></a></td>
                </tr>
            </table>
            </form>


        </div>
    </div>
    <!--End 第二步：确认订单信息 End-->


    <!--Begin Footer Begin -->
    <div class="b_btm_bg bg_color">
        <div class="b_btm">
            <table border="0" style="width:210px; height:62px; float:left; margin-left:75px; margin-top:30px;"
                   cellspacing="0" cellpadding="0">
                <tr>
                    <td width="72"><img src="${pageContext.request.contextPath}/images/b1.png" width="62" height="62"/>
                    </td>
                    <td><h2>正品保障</h2>正品行货 放心购买</td>
                </tr>
            </table>
            <table border="0" style="width:210px; height:62px; float:left; margin-left:75px; margin-top:30px;"
                   cellspacing="0" cellpadding="0">
                <tr>
                    <td width="72"><img src="${pageContext.request.contextPath}/images/b2.png" width="62" height="62"/>
                    </td>
                    <td><h2>满38包邮</h2>满38包邮 免运费</td>
                </tr>
            </table>
            <table border="0" style="width:210px; height:62px; float:left; margin-left:75px; margin-top:30px;"
                   cellspacing="0" cellpadding="0">
                <tr>
                    <td width="72"><img src="${pageContext.request.contextPath}/images/b3.png" width="62" height="62"/>
                    </td>
                    <td><h2>天天低价</h2>天天低价 畅选无忧</td>
                </tr>
            </table>
            <table border="0" style="width:210px; height:62px; float:left; margin-left:75px; margin-top:30px;"
                   cellspacing="0" cellpadding="0">
                <tr>
                    <td width="72"><img src="${pageContext.request.contextPath}/images/b4.png" width="62" height="62"/>
                    </td>
                    <td><h2>准时送达</h2>收货时间由你做主</td>
                </tr>
            </table>
        </div>
    </div>
    <div class="b_nav">
        <dl>
            <dt><a href="#">新手上路</a></dt>
            <dd><a href="#">售后流程</a></dd>
            <dd><a href="#">购物流程</a></dd>
            <dd><a href="#">订购方式</a></dd>
            <dd><a href="#">隐私声明</a></dd>
            <dd><a href="#">推荐分享说明</a></dd>
        </dl>
        <dl>
            <dt><a href="#">配送与支付</a></dt>
            <dd><a href="#">货到付款区域</a></dd>
            <dd><a href="#">配送支付查询</a></dd>
            <dd><a href="#">支付方式说明</a></dd>
        </dl>
        <dl>
            <dt><a href="#">会员中心</a></dt>
            <dd><a href="#">资金管理</a></dd>
            <dd><a href="#">我的收藏</a></dd>
            <dd><a href="#">我的订单</a></dd>
        </dl>
        <dl>
            <dt><a href="#">服务保证</a></dt>
            <dd><a href="#">退换货原则</a></dd>
            <dd><a href="#">售后服务保证</a></dd>
            <dd><a href="#">产品质量保证</a></dd>
        </dl>
        <dl>
            <dt><a href="#">联系我们</a></dt>
            <dd><a href="#">网站故障报告</a></dd>
            <dd><a href="#">购物咨询</a></dd>
            <dd><a href="#">投诉与建议</a></dd>
        </dl>
        <div class="b_tel_bg">
            <a href="#" class="b_sh1">新浪微博</a>
            <a href="#" class="b_sh2">腾讯微博</a>
            <p>
                服务热线：<br/>
                <span>400-123-4567</span>
            </p>
        </div>
        <div class="b_er">
            <div class="b_er_c"><img src="${pageContext.request.contextPath}/images/er.gif" width="118" height="118"/>
            </div>
            <img src="${pageContext.request.contextPath}/images/ss.png"/>
        </div>
    </div>
    <div class="btmbg">
        <div class="btm">
            备案/许可证编号：蜀ICP备12009302号-1-www.dingguagua.com Copyright © 2015-2018 尤洪商城网 All Rights Reserved. 复制必究 ,
            Technical Support: Dgg Group <br/>
            <img src="${pageContext.request.contextPath}/images/b_1.gif" width="98" height="33"/><img
                src="${pageContext.request.contextPath}/images/b_2.gif" width="98" height="33"/><img
                src="${pageContext.request.contextPath}/images/b_3.gif" width="98" height="33"/><img
                src="${pageContext.request.contextPath}/images/b_4.gif" width="98" height="33"/><img
                src="${pageContext.request.contextPath}/images/b_5.gif" width="98" height="33"/><img
                src="${pageContext.request.contextPath}/images/b_6.gif" width="98" height="33"/>
        </div>
    </div>
    <!--End Footer End -->
</div>

</body>


<!--[if IE 6]>
<script src="//letskillie6.googlecode.com/svn/trunk/2/zh_CN.js"></script>
<![endif]-->
</html>
