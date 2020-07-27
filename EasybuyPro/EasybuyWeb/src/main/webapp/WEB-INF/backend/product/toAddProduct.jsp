<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.8.2.min.js"></script>
    <script type="text/javascript">
        function queryProductCategoryList(thisSelect, addSelect) {
            $.post("${pageContext.request.contextPath}/product/findByCategoryId.do", {"id": thisSelect.value}, function (success) {
                $("#" + addSelect).empty();
                var option1 = new Option("请选择", 0);
                $("#" + addSelect).append(option1);
                for (var i = 0; i < success.length; i++) {
                    var option = new Option(success[i].name, success[i].id);
                    $("#" + addSelect).append(option);
                }
            }, "JSON")
        }

        var flag = true;
        $(function () {
            $("#photos").change(function () {
                var fileType = $(this).val().substr($(this).val().lastIndexOf(".")).toLowerCase();
                var reg = /^.jpg|.png|.webp|.gif$/;
                if (!reg.test(fileType)) {
                    $("#spanPhoto").css({"color": "red"});
                    $("#spanPhoto").html("请上传.jsp|.png|.webp|.gif类型图片");
                    flag = false;
                    return;
                } else {
                    $("#spanPhoto").css({"color": "green"});
                    $("#spanPhoto").html("✔");
                    flag = true;
                }

                var file = $("#photos")[0].files[0].size;

                file = Math.round(file / 1024 * 100) / 100; //单位为KB
                if (file > 3072) {
                    $("#spanPhoto").css({"color": "red"});
                    $("#spanPhoto").html("文件大小不能大于3MB");
                    flag = false;
                    return;
                } else {
                    $("#spanPhoto").css({"color": "green"});
                    $("#spanPhoto").html("✔");
                    flag = true;
                }

                // var files = $("#photos").getAsDataURL();
                // var $fileimage = $("#fileimage");

                //JS内置文件流
                var fileReader = new FileReader();
                // alert($("#photos")[0].files[0]);
                // alert($fileimage.src);
                // alert(fileReader.result);

                fileReader.onload=function () {
                    $fileimage.src=fileReader.result;
                }

            });




            // $("#productCategoryLevel1").change();
            // $("#productCategoryLevel2").change();
        });





        function update() {
            var productCategoryLevel1 = $("#productCategoryLevel1").val();
            var productCategoryLevel2 = $("#productCategoryLevel2").val();
            var productCategoryLevel3 = $("#productCategoryLevel3").val();
            if (productCategoryLevel1 == 0) {
                alert("请选择一级分类");
                return;
            }
            if (productCategoryLevel2 == 0) {
                alert("请选择二级分类");
                return;
            }
            if (productCategoryLevel3 == 0) {
                alert("请选择三级分类");
                return;
            }
            var name = $("#name").val();
            if (name.trim().length == 0) {
                alert("请输入商品名称");
                return;
            }
            var price = $("#price").val();
            if (price.trim().length == 0 || isNaN(price)) {
                alert("请输入正确的数字");
                return;
            }

            var stock = $("#stock").val();
            if (stock.trim().length == 0 || isNaN(stock)) {
                alert("请输入正确的商品库存");
                return;
            }

            if (!flag) {
                alert("请选择正确的图片格式");
                return;
            }

            $("#productAdd").attr("action", "${pageContext.request.contextPath}/productController/updateProduct.do")
            $("#productAdd").submit()
        }


        function saveProduct() {
            var productCategoryLevel1 = $("#productCategoryLevel1").val();
            var productCategoryLevel2 = $("#productCategoryLevel2").val();
            var productCategoryLevel3 = $("#productCategoryLevel3").val();
            if (productCategoryLevel1 == 0) {
                alert("请选择一级分类");
                return;
            }
            if (productCategoryLevel2 == 0) {
                alert("请选择二级分类");
                return;
            }
            if (productCategoryLevel3 == 0) {
                alert("请选择三级分类");
                return;
            }
            var name = $("#name").val();
            if (name.trim().length == 0) {
                alert("请输入商品名称");
                return;
            }
            var price = $("#price").val();
            if (price.trim().length == 0 || isNaN(price)) {
                alert("请输入正确的数字");
                return;
            }

            var stock = $("#stock").val();
            if (stock.trim().length == 0 || isNaN(stock)) {
                alert("请输入正确的商品库存");
                return;
            }

            $("#photos").each(function () {
                if ($(this).val() == "") {
                    alert("请选择文件");
                    return;
                }
            });
            // alert($("#photos")[0].files[0].size)

            if (!flag) {
                alert("请选择正确的图片格式");
                return;
            }

            $("#productAdd").attr("action", "${pageContext.request.contextPath}/productController/saveProduct.do")
            $("#productAdd").submit()
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
            <div class="mem_tit">
                <c:choose>
                    <c:when test="${empty product.id || product.id==0}">
                        添加商品
                    </c:when>
                    <c:otherwise>
                        修改商品
                    </c:otherwise>
                </c:choose>
            </div>

            <br>
            <form method="post" enctype="multipart/form-data" id="productAdd">
                <table border="0" class="add_tab" style="width:930px;" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="135" align="right">一级分类</td>
                        <td colspan="3" style="font-family:'宋体';">
                            <select name="categoryLevel1Id" style="background-color:#f6f6f6;" id="productCategoryLevel1"
                                    onchange="queryProductCategoryList(this,'productCategoryLevel2');">
                                <option value="0" selected="selected">请选择...</option>
                                <c:forEach items="${category1}" var="temp">
                                    <option value="${temp.id}"
                                            <c:if test="${product.categoryLevel1Id==temp.id}">selected="selected"</c:if> >${temp.name}</option>
                                </c:forEach>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td width="135" align="right">二级分类</td>
                        <td>
                            <select name="categoryLevel2Id" style="background-color:#f6f6f6;"
                                    id="productCategoryLevel2"
                                    onchange="queryProductCategoryList(this,'productCategoryLevel3');">
                                <option value="0" selected="selected">请选择...</option>
                                <c:forEach items="${category2}" var="temp">
                                    <option value="${temp.id}"
                                            <c:if test="${product.categoryLevel2Id==temp.id}">selected="selected"</c:if> >${temp.name}</option>
                                </c:forEach>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td width="135" align="right">三级分类</td>
                        <td>
                            <select name="categoryLevel3Id" style="background-color:#f6f6f6;"
                                    id="productCategoryLevel3">
                                <option value="0" selected="selected">请选择...</option>
                                <c:forEach items="${category3}" var="temp">
                                    <option value="${temp.id}"
                                            <c:if test="${product.categoryLevel3Id==temp.id}">selected="selected"</c:if> >${temp.name}</option>
                                </c:forEach>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td width="135" align="right">商品名称</td>
                        <td>
                            <input type="text" value="${product.name}" class="add_ipt" name="name" id="name"/>（必填）
                            <input type="hidden" name="id" value="${product.id}" id="id">
                        </td>
                    </tr>
                    <tr>
                        <td width="135" align="right">商品图片</td>
                        <td>
                            <c:if test="${product.fileName!=null && product.fileName!=''}">
                                <img id="fileimage" src="${ctx}/images/${product.fileName}" width="50" height="50"/>
                                <input type="hidden" name="fileName" value="${product.fileName}">
                            </c:if>
                            <input type="file" class="text" name="photo" id="photos"/><span id="spanPhoto"></span>
                        </td>
                    </tr>
                    <tr>
                        <td width="135" align="right">单价</td>
                        <td>
                            <input type="text" value="${product.price}" class="add_ipt" name="price" id="price"/>
                        </td>
                    </tr>
                    <tr>
                        <td width="135" align="right">库存</td>
                        <td>
                            <input type="text" value="${product.stock}" class="add_ipt" name="stock" id="stock"/>
                        </td>
                    </tr>
                    <tr>
                        <td width="135" align="right">描述</td>
                        <td>
                            <textarea name="description">${product.description}</textarea>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            <c:choose>
                                <c:when test="${empty product.id}">
                                    <input type="button" onclick="saveProduct()" value="商品上架" class="s_btn">
                                </c:when>
                                <c:otherwise>
                                    <input type="button" onclick="update()" value="确定修改" class="s_btn">
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
    </div>
    <%@ include file="/WEB-INF/common/pre/footer.jsp" %>
</div>
</body>
</html>


