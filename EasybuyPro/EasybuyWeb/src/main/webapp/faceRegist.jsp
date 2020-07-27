<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>人脸注册</title>

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

        var isSuccess=false;

        $(function () {

            $("input[name='password']").blur(function () {
                $.post("${pageContext.request.contextPath}/userInfo/checkPass.do",{"pass":$(this).val()},function (success) {
                    // alert(success);
                    if (success == "true") {
                        isSuccess=true;
                    }else{
                        alert("验证密码不正确,为了您的账号安全,请填写原密码");
                    }
                });
            });
        });


        //注册
        function registered() {


            var password = $("input[name='password']").val();
            if(password.trim().length==0){
                alert("为了您的账号安全,请填写原密码")
                return;
            }
            alert(isSuccess);
           if(isSuccess==true){
               var username = $("input[name='username']").val();

               $("input[name='name']").val(username+'K'+password);
               // alert($("input[name='name']").val());

               var canvas = document.getElementById("canvas");
               //获取浏览器画布对象
               //编辑数据
               var imgData = canvas.toDataURL();
               //将图片转换成BASE64数据
               var base64 = imgData.substr(22);
               //获取名称
               var name = $('input[name="name"]').val();
               //开始异步注册
               xhrFields:{
                   withCredentials:true
               }
               $.post("http://localhost:8888/registered", {"img": base64, "name": name}, function (data, status) {
                   if (status == "success") {
                       if (data == "success") {
                           alert("人脸注册成功");
                           location.href="${pageContext.request.contextPath}/userInfo/updateUserFace.do?userId=${sessionScope.user.id}";
                       } else if (data == "error") {
                           alert("请将面部放于视频中部位置");
                       }
                   } else {
                       alert("上传失败");
                   }
               }, "text")
           }

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
<div id="contentHolder">
    <video id="video" width="320" height="320" autoplay></video>
    <input type="button" id="snap" style="width:100px;height:35px;" value="拍 照"/>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;验证账号:&nbsp;<input type="text" name="username" value="${sessionScope.user.loginName}" readonly>
    验证密码:<input type="password" name="password"/>
    <input type="hidden" name="name">
    <canvas style="" id="canvas" width="320" height="320"></canvas>
    <input type="button" value="注册人脸" onclick="registered()"/>
<%--    <input type="button" value="验证" onclick="verification()"/>--%>
<%--    <input type="button" value="检测" onclick="faceDetection()"/>--%>
</div>

</body>
</html>
