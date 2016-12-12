<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Bootstrap E-commerce Templates</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<!--[if ie]><meta content='IE=8' http-equiv='X-UA-Compatible'/><![endif]-->
<!-- bootstrap -->
<link href="<c:url value='/resources/bootstrap/css/bootstrap.min.css'/>"
	rel="stylesheet">
<link
	href="<c:url value='/resources/bootstrap/css/bootstrap-responsive.min.css' />"
	rel="stylesheet">
<link href="<c:url value='/resources/themes/css/bootstrappage.css' />"
	rel="stylesheet" />

<!-- global styles -->
<link href="<c:url value='/resources/themes/css/flexslider.css' />"
	rel="stylesheet" />
<link href="<c:url value='/resources/themes/css/main.css' />"
	rel="stylesheet" />

<!-- scripts -->
<script src="<c:url value='/resources/themes/js/jquery-1.7.2.min.js' />"></script>
<script src="<c:url value='/resources/bootstrap/js/bootstrap.min.js' />"></script>
<script src="<c:url value='/resources/themes/js/superfish.js' />"></script>
<script
	src="<c:url value='/resources/themes/js/jquery.scrolltotop.js' />"></script>

<!-- Latest compiled and minified CSS -->


<!--[if lt IE 9]>			
			<script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
			<script src="js/respond.min.js"></script>
		<![endif]-->
