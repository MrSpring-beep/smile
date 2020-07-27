<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
    <style>

        /*======================
            404 page
        =======================*/


        .page_404{ padding:40px 0; background:#fff; font-family: 'Arvo', serif;
        }

        .page_404  img{ width:100%;}

        .four_zero_four_bg{

            background: url(https://cdn.dribbble.com/users/285475/screenshots/2083086/dribbble_1.gif) no-repeat;
            height: 400px;
            background-position: center;
        }


        .four_zero_four_bg h1{
            font-size:80px;
            margin-left: 650px;
        }

        .contant_box_404 {
            margin-top: -50px;
            margin-left: 650px;
        }

        .four_zero_four_bg h3{
            font-size:80px;
        }

        .link_404{
            color: #fff!important;
            padding: 10px 20px;
            background: #39ac31;
            margin: 20px 0;
            margin-left: 50px;
            display: inline-block;}
        .contant_box_404{ margin-top:-50px;}
    </style>
</head>
<body>
<section class="page_404">
    <div class="container">
        <div class="row">
            <div class="col-sm-12 ">
                <div class="col-sm-10 col-sm-offset-1  text-center">
                    <div class="four_zero_four_bg">
                        <h1 class="text-center ">404</h1>


                    </div>

                    <div class="contant_box_404">
                        <h3 class="h2" style="margin-left: 30px">
                            看起来你迷路了
                        </h3>

                        <p style="margin-left: 15px">您正在寻找的页面不存在!</p>

                        <a href="${pageContext.request.contextPath}/index.jsp" class="link_404">回到首页</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
</body>
</html>
