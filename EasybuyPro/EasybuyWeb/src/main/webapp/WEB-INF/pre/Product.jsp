<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
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
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
    <!--[if IE 6]>
    <script src="${pageContext.request.contextPath}/js/iepng.js" type="text/javascript"></script>
        <script type="text/javascript">
           EvPNG.fix('div, ul, img, li, input, a'); 
        </script>
    <![endif]-->

    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/ShopShow.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/MagicZoom.css"/>


    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.8.2.min.js"></script>
    <script type="text/javascript">
        var loginState = "";

        if (${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.username != null}) {
            loginState = "${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.username}";
        }

        function saveProductTrolley(object) {
            if (loginState == null || loginState == "") {
                $("#pp").html("请您TM的先登录呢!!!");
                $("#disappare").show().delay(3000).fadeOut(300);
                return;
            }

            var count = $(".n_ipt").val();

            $.post("${pageContext.request.contextPath}/trolley/saveProductTrolley.do", {
                "productId": object,
                "count": count
            }, function (data) {
                if (data > 0) {
                    alert("商品已添加到购物车");
                    //刷新购物车
                    location.href = "${pageContext.request.contextPath}/product/findByProductId.do?productId=" +${product.id};
                }
            })
        }

        function invernChenge(ThisVal,stock) {
            if(ThisVal.value>stock){
                alert("库存不足");
                ThisVal.value=1;
                return;
            }
            if (ThisVal.value<1){
                alert("不能这个样子");
                ThisVal.value=1;
                return;
            }
        }
    </script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/num.js">
        var jq = jQuery.noConflict();
    </script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/lrscroll_1.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/n_nav.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/menu.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/MagicZoom.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/p_tab.js"></script>

    <script type="text/javascript" src="${pageContext.request.contextPath}/js/shade.js"></script>


    <title>尤洪</title>
</head>
<body>
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
                                src="${pageContext.request.contextPath}/images/${product.fileName}" width="58"
                                height="58"/></a></div>
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
        </div>
    </div>
</div>

