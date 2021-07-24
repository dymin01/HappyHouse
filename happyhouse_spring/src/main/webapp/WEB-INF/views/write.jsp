<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="ko">

    <!-- Basic -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">   
   
    <!-- Mobile Metas -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
 
     <!-- Site Metas -->
    <title>Notice</title>  
    <meta name="keywords" content="">
    <meta name="description" content="">
    <meta name="author" content="">

    <!-- Site Icons -->
    <link rel="shortcut icon" href="images/favicon.ico" type="image/x-icon" />
    <link rel="apple-touch-icon" href="images/apple-touch-icon.png">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="${root}/css/bootstrap.min.css">
    <!-- Site CSS -->
    <link rel="stylesheet" href="${root}/css/style.css">
    <!-- ALL VERSION CSS -->
    <link rel="stylesheet" href="${root}/css/versions.css">
    <!-- Responsive CSS -->
    <link rel="stylesheet" href="${root}/css/responsive.css">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="${root}/css/custom.css">

    <!-- Modernizer for Portfolio -->
    <script src="js/modernizer.js"></script>

    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
	<script type="text/javascript">
		function writeArticle() {
			if(document.getElementById("subject").value == "") {
				alert("제목 입력!!!!");
				return;
			} else if(document.getElementById("content").value == "") {
				alert("내용 입력!!!!");
				return;
			} else {
			  	document.getElementById("writeform").action = "${root}/notice/write";
			  	document.getElementById("writeform").submit();
			}
		}
	</script>
</head>
<body class="host_version"> 

	<%@include file="nav.jsp" %>
	
    <div id="overviews" class="section lb">
        <div class="container">
            <div class="section-title row text-center">
                <div class="col-md-8 offset-md-2">
                    <h3 class="lead mt-3">공지사항 작성</h3>
                    <form id="writeform" method="post" action="">
						<input type="hidden" name="act" id="act" value="write">
						<div class="form-group" align="left">
							<label for="subject">제목:</label>
							<input type="text" class="form-control" id="subject" name="subject"">
						</div>
						<div class="form-group" align="left">
							<label for="content">내용:</label>
							<textarea class="form-control" rows="15" id="content" name="content""></textarea>
						</div>
						<button type="button" class="btn btn-primary" onclick="javascript:writeArticle();">글작성</button>
						<button type="reset" class="btn btn-warning">초기화</button>
						<button onclick="location.href='${root}/notice/list'" type="button" class="btn btn-secondary">돌아가기</button>
					</form>
                </div>
            </div><!-- end title -->
        </div><!-- end container -->
    </div><!-- end section -->



    <div class="copyrights">
        <div class="container">
            <div class="footer-distributed">
                <div class="footer-left">                   
                    <p class="footer-company-name">All Rights Reserved. &copy; 2018 <a href="#">QuickCloud</a> Design By : <a href="https://html.design/">html design</a></p>
                </div>

                <div class="footer-right">
                    <ul class="footer-links-soi">
						<li><a href="#"><i class="fa fa-facebook"></i></a></li>
						<li><a href="#"><i class="fa fa-github"></i></a></li>
						<li><a href="#"><i class="fa fa-twitter"></i></a></li>
						<li><a href="#"><i class="fa fa-dribbble"></i></a></li>
						<li><a href="#"><i class="fa fa-pinterest"></i></a></li>
					</ul><!-- end links -->
                </div>
            </div>
        </div><!-- end container -->
    </div><!-- end copyrights -->

    <a href="#" id="scroll-to-top" class="dmtop global-radius"><i class="fa fa-angle-up"></i></a>

    <!-- ALL JS FILES -->
    <script src="js/all.js"></script>
    <!-- ALL PLUGINS -->
    <script src="js/custom.js"></script>

</body>
</html>