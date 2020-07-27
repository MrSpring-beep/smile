<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.8.2.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/ckeditor5-build-classic/ckeditor.js"></script>
    <script type="text/javascript">
        window.onload=function () {
            ClassicEditor
                        .create(document.querySelector("#NewsContent"))
                        .then(editor=>{
                            myEditor=editor;
                        })
                        .catch(error=>{
                            console.error(error);
                        })
        };
        function saveNews() {
            var title = $("[name='remark']").val();
            if(title.trim().length==0){
                alert("请输入地址备注");
                return;
            }

            var newsContent = $("#textarea0 p").text();
            if(newsContent.trim().length==0){
                alert("请输入新地址");
                return;
            }

            $("#productAdd").attr("action","${pageContext.request.contextPath}/userAddress/saveUserAddress.do");
            $("#productAdd").submit();
        }



        function updateNews(type) {

            var title = $("[name='remark']").val();
            if(title.trim().length==0){
                alert("请输入地址备注");
                return;
            }

            var newsContent = $("#textarea0 p").text();
            if(newsContent.trim().length==0){
                alert("请输入地址");
                return;
            }

            if(type==0){
                $("#productAdd").attr("action","${pageContext.request.contextPath}/userAddress/updateUserAddress.do");
            }else if(type==1){
                $("#productAdd").attr("action","${pageContext.request.contextPath}/userAddress/updateUserAddressAndIsDefault.do");
            }

            $("#productAdd").submit();
        }
    </script>
    <style type="text/css">
        #s_btn{
            /*width: 90px;*/
            height: 40px;
            line-height: 40px\9;
            background-color: #ff4e00;
            color: #FFF;
            font-size: 16px;
            font-family: "Microsoft YaHei";
            text-align: center;
            float: left;
            border: 0;
            cursor: pointer;
        }
    </style>
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
                 <c:if test="${ebUserAddress!=null}">
                     修改地址
                 </c:if>
                 <c:if test="${ebUserAddress==null}">
                     添加地址
                 </c:if>

            </div>
            <br>
            <form method="post" id="productAdd">
            <table border="0" class="add_tab" style="width:930px;" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="135" align="right">地址备注</td>
                    <td colspan="3" style="font-family:'宋体';">
                        <input type="text" name="remark" value="${ebUserAddress.remark}"/>
                        <input type="hidden" name="id" value="${ebUserAddress.id}"/>
                        <input type="hidden" name="isDefault" value="${ebUserAddress.isDefault}"/>
                    </td>
                </tr>
                <tr>
                    <td width="135" align="right">我的地址</td>
                    <td id="textarea0">
                        <textarea rows="8" cols="30" name="address" id="NewsContent">${ebUserAddress.address}</textarea>
                    </td>
                </tr>
                <tr>
                    <c:if test="${ebUserAddress==null}">
                        <td colspan="2" style="padding-left: 150px"><input type="button" onclick="saveNews()" value="添加地址" class="s_btn"></td>
                    </c:if>
                    <c:if test="${ebUserAddress!=null}">
                        <td  style="padding-left: 150px"><input type="button" onclick="updateNews(0)" value="修改地址" class="s_btn"/></td>
                        <c:if test="${ebUserAddress.isDefault!=1}">
                            <td style="width: 172px;height: 40px"><input type="button" onclick="updateNews(1)" value="修改并设置为默认地址" id="s_btn"></td>
                        </c:if>
                    </c:if>
                </tr>
            </table>
            </form>
        </div>
    </div>
    <%@ include file="/WEB-INF/common/pre/footer.jsp" %>
</div>
</body>
</html>