<!--Begin Header Begin-->
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
    <div class="postion">
    </div>
    <div class="content">

        <div id="tsShopContainer">
            <div id="tsImgS"><a href="${pageContext.request.contextPath}/images/${product.fileName}" title="Images"
                                class="MagicZoom" id="MagicZoom"><img
                    src="${pageContext.request.contextPath}/images/${product.fileName}" width="390" height="390"/></a>
            </div>
            <div id="tsPicContainer">
                <div id="tsImgSArrL" onclick="tsScrollArrLeft()"></div>
                <div id="tsImgSCon">
                    <ul>
                        <li onclick="showPic(0)" rel="MagicZoom" class="tsSelectImg"><img
                                src="${pageContext.request.contextPath}/images/${product.fileName}"
                                tsImgS="${pageContext.request.contextPath}/images/${product.fileName}" width="79"
                                height="79"/></li>
                        <li onclick="showPic(1)" rel="MagicZoom"><img
                                src="${pageContext.request.contextPath}/images/ps2.jpg"
                                tsImgS="${pageContext.request.contextPath}/images/ps2.jpg" width="79" height="79"/></li>
                        <li onclick="showPic(2)" rel="MagicZoom"><img
                                src="${pageContext.request.contextPath}/images/ps3.jpg"
                                tsImgS="${pageContext.request.contextPath}/images/ps3.jpg" width="79" height="79"/></li>
                        <li onclick="showPic(3)" rel="MagicZoom"><img
                                src="${pageContext.request.contextPath}/images/ps4.jpg"
                                tsImgS="${pageContext.request.contextPath}/images/ps4.jpg" width="79" height="79"/></li>
                        <li onclick="showPic(4)" rel="MagicZoom"><img
                                src="${pageContext.request.contextPath}/images/ps1.jpg"
                                tsImgS="${pageContext.request.contextPath}/images/ps1.jpg" width="79" height="79"/></li>
                        <li onclick="showPic(5)" rel="MagicZoom"><img
                                src="${pageContext.request.contextPath}/images/ps2.jpg"
                                tsImgS="${pageContext.request.contextPath}/images/ps2.jpg" width="79" height="79"/></li>
                        <li onclick="showPic(6)" rel="MagicZoom"><img
                                src="${pageContext.request.contextPath}/images/ps3.jpg"
                                tsImgS="${pageContext.request.contextPath}/images/ps3.jpg" width="79" height="79"/></li>
                        <li onclick="showPic(7)" rel="MagicZoom"><img
                                src="${pageContext.request.contextPath}/images/ps4.jpg"
                                tsImgS="${pageContext.request.contextPath}/images/ps4.jpg" width="79" height="79"/></li>
                    </ul>
                </div>
                <div id="tsImgSArrR" onclick="tsScrollArrRight()"></div>
            </div>
            <img class="MagicZoomLoading" width="16" height="16"
                 src="${pageContext.request.contextPath}/images/loading.gif" alt="Loading..."/>
        </div>

        <div class="pro_des">
            <div class="des_name">
                <p>${product.name}</p>
                “开业巨惠，北京专柜直供”，不光低价，“真”才靠谱！
                <p>商品积分：<span>${product.stock}</span></p>
            </div>
            <div class="des_price">
                本店价格：<b>${product.price}</b><br/>
                商品库存：<span>${product.inventory}</span><br/>

            </div>
            <div class="des_choice">
                <span class="fl">型号选择：</span>
                <ul>
                    <li class="checked">30ml
                        <div class="ch_img"></div>
                    </li>
                    <li>50ml
                        <div class="ch_img"></div>
                    </li>
                    <li>100ml
                        <div class="ch_img"></div>
                    </li>
                </ul>
            </div>
            <div class="des_choice">
                <span class="fl">颜色选择：</span>
                <ul>
                    <li>红色
                        <div class="ch_img"></div>
                    </li>
                    <li class="checked">白色
                        <div class="ch_img"></div>
                    </li>
                    <li>黑色
                        <div class="ch_img"></div>
                    </li>
                </ul>
            </div>
            <div class="des_share">
                <div class="d_sh">
                    分享
                    <div class="d_sh_bg">
                        <a href="#"><img src="${pageContext.request.contextPath}/images/sh_1.gif"/></a>
                        <a href="#"><img src="${pageContext.request.contextPath}/images/sh_2.gif"/></a>
                        <a href="#"><img src="${pageContext.request.contextPath}/images/sh_3.gif"/></a>
                        <a href="#"><img src="${pageContext.request.contextPath}/images/sh_4.gif"/></a>
                        <a href="#"><img src="${pageContext.request.contextPath}/images/sh_5.gif"/></a>
                    </div>
                </div>
                <div class="d_care"><a onclick="ShowDiv('MyDiv','fade')">关注商品</a></div>
            </div>
            <div class="des_join">
                <div class="j_nums">
                    <input type="text" value="1" name="" class="n_ipt" onchange="invernChenge(this,${product.inventory})"/>
                    <input type="button" value="" onclick="addUpdate(jq(this));" class="n_btn_1"/>
                    <input type="button" value="" onclick="jianUpdate(jq(this));" class="n_btn_2"/>
                </div>
                <span class="fl"><a href="javascript:void(0)" onclick="saveProductTrolley(${product.id})"><img
                        src="${pageContext.request.contextPath}/images/j_car.png"/></a></span>
            </div>
        </div>

        <div class="s_brand">
            <div class="s_brand_img"><img src="${pageContext.request.contextPath}/images/sbrand.jpg" width="188"
                                          height="132"/></div>
            <div class="s_brand_c"><a href="#">进入品牌专区</a></div>
        </div>


    </div>


    <!--Begin 弹出层-收藏成功 Begin-->
    <div id="fade" class="black_overlay"></div>
    <div id="MyDiv" class="white_content">
        <div class="white_d">
            <div class="notice_t">
                <span class="fr" style="margin-top:10px; cursor:pointer;" onclick="CloseDiv('MyDiv','fade')"><img
                        src="${pageContext.request.contextPath}/images/close.gif"/></span>
            </div>
            <div class="notice_c">

                <table border="0" align="center" style="margin-top:;" cellspacing="0" cellpadding="0">
                    <tr valign="top">
                        <td width="40"><img src="${pageContext.request.contextPath}/images/suc.png"/></td>
                        <td>
                            <span style="color:#3e3e3e; font-size:18px; font-weight:bold;">您已成功收藏该商品</span><br/>
                            <a href="#">查看我的关注 >></a>
                        </td>
                    </tr>
                    <tr height="50" valign="bottom">
                        <td>&nbsp;</td>
                        <td><a href="#" class="b_sure">确定</a></td>
                    </tr>
                </table>

            </div>
        </div>
    </div>
    <!--End 弹出层-收藏成功 End-->


    <!--Begin 弹出层-加入购物车 Begin-->
    <div id="fade1" class="black_overlay"></div>
    <div id="MyDiv1" class="white_content">
        <div class="white_d">
            <div class="notice_t">
                <span class="fr" style="margin-top:10px; cursor:pointer;" onclick="CloseDiv_1('MyDiv1','fade1')"><img
                        src="${pageContext.request.contextPath}/images/close.gif"/></span>
            </div>
            <div class="notice_c">

                <table border="0" align="center" style="margin-top:;" cellspacing="0" cellpadding="0">
                    <tr valign="top">
                        <td width="40"><img src="${pageContext.request.contextPath}/images/suc.png"/></td>
                        <td>
                            <span style="color:#3e3e3e; font-size:18px; font-weight:bold;">宝贝已成功添加到购物车</span><br/>
                            购物车共有1种宝贝（3件） &nbsp; &nbsp; 合计：1120元
                        </td>
                    </tr>
                    <tr height="50" valign="bottom">
                        <td>&nbsp;</td>
                        <td><a href="#" class="b_sure">去购物车结算</a><a href="#" class="b_buy">继续购物</a></td>
                    </tr>
                </table>

            </div>
        </div>
    </div>
    <!--End 弹出层-加入购物车 End-->


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

<script src="${pageContext.request.contextPath}/js/ShopShow.js"></script>

<!--[if IE 6]>
<script src="//letskillie6.googlecode.com/svn/trunk/2/zh_CN.js"></script>
<![endif]-->
</html>
