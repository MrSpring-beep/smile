<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <%@ include file="/WEB-INF/common/pre/header.jsp" %>
    <link type="text/css" rel="stylesheet" href="${ctx}/css/style.css" />
</head>
<body>
<%@ include file="/WEB-INF/common/backend/searchBar.jsp" %>
<div class="i_bg bg_color">
    <!--Begin 用户中心 Begin -->
	<div class="m_content">
        <%@ include file="/WEB-INF/common/backend/leftBar.jsp"%>
		<div class="m_right">
            <p></p>
            <div class="mem_tit">${news.title}</div>
            <p style="padding:0 40px; margin:0 auto 20px auto;">
                ${news.content}
            </p>
        </div>
    </div>
	<!--End 用户中心 End--> 
    <!--Begin Footer Begin -->
    <%@ include file="/WEB-INF/common/pre/footer.jsp" %>
    <!--End Footer End -->    
</div>
</body>
</html>
