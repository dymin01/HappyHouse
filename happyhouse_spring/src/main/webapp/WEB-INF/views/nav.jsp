<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<!-- 쿠키 검사 -->
<c:if test="${cookie.ssafy_id.value ne null}">
	<c:set var="saveid" value="${cookie.ssafy_id.value}"/>
	<c:set var="idck" value=" checked=\"checked\""/>
</c:if>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
/* $(document).ready(function() {*/
	function login() {
		if(document.getElementById("userid").value == "") {
			alert("아이디 입력!!!");
			return;
		} else if(document.getElementById("userpwd").value == "") {
			alert("비밀번호 입력!!!");
			return;
		} else {
			document.getElementById("loginform").action = "${root}/user/login";
			document.getElementById("loginform").submit();
		}
	}

	function moveJoin() {
		document.getElementById("registerform").action = "${root}/user/join";
		document.getElementById("registerform").submit();
	}
</script>
</head>
<body>
<!-- Modal -->
	<div class="modal fade" id="login" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header tit-up">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title">Customer Login</h4>
			</div>
			<div class="modal-body customer-box">
				<!-- Nav tabs -->
				<ul class="nav nav-tabs">
					<li><a class="active" href="#Login" data-toggle="tab">Login</a></li>
					<li><a href="#Registration" data-toggle="tab">Registration</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
					<div class="tab-pane active" id="Login">
						<form role="form" class="form-horizontal" id="loginform" method="post" action="">
						<input type="hidden" name="act" value="login">
							<div class="form-group">
								<div class="col-sm-12">
									<input class="form-control" id="userid" name="userid" placeholder="ID" type="text" value="${saveid}">
								</div>
							</div>
							<div class="form-group">
								<div class="col-sm-12">
									<input class="form-control" id="userpwd" name="userpwd" placeholder="Password" type="password">
								</div>
							</div>
							<div class="form-group form-check" align="right">
							    <label class="form-check-label">
							      <input class="form-check-input" type="checkbox" id="idsave" name="idsave" value="saveok"${idck}> 아이디저장
							    </label>
							</div>
							<div class="row">
								<div class="col-sm-10">
									<button type="button" class="btn btn-light btn-radius btn-brd grd1" id="loginbtn" onclick="javascript:login();" data-dismiss="modal">
										Login
									</button>
									<a class="for-pwd" href="forgotpwd.html">Forgot your password?</a>
								</div>
							</div>
						</form>
					</div>
					
					<div class="tab-pane" id="Registration">
						<form role="form" class="form-horizontal" id="registerform" method="post" action="">
						<input type="hidden" name="act" value="mvregister"/>
							<div class="form-group">
								<div class="col-sm-12">
									<input class="form-control" id="rename" name="username" placeholder="Name" type="text">
								</div>
							</div>
							<div class="form-group">
								<div class="col-sm-12">
									<input class="form-control" id="reid" name="userid" placeholder="ID" type="text">
								</div>
							</div>
							<div class="form-group">
								<div class="col-sm-12">
									<input class="form-control" id="repwd" name="userpwd" placeholder="Password" type="password">
								</div>
							</div>
							<div class="form-group">
								<div class="col-sm-12">
									<input class="form-control" id="email" name="email" placeholder="Email" type="email">
								</div>
							</div>
							<div class="form-group">
								<div class="col-sm-12">
									<input class="form-control" id="address" name="address" placeholder="Address" type="text">
								</div>
							</div>
							<div class="row">							
								<div class="col-sm-10">
									<button type="button" class="btn btn-light btn-radius btn-brd grd1" onclick="javascript:moveJoin();">
										Save &amp; Continue
									</button>
									<button type="button" class="btn btn-light btn-radius btn-brd grd1" data-dismiss="modal">
										Cancel</button>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	  </div>
	</div>
	<!-- Mypage modal -->
	<div class="modal fade" id="mypage" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header tit-up">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title">MyPage</h4>
			</div>
			<div class="modal-body customer-box">
				<!-- Nav tabs -->
				<ul class="nav nav-tabs">
					<li><a class="active" href="#memberinfo" data-toggle="tab">About Me!</a></li>
					<li><a href="#likes" data-toggle="tab">Likes</a></li> 
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
					<div class="tab-pane active" id="memberinfo">
						<form role="form" class="form-horizontal">
							<table class="table table-borderless">
							    
							    <tbody>
							      <tr>
							        <td>Name</td>
							        <td id="tname" style="text-align: left">${userinfo.username}</td>
							      </tr>
							      <tr>
							        <td>ID</td>
							        <td id="tid"style="text-align: left">${userinfo.userid}</td>
							      </tr>
							      <tr>
							        <td>E-Mail</td>
							        <td id="temail"style="text-align: left">${userinfo.email}</td>
							      </tr>
							      <tr>
							        <td>Address</td>
							        <td id="taddress"style="text-align: left">${userinfo.address}</td>
							      </tr>
							      <tr>
							        <td>Register Date</td>
							        <td id="tjoindate"style="text-align: left">${userinfo.joindate}</td>
							      </tr>
							    </tbody>
							  </table>
							<div class="row">
								<div class="col-sm-9">
									<button type="button" class="btn btn-light btn-radius btn-brd grd1" onclick="location.href='user/mvmodify'">
										Update
									</button>
								</div>
								<div class="col-sm-3">
                                    <button type="button" class="btn btn-danger btn-radius btn-brd grd1" onclick="location.href='${root}/user/logout'">
                                        Logout
                                    </button>
                                    <button type="button" class="btn btn-danger btn-radius btn-brd grd1" onclick="location.href='${root}/user/delete'">
                                        Delete
                                    </button>
                                </div>
							</div>
						</form>
					</div>
					<div class="tab-pane" id="likes">
						<form role="form" class="form-horizontal">
							<table class="table table-borderless">
							    
							    <tbody>
							      <tr>
							        <td>종로구 사직동</td>
							        <td  style="text-align: left">
							        <button type="button" class="btn btn-light">동네업종</button>
							        <button type="button" class="btn btn-light">대기오염정보</button>
							        <button type="button" class="btn">X</button>
							        </td>
							      </tr>
							      <tr>
							        <td>종로구 평창동</td>
							        <td  style="text-align: left">
							        <button type="button" class="btn btn-light">동네업종</button>
							        <button type="button" class="btn btn-light">대기오염정보</button>
							        <button type="button" class="btn">X</button>
							        </td>
							      </tr>
							      <tr>
							        <td>종로구 무악동</td>
							        <td  style="text-align: left">
							        <button type="button" class="btn btn-light">동네업종</button>
							        <button type="button" class="btn btn-light">대기오염정보</button>
							        <button type="button" class="btn">X</button>
							        </td>
							      </tr>
							      
							    </tbody>
							  </table>
							<div class="row">
								<div class="col-sm-9">
									<button type="button" class="btn btn-light btn-radius btn-brd grd1" onclick="location.href='edit.html'">
										Update
									</button>
								</div>
								<div class="col-sm-3">
									<button type="button" class="btn btn-danger btn-radius btn-brd grd1" href="${root}/user/logout">
										Logout
									</button>
									<button type="button" class="btn btn-danger btn-radius btn-brd grd1" onclick="location.reload()">
										Delete
									</button>
								</div>
							</div>
						</form>
					</div>
					
				</div>
			</div>
		</div>
	  </div>
	</div>

    <!-- LOADER -->
