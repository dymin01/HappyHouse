<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <!-- Site CSS -->
    <link rel="stylesheet" href="style.css">
    <!-- ALL VERSION CSS -->
    <link rel="stylesheet" href="css/versions.css">
    <!-- Responsive CSS -->
    <link rel="stylesheet" href="css/responsive.css">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="css/custom.css">

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
			<h1>공지사항<span class="m_1">공지사항 페이지입니다.</span></h1>
		</div>
	</div>
	
    <div id="overviews" class="section lb">
        <div class="container">
            <div class="section-title row text-center">
                <div class="col-md-8 offset-md-2">
                    <button type="button" class="btn btn-outline-success" onclick="location.href='write.jsp'"> 공지사항 등록 </button>
                    <p class="lead mt-3">공지사항 페이지입니다. 꼭 확인해 주세요</p>
                </div>
            </div><!-- end title -->

            <hr class="invis"> 
		
            <div class="row"> 
            <c:if test="${empty notices}">
				<div class="jumbotron">
					<h6>작성된 글이 없습니다</h6>
				</div>
			</c:if>
			<c:if test="${!empty notices}">
				<c:forEach items="${notices}" var="notice">
	                <div class="col-md-4 col-sm-6 col-xs-12">
	                    <div class="icon-wrapper wow fadeIn" data-wow-duration="1s" data-wow-delay="0.2s">
	                        <i class="flaticon-server global-radius effect-1 alignleft"></i>
	                        <h3>${notice.subject}</h3>
	                        <p class="text-muted">${fn:substring(notice.regtime, 0, 10) }
							<small class="readmore">
								<a href="notice?act=readarticle&articleno=${notice.articleNo}">Read more</a>
							</small>
							</p>
							<div class="mt-3">
			                    <button type="button" class="btn btn-outline-secondary btn-sm" onclick="location.href='notice?act=mvmodify&articleno=${notice.articleNo}'"> 수정 </button>
			                    <button type="button" class="btn btn-outline-danger btn-sm" onclick="location.href='notice?act=delete&articleno=${notice.articleNo}'"> 삭제 </button>
							</div>
	                    </div><!-- end icon-wrapper -->
	                </div><!-- end col -->
				</c:forEach>
			</c:if>
			</div>

            <!-- <div class="row"> 
                <div class="col-md-4 col-sm-6 col-xs-12">
                    <div class="icon-wrapper wow fadeIn" data-wow-duration="1s" data-wow-delay="0.2s">
                        <i class="flaticon-cup global-radius effect-1 alignleft"></i>
                        <h3>Awards Winner Support</h3>
                        <p>Our Landigoo responsive site template elements 100% compatible with all mobile devices and modern browsers! 
						<small class="readmore">
							<a href="#">Read more</a>
						</small>
						</p>
                    </div>end icon-wrapper
                </div>end col

                <div class="col-md-4 col-sm-6 col-xs-12">
                    <div class="icon-wrapper wow fadeIn" data-wow-duration="1s" data-wow-delay="0.4s">
                        <i class="flaticon-cer-file-format global-radius effect-1 alignleft"></i>
                        <h3>Free SSL Certifica</h3>
                        <p>We offer pixel perfect icons, graphic sources for high-resolution devices! Landigoo compatible retina display! 
						<small class="readmore">
							<a href="#">Read more</a>
						</small>
						</p>
                    </div>end icon-wrapper
                </div>end col

                <div class="col-md-4 col-sm-6 col-xs-12">
                    <div class="icon-wrapper wow fadeIn" data-wow-duration="1s" data-wow-delay="0.6s">
                        <i class="flaticon-locked global-radius effect-1 alignleft"></i>
                        <h3>High Security</h3>
                        <p>When you need anything about for Landigoo template, just drop an email or leave a feedback from TF!
						<small class="readmore">
							<a href="#">Read more</a>
						</small>
						</p>
                    </div>end icon-wrapper
                </div>end col
            </div>end row -->
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