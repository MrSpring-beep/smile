<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<style>
    #snap{
        margin-top: -20px;
        margin-left: 70px;
        width:159px; height:42px; line-height:42px\9; overflow:hidden; background:url(../images/btn_log.gif) repeat-x center top; color:#FFF; font-size:16px; font-family:"Microsoft YaHei"; text-align:center; padding:0; border:0; cursor:pointer; -webkit-border-radius:2px; -moz-border-radius:2px; border-radius:2px;
    }
    #video{
        margin-left: 70px;
    }
    #check{
        z-index: 10;
        margin-top: -362px;
        margin-left: 240px;
        width:159px; height:42px; line-height:42px\9; overflow:hidden; background:url(../images/btn_log.gif) repeat-x center top; color:#FFF; font-size:16px; font-family:"Microsoft YaHei"; text-align:center; padding:0; border:0; cursor:pointer; -webkit-border-radius:2px; -moz-border-radius:2px; border-radius:2px;
    }
</style>
<head>
    <meta charset="UTF-8">
    <title>FaceRecognition</title>
    <script type="text/javascript" src="../js/jquery-1.8.2.min.js"></script>
    <script type="text/javascript">
        //获取摄像头的视频流并且在video中展示
        window.addEventListener("DOMContentLoaded",function () {
            var canvas = document.getElementById("canvas"),
               context = canvas.getContext("2d"),
               video = document.getElementById("video"),
                videoObj={"video":true},
                errBack=function (error) {
                    console.log("Video capture error: ",error.code);
                };
            $("#snap").click(function () {
                context.drawImage(video, 0, 0, 330, 250);
            });

            if(navigator.getUserMedia){
                navigator.getUserMedia(videoObj,function (stream) {
                    video.srcObject=stream;
                    video.play();
                },errBack);
            }else if(navigator.webkitGetUserMedia){
                navigator.webkitGetUserMedia(videoObj,function (stream) {
                    video.src=window.webkitURL.createObjectURL(stream);
                    video.play();
                },errBack)
            }

        },false);


        //搜索
        function verification() {
            var canvas = document.getElementById("canvas");
            //获取浏览器画布对象
            //编辑数据
            var imgData = canvas.toDataURL();
            //将图片转换成BASE64数据
            var base64 = imgData.substr(22);

            //开始异步搜索
            $.post("${pageContext.request.contextPath}/face/verification", {"img": base64}, function (data, status) {
                if (status == "success") {
                    if (data != null) {
                        if ("error" == data) {
                            alert("识别错误 or 您未上传自己的帅照");
                        } else {
                            alert("身份验证成功！欢迎您，尊敬的：" + data);
                            $("input[name='username']").val(data);
                            $("#userAdmin").submit();
                            // location.href="/success";
                        }
                    }
                } else {
                    alert("上传失败");
                }
            },"text")
        }



    </script>
</head>
<body>
        <div id="contentHolder">
            <video id="video" width="320" height="320" autoplay></video>
            <input type="button" id="snap"  value="拍 照"/>
<%--            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="name">--%>
            <canvas style="" id="canvas" width="320" height="320"></canvas>
            <input type="button" value="验证" id="check" onclick="verification()"/>
        </div>

</body>
</html>