<!-- 	<div id="preloader">
		<div class="loader-container">
			<div class="progress-br float shadow">
				<div class="progress__item"></div>
			</div>
		</div>
	</div> -->
	<!-- END LOADER -->	
	
	<!-- Start header -->
	<header class="top-navbar">
		<nav class="navbar navbar-expand-lg navbar-light bg-light">
			<div class="container-fluid">
				<a class="navbar-brand" href="/">
					<img src="${root}/images/happylogo.png" style="width:100px" alt="" />
				</a>
				<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbars-host" aria-controls="navbars-rs-food" aria-expanded="false" aria-label="Toggle navigation">
					<span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
				</button>
				<div class="collapse navbar-collapse" id="navbars-host">
					<ul class="navbar-nav ml-auto">
						<li class="nav-item"><a class="nav-link" href="/">Home</a></li>
						<li class="nav-item"><a class="nav-link" href="${root}/notice/list">Notice </a></li>
					</ul>
					<c:if test="${userinfo == null}">
					<ul id="cslogin" class="nav navbar-nav navbar-right">
                        <li><a class="hover-btn-new log" href="#" data-toggle="modal" data-target="#login"><span>Customer Login</span></a></li>
                    </ul>
                    </c:if>
                    <c:if test="${userinfo != null}">
	                    <ul id="cslogout" class="nav navbar-nav navbar-right">
	                        <li><a class="hover-btn-new log" href="#" data-toggle="modal" data-target="#mypage"><span>MyPage</span></a></li>
	       					<li><a class="hover-btn-new log" href="${root}/user/logout"><span>LogOut</span></a></li>
	                    </ul>
                    </c:if>
				</div>
			</div>
		</nav>
	</header>
	<!-- End header -->
</body>
</html>