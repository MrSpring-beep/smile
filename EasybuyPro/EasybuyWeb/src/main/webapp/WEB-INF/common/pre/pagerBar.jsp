<%@ page language="java" contentType="text/html; charset=utf-8"  pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<script type="text/javascript">
    var contextPath = "${ctx}";
</script>
<div class="pages">

<%--      <a href="${ctx}/${pager.url}&currentPage=1" class="p_pre">首页</a>--%>
<%--            <a href="${ctx}/${pager.url}&currentPage=${pager.currentPage-1}" class="p_pre">上一页</a>--%>
<%--                <a href="${ctx}/${pager.url}&currentPage=${temp}" class="cur">${temp}</a>--%>
<%--                <a href="${ctx}/${pager.url}&currentPage=${temp}">${temp}</a>--%>


<%--         <a href="${ctx}/${pager.url}&currentPage=${pager.currentPage+1}" class="p_pre">下一页</a>--%>

<%--      <a href="${ctx}/${pager.url}&currentPage=${pager.pageCount}" class="p_pre">尾页</a>--%>


        <a href="${pageContext.request.contextPath}/${url}?page=1&size=${pageInfo.pageSize}" aria-label="Previous" class="p_pre">首页</a>
<a href="${pageContext.request.contextPath}/${url}?page=${pageInfo.pageNum-1}&size=${pageInfo.pageSize}" class="p_pre">上一页</a>
    <c:forEach begin="1" end="${pageInfo.pages}" var="pageNum">
        <c:if test="${pageNum==pageInfo.pageNum}">
            <a href="${pageContext.request.contextPath}/${url}?page=${pageNum}&size=${pageInfo.pageSize}" class="cur">${pageNum}</a>
        </c:if>
        <c:if test="${pageNum!=pageInfo.pageNum}">
            <a href="${pageContext.request.contextPath}/${url}?page=${pageNum}&size=${pageInfo.pageSize}">${pageNum}</a>
        </c:if>
    </c:forEach>
    <a href="${pageContext.request.contextPath}/${url}?page=${pageInfo.pageNum+1}&size=${pageInfo.pageSize}" class="p_pre">下一页</a>
        <a href="${pageContext.request.contextPath}/${url}?page=${pageInfo.pages}&size=${pageInfo.pageSize}" aria-label="Next" class="p_pre">尾页</a>

</div>
