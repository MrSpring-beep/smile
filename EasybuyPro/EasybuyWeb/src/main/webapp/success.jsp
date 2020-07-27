<%--
  Created by IntelliJ IDEA.
  User: 14804
  Date: 2020/7/9
  Time: 17:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<html>
<head>
    <title>success</title>
</head>
<body>



<div>
    <security:authentication property="principal.username"></security:authentication>
</div>



</body>
</html>
