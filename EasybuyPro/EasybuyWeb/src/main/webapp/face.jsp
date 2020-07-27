<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>FaceRecognition</title>
    <script type="text/javascript" src="https://cdn.bootcss.com/jquery/1.10.2/jquery.min.js"></script>
    <script type="text/javascript">
        //获取摄像头的视频流并且在video中展示
        window.addEventListener("DOMContentLoaded", function () {
            var canvas = document.getElementById("canvas"),
                context = canvas.getContext("2d"),
                video = document.getElementById("video"),
                videoObj = {"video": true},
                errBack = function (error) {
                    console.log("Video capture error: ", error.code);
                };
            $("#snap").click(function () {
                context.drawImage(video, 0, 0, 330, 250);
            });

            if (navigator.getUserMedia) {
                navigator.getUserMedia(videoObj, function (stream) {
                    video.srcObject = stream;
                    video.play();
                }, errBack);
            } else if (navigator.webkitGetUserMedia) {
                navigator.webkitGetUserMedia(videoObj, function (stream) {
                    video.src = window.webkitURL.createObjectURL(stream);
                    video.play();
                }, errBack)
            }

        }, false);


        //注册
        function registered() {
            var canvas = document.getElementById("canvas");
            //获取浏览器画布对象
            //编辑数据
            var imgData = canvas.toDataURL();
            //将图片转换成BASE64数据
            var base64 = imgData.substr(22);
            //获取名称
            var name = $('input[name="name"]').val();
            //开始异步注册
            $.post("http://localhost:8888/registered", {"img": base64, "name": name}, function (data, status) {
                if (status == "success") {
                    if (data == "success") {
                        alert("success");
                    } else if (data == "error") {
                        alert("error");
                    }
                } else {
                    alert("上传失败");
                }
            }, "text")

        }

        //搜索
        function verification() {
            var canvas = document.getElementById("canvas");
            //获取浏览器画布对象
            //编辑数据
            var imgData = canvas.toDataURL();
            //将图片转换成BASE64数据
            var base64 = imgData.substr(22);

            xhrFields:{
                withCredentials:true
            }
            //开始异步搜索
            $.post("http://localhost:8888/verification", {"img": base64}, function (data, status) {
                if (status == "success") {
                    if (data != null) {
                        if ("error" == data) {
                            alert("识别错误 or 您未上传自己的帅照");
                        } else {
                            var index = data.indexOf("K");
                            var name = data.substring(0, index);
                            alert("身份验证成功！欢迎您，尊敬的：" + name);
                            location.href = "${pageContext.request.contextPath}/Login.jsp?data=" + data;
                        }
                    }
                } else {
                    alert("上传失败");
                }
            }, "text")
        }

        //检测
        function faceDetection() {
            var canvans = document.getElementById("canvas");
            // 获取浏览器页面的画布对象
            // 以下开始编 数据
            var imgData = canvans.toDataURL();
            // 将图像转换为base64数据
            var base64Data = imgData.substr(22);
            //开始异步上
            $.post("/faceDetection", {"img": base64Data}, function (data, status) {
                if (status == "success") {
                    if (data == "success") {
                        alert("success");
                    } else if (data == "error") {
                        alert("error");
                    }
                } else {
                    alert("上传失败");
                }
            }, "text");
        }


    </script>
</head>
<body>

    <div><video id="video" width="320" height="320" autoplay></video></div>
    <input type="button" id="snap"  value="拍 照"/>
<%--    <a href="javascript:void(0)" id="snap"><img src="${pageContext.request.contextPath}/images/paizhao.gif"></a>--%>
    <div><canvas style="" id="canvas" width="320" height="280"></canvas></div>
    <input type="button" value="验证" onclick="verification()" id="check"/>

</body>
</html>