</head>
<body>
	<div id="top-bar" class="container">
		<div class="row">
			<div class="span4">
				<form method="POST" class="search_form">
					<input type="text" class="input-block-level search-query"
						Placeholder="eg. T-sirt">
				</form>
			</div>
			<div class="span8">
				<div class="account pull-right">
					<ul class="user-menu">
						<!-- 김태훈 코드 시작, 로그인한 사용자별 상단 메뉴 정렬-->
						<!-- TODO: 마이페이지, 장바구니 링크 걸고, 인터셉터 걸어야함 -->
						<!-- ---------------visitor 입장----------------------------- -->
						<c:if test="${empty s_login_id && empty b_login_id }">
							<li><a href="">My Page</a></li>
							<li><a href="cart/selectCart">Cart</a></li>
						</c:if>
						<!-- ------------바이어 입장 시작-------------------------- -->
						<c:if test="${not empty b_login_id }">
							<li><a href="">My Page</a></li>
							<li><a href="../cart/selectCart">Cart</a></li>
						</c:if>
						<!-- ------------------셀러 입장시작------------------------------- -->
						<c:if test="${not empty s_login_id and s_login_id ne 'admin'}">
							<li><a href="">My Page</a></li>
							<li><a href="sellerHome?s_id=${s_login_id}">My Home</a></li>
							<!-- 마이홈은 판매자홈 말하는거임 -->
						</c:if>
						<!-- ----------------어드민 입장 시작--------------------------------------->
						<c:if test="${s_login_id eq 'admin'}">
							<li><a href="">My Page</a></li>
						</c:if>
						<c:if test="${empty s_login_id && empty b_login_id }">
							<c:url value="login" var="login" />
							<li><a href="${login}">Login</a></li>
						</c:if>
						<c:if test="${not empty s_login_id || not empty b_login_id }">
							<!-- 세션에 로그인 정보가 있는 경우 -->
							<c:url value="logout" var="logout" />
							<li><a href="${logout }">Logout</a></li>
						</c:if>
						<!-- 김태훈 코드 끝 ------------------------------------------------------------------->
					</ul>
				</div>
			</div>
		</div>
	</div>
	<div id="wrapper" class="container">
		<section class="navbar main-menu">
				<div class="navbar-inner main-menu">				
					<a href="./" class="logo pull-left"><img src=<c:url value='/resources/themes/images/logo.png' /> class="site_logo" alt=""></a>
					<nav id="menu" class="pull-right">
						<ul>
							<li><a href="./products">Home / Deco</a>					
								<ul>
									<li><a href="./products">furniture</a></li>	<!-- 가구 -->									
									<li><a href="./products">pottery</a></li>		<!-- 도자기 -->		
									<li><a href="./products">lamp</a></li>			<!-- 조명 -->									
								</ul>
							</li>															
							<li><a href="./products">Candle / Diffuser</a>
								<ul>
									<li><a href="./products">candle</a></li>			<!-- 양초 -->										
									<li><a href="./products">diffuser</a></li>			<!-- 디퓨저 -->
									<li><a href="./products">aromatic oils</a></li>	<!-- 아로마오일 -->									
								</ul>		
								</li>	
							<li><a href="./products">Art / Fancy</a>
								<ul>									
									<li><a href="./products">picture</a></li>		<!-- 사진 -->
									<li><a href="./products">fancy</a></li>		<!-- 문구 -->
									<li><a href="./products">paper</a></li>		<!-- 페이퍼 -->
								</ul>
							</li>							
							<li><a href="./products">Jewellery</a>
								<ul>									
									<li><a href="./products">earring</a></li>		<!-- 귀걸이 -->
									<li><a href="./products">necklace</a></li>		<!-- 목걸이 -->
									<li><a href="./products">ring</a></li>			<!-- 반지 -->
								</ul>
							</li>
							<li><a href="./products">Event</a></li>
						</ul>
					</nav>
				</div>
			</section>
		<section class="header_text sub">
			<img class="pageBanner"
				src="<c:url value='/resources/themes/images/pageBanner.png'/>"
				alt="New products">
			<h4>
				<span>Login or Regsiter</span>
			</h4>
		</section>
		<section class="main-content">
			<div class="row">

				<!-- *************** -->
				<div class="span5">
					<h4 class="title">
						<span class="text"><strong>Login</strong> Form</span>
					</h4>
					<!-- ---------------------- -->
					<ul id="myTab" class="nav nav-tabs">
						<li class="active"><a href="#buyerLogin" data-toggle="tab">구매자
								로그인</a></li>
						<li class=""><a href="#sellerLogin" data-toggle="tab">판매자
								로그인</a></li>
					</ul>
					<div id="myTabContent" class="tab-content">
						<div class="tab-pane fade active in" id="buyerLogin">
							<form action="buyer/login" method="post">
								<input type="hidden" name="next" value="/">
								<fieldset>
									<div class="control-group">
										<label class="control-label">아이디</label>
										<div class="controls">
											<input type="text" placeholder="아이디 입력" id="username"
												class="input-xlarge" name="b_id">
										</div>
									</div>
									<div class="control-group">
										<label class="control-label">비밀번호</label>
										<div class="controls">
											<input type="password" name="b_pw" placeholder="비밀번호 입력"
												id="password" class="input-xlarge">
										</div>
									</div>
									<div class="control-group">
										<input tabindex="3" class="btn btn-inverse large"
											type="submit" value="구매자 로그인"> <input type="hidden"
											name="query" value="<%=request.getQueryString()%>" />
										<hr>
										<p class="reset">
											구매자 <a tabindex="4" href="#"
												title="Recover your username or password">아이디/비밀번호 찾기</a>
										</p>
									</div>
								</fieldset>
							</form>

						</div>
						<div class="tab-pane fade" id="sellerLogin">
							<form action="seller/login" method="post" id="loginBuyerOrSeller">
								<input type="hidden" name="next" value="/">
								<fieldset>
									<div class="control-group">
										<label class="control-label">아이디</label>
										<div class="controls">
											<input type="text" placeholder="아이디 입력" id="username"
												class="input-xlarge" name="s_id">
										</div>
									</div>
									<div class="control-group">
										<label class="control-label">비밀번호</label>
										<div class="controls">
											<input type="password" name="s_pw" placeholder="비밀번호 입력"
												id="password" class="input-xlarge">
										</div>
									</div>
									<div class="control-group">
										<input tabindex="3" class="btn btn-inverse large"
											type="submit" value="판매자 로그인">
										<hr>
										<p class="reset">
											판매자 <a tabindex="4" href="#"
												title="Recover your username or password">아이디/비밀번호 찾기</a>
										</p>
									</div>
								</fieldset>
							</form>
						</div>
						<!-- class = tab-pane -->
					</div>
					<!-- myTabContent -->

				</div><!-- end span5 -->

				<div class="span7">
					<h4 class="title">
						<span class="text"><strong>Register</strong> Select</span>
					</h4>
					<a href="buyer/register"><img alt="구매자 회원가입"
						src="http://order.garak24.com/data/skin/default/images/buttons/banner_join_buyer.gif"
						style="width: 150px"></a> <a href="seller/register"><img
						alt="판매자 회원가입"
						src="http://order.garak24.com/data/skin/default/images/buttons/banner_join_seller.gif"
						style="width: 150px"></a>


				</div><!-- span7 -->
			</div><!-- end row -->
		</section>




		<section id="footer-bar">
			<div class="row">
				<div class="span3">
					<h4>Navigation</h4>
					<ul class="nav">
						<li><a href="./index.html">Homepage</a></li>
						<li><a href="./about.html">About Us</a></li>
						<li><a href="./contact.html">Contac Us</a></li>
						<li><a href="./cart.html">Your Cart</a></li>
						<li><a href="./register.html">Login</a></li>
					</ul>
				</div>
				<div class="span4">
					<h4>My Account</h4>
					<ul class="nav">
						<li><a href="#">My Account</a></li>
						<li><a href="#">Order History</a></li>
						<li><a href="#">Wish List</a></li>
						<li><a href="#">Newsletter</a></li>
					</ul>
				</div>
				<div class="span5">
					<p class="logo">
						<img src="<c:url value='resources/themes/images/logo.png' />"
							class="site_logo" alt="">
					</p>
					<!-- <p>Lorem Ipsum is simply dummy text of the printing and
						typesetting industry. the Lorem Ipsum has been the industry's
						standard dummy text ever since the you.</p> -->
					<br /> <span class="social_icons"> <a class="facebook"
						href="#">Facebook</a> <a class="twitter" href="#">Twitter</a> <a
						class="skype" href="#">Skype</a> <a class="vimeo" href="#">Vimeo</a>
					</span>
				</div>
			</div>
		</section>
		<section id="copyright">
			<span>Copyright 2016. Monday To Friday all rights reserved.</span>
		</section>
	</div>
	<input type="hidden" value="${loginFail}" id="failCheck">
	<script src="<c:url value='/resources/themes/js/common.js' />"></script>
	<script>
		$(document).ready(function() {
			$('#checkout').click(function(e) {
				document.location.href = "checkout.html";
			})
			var fail = $("#failCheck").val();
			if (fail=="fail"){
				alert("아이디/비밀번호가 일치하지 않습니다.")
				<%request.getSession().removeAttribute("loginFail");%>
				$("#failCheck").val("");
			}
		});
	</script>
</body>
</html>