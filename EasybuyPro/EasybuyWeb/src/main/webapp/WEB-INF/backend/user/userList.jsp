<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<%--    <%@ include file="/WEB-INF/common/pre/header.jsp" %>--%>
    <script src="${ctx}/js/backend/backend.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.4.2.min.js"></script>
    <script type="text/javascript">
        function deleteUserId(object) {
            if(confirm("确定删除吗？")){
                location.href="${pageContext.request.contextPath}/userInfo/deleteUserId.do?userId="+object;
                alert("删除成功");
            }
        }
    </script>

</head>
<body>
<!--End Header End-->
<jsp:include page="/WEB-INF/common/pre/top.jsp"></jsp:include>
<jsp:include page="/WEB-INF/common/pre/trolley.jsp"></jsp:include>
<%--<%@ include file="/WEB-INF/common/backend/searchBar.jsp" %>--%>
<div class="i_bg bg_color">
    <!--Begin 用户中心 Begin -->
    <div class="m_content">
        <%@ include file="/WEB-INF/common/backend/leftBar.jsp" %>
        <div class="m_right" id="content">
            <div class="mem_tit">用户列表</div>
            <div class="search" style="margin-top: -5px">
                <form method="post" action="${pageContext.request.contextPath}/userInfo/findUserAll.do">
                    <input type="text" name="userName" value="" class="s_ipt" placeholder="用户名称" />
                    <input type="submit" value="搜索" class="s_btn" />
                </form>
            </div>
            <p align="right">
                <a href="${pageContext.request.contextPath}/backstage/redirectUserAdd.do"  class="add_b">添加用户</a>
                <br>
            </p>
            <br>
            <table border="0" class="order_tab" style="width:930px; text-align:center; margin-bottom:30px;"
                   cellspacing="0" cellpadding="0">
                <tbody>
                <tr>
                    <td width="10%">用户名称</td>
                    <td width="10%">真实姓名</td>
                    <td width="5%">性别</td>
                    <td width="5%">类型</td>
                    <td width="5%" colspan="2">操作</td>
                </tr>
                <c:forEach items="${pageInfo.list}" var="userInfo">
                    <c:if test="${userInfo.userName==sessionScope.user.userName}">
                        <tr style="color:#ff4e00;">
                            <td>${userInfo.loginName}</td>
                            <td>${userInfo.userName}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${userInfo.sex==1}">
                                        男
                                    </c:when>
                                    <c:otherwise>
                                        女
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${userInfo.type==1}">
                                        管理员
                                    </c:when>
                                    <c:when test="${userInfo.type==2}">
                                        超级管理员
                                    </c:when>
                                    <c:otherwise>
                                        用户
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:if test="${userInfo.type!=1 or sessionScope.user.id==userInfo.id}">
                                    <a href="${pageContext.request.contextPath}/backstage/redirectUserUpdate.do?loginName=${userInfo.loginName}">修改</a>
                                </c:if>
                            </td>
                            <td>
                                <c:if test="${sessionScope.user.id!=userInfo.id and userInfo.type!=1}">
                                    <a href="javascript:void(0);" onclick="deleteUserId('${userInfo.id}');">删除</a>
                                </c:if>
                            </td>
                        </tr>
                    </c:if>
                    <c:if test="${userInfo.userName!=sessionScope.user.userName}">
                    <tr>
                        <td>${userInfo.loginName}</td>
                        <td>${userInfo.userName}</td>
                        <td>
                            <c:choose>
                                <c:when test="${userInfo.sex==1}">
                                    男
                                </c:when>
                                <c:otherwise>
                                    女
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${userInfo.type==1}">
                                    管理员
                                </c:when>
                                <c:otherwise>
                                    用户
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:if test="${userInfo.type!=1 or sessionScope.user.id==userInfo.id}">
                                <a href="${pageContext.request.contextPath}/backstage/redirectUserUpdate.do?loginName=${userInfo.loginName}">修改</a>
                            </c:if>
                            <c:if test="${sessionScope.user.type==2 and userInfo.type!=0}">
                                <a href="${pageContext.request.contextPath}/backstage/redirectUserUpdate.do?loginName=${userInfo.loginName}">修改</a>
                            </c:if>
                        </td>
                        <td>
                        	<c:if test="${sessionScope.user.id!=userInfo.id and userInfo.type!=1}">
                           	    <a href="javascript:void(0);" onclick="deleteUserId('${userInfo.id}');">删除</a>
                        	</c:if>
                            <c:if test="${sessionScope.user.type==2 and userInfo.type!=0}">
                                <a href="javascript:void(0);" onclick="deleteUserId('${userInfo.id}');">删除</a>
                            </c:if>
                        </td>
                    </tr>
                    </c:if>
                </c:forEach>
                </tbody>
            </table>
            <%@ include file="/WEB-INF/common/pre/pagerBar.jsp" %>
        </div>
    </div>
    <%@ include file="/WEB-INF/common/pre/footer.jsp" %>
</div>
</body>
</html>


