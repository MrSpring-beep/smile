<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.8.2.min.js"></script>
<script type="text/javascript">
    $(function () {
       <c:if test="${sessionScope.user==null}">
            <c:if test="${sessionScope.isOne!=1}">
                location.reload();
                location.href="${ctx}/news/findNewList.do";
            </c:if>
        </c:if>
    });
</script>
<div class="m_left">
    <div class="left_n">管理中心</div>
    <c:if test="${sessionScope.user!=null}">
    <div class="left_m">
        <div class="left_m_t t_bg1">订单中心</div>
        <ul>
            <li><a href="${pageContext.request.contextPath}/order/findByUserId.do" <c:if test="${menu==1}"> class="now" </c:if>>我的订单</a></li>
        	<c:if test="${sessionScope.user.type==1 or sessionScope.user.type==2}">
        		<li><a href="${ctx}/order/findOrderAll.do" <c:if test="${menu==9}"> class="now" </c:if>>全部订单</a></li>
        	</c:if>
        </ul>
    </div>
    </c:if>
    <c:if test="${sessionScope.user!=null}">
    <div class="left_m">
        <div class="left_m_t t_bg2">会员中心</div>
        <ul>
                <li><a href="${ctx}/backstage/redirectUserInfoJSP.do"  <c:if test="${menu==2}"> class="now" </c:if> >用户信息</a></li>
                <li><a href="${ctx}/backstage/findUserAddress.do"  <c:if test="${menu==99}"> class="now" </c:if> >收货地址</a></li>
            <c:if test="${sessionScope.user.type==1 or sessionScope.user.type==2}">
            	<li><a href="${pageContext.request.contextPath}/userInfo/findUserAll.do"  <c:if test="${menu==8}"> class="now" </c:if>>用户列表</a></li>
            </c:if>
        </ul>
    </div>
    </c:if>
    <c:if test="${sessionScope.user.type==1 or sessionScope.user.type==2}">
    <div class="left_m">
        <div class="left_m_t t_bg2">商品管理</div>
        <ul>
            <li><a href="${ctx}/product/findCategoryAll.do" <c:if test="${menu==4}"> class="now" </c:if>>分类管理</a></li>
            <li><a href="${ctx}/product/findProductAll.do"  <c:if test="${menu==5}"> class="now" </c:if>>商品管理</a></li>
            <li><a href="${ctx}/backstage/redirectToAddProductAdd.do" <c:if test="${menu==6}"> class="now" </c:if>>商品上架</a></li>
        </ul>
    </div>
    </c:if>
    <div class="left_m">
        <div class="left_m_t t_bg2">资讯中心</div>
        <ul>
            <li><a href="${ctx}/news/findNewList.do"<c:if test="${menu==7}"> class="now" </c:if>>资讯列表</a></li>
        </ul>
    </div>
</div>