<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>sellerHome</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<!--[if ie]><meta content='IE=8' http-equiv='X-UA-Compatible'/><![endif]-->
<!-- bootstrap -->
<link
	href="<c:url value='/resources/bootstrap/css/bootstrap.min.css' />"
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
<script src="<c:url value='/resources/themes/js/jquery.scrolltotop.js' />"></script>


<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>


<style>
p {
	color: gray;
}
#coverBox {
	display: inline-block;
	margin-left: 320px;
}
#sellerLogo {
	width: 200px;
	height: 200px;
	float: left;
	border: none;
	margin: 30px;
}
#logoImg {
	width: 200px;
	height: 200px;
}
#sellerInfo {
	width: 300px;
	height: 200px;
	float: left;
	border: none;
	margin: 30px;
}

</style>

</head><!-- -------------------------------------------------------------- -->


<body>
	<!-- 김태훈 백버튼 리프레시 인풋 -->
	<input type="hidden" id="refreshed" value="no" style="display: none">

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
<!-- 김태훈 코드 시작, 로그인한 사용자별 상단 메뉴 정렬--><!-- TODO: 마이페이지, 장바구니 링크 걸고, 인터셉터 걸어야함 -->
						<!-- ---------------visitor 입장----------------------------- -->
						<c:if test="${empty s_login_id && empty b_login_id }">
						<li><a href="">My Page</a></li>
						<li><a href="">Cart</a></li>
						</c:if>
						<!-- ------------바이어 입장 시작-------------------------- -->
						<c:if test="${not empty b_login_id }">
						<li><a href="">My Page</a></li>	
						<li><a href="">Cart</a></li>
						</c:if>
						<!-- ------------------셀러 입장시작------------------------------- -->
						<c:if test="${not empty s_login_id and s_login_id ne 'admin'}">
						<li><a href="">My Page</a></li>
						<li><a href="sellerHome?s_id=${s_login_id}">My Home</a></li><!-- 마이홈은 판매자홈 말하는거임 -->
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
					<a href="./" class="logo pull-left"><img src="<c:url value='/resources/themes/images/logo.png' />" class="site_logo" alt=""></a>
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
				src="<c:url value='/resources/themes/images/pageBanner.png' />"
				alt="New products">
			<h4>
				<span>Seller's Home</span>
			</h4>
		</section>
		<section class="main-content">
			<div class="row">
				<div class="span12">
					<div class="accordion" id="accordion2">
						<!-- -------------------------------------------------------------- -->
						<hr/>
						
						<div id="coverBox">
							<div id="sellerLogo">
								<img id="logoImg" src="${sellerInfo.s_logo }" />
							</div>
							
							<div id="sellerInfo">
								<br/>
								<label>판매자</label>
								<p>${sellerInfo.s_name }</p>
								<label>이메일</label>
								<p>${sellerInfo.s_email }</p>
								<label>개인 쇼핑몰 / SNS</label>
								<p>${sellerInfo.s_info }</p>
							</div>
						</div>
						
						<hr/>				

						<!-- -------------------------------------------------------------- -->
									
					</div><!-- #### -->
				</div>
			</div>
		</section>
		
		<section class="main-content">
				<div class="row">
					<div class="span12">													
						<div class="row">
							<div class="span12">
								<h4 class="title">
									<span class="pull-left"><span class="text"><span class="line">Feature <strong>Products</strong></span></span></span>
									<span class="pull-right">
										<a class="left button" href="#myCarousel" data-slide="prev"></a><a class="right button" href="#myCarousel" data-slide="next"></a>
									</span>
								</h4>
								
								
								<!-- /////////////////////////////////////////////////////////////////////////////////////// -->
								
								<!-- 1번째 리스트 라인 -->
								<div id="myCarousel" class="myCarousel carousel slide">
									<div class="carousel-inner">
	<!-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// -->	
	<!-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// -->
	<!-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// -->
		
								
				 <!-- ** 마지막 페이지 다음에 오는 페이지는 다시 첫번째 페이지 ** -->			
					 
				<!-- 첫번째 페이지 -->
				<div class="active item">		
					<ul class="thumbnails">	
						<c:forEach begin="0" end="0" var="page">
						<c:forEach begin="0" end="3" varStatus="status" items="${productList }"><!-- 1번째 // 4 개씩 출력 -->
								<li class="span3">
								<div class="product-box">
									<span class="sale_tag"><%--  #index : ${4 * page + status.index} --%> </span>
										<p><a href="pDetail?p_no=${productList[4 * page + status.index].p_no }"><img src="${productList[4 * page + status.index].p_img }" /></a></p>
										<a href="pDetail?p_no=${productList[4 * page + status.index].p_no }" class="title">${productList[4 * page + status.index].p_name }</a><br>
										<a href="pDetail?p_no=${productList[4 * page + status.index].p_no }" class="category">${productList[4 * page + status.index].p_cate1}</a><!-- 카테고리 -->
										<%-- <p class="price">₩ ${productList[4 * page + status.index].p_price }</p>	  --%>
										<p class="price"><fmt:formatNumber value="${productList[4 * page + status.index].p_price}" groupingUsed="true"/> 원</p>	
									</div>
								</li>
						</c:forEach>
						</c:forEach> 
					</ul>
				</div>
	
	
	
				<c:if test="${numOfPage >= 2}">
				<!-- 두번째 페이지 이상 ~ -->
				
					<c:if test="${numOfPage >= 3}">
					<%-- <c:forEach begin="1" end="${numOfPage-1 }" var="page"> --%>
						<c:forEach begin="1" end="${numOfPage-2 }" var="page">
						<div class="item">		
							<ul class="thumbnails">	
								<%-- <c:forEach begin="0" end="4" var="i"> --%>
									<%-- ${productList.list[4 * page + i] } --%>
								<c:forEach begin="0" end="3" varStatus="status" items="${productList }"><!-- 2번째 // 4 개씩 출력 -->
									<li class="span3">
									<div class="product-box">
										<span class="sale_tag"><%--  #index : ${4 * page + status.index} --%> </span>
											<p><a href="pDetail?p_no=${productList[4 * page + status.index].p_no }"><img src="${productList[4 * page + status.index].p_img }" /></a></p>
											<a href="pDetail?p_no=${productList[4 * page + status.index].p_no }" class="title">${productList[4 * page + status.index].p_name }</a><br>
											<a href="pDetail?p_no=${productList[4 * page + status.index].p_no }" class="category">${productList[4 * page + status.index].p_cate1}</a><!-- 카테고리 -->
											<p class="price"><fmt:formatNumber value="${productList[4 * page + status.index].p_price}" groupingUsed="true"/> 원</p> 
											
									</div>
									</li>
								</c:forEach>
								
								</ul>
							</div>
						</c:forEach>
					</c:if>
					
					
				<!-- 마지막 페이지 -->
					<c:if test="${remainder != 0}">
						<c:forEach begin="${numOfPage-1}" end="${numOfPage-1}" var="page">
							<div class="item">		
								<ul class="thumbnails">	
									<%-- <c:forEach begin="0" end="4" var="i"> --%>
										<%-- ${productList.list[4 * page + i] } --%>
									<c:forEach begin="0" end="${remainder-1}" varStatus="status" items="${productList }"><!-- 3번째 // 4 개씩 출력 -->
										<li class="span3">
										<div class="product-box">
											<span class="sale_tag"><%--  #index : ${4 * page + status.index} --%> </span>
												<p><a href="pDetail?p_no=${productList[4 * page + status.index].p_no }"><img src="${productList[4 * page + status.index].p_img }" /></a></p>
												<a href="pDetail?p_no=${productList[4 * page + status.index].p_no }" class="title">${productList[4 * page + status.index].p_name }</a><br>
												<a href="pDetail?p_no=${productList[4 * page + status.index].p_no }" class="category">${productList[4 * page + status.index].p_cate1}</a><!-- 카테고리 -->
												<p class="price"><fmt:formatNumber value="${productList[4 * page + status.index].p_price}" groupingUsed="true"/> 원</p> 
												
											</div>
										</li>
									</c:forEach>
									
								</ul>
							</div>
						</c:forEach> 
					</c:if>
					<c:if test="${remainder == 0}">
						<c:forEach begin="${numOfPage-1}" end="${numOfPage-1}" var="page">
							<div class="item">		
								<ul class="thumbnails">	
									<%-- <c:forEach begin="0" end="4" var="i"> --%>
										<%-- ${productList.list[4 * page + i] } --%>
									<c:forEach begin="0" end="3" varStatus="status" items="${productList }"><!-- 3번째 // 4 개씩 출력 -->
										<li class="span3">
										<div class="product-box">
											<span class="sale_tag"><%--  #index : ${4 * page + status.index} --%> </span>
												<p><a href="pDetail?p_no=${productList[4 * page + status.index].p_no }"><img src="${productList[4 * page + status.index].p_img }" /></a></p>
												<a href="pDetail?p_no=${productList[4 * page + status.index].p_no }" class="title">${productList[4 * page + status.index].p_name }</a><br>
												<a href="pDetail?p_no=${productList[4 * page + status.index].p_no }" class="category">${productList[4 * page + status.index].p_cate1}</a><!-- 카테고리 -->
												<p class="price"><fmt:formatNumber value="${productList[4 * page + status.index].p_price}" groupingUsed="true"/> 원</p> 
												
											</div>
										</li>
									</c:forEach>
									
								</ul>
							</div>
						</c:forEach> 
					</c:if>
				
				</c:if>		
									
			</section>
	<!-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// -->	
	<!-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// -->
	<!-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// -->
				
									
		
		
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
						<img src="<c:url value='/resources/themes/images/logo.png' />"
							class="site_logo" alt="">
					</p>
					<p>Lorem Ipsum is simply dummy text of the printing and
						typesetting industry. the Lorem Ipsum has been the industry's
						standard dummy text ever since the you.</p>
					<br /> <span class="social_icons"> <a class="facebook"
						href="#">Facebook</a> <a class="twitter" href="#">Twitter</a> <a
						class="skype" href="#">Skype</a> <a class="vimeo" href="#">Vimeo</a>
					</span>
				</div>
			</div>
		</section>
		<section id="copyright">
			<span>December 2016 Web Project All right.</span>
		</section>
	</div>
	<!-- <script src="/shop01/resources/themes/js/common.js"/></script> -->
	
	<script>
	// 김태훈 백버튼 리프레시 코드(스크립트 안에넣기)
    onload=function(){
    var e=document.getElementById("refreshed");
    if(e.value=="no")e.value="yes";
    else{e.value="no";location.reload();}
    }
	</script>
	
</body>
</html>