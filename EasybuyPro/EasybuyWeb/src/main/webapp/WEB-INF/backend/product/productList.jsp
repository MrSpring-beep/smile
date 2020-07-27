<%@ page language="java" contentType="text/html; charset=utf-8"  pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>

  <script src="${ctx}/statics/js/backend/backend.js"></script>
  <script type="text/javascript">
    //删除商品信息
    function deleteById(id) {
      if(confirm("确定删除此商品吗")){
        location.href="${pageContext.request.contextPath}/productController/updateProductIsDel.do?id="+id;
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
    <%@ include file="/WEB-INF/common/backend/leftBar.jsp"%>
    <div class="m_right" id="content">
      <div class="mem_tit">商品列表</div>
      <br>
      <table border="0" class="order_tab" style="width:930px; text-align:center; margin-bottom:30px;" cellspacing="0" cellpadding="0">
        <tbody>
        <tr>
          <td width="10%">商品名称</td>
          <td width="10%">商品图片</td>
          <td width="5%">库存</td>
          <td width="10%">价格</td>
          <td width="10%" colspan="2">操作</td>
        </tr>
        <c:forEach items="${pageInfo.list}" var="temp">
          <tr>
            <td>${temp.name}</td>
            <td>
              <a href="${ctx}/Product?action=queryProductDeatil&id=${temp.id}" target="_blank">
                  <img src="${ctx}/images/${temp.fileName}" width="50" height="50"/>
              </a>
            </td>
            <td>${temp.stock}</td>
            <td>${temp.price}</td>
            <td><a href="${ctx}/backstage/redirectToAddProduct.do?t&id=${temp.id}">修改</a></td>
            <td><a href="javascript:void(0);" onclick="deleteById('${temp.id}');">删除</a></td>
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


