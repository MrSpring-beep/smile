<%--
  Created by IntelliJ IDEA.
  User: 14804
  Date: 2020/7/11
  Time: 14:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<head>
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" />
    <!--[if IE 6]>
<%--    <script src="${pageContext.request.contextPath}/js/iepng.js" type="text/javascript"></script>--%>
<%--        <script type="text/javascript">--%>
<%--           EvPNG.fix('div, ul, img, li, input, a');--%>
<%--        </script>--%>
    <![endif]-->



    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.8.2.min.js"></script>
    <script>

        jQuery(function () {
            jQuery("#urls").load("${pageContext.request.contextPath}/product/findCategory.do #menu");
        });

    </script>

    <script type="text/javascript" src="${pageContext.request.contextPath}/js/lrscroll_1.js"></script>

    <script type="text/javascript" src="${pageContext.request.contextPath}/js/menu.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/n_nav.js"></script>

    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/ShopShow.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/MagicZoom.css" />
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/MagicZoom.js"></script>

    <script type="text/javascript" src="${pageContext.request.contextPath}/js/num.js">
        var jq = jQuery.noConflict();
    </script>

    <script type="text/javascript" src="${pageContext.request.contextPath}/js/p_tab.js"></script>

    <script type="text/javascript" src="${pageContext.request.contextPath}/js/shade.js"></script>


    <title>Title</title>
</head>
<body>

<!--End Header End-->
<!--Begin Menu Begin-->
<div class="menu_bg">
    <div class="menu">
        <!--Begin 商品分类详情 Begin-->
        <div class="nav">
            <div class="nav_t">全部商品分类</div>
            <div class="leftNav none" id="urls">

            </div>
        </div>
        <!--End 商品分类详情 End-->
        <ul class="menu_r">
            <li><a href="Index.html">首页</a></li>
            <li><a href="Food.html">美食</a></li>
            <li><a href="Fresh.html">生鲜</a></li>
            <li><a href="HomeDecoration.html">家居</a></li>
            <li><a href="SuitDress.html">女装</a></li>
            <li><a href="MakeUp.html">美妆</a></li>
            <li><a href="Digital.html">数码</a></li>
            <li><a href="GroupBuying.html">团购</a></li>
        </ul>
        <div class="m_ad">中秋送好礼！</div>
    </div>
</div>

</body>
</html>
