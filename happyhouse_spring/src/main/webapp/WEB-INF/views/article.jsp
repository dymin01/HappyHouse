<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">

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

</head>
<body class="host_version"> 


	<%@include file="nav.jsp" %>
	<div class="all-title-box">
		<div class="container text-center">
			<h1 style="color: black">공지사항</h1>
		</div>
	</div>
	
    <div id="overviews" class="section lb">
        <div class="container">

			<div class="message-box">
			    <h4>등록일시: ${article.regtime} 작성자: ${article.userid}</h4>
			    <h2>${article.subject}</h2>
			    <p>${article.content }</p>
			
			    <a href="${root }/notice/list" class="hover-btn-new"><span>목록</span></a>
			</div><!-- end messagebox -->
            
        </div><!-- end container -->
    </div><!-- end section -->
	<ul class="pagination justify-content-center" style="margin:20px 0;">
	 <li class="page-item"><a class="page-link" href="#">&#60&#60</a></li>
  <li class="page-item"><a class="page-link" href="#">&#60</a></li>
  <li class="page-item active"><a class="page-link" href="#">1</a></li>
  <li class="page-item"><a class="page-link" href="#">2</a></li>
  <li class="page-item"><a class="page-link" href="#">3</a></li>
  <li class="page-item"><a class="page-link" href="#">&#62</a></li>
   <li class="page-item"><a class="page-link" href="#">&#62&#62</a></li>
</ul>

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