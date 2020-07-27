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


<title>尤洪</title>
</head>
<body>
<div id="top">
<%@include file="../common/pre/top.jsp"%>
</div>

<div class="top">
    <div class="logo"><a href="${pageContext.request.contextPath}/index.jsp"><img src="${pageContext.request.contextPath}/images/logo.png" /></a></div>
    <div class="search">
        <form method="post" action="${pageContext.request.contextPath}/productController/findByProductName.do">
            <input type="text" value="" name="name" class="s_ipt" />
            <input type="submit" value="搜索" class="s_btn" />
        </form>
        <span class="fl"><a href="#">咖啡</a><a href="#">iPhone 11Pro Max</a><a href="#">新鲜美食</a><a href="#">蛋糕</a><a href="#">日用品</a><a href="#">连衣裙</a></span>
    </div>
    <div class="i_car">
        <div class="car_t">购物车 [ <span>${productList.size()}</span> ]</div>
        <div class="car_bg">
            <!--Begin 购物车未登录 Begin-->
            <c:if test="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.username != null}">
                <div class="un_login">查看我的购物车！</div>
            </c:if>
            <c:if test="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.username == null}">
                <div class="un_login">还未登录！<a href="${pageContext.request.contextPath}/Login.jsp" style="color:#ff4e00;">马上登录</a> 查看购物车！</div>
            </c:if>
            <!--End 购物车未登录 End-->
            <!--Begin 购物车已登录 Begin-->
            <ul class="cars">
                <c:forEach items="${productList}" var="product">
                    <li>
                        <div class="img"><a href="#"><img src="${pageContext.request.contextPath}/images/${product.fileName}" width="58" height="58" /></a></div>
                        <div class="name"><a href="#">${product.name}</a></div>
                        <div class="price"><font color="#ff4e00">￥${product.price}</font> X${product.count}</div>
                    </li>
                </c:forEach>

            </ul>


            <c:if test="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.username != null}">
                <c:if test="${productList.size()==0 or productList==null}">
                    <div align="center" style="height: 20px;line-height: 20px;font-size: 20px;color: orangered;margin-bottom: 50px; font-family: 楷体;"><b>这里空空如也</b></div>
                </c:if>
                <c:if test="${productList.size()!=0 and productList!=null}">
                    <div class="price_sum">共计&nbsp; <font color="#ff4e00">￥</font><span>${totalPrice}</span></div>
                    <div class="price_a"><a href="${pageContext.request.contextPath}/trolley/closeAnAccount.do">去购物车结算</a></div>
                </c:if>
            </c:if>-
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
            <div class="leftNav">
                <ul id="menu">
                    <c:forEach items="${category1}" var="categroyOne" varStatus="index">
                        <li>
                            <div class="fj">
                                <span class="n_img"><span></span><img src="${pageContext.request.contextPath}/images/nav${index.count}.png" /></span>
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
            <li><a href="#1">化妆品</a></li>
            <li><a href="#2">家用商品</a></li>
            <li><a href="#3">生鲜</a></li>
            <li><a href="#4">电子商品</a></li>
            <li><a href="#5">保健食品</a></li>
            <li><a href="#6">箱包</a></li>
            <li><a href="GroupBuying.jsp">团购</a></li>
        </ul>
        <div class="m_ad">中秋送好礼！</div>
    </div>
</div>

