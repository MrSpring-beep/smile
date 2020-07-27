<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <%--  <%@ include file="/WEB-INF/common/pre/header.jsp" %>--%>
    <script src="${ctx}/js/backend/backend.js"></script>
    <script type="text/javascript">
        function deleteProductCategory(id,type) {
            if (confirm("确定删除该分类吗,这会使该分类的子分类一并删除")) {
                location.href="${pageContext.request.contextPath}/productController/delProductAndCate.do?id="+id+"&type="+type;
            }
        }

        function toAddProductCategory() {
            $("#addProductCategory").load("${pageContext.request.contextPath}/backstage/redirectAddCategory.do #add");
        }


        function selectProductCategoryLevel(thisSelect) {
            if (thisSelect.value == 1) {
                $("#tr2").hide();
                $("#tr3").hide();
            } else if (thisSelect.value == 2) {
                $("#tr2").show();
                $("#tr3").hide();
            } else if (thisSelect.value == 3) {
                $("#tr2").show();
                $("#tr3").show();

            } else if (thisSelect.value == 0) {
                $("#tr2").hide();
                $("#tr3").hide();
            }
        }

        function queryProductCategoryList(thisSelect, addSelect) {
            $.post("${pageContext.request.contextPath}/product/findByCategoryId.do", {"id": thisSelect.value}, function (success) {
                $("#" + addSelect).empty();
                for (var i = 0; i < success.length; i++) {
                    var option = new Option(success[i].name, success[i].id);
                    $("#" + addSelect).append(option);
                }
            }, "JSON")
        }

        function saveOrUpdate() {
            var type = $("#type").val();
            var name = $("#name").val();
            if (name.trim().length == 0) {
                alert("请输入分类名称");
                return;
            }
            if (type != 0) {
                if (type == 1) {
                    location.href = "${pageContext.request.contextPath}/product/saveCategory.do?name=" + name + "&parentId=0&type=" + type;
                } else if (type == 2) {
                    var productCategoryLevel1 = $("#productCategoryLevel1").val();
                    if(productCategoryLevel1==0){
                        alert("请选择一级分类");
                        return;
                    }
                    location.href = "${pageContext.request.contextPath}/product/saveCategory.do?name=" + name + "&parentId=" + productCategoryLevel1 + "&type=" + type;
                } else if (type == 3) {
                    var productCategoryLevel2 = $("#productCategoryLevel2").val();
                    if(productCategoryLevel2==0){
                        alert("请选择二级分类");
                        return;
                    }
                    location.href = "${pageContext.request.contextPath}/product/saveCategory.do?name=" + name + "&parentId=" + productCategoryLevel2 + "&type=" + type;
                }
            } else {
                alert("请选择级别");
            }



        }
    </script>
</head>
<body>
<jsp:include page="/WEB-INF/common/pre/top.jsp"></jsp:include>
<jsp:include page="/WEB-INF/common/pre/trolley.jsp"></jsp:include>
<!--End Header End-->
<div class="i_bg bg_color">
    <!--Begin 用户中心 Begin -->
    <div class="m_content">
        <%@ include file="/WEB-INF/common/backend/leftBar.jsp" %>
        <div class="m_right" id="content">
            <div class="mem_tit">分类列表</div>
            <p align="right">
                <a href="javascript:void(0);" onclick="toAddProductCategory();" class="add_b">添加分类</a>
                <br>
            </p>
            <br>
            <table border="0" class="order_tab" style="width:930px; text-align:center; margin-bottom:30px;"
                   cellspacing="0" cellpadding="0">
                <tbody>
                <tr>
                    <td width="5%">选择</td>
                    <td width="20%">分类名称</td>
                    <td width="25%">分类级别</td>
                    <td width="25%">父级分类</td>
                    <td width="25%">操作</td>
                </tr>
                <c:forEach items="${pageInfo.list}" var="category">
                    <tr>
                        <td width="5%"><input type="radio" value="${category.id}" name="select"
                                              onclick="toUpdateProductCategoryList(this);"/></td>
                        <td>${category.name}</td>
                        <td>
                            <c:choose>
                                <c:when test="${category.type==1}">一级分类</c:when>
                                <c:when test="${category.type==2}">二级分类</c:when>
                                <c:when test="${category.type==3}">三级分类</c:when>
                            </c:choose>
                        </td>
                        <td>
                            <c:if test="${empty category.parentName}">
                                无
                            </c:if>
                            <c:if test="${not empty category.parentName}">
                                ${category.parentName}
                            </c:if>
                        </td>
                        <td><a href="javascript:void(0);"
                               onclick="deleteProductCategory(${category.id},${category.type});">删除</a></td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <%@ include file="/WEB-INF/common/pre/pagerBar.jsp" %>
            <div id="addProductCategory">

            </div>
        </div>
    </div>
    <%@ include file="/WEB-INF/common/pre/footer.jsp" %>
</div>
</body>
</html>


