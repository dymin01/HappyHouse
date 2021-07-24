<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />
<!-- 쿠키 검사 -->
<c:if test="${cookie.ssafy_id.value ne null}">
	<c:set var="saveid" value="${cookie.ssafy_id.value}" />
	<c:set var="idck" value=" checked=\"checked\"" />
</c:if>
<!DOCTYPE html>
<html lang="en">

<!-- Basic -->
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<!-- Mobile Metas -->
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Site Metas -->
<title>Happy House</title>
<meta name="keywords" content="">
<meta name="description" content="">
<meta name="author" content="">

<!-- Site Icons -->
<link rel="shortcut icon" href="${root}/images/favicon.ico"
	type="image/x-icon" />
<link rel="apple-touch-icon" href="${root}/images/apple-touch-icon.png">

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
<script src="${root}/js/modernizer.js"></script>

<!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script src="https://code.jquery.com/jquery-latest.min.js"
	type="application/javascript"></script>
<script type="application/javascript"
	src="https://zelkun.tistory.com/attachment/cfile8.uf@99BB7A3D5D45C065343307.js"></script>

</head>
<script type="text/javascript">
	function login() {
		if(document.getElementById("userid").value == "") {
			alert("아이디 입력!!!");
			return;
		} else if(document.getElementById("userpwd").value == "") {
			alert("비밀번호 입력!!!");
			return;
		} else {
			document.getElementById("loginform").action = "${root}/main";
			document.getElementById("loginform").submit();
		}
	}

	function moveJoin() {

		document.getElementById("registerform").action = "${root}/main";
		document.getElementById("registerform").submit();
	}

	$(document).ready(function(){
		$.ajax({
		   type: "GET",
			url: "http://localhost:8080/main/sido",
		   async: true,		   
		   success: function(data){
			   console.log(data);
			   $.each(data, function(index, vo) {
					$("#sido").append("<option value='"+vo.sido_code+"'>"+vo.sido_name+"</option>");
				});//each 
		   },
		   error: function onError (error) {
		        console.error(error);
		    }
	 }); 
	
		$("#sido").change(function() {
			$.ajax({
				   type: "GET",
					url: "http://localhost:8080/main/gugun/"+$("#sido").val(),
				   async: true,		   
				   success: function(data){
					   console.log(data);
					   $("#gugun").empty();
						$("#gugun").append('<option value="0">선택</option>');
						$.each(data, function(index, vo) {
							$("#gugun").append("<option value='"+vo.gugun_code+"'>"+vo.gugun_name+"</option>");
						});//each
				   },
				   error: function onError (error) {
				        console.error(error);
				    }
			 }); 
			
		});//change

		$("#gugun").change(function() {
			$.ajax({
				   type: "GET",
					url: "http://localhost:8080/main/dong/"+$("#gugun").val(),
				   async: true,		   
				   success: function(data){
					   console.log(data);
					   $("#dong").empty();
						$("#dong").append('<option value="0">선택</option>');
						$.each(data, function(index, vo) {
							$("#dong").append("<option value='"+vo.dong+"'>"+vo.dong+"</option>");
						});//each
				   },
				   error: function onError (error) {
				        console.error(error);
				    }
			 }); 
		});//change
		
		// 동 바뀌면
		function searchHouse() {
			$.ajax({
				 type: "GET",
					url: "http://localhost:8080/main/houselist/"+$("#dong").val(),
				   async: true,		   
				   success: function(data){
					   console.log(data);
					   houselist(data);
				   },
				   error: function onError (error) {
				        console.error(error);
				    }
			});
			
		}
		
		
		$('#dong').on('change', function(){ searchHouse(); } );
		
		function houselist(data){
			$("#apt-deal-list").empty();
			$("#apt-deal-list").append("<h1>거래 정보</h1><hr>");
			data.forEach(function myFunction(item, index) {
				var div = $("<div></div>");
				var p = $("<p class='font-weight-bold'></p>");
				var a = $("<a></a>");
				$(a).attr("href", "javacsript:void(0);");
				$(a).attr("onclick", "detailhousedeal('"+item.aptName+"');");
				$(a).html(item.aptName);
				var p1 = $("<p></p>");
				$(p1).html("거래금액: " + item.dealAmount);
				var p2 = $("<p></p>");
				$(p2).html("면적: " + item.area);
				var p3 = $("<p></p>");
				$(p3).html("거래일: " + item.dealYear + "년" + item.dealMonth + "월" + item.dealDay + "일");
				var hr = $("<hr>");
				$(p).append(a);
				$(div).append(p, p1, p2, p3, hr);
				$("#apt-deal-list").append(div);
			});
		}
		
		
		function search() {
			// searchForm을 submit 시킨다.
			
			console.log("@@@@@@@@@@ in search @@@@@@@@@@@@@@");
			
			document.querySelector("#searchForm").submit();
		}
		
		document.querySelector("#btnSearch").addEventListener("click", function() {
			search();
		});
		
	}); 
	
	function detailhousedeal(aptName){
		console.log(aptName);
		
		$.ajax({
			 type: "GET",
				url: "http://localhost:8080/main/housedetail/"+aptName,
			   async: true,		   
			   success: function(data){
				   console.log(data);
				   housedetail(data);
			   },
			   error: function onError (error) {
			        console.error(error);
			    }
		});
	}
	
	function housedetail(data){
		
		console.log(" housedetail in");
		console.log(data);
		
		$("#apt-deal-list").empty();
		$("#apt-deal-list").append("<h1>거래 상세 정보</h1><hr>");
		data.forEach(function myFunction(item, index) {
			var div = $("<div></div>");
			var p = $("<p class='font-weight-bold'></p>");
			$(p).html(item.aptName);
			var p1 = $("<p></p>");
			$(p1).html("거래금액: " + item.dealAmount);
			var p2 = $("<p></p>");
			$(p2).html("전용면적: " + item.area);
			var p3 = $("<p></p>");
			$(p3).html("거래구분: 아파트 매매");
			var p4 = $("<p></p>");
			$(p4).html("거래일: " + item.dealYear + "년" + item.dealMonth + "월" + item.dealDay + "일");
			var hr = $("<hr>");
			$(div).append(p, p1, p2, p3, p4, hr);
			$("#apt-deal-list").append(div);
		});
	}
	
	
	
	
	
