<%@ page language="java" contentType="text/html; charset=utf-8"  pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
            background-color: #ffffff;
            color: #ff5900;
        }
    </style>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link type="text/css" rel="stylesheet" href="${ctx}/css/style.css" />
    <script type="text/javascript">
        $(function () {
            var msg="${msg}";
            if(msg!=""){
                $("#pp").html(msg);
                $("#disappare").show().delay(3000).fadeOut(300);
            }
        });
        function saveNews() {
            location.href="${pageContext.request.contextPath}/backstage/redirectAddNews.do";
        }

        function delNews(id) {
            if(confirm("确定删除该新闻吗")){
                location.href="${pageContext.request.contextPath}/news/delNews.do?newsId="+id;
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
<jsp:include page="/WEB-INF/common/pre/top.jsp"></jsp:include>
<jsp:include page="/WEB-INF/common/pre/trolley.jsp"></jsp:include>
<div class="i_bg bg_color">
    <!--Begin 用户中心 Begin -->
	<div class="m_content">
        <%@ include file="/WEB-INF/common/backend/leftBar.jsp"%>
        <div class="m_right">
            <p></p>
            <div class="mem_tit">资讯列表</div>
            <c:if test="${sessionScope.user.type==1 or sessionScope.user.type==2}">
                <input type="button" onclick="saveNews()" value="新增新闻" class="s_btn" style="margin-left: 860px;margin-top: -50px">
            </c:if>
            <table border="0" class="order_tab" style="width:930px; text-align:center; margin-bottom:30px;" cellspacing="0" cellpadding="0">
                <tbody>
                <tr>


                    <c:if test="${sessionScope.user.type==0}">
                        <td width="50%">文章标题</td>
                        <td width="50%">创建时间</td>
                    </c:if>
                    <c:if test="${sessionScope.user.type==1 || sessionScope.user.type==2}">
                        <td width="40%">文章标题</td>
                        <td width="40%">创建时间</td>
                        <td colspan="2" width="200px">操作</td>
                    </c:if>
                </tr>
                <c:forEach items="${pageInfo.list}" var="temp">
                    <tr>
                        <td><a href="${ctx}/news/findNewsById.do?id=${temp.id}">${temp.title}</a></td>
                        <td><fmt:formatDate value="${temp.createTime}" pattern="yyyy-MM-dd HH:mm"/> </td>
                        <c:if test="${sessionScope.user!=null}">
                            <c:if test="${sessionScope.user.type==1 or sessionScope.user.type==2}">
                                <td><a href="${pageContext.request.contextPath}/backstage/updateNewsShowInfo.do?id=${temp.id}">修改</a></td>
                                <td><a href="javascript:void(0)" onclick="delNews(${temp.id})">删除</a></td>
                            </c:if>
                        </c:if>
                    </tr>
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
