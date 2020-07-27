<%@ page language="java" contentType="text/html; charset=utf-8"  pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
  <script src="${ctx}/statics/js/backend/backend.js"></script>
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
      <p></p>
      <p></p>
      <div class="mem_tit">订单列表</div>
      <table border="0" class="order_tab" style="width:930px; text-align:center; margin-bottom:30px;" cellspacing="0" cellpadding="0">
        <c:if test="${pageInfo.list.size()==0 or pageInfo.list==null}">
            <h2 style="margin-left: 350px;color: #ff4e00">亲,您好穷,您没有购买过一件商品!!!</h2>
        </c:if>
        <tbody>
        <c:forEach items="${pageInfo.list}" var="order">
          <tr class="td_bg">
            <td>用户名:${order.loginName}</td>
            <td><a href="${ctx}/order/findBySerialNumber.do?orderId=${order.id}">订单号:${order.serialNumber}</a></td>
            <td>地址:${order.userAddress}</td>
            <td>￥${order.cost}</td>
          </tr>
          <tr>
          </tr>
          <tr>
            <td colspan="4">
              <table border="0" class="order_tab" style="width:930px; text-align:center; margin-bottom:30px;" cellspacing="0" cellpadding="0">
                <tbody>
                <tr>
                  <td width="20%">商品名称</td>
                  <td width="20%">商品图片</td>
                  <td width="25%">数量</td>
                  <td width="25%">价格</td>
                </tr>
                  <c:if test="${order.orderDetails!=null}">
                    <c:forEach items="${order.orderDetails}" var="orderDetail">
                      <tr>
                        <td>${orderDetail.ebProduct.name}</td>
                        <td>
                          <a href="${pageContext.request.contextPath}/product/findByProductId.do?productId=${orderDetail.ebProduct.id}" >
                            <img src="${ctx}/images/${orderDetail.ebProduct.fileName}" width="50" height="50">
                          </a>
                        </td>
                        <td>${orderDetail.quantity}</td>
                        <td>${orderDetail.cost}</td>
                      </tr>
                    </c:forEach>
                  </c:if>
                <c:if test="${order.orderDetails==null}">
                    <h2>${msg}</h2>
                </c:if>
                </tbody>
              </table>
            </td>
          </tr>
        </c:forEach>
        </tbody>
      </table>
      <c:if test="${pageInfo.list.size()!=0 and pageInfo.list!=null}">
        <%@ include file="/WEB-INF/common/pre/pagerBar.jsp" %>
      </c:if>
    </div>
  </div>
  <%@ include file="/WEB-INF/common/pre/footer.jsp" %>
</div>
</body>
</html>