<!--End Menu End-->
<div class="i_bg bg_color">
	<div class="i_ban_bg">
		<!--Begin Banner Begin-->
    	<div class="banner">
            <div class="top_slide_wrap">
                <ul class="slide_box bxslider">
                    <li><img src="${pageContext.request.contextPath}/images/7c3bbc604f4cbc3a.jpg!q90.webp" width="740" height="401" /></li>
                    <li><img src="${pageContext.request.contextPath}/images/3d6d62156da8064f.jpg!q80.webp" width="740" height="401" /></li>
                    <li><img src="${pageContext.request.contextPath}/images/b37126e3509b12ed.jpg!cc_1980x1014.webp" width="740" height="401" /></li>
                </ul>
                <div class="op_btns clearfix">
                    <a href="#" class="op_btn op_prev"><span></span></a>
                    <a href="#" class="op_btn op_next"><span></span></a>
                </div>
            </div>
        </div>
        <script type="text/javascript">
        //var jq = jQuery.noConflict();
        (function(){
            $(".bxslider").bxSlider({
                auto:true,
                prevSelector:jq(".top_slide_wrap .op_prev")[0],nextSelector:jq(".top_slide_wrap .op_next")[0]
            });
        })();
        </script>
        <!--End Banner End-->
        <div class="inews">
        	<div class="news_t">
            	<span class="fr"><a href="${pageContext.request.contextPath}/news/findNewList.do">更多 ></a></span>新闻资讯
            </div>
            <ul>
                <c:forEach items="${news}" var="newso" varStatus="num">
                   <c:if test="${num.index<5}">
                       <li><span>[ 特惠 ]</span><a href="javascript:void(0)">${newso.content}</a></li>
                   </c:if>
                </c:forEach>
            </ul>
            <div class="charge_t">
            	话费充值<div class="ch_t_icon"></div>
            </div>
            <form>
            <table border="0" style="width:205px; margin-top:10px;" cellspacing="0" cellpadding="0">
              <tr height="35">
                <td width="33">号码</td>
                <td><input type="text" value="" class="c_ipt" /></td>
              </tr>
              <tr height="35">
                <td>面值</td>
                <td>
                	<select class="jj" name="city">
                      <option value="0" selected="selected">100元</option>
                      <option value="1">50元</option>
                      <option value="2">30元</option>
                      <option value="3">20元</option>
                      <option value="4">10元</option>
                    </select>
                    <span style="color:#ff4e00; font-size:14px;">￥99.5</span>
                </td>
              </tr>
              <tr height="35">
                <td colspan="2"><input type="submit" value="立即充值" class="c_btn" /></td>
              </tr>
            </table>
            </form>
        </div>
    </div>
    <!--Begin 热门商品 Begin-->
    <div class="content mar_10">
    	<div class="h_l_img">
        	<div class="img"><img src="${pageContext.request.contextPath}/images/l_img.jpg" width="188" height="188" /></div>
            <div class="pri_bg">
                <span class="price fl">￥53.00</span>
                <span class="fr">16R</span>
            </div>
        </div>
        <div class="hot_pro">
        	<div id="featureContainer">
                <div id="feature">
                    <div id="block">
                        <div id="botton-scroll">
                            <ul class="featureUL">
                                <li class="featureBox">
                                    <div class="box">
                                    	<div class="h_icon"><img src="${pageContext.request.contextPath}/images/hot.png" width="50" height="50" /></div>
                                        <div class="imgbg">
                                        	<a href="#"><img src="${pageContext.request.contextPath}/images/hot1.jpg" width="160" height="136" /></a>
                                        </div>
                                        <div class="name">
                                        	<a href="#">
                                            <h2>德国进口</h2>
                                            德亚全脂纯牛奶200ml*48盒
                                            </a>
                                        </div>
                                        <div class="price">
                                            <font>￥<span>189</span></font> &nbsp; 26R
                                        </div>
                                    </div>
                                </li>
                                <li class="featureBox">
                                    <div class="box">
                                        <div class="h_icon"><img src="${pageContext.request.contextPath}/images/hot.png" width="50" height="50" /></div>
                                        <div class="imgbg">
                                        	<a href="#"><img src="${pageContext.request.contextPath}/images/hot2.jpg" width="160" height="136" /></a>
                                        </div>
                                        <div class="name">
                                        	<a href="#">
                                            <h2>iphone 6S</h2>
                                            Apple/苹果 iPhone 6s Plus公开版
                                            </a>
                                        </div>
                                        <div class="price">
                                            <font>￥<span>5288</span></font> &nbsp; 25R
                                        </div>
                                    </div>
                                </li>
                                <li class="featureBox">
                                    <div class="box">
                                        <div class="h_icon"><img src="${pageContext.request.contextPath}/images/hot.png" width="50" height="50" /></div>
                                        <div class="imgbg">
                                        	<a href="#"><img src="${pageContext.request.contextPath}/images/hot3.jpg" width="160" height="136" /></a>
                                        </div>
                                        <div class="name">
                                        	<a href="#">
                                            <h2>倩碧特惠组合套装</h2>
                                            倩碧补水组合套装8折促销
                                            </a>
                                        </div>
                                        <div class="price">
                                            <font>￥<span>368</span></font> &nbsp; 18R
                                        </div>
                                    </div>
                                </li>
                                <li class="featureBox">
                                    <div class="box">
                                        <div class="h_icon"><img src="${pageContext.request.contextPath}/images/hot.png" width="50" height="50" /></div>
                                        <div class="imgbg">
                                        	<a href="#"><img src="${pageContext.request.contextPath}/images/hot4.jpg" width="160" height="136" /></a>
                                        </div>
                                        <div class="name">
                                        	<a href="#">
                                            <h2>品利特级橄榄油</h2>
                                            750ml*4瓶装组合 西班牙原装进口
                                            </a>
                                        </div>
                                        <div class="price">
                                            <font>￥<span>280</span></font> &nbsp; 30R
                                        </div>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <a class="h_prev" href="javascript:void(0);">Previous</a>
                    <a class="h_next" href="javascript:void(0);">Next</a>
                </div>
            </div>
        </div>
    </div>
    <!--Begin 限时特卖 Begin-->
    <div class="i_t mar_10">
    	<span class="fl">限时特卖</span>
        <span class="i_mores fr"><a href="#">更多</a></span>
    </div>
    <div class="content">
    	<div class="i_sell">
            <div id="imgPlay">
                <ul class="imgs" id="actor">
                    <li><a href="#"><img src="${pageContext.request.contextPath}/images/tm_r.jpg" width="211" height="357" /></a></li>
                    <li><a href="#"><img src="${pageContext.request.contextPath}/images/tm_r.jpg" width="211" height="357" /></a></li>
                    <li><a href="#"><img src="${pageContext.request.contextPath}/images/tm_r.jpg" width="211" height="357" /></a></li>
                </ul>
                <div class="previ">上一张</div>
                <div class="nexti">下一张</div>
            </div>
        </div>
        <div class="sell_right">
        	<div class="sell_1">
            	<div class="s_img"><a href="#"><img src="${pageContext.request.contextPath}/images/tm_1.jpg" width="185" height="155" /></a></div>
            	<div class="s_price">￥<span>89</span></div>
                <div class="s_name">
                	<h2><a href="#">沙宣洗发水</a></h2>
                    倒计时：<span>1200</span> 时 <span>30</span> 分 <span>28</span> 秒
                </div>
            </div>
            <div class="sell_2">
            	<div class="s_img"><a href="#"><img src="${pageContext.request.contextPath}/images/tm_2.jpg" width="185" height="155" /></a></div>
            	<div class="s_price">￥<span>289</span></div>
                <div class="s_name">
                	<h2><a href="#">德芙巧克力</a></h2>
                    倒计时：<span>1200</span> 时 <span>30</span> 分 <span>28</span> 秒
                </div>
            </div>
            <div class="sell_b1">
            	<div class="sb_img"><a href="#"><img src="${pageContext.request.contextPath}/images/tm_b1.jpg" width="242" height="356" /></a></div>
            	<div class="s_price">￥<span>289</span></div>
                <div class="s_name">
                	<h2><a href="#">东北大米</a></h2>
                    倒计时：<span>1200</span> 时 <span>30</span> 分 <span>28</span> 秒
                </div>
            </div>
            <div class="sell_3">
            	<div class="s_img"><a href="#"><img src="${pageContext.request.contextPath}/images/tm_3.jpg" width="185" height="155" /></a></div>
            	<div class="s_price">￥<span>289</span></div>
                <div class="s_name">
                	<h2><a href="#">迪奥香水</a></h2>
                    倒计时：<span>1200</span> 时 <span>30</span> 分 <span>28</span> 秒
                </div>
            </div>
            <div class="sell_4">
            	<div class="s_img"><a href="#"><img src="${pageContext.request.contextPath}/images/tm_4.jpg" width="185" height="155" /></a></div>
            	<div class="s_price">￥<span>289</span></div>
                <div class="s_name">
                	<h2><a href="#">美妆</a></h2>
                    倒计时：<span>1200</span> 时 <span>30</span> 分 <span>28</span> 秒
                </div>
            </div>
            <div class="sell_b2">
            	<div class="sb_img"><a href="#"><img src="${pageContext.request.contextPath}/images/tm_b2.jpg" width="242" height="356" /></a></div>
            	<div class="s_price">￥<span>289</span></div>
                <div class="s_name">
                	<h2><a href="#">美妆</a></h2>
                    倒计时：<span>1200</span> 时 <span>30</span> 分 <span>28</span> 秒
                </div>
            </div>
        </div>
    </div>
    <!--End 限时特卖 End-->
    <div class="content mar_20">
    	<img src="${pageContext.request.contextPath}/images/mban_1.jpg" width="1200" height="110" />
    </div>
	<c:forEach items="${category1}" var="category1" varStatus="num">
        <a name="${num.index+1}">
        <!--Begin 进口 生鲜 Begin-->
        <div class="i_t mar_10">
            <span class="floor_num">${num.index+1}F</span>
            <span class="fl">${category1.name}</span>
        </div>

            <div class="content" >
                <div class="fresh_left">
                    <div class="fre_ban">
                        <div id="imgPlay1">
                            <ul class="imgs" id="actor1">
                                <li><a href="#"><img src="${pageContext.request.contextPath}/images/fre_r.jpg" width="211" height="286" /></a></li>
                                <li><a href="#"><img src="${pageContext.request.contextPath}/images/fre_r.jpg" width="211" height="286" /></a></li>
                                <li><a href="#"><img src="${pageContext.request.contextPath}/images/fre_r.jpg" width="211" height="286" /></a></li>
                            </ul>
                            <div class="prevf">上一张</div>
                            <div class="nextf">下一张</div>
                        </div>
                    </div>
                    <div class="fresh_txt">
                        <div class="fresh_txt_c">
                            <c:forEach items="${category2}" var="category2">
                                <c:if test="${category2.parentId==category1.id}">
                                    <a href="${pageContext.request.contextPath}/product/findByParenCategoryId.do?cateGoryId=${category2.id}">${category2.name}</a>
                                </c:if>
                            </c:forEach>
                        </div>
                    </div>
                </div>

                      <div class="fresh_mid">
                          <ul>
                              <c:forEach items="${productAll}" var="product">
                                  <c:if test="${product.categoryLevel1Id==category1.id}">
                              <li>
                                  <div class="name"><a href="#">${product.name}</a></div>
                                  <div class="price">
                                      <font>￥<span>${product.price}</span></font> &nbsp; ${product.stock}R
                                  </div>
                                  <div class="img"><a href="${pageContext.request.contextPath}/product/findByProductId.do?productId=${product.id}"><img src="${pageContext.request.contextPath}/images/${product.fileName}" width="185" height="155" /></a></div>
                              </li>
                                  </c:if>
                              </c:forEach>
                          </ul>
                      </div>
                      <div class="fresh_right">
                          <ul>
                              <li><a href="#"><img src="${pageContext.request.contextPath}/images/fre_b1.jpg" width="260" height="220" /></a></li>
                              <li><a href="#"><img src="${pageContext.request.contextPath}/images/fre_b2.jpg" width="260" height="220" /></a></li>
                          </ul>
                      </div>



            </div>
        </a>
    </c:forEach>
    <!--End 进口 生鲜 End-->
    <!--Begin 食品饮料 Begin-->


    <!--End 食品饮料 End-->
    <!--Begin 个人美妆 Begin-->

    <!--End 个人美妆 End-->


    <!--End 母婴玩具 End-->
    <!--Begin 家居生活 Begin-->


    <!--End 家居生活 End-->
    <!--Begin 数码家电 Begin-->

    <!--End 数码家电 End-->
    <!--Begin 猜你喜欢 Begin-->
    <div class="i_t mar_10">
    	<span class="fl">猜你喜欢</span>
    </div>
    <div class="like">
        <div id="featureContainer1">
            <div id="feature1">
                <div id="block1">
                    <div id="botton-scroll1">
                        <ul class="featureUL">
                            <li class="featureBox">
                                <div class="box">
                                    <div class="imgbg">
                                        <a href="#"><img src="${pageContext.request.contextPath}/images/hot1.jpg" width="160" height="136" /></a>
                                    </div>
                                    <div class="name">
                                        <a href="#">
                                        <h2>德国进口</h2>
                                        德亚全脂纯牛奶200ml*48盒
                                        </a>
                                    </div>
                                    <div class="price">
                                        <font>￥<span>189</span></font> &nbsp; 26R
                                    </div>
                                </div>
                            </li>
                            <li class="featureBox">
                                <div class="box">
                                    <div class="imgbg">
                                        <a href="#"><img src="${pageContext.request.contextPath}/images/hot2.jpg" width="160" height="136" /></a>
                                    </div>
                                    <div class="name">
                                        <a href="#">
                                        <h2>iphone 6S</h2>
                                        Apple/苹果 iPhone 6s Plus公开版
                                        </a>
                                    </div>
                                    <div class="price">
                                        <font>￥<span>5288</span></font> &nbsp; 25R
                                    </div>
                                </div>
                            </li>
                            <li class="featureBox">
                                <div class="box">
                                    <div class="imgbg">
                                        <a href="#"><img src="${pageContext.request.contextPath}/images/hot3.jpg" width="160" height="136" /></a>
                                    </div>
                                    <div class="name">
                                        <a href="#">
                                        <h2>倩碧特惠组合套装</h2>
                                        倩碧补水组合套装8折促销
                                        </a>
                                    </div>
                                    <div class="price">
                                        <font>￥<span>368</span></font> &nbsp; 18R
                                    </div>
                                </div>
                            </li>
                            <li class="featureBox">
                                <div class="box">
                                    <div class="imgbg">
                                        <a href="#"><img src="${pageContext.request.contextPath}/images/hot4.jpg" width="160" height="136" /></a>
                                    </div>
                                    <div class="name">
                                        <a href="#">
                                        <h2>品利特级橄榄油</h2>
                                        750ml*4瓶装组合 西班牙原装进口
                                        </a>
                                    </div>
                                    <div class="price">
                                        <font>￥<span>280</span></font> &nbsp; 30R
                                    </div>
                                </div>
                            </li>
                            <li class="featureBox">
                                <div class="box">
                                    <div class="imgbg">
                                        <a href="#"><img src="${pageContext.request.contextPath}/images/hot4.jpg" width="160" height="136" /></a>
                                    </div>
                                    <div class="name">
                                        <a href="#">
                                        <h2>品利特级橄榄油</h2>
                                        750ml*4瓶装组合 西班牙原装进口
                                        </a>
                                    </div>
                                    <div class="price">
                                        <font>￥<span>280</span></font> &nbsp; 30R
                                    </div>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
                <a class="l_prev" href="javascript:void();">Previous</a>
                <a class="l_next" href="javascript:void();">Next</a>
            </div>
        </div>
    </div>
    <!--End 猜你喜欢 End-->

    <!--Begin Footer Begin -->
    <div class="b_btm_bg b_btm_c">
        <div class="b_btm">
            <table border="0" style="width:210px; height:62px; float:left; margin-left:75px; margin-top:30px;" cellspacing="0" cellpadding="0">
              <tr>
                <td width="72"><img src="${pageContext.request.contextPath}/images/b1.png" width="62" height="62" /></td>
                <td><h2>正品保障</h2>正品行货  放心购买</td>
              </tr>
            </table>
			<table border="0" style="width:210px; height:62px; float:left; margin-left:75px; margin-top:30px;" cellspacing="0" cellpadding="0">
              <tr>
                <td width="72"><img src="${pageContext.request.contextPath}/images/b2.png" width="62" height="62" /></td>
                <td><h2>满38包邮</h2>满38包邮 免运费</td>
              </tr>
            </table>
            <table border="0" style="width:210px; height:62px; float:left; margin-left:75px; margin-top:30px;" cellspacing="0" cellpadding="0">
              <tr>
                <td width="72"><img src="${pageContext.request.contextPath}/images/b3.png" width="62" height="62" /></td>
                <td><h2>天天低价</h2>天天低价 畅选无忧</td>
              </tr>
            </table>
            <table border="0" style="width:210px; height:62px; float:left; margin-left:75px; margin-top:30px;" cellspacing="0" cellpadding="0">
              <tr>
                <td width="72"><img src="${pageContext.request.contextPath}/images/b4.png" width="62" height="62" /></td>
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
            服务热线：<br />
            <span>400-123-4567</span>
            </p>
        </div>
        <div class="b_er">
            <div class="b_er_c"><img src="${pageContext.request.contextPath}/images/er.gif" width="118" height="118" /></div>
            <img src="${pageContext.request.contextPath}/images/ss.png" />
        </div>
    </div>
    <div class="btmbg">
		<div class="btm">
        	备案/许可证编号：蜀ICP备12009302号-1-www.dingguagua.com   Copyright © 2015-2018 尤洪商城网 All Rights Reserved. 复制必究 , Technical Support: Dgg Group <br />
            <img src="${pageContext.request.contextPath}/images/b_1.gif" width="98" height="33" /><img src="${pageContext.request.contextPath}/images/b_2.gif" width="98" height="33" /><img src="${pageContext.request.contextPath}/images/b_3.gif" width="98" height="33" /><img src="${pageContext.request.contextPath}/images/b_4.gif" width="98" height="33" /><img src="${pageContext.request.contextPath}/images/b_5.gif" width="98" height="33" /><img src="${pageContext.request.contextPath}/images/b_6.gif" width="98" height="33" />
        </div>
    </div>
    <!--End Footer End -->
</div>

</body>


<!--[if IE 6]>
<script src="//letskillie6.googlecode.com/svn/trunk/2/zh_CN.js"></script>
<![endif]-->
</html>