</script>
<body class="host_version">

	<%@include file="nav.jsp"%>

	<div id="carouselExampleControls"
		class="carousel slide bs-slider box-slider" data-ride="carousel"
		data-pause="hover" data-interval="false">
		<!-- Indicators -->
		<ol class="carousel-indicators">
			<li data-target="#carouselExampleControls" data-slide-to="0"
				class="active"></li>
			<li data-target="#carouselExampleControls" data-slide-to="1"></li>
			<li data-target="#carouselExampleControls" data-slide-to="2"></li>
		</ol>
		<div class="carousel-inner" role="listbox">
			<div class="carousel-item active">
				<div id="home" class="first-section"
					style="background-image:url('${root}/images/house1.jpeg');">
					<div class="dtab">
						<div class="container">
							<div class="row">
								<div class="col-md-12 col-sm-12 text-right">
									<div class="big-tagline">
										<h2>
											<strong>Happy</strong> House
										</h2>
										<p class="lead">필요한 정보들을 한눈에!</p>
										<a href="#" class="hover-btn-new"><span>Contact Us</span></a>
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href="#"
											class="hover-btn-new"><span>Read More</span></a>
									</div>
								</div>
							</div>
							<!-- end row -->
						</div>
						<!-- end container -->
					</div>
				</div>
				<!-- end section -->
			</div>
			<div class="carousel-item">
				<div id="home" class="first-section"
					style="background-image:url('${root}/images/house2.jpeg');">
					<div class="dtab">
						<div class="container">
							<div class="row">
								<div class="col-md-12 col-sm-12 text-left">
									<div class="big-tagline">
										<h2 data-animation="animated zoomInRight">
											Find the right <strong>House</strong>
										</h2>
										<p class="lead" data-animation="animated fadeInLeft">당신에게
											딱 맞는 집을 찾아보세요!</p>
										<a href="#" class="hover-btn-new"><span>Contact Us</span></a>
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href="#"
											class="hover-btn-new"><span>Read More</span></a>
									</div>
								</div>
							</div>
							<!-- end row -->
						</div>
						<!-- end container -->
					</div>
				</div>
				<!-- end section -->
			</div>
			<div class="carousel-item">
				<div id="home" class="first-section"
					style="background-image:url('${root}/images/house3.jpeg');">
					<div class="dtab">
						<div class="container">
							<div class="row">
								<div class="col-md-12 col-sm-12 text-center">
									<div class="big-tagline">
										<h2 data-animation="animated zoomInRight">
											<strong>SSAFY</strong>5기 화이팅!
										</h2>
										<p class="lead" data-animation="animated fadeInLeft">서울
											14반은 더 화이팅ㅎㅎ</p>
										<a href="#" class="hover-btn-new"><span>Contact Us</span></a>
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href="#"
											class="hover-btn-new"><span>Read More</span></a>
									</div>
								</div>
							</div>
							<!-- end row -->
						</div>
						<!-- end container -->
					</div>
				</div>
				<!-- end section -->
			</div>
			<!-- Left Control -->
			<a class="new-effect carousel-control-prev"
				href="#carouselExampleControls" role="button" data-slide="prev">
				<span class="fa fa-angle-left" aria-hidden="true"></span> <span
				class="sr-only">Previous</span>
			</a>

			<!-- Right Control -->
			<a class="new-effect carousel-control-next"
				href="#carouselExampleControls" role="button" data-slide="next">
				<span class="fa fa-angle-right" aria-hidden="true"></span> <span
				class="sr-only">Next</span>
			</a>
		</div>
	</div>


	<div id="domain" class="section wb">
		<div class="container">

			<div class="row text-center">
				<div class="col-lg-12">
				
					<form method="get" action="${root }/main/list" id="searchForm" class="form-inline">
						<!-- 현재의 페이지 정보를 hidden으로 관리한다. -->
						<label>검색컬럼:</label> <select name="key" id="key" class="form-control">
							<option value="none">없음</option>
							<option value="AptName">아파트 이름</option>
							<option value="dealAmount">매매가격</option>
							<option value="area">면적</option>
						</select> <label>검색어:</label> <input type="text" name="word" id="word"
							class="form-control"> <label>정렬 컬럼:</label> <select
							name="orderBy" id="orderBy" class="form-control mb-2">
							<option value="none">없음</option>
							<option value="AptName">아파트 이름</option>
							<option value="dealAmount">매매가격</option>
							<option value="area">면적</option>
						</select> <label>정렬 방향:</label> <select name="orderByDir" id="orderByDir"
							class="form-control mb-2">
							<option value="asc">오름차순</option>
							<option value="desc">내림차순</option>
						</select>
						<div class="flex-grow-1 text-right">
							<!-- 클릭 시 전송되는 것을 막기 위해 type은 submit이 아니라 button이다. -->
							<input type="button" value="검색" class="btn btn-primary"
								id="btnSearch">
						</div>
					</form>
				</div>

				<!-- end col -->
			</div>
			<!-- end row -->
			<div class="row text-center">
				<div class="col-lg-12">
					<form class="checkdomain form-inline" id="searchform" action="$"
						method="post">
						<div class="col-sm-12 text-center checkdomain-wrapper">
							<select class="custom-select" id="sido" name="sido">
								<option value="">도/광역시</option>
							</select> <select class="custom-select" id="gugun" name="gugun">
								<option value="">시/구/군</option>
							</select> <input type="hidden" name="act" id="act" value="searchHouseDeal">
							<select class="custom-select" id="dong" name="dong">
								<option value="">동</option>
							</select>
							<button onclick="alert(`관심지역이 등록되었습니다!`)" type="button"
								class="btn btn-outline-success">관심지역 등록</button>
						</div>
					</form>
				</div>

				<div class="row text-center col-lg-12 mb-5">
					<c:if test="${empty list }">
					<div class="col-sm-6 d-inline-block text-left" id="apt-deal-list">
						<!-- 비동기로 넣어줌. -->
					</div>
					</c:if>
					<c:if test="${!empty list }">
						<div class="col-sm-6 d-inline-block text-left" id="apt-deal-list">
						<h1>거래 정보</h1> <hr/>
							<c:forEach var="data" items="${list }">
								<div>
									<p class="font-weight-bold">
										<a href="javacsript:void(0);" onclick="detailhousedeal(${data.aptName});">${data.aptName}</a>
									</p>
									<p>거래금액: ${data.dealAmount}</p>
									<p>면적: ${data.area}</p>
									<p>거래일: ${data.dealYear}년 ${data.dealMonth}월 ${data.dealDay}일<p>
								</div>
							<hr/>
							</c:forEach>
						</div>
					</c:if>
					
					
					<div class="col-sm-6 d-inline-block">
						<div id="kakaomap" style="height: 400px;"></div>
						<div class="" id="dist"></div>
					</div>
					<script type="text/javascript"
						src="//dapi.kakao.com/v2/maps/sdk.js?appkey=bcf259230cf616e2988a41e58c1bcddb"></script>
					<script>
                    var container = document.getElementById('kakaomap');
                    var options = {
                        center: new kakao.maps.LatLng(37.5758061234865, 126.973691352767),
                        level: 3
                    };

                    var map = new kakao.maps.Map(container, options);
                    // 지도를 클릭한 위치에 표출할 마커입니다
                       var marker = new kakao.maps.Marker({ 
                           // 지도 중심좌표에 마커를 생성합니다 
                           position: map.getCenter() 
                       }); 
                       var marker2 = new kakao.maps.Marker({ 
                           // 지도 중심좌표에 마커를 생성합니다 
                           position: map.getCenter() 
                       }); 
                       // 지도에 마커를 표시합니다
                       marker.setMap(map);
                       marker2.setMap(map);
                       marker.setVisible(false);
                       marker2.setVisible(false);
                       var cnt = 0;

                    // 지도에 표시할 선을 생성합니다
                   	var polyline = new kakao.maps.Polyline({
                   	    path: [], // 선을 구성하는 좌표배열 입니다
                   	    strokeWeight: 5, // 선의 두께 입니다
                   	    strokeColor: '#FFAE00', // 선의 색깔입니다
                   	    strokeOpacity: 0.7, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
                   	    strokeStyle: 'solid' // 선의 스타일입니다
                   	});
                       
                       // 지도에 클릭 이벤트를 등록합니다
                       // 지도를 클릭하면 마지막 파라미터로 넘어온 함수를 호출합니다
                       kakao.maps.event.addListener(map, 'click', function(mouseEvent) {        
                           
                           // 클릭한 위도, 경도 정보를 가져옵니다 
                           var latlng = mouseEvent.latLng; 
                           
                           if (cnt == 2) {
                           // 마커 위치를 클릭한 위치로 옮깁니다
   	                        marker.setPosition(latlng);
                           	marker.setVisible(true);
                           	marker2.setVisible(false);
                           	polyline.setMap(null);
                           	cnt = 1;
                           } else if (cnt == 1) {
   	                        marker2.setPosition(latlng);
                           	marker2.setVisible(true);
                           	var pos = marker.getPosition();
                           	var pos2 = marker2.getPosition();
                           	
                           	// 선을 구성하는 좌표 배열입니다. 이 좌표들을 이어서 선을 표시합니다
                           	var linePath = [pos, pos2];

                           	// 지도에 표시할 경로를 설정합니다
                           	polyline.setPath(linePath);

                           	// 지도에 선을 표시합니다 
                           	polyline.setMap(map);
                           	
                           	calDistance(pos.getLat(), pos.getLng(), pos2.getLat(), pos2.getLng());
   	                        cnt++;
                           } else {
   	                        marker.setPosition(latlng);
                           	marker.setVisible(true);
   	                        cnt++;
                           }
                           
                           var message = '클릭한 위치의 위도는 ' + latlng.getLat() + ' 이고, ';
                           message += '경도는 ' + latlng.getLng() + ' 입니다';
                           
                           
                       });
                       
                       function calDistance(lat1,lng1,lat2,lng2) {
                       	function deg2rad(deg) { return deg * (Math.PI/180) } 
                       	
                       	var R = 6371; // Radius of the earth in km 
                       	var dLat = deg2rad(lat2-lat1); // deg2rad below 
                       	var dLon = deg2rad(lng2-lng1); 
                       	var a = Math.sin(dLat/2) * Math.sin(dLat/2) + Math.cos(deg2rad(lat1)) * Math.cos(deg2rad(lat2)) * Math.sin(dLon/2) * Math.sin(dLon/2); 
                       	var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a)); 
                       	var d = R * c; // Distance in km 
                       	document.getElementById('dist').innerHTML = "클릭한 두 위치의 거리는 " + Math.floor(d * 100000)/100 + "m 입니다.";

                       }
                </script>
				</div>
			</div>
			<!-- end container -->
		</div>
		<!-- end section -->

		<div id="overviews" class="section lb">
			<div class="container">
				<div class="section-title row text-center">
					<div class="col-md-8 offset-md-2">
						<h3>About</h3>
						<p class="lead">Lorem Ipsum dolroin gravida nibh vel velit
							auctor aliquet. Aenean sollicitudin, lorem quis bibendum auctor,
							nisi elit consequat ipsum, nec sagittis sem!</p>
					</div>
				</div>
				<!-- end title -->

				<div class="row align-items-center">
					<div class="col-xl-6 col-lg-6 col-md-12 col-sm-12">
						<div class="message-box">
							<h4>주택 관련 기사를 확인해보세요!</h4>
							<h2>주택 관련 기사</h2>
							<ul class="nav nav-tabs nav-justified">
								<li class="nav-item"><a class="nav-link active" href="#">최신순</a>
								</li>
								<li class="nav-item"><a class="nav-link" href="#">관련도순</a>
								</li>
								<li class="nav-item"><a class="nav-link" href="#">인기순</a></li>
							</ul>
							<table class="table table-hover">
								<tbody>
									<tr>
										<td>기사1</td>
									</tr>
									<tr>
										<td>기사2</td>
									</tr>
									<tr>
										<td>기사3</td>
									</tr>
									<tr>
										<td>기사4</td>
									</tr>
									<tr>
										<td>기사5</td>
									</tr>
								</tbody>
							</table>
							<a href="#" class="hover-btn-new"><span>Show More</span></a>
						</div>
						<!-- end messagebox -->
					</div>
					<!-- end col -->

					<div class="col-xl-6 col-lg-6 col-md-12 col-sm-12">
						<div class="post-media wow fadeIn">
							<img src="images/house2.jpeg" alt=""
								class="img-fluid img-rounded">
						</div>
						<!-- end media -->
					</div>
					<!-- end col -->
				</div>
				<div class="row align-items-center">
					<div class="col-xl-6 col-lg-6 col-md-12 col-sm-12">
						<div class="post-media wow fadeIn">
							<img src="images/house3.jpeg" alt=""
								class="img-fluid img-rounded">
						</div>
						<!-- end media -->
					</div>
					<!-- end col -->

					<div class="col-xl-6 col-lg-6 col-md-12 col-sm-12">
						<div class="message-box">
							<h2>오늘의 뉴스</h2>
							<table class="table table-hover">
								<thead>
									<tr>
										<th>분야</th>
										<th>기사제목</th>
										<th>작성자</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>경제</td>
										<td>기사1</td>
										<td>김싸피</td>
									</tr>
									<tr>
										<td>사회</td>
										<td>기사2</td>
										<td>박싸피</td>
									</tr>
									<tr>
										<td>스포츠</td>
										<td>기사3</td>
										<td>이싸피</td>
									</tr>
								</tbody>
							</table>
							<a href="#" class="hover-btn-new"><span>Learn More</span></a>
						</div>
						<!-- end messagebox -->
					</div>
					<!-- end col -->

				</div>
				<!-- end row -->
			</div>
			<!-- end container -->
		</div>
		<!-- end section -->


		<div id="pricing" class="section lb">
			<div class="container">
				<div class="section-title text-center">
					<h3>Ready to get started?</h3>
					<p>Lorem ipsum dolor sit aet, consectetur adipisicing lit sed
						do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
				</div>
				<!-- end title -->

				<div class="row">
					<div class="col-md-6 offset-md-3">
						<div class="message-box">
							<ul class="nav nav-pills nav-stacked" id="myTabs">
								<li><a class="active" href="#tab1" data-toggle="pill">Monthly
										Subscription</a></li>
								<li><a href="#tab2" data-toggle="pill">Yearly
										Subscription</a></li>
							</ul>
						</div>
					</div>
					<!-- end col -->
				</div>

				<hr class="invis">

				<div class="row">
					<div class="col-md-12">
						<div class="tab-content">
							<div class="tab-pane active fade show" id="tab1">
								<div class="row text-center">
									<div class="col-md-4">
										<div class="pricing-table pricing-table-highlighted">
											<div class="pricing-table-header grd1">
												<h2>Shared Hosting</h2>
												<h3>$85/month</h3>
											</div>
											<div class="pricing-table-space"></div>
											<div class="pricing-table-features">
												<p>
													<i class="fa fa-envelope-o"></i> <strong>250</strong> Email
													Addresses
												</p>
												<p>
													<i class="fa fa-rocket"></i> <strong>125GB</strong> of
													Storage
												</p>
												<p>
													<i class="fa fa-database"></i> <strong>140</strong>
													Databases
												</p>
												<p>
													<i class="fa fa-link"></i> <strong>60</strong> Domains
												</p>
												<p>
													<i class="fa fa-life-ring"></i> <strong>24/7
														Unlimited</strong> Support
												</p>
											</div>
											<div class="pricing-table-sign-up">
												<a href="#" class="hover-btn-new"><span>Order Now</span></a>
											</div>
										</div>
									</div>
									<div class="col-md-4">
										<div class="pricing-table pricing-table-highlighted">
											<div class="pricing-table-header grd1">
												<h2>WordPress Hosting</h2>
												<h3>$59/month</h3>
											</div>
											<div class="pricing-table-space"></div>
											<div class="pricing-table-features">
												<p>
													<i class="fa fa-envelope-o"></i> <strong>150</strong> Email
													Addresses
												</p>
												<p>
													<i class="fa fa-rocket"></i> <strong>65GB</strong> of
													Storage
												</p>
												<p>
													<i class="fa fa-database"></i> <strong>60</strong>
													Databases
												</p>
												<p>
													<i class="fa fa-link"></i> <strong>30</strong> Domains
												</p>
												<p>
													<i class="fa fa-life-ring"></i> <strong>24/7
														Unlimited</strong> Support
												</p>
											</div>
											<div class="pricing-table-sign-up">
												<a href="#" class="hover-btn-new"><span>Order Now</span></a>
											</div>
										</div>
									</div>

									<div class="col-md-4">
										<div class="pricing-table pricing-table-highlighted">
											<div class="pricing-table-header grd1">
												<h2>Reseller Hosting</h2>
												<h3>$85/month</h3>
											</div>
											<div class="pricing-table-space"></div>
											<div class="pricing-table-features">
												<p>
													<i class="fa fa-envelope-o"></i> <strong>250</strong> Email
													Addresses
												</p>
												<p>
													<i class="fa fa-rocket"></i> <strong>125GB</strong> of
													Storage
												</p>
												<p>
													<i class="fa fa-database"></i> <strong>140</strong>
													Databases
												</p>
												<p>
													<i class="fa fa-link"></i> <strong>60</strong> Domains
												</p>
												<p>
													<i class="fa fa-life-ring"></i> <strong>24/7
														Unlimited</strong> Support
												</p>
											</div>
											<div class="pricing-table-sign-up">
												<a href="#" class="hover-btn-new"><span>Order Now</span></a>
											</div>
										</div>
									</div>
								</div>
								<!-- end row -->
							</div>
							<!-- end pane -->

							<div class="tab-pane fade" id="tab2">
								<div class="row text-center">
									<div class="col-md-4">
										<div class="pricing-table pricing-table-highlighted">
											<div class="pricing-table-header grd1">
												<h2>Shared Hosting</h2>
												<h3>$85/Year</h3>
											</div>
											<div class="pricing-table-space"></div>
											<div class="pricing-table-features">
												<p>
													<i class="fa fa-envelope-o"></i> <strong>250</strong> Email
													Addresses
												</p>
												<p>
													<i class="fa fa-rocket"></i> <strong>125GB</strong> of
													Storage
												</p>
												<p>
													<i class="fa fa-database"></i> <strong>140</strong>
													Databases
												</p>
												<p>
													<i class="fa fa-link"></i> <strong>60</strong> Domains
												</p>
												<p>
													<i class="fa fa-life-ring"></i> <strong>24/7
														Unlimited</strong> Support
												</p>
											</div>
											<div class="pricing-table-sign-up">
												<a href="#" class="hover-btn-new"><span>Order Now</span></a>
											</div>
										</div>
									</div>
									<div class="col-md-4">
										<div class="pricing-table pricing-table-highlighted">
											<div class="pricing-table-header grd1">
												<h2>WordPress Hosting</h2>
												<h3>$59/Year</h3>
											</div>
											<div class="pricing-table-space"></div>
											<div class="pricing-table-features">
												<p>
													<i class="fa fa-envelope-o"></i> <strong>150</strong> Email
													Addresses
												</p>
												<p>
													<i class="fa fa-rocket"></i> <strong>65GB</strong> of
													Storage
												</p>
												<p>
													<i class="fa fa-database"></i> <strong>60</strong>
													Databases
												</p>
												<p>
													<i class="fa fa-link"></i> <strong>30</strong> Domains
												</p>
												<p>
													<i class="fa fa-life-ring"></i> <strong>24/7
														Unlimited</strong> Support
												</p>
											</div>
											<div class="pricing-table-sign-up">
												<a href="#" class="hover-btn-new"><span>Order Now</span></a>
											</div>
										</div>
									</div>

									<div class="col-md-4">
										<div class="pricing-table pricing-table-highlighted">
											<div class="pricing-table-header grd1">
												<h2>Reseller Hosting</h2>
												<h3>$85/Year</h3>
											</div>
											<div class="pricing-table-space"></div>
											<div class="pricing-table-features">
												<p>
													<i class="fa fa-envelope-o"></i> <strong>250</strong> Email
													Addresses
												</p>
												<p>
													<i class="fa fa-rocket"></i> <strong>125GB</strong> of
													Storage
												</p>
												<p>
													<i class="fa fa-database"></i> <strong>140</strong>
													Databases
												</p>
												<p>
													<i class="fa fa-link"></i> <strong>60</strong> Domains
												</p>
												<p>
													<i class="fa fa-life-ring"></i> <strong>24/7
														Unlimited</strong> Support
												</p>
											</div>
											<div class="pricing-table-sign-up">
												<a href="#" class="hover-btn-new"><span>Order Now</span></a>
											</div>
										</div>
									</div>
								</div>
								<!-- end row -->
							</div>
							<!-- end pane -->
						</div>
						<!-- end content -->
					</div>
					<!-- end col -->
				</div>
				<!-- end row -->
			</div>
			<!-- end container -->
		</div>
		<!-- end section -->


		<footer class="footer">
			<div class="container">
				<div class="row">
					<div class="col-lg-4 col-md-4 col-xs-12">
						<div class="widget clearfix">
							<div class="widget-title">
								<h3>About US</h3>
							</div>
							<p>지역별 아파트 매매 실거래가를 확인할 수 있습니다. 회원가입, 로그인/로그아웃, 회원정보 조회,수정,
								비밀번호 찾기 등의 페이지를 구현하였고 간단한 조회 페이지 구성도 해보았습니다.</p>
							<p>Sed fermentum est vitae rhoncus molestie. Cum sociis
								natoque penatibus et magnis dis montes.</p>
						</div>
						<!-- end clearfix -->
					</div>
					<!-- end col -->

					<div class="col-lg-4 col-md-4 col-xs-12">
						<div class="widget clearfix">
							<div class="widget-title">
								<h3>Information Link</h3>
							</div>
							<ul class="footer-links">
								<li><a href="#">Home</a></li>
								<li><a href="#">Blog</a></li>
								<li><a href="#">Pricing</a></li>
								<li><a href="#">About</a></li>
								<li><a href="#">Faq</a></li>
								<li><a href="#">Contact</a></li>
							</ul>
							<!-- end links -->
						</div>
						<!-- end clearfix -->
					</div>
					<!-- end col -->

					<div class="col-lg-4 col-md-4 col-xs-12">
						<div class="widget clearfix">
							<div class="widget-title">
								<h3>Contact Details</h3>
							</div>

							<ul class="footer-links">
								<li><a href="mailto:#">happyhouse@ssafy.com</a></li>
								<li><a href="#">www.happyhouse.com</a></li>
								<li>212, Teheran-ro, Gangnam-gu, Seoul, Republic of Korea</li>
								<li>+81 10 6396 9583</li>
							</ul>
							<!-- end links -->
						</div>
						<!-- end clearfix -->
					</div>
					<!-- end col -->

				</div>
				<!-- end row -->
			</div>
			<!-- end container -->
		</footer>
		<!-- end footer -->

		<div class="copyrights">
			<div class="container">
				<div class="footer-distributed">
					<div class="footer-left">
						<p class="footer-company-name">
							All Rights Reserved. &copy; 2018 <a href="#">HappyHouse</a>
							Design By : <a href="https://html.design/">html design</a>
						</p>
					</div>

					<div class="footer-right">
						<ul class="footer-links-soi">
							<li><a href="#"><i class="fa fa-facebook"></i></a></li>
							<li><a href="#"><i class="fa fa-github"></i></a></li>
							<li><a href="#"><i class="fa fa-twitter"></i></a></li>
							<li><a href="#"><i class="fa fa-dribbble"></i></a></li>
							<li><a href="#"><i class="fa fa-pinterest"></i></a></li>
						</ul>
						<!-- end links -->
					</div>
				</div>
			</div>
			<!-- end container -->
		</div>
		<!-- end copyrights -->

		<a href="#" id="scroll-to-top" class="dmtop global-radius"><i
			class="fa fa-angle-up"></i></a>

		<!-- ALL JS FILES -->
		<script src="js/all.js"></script>
		<!-- ALL PLUGINS -->
		<script src="js/custom.js"></script>
		<script src="js/timeline.min.js"></script>
		<script>
		timeline(document.querySelectorAll('.timeline'), {
			forceVerticalMode: 700,
			mode: 'horizontal',
			verticalStartPosition: 'left',
			visibleItems: 4
		});
	</script>
</body>
</html>