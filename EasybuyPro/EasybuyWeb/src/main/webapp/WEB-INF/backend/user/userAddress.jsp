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
            location.href="${pageContext.request.contextPath}/backstage/redirectAddUserAddress.do";
        }

        function delNews(id) {
            if(confirm("确定删除该地址吗")){
                location.href="${pageContext.request.contextPath}/userAddress/delUserAddress.do?id="+id;
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
            <div class="mem_tit">我的收货地址</div>
                <input type="button" onclick="saveNews()" value="新增地址" class="s_btn" style="margin-left: 860px;margin-top: -50px">
            <table border="0" class="order_tab" style="width:930px; text-align:center; margin-bottom:30px;" cellspacing="0" cellpadding="0">
                <tbody>
                <tr>
                        <td width="40%">地址备注</td>
                        <td width="40%">地址信息</td>
                        <td colspan="2" width="200px">操作</td>
                </tr>
                <c:forEach items="${pageInfo.list}" var="temp">
                    <tr <c:if test="${temp.isDefault==1}">style="color: red" </c:if>>
                        <td>${temp.remark}</td>
                        <td>${temp.address}</td>
                        <c:if test="${sessionScope.user!=null}">
                                <td><a href="${pageContext.request.contextPath}/backstage/updateUserAddressShow.do?id=${temp.id}">修改</a></td>
                                <td><a href="javascript:void(0)" onclick="delNews(${temp.id})">删除</a></td>
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
