<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <script src="${ctx}/statics/js/backend/backend.js"></script>
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
            var title = $("[name='title']").val();
            if(title.trim().length==0){
                alert("请输入新闻标题");
                return;
            }

            var newsContent = $("#textarea0 p").text();
            if(newsContent.trim().length==0){
                alert("请输入新闻内容");
                return;
            }

            $("#productAdd").attr("action","${pageContext.request.contextPath}/news/saveNews.do");
            $("#productAdd").submit();
        }



        function updateNews() {

            var title = $("[name='title']").val();
            if(title.trim().length==0){
                alert("请输入新闻标题");
                return;
            }

            var newsContent = $("#textarea0 p").text();
            if(newsContent.trim().length==0){
                alert("请输入新闻内容");
                return;
            }

            $("#productAdd").attr("action","${pageContext.request.contextPath}/news/updateNews.do");
            $("#productAdd").submit();
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
                 <c:if test="${eBuyNews!=null}">
                     修改新闻
                 </c:if>
                 <c:if test="${eBuyNews==null}">
                     添加新闻
                 </c:if>

            </div>
            <br>
            <form method="post" id="productAdd">
            <table border="0" class="add_tab" style="width:930px;" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="135" align="right">新闻标题</td>
                    <td colspan="3" style="font-family:'宋体';">
                        <input type="text" name="title" value="${eBuyNews.title}"/>
                        <input type="hidden" name="id" value="${eBuyNews.id}"/>
                    </td>
                </tr>
                <tr>
                    <td width="135" align="right">新闻内容</td>
                    <td id="textarea0">
                        <textarea rows="8" cols="30" name="content" id="NewsContent">${eBuyNews.content}</textarea>
                    </td>
                </tr>
                <tr>
                    <c:if test="${eBuyNews==null}">
                        <td colspan="2" style="padding-left: 150px"><input type="button" onclick="saveNews()" value="新增新闻" class="s_btn"></td>
                    </c:if>
                    <c:if test="${eBuyNews!=null}">
                        <td colspan="2" style="padding-left: 150px"><input type="button" onclick="updateNews()" value="修改新闻" class="s_btn"></td>
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


