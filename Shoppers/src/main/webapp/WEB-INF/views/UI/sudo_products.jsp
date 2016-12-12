<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>H-Shopper : 특별함을 전하는</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<meta name="description" content="">
		<!--[if ie]><meta content='IE=8' http-equiv='X-UA-Compatible'/><![endif]-->
		<!-- bootstrap -->
		<link href="<c:url value='/resources/bootstrap/css/bootstrap.min.css' />" rel="stylesheet">      
		<link href="<c:url value='/resources/bootstrap/css/bootstrap-responsive.min.css' />" rel="stylesheet">		
		<link href="<c:url value='/resources/themes/css/bootstrappage.css' />" rel="stylesheet"/>
		
		<!-- global styles -->
		<link href="<c:url value='/resources/themes/css/flexslider.css' />" rel="stylesheet"/>
		<link href="<c:url value='/resources/themes/css/main.css' />" rel="stylesheet"/>

		<!-- scripts -->
		<script src="<c:url value='/resources/themes/js/jquery-1.7.2.min.js' />"></script>
		<script src="<c:url value='/resources/bootstrap/js/bootstrap.min.js' />"></script>				
		<script src="<c:url value='/resources/themes/js/superfish.js' />"></script>	
		<script src="<c:url value='/resources/themes/js/jquery.scrolltotop.js' />"></script>
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
						<input type="text" class="input-block-level search-query" Placeholder="eg. T-sirt">
					</form>
				</div>
				<div class="span8">
					<div class="account pull-right">
						<ul class="user-menu">				
<!-- 김태훈 코드 시작, 로그인한 사용자별 상단 메뉴 정렬--><!-- TODO: 마이페이지, 장바구니 링크 걸고, 인터셉터 걸어야함 -->
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
					<!-- 방문객 입장 -->
					<c:if test="${empty s_login_id && empty b_login_id }">
					<a href="./" class="logo pull-left"><img src=<c:url value='/resources/themes/images/logo.png' /> class="site_logo" alt=""></a>
					</c:if>
					<!-- 셀러 입장 -->
					<c:if test="${not empty s_login_id and s_login_id ne 'admin'}">
					<a href="../seller/main" class="logo pull-left"><img src=<c:url value='/resources/themes/images/logo.png' /> class="site_logo" alt=""></a>
					</c:if>
					<!-- 바이어 입장 -->
					<c:if test="${not empty b_login_id }">
					<a href="../buyer/main" class="logo pull-left"><img src=<c:url value='/resources/themes/images/logo.png' /> class="site_logo" alt=""></a>
					</c:if>
					<nav id="menu" class="pull-right">
						<ul>
							<li><a href="./products?p_cate1=home_deco">Home / Deco</a>					
								<ul>
									<li><a href="./products?p_cate2=furniture">furniture</a></li>	<!-- 가구 -->									
									<li><a href="./products?p_cate2=pottery">pottery</a></li>		<!-- 도자기 -->		
									<li><a href="./products?p_cate2=lamp">lamp</a></li>			<!-- 조명 -->									
								</ul>
							</li>															
							<li><a href="./products?p_cate1=candle_diffuser">Candle / Diffuser</a>
								<ul>
									<li><a href="./products?p_cate2=candle">candle</a></li>			<!-- 양초 -->										
									<li><a href="./products?p_cate2=diffuser">diffuser</a></li>			<!-- 디퓨저 -->
									<li><a href="./products?p_cate2=aromatic oils">aromatic oils</a></li>	<!-- 아로마오일 -->									
								</ul>		
								</li>	
							<li><a href="./products?p_cate1=art_fancy">Art / Fancy</a>
								<ul>									
									<li><a href="./products?p_cate2=picture">picture</a></li>		<!-- 사진 -->
									<li><a href="./products?p_cate2=fancy">fancy</a></li>		<!-- 문구 -->
									<li><a href="./products?p_cate2=paper">paper</a></li>		<!-- 페이퍼 -->
								</ul>
							</li>							
							<li><a href="./products?p_cate1=jewellery">Jewellery</a>
								<ul>									
									<li><a href="./products?p_cate2=earring">earring</a></li>		<!-- 귀걸이 -->
									<li><a href="./products?p_cate2=necklace">necklace</a></li>		<!-- 목걸이 -->
									<li><a href="./products?p_cate2=ring">ring</a></li>			<!-- 반지 -->
								</ul>
							</li>
							<li><a href="./products">Event</a></li>
						</ul>
					</nav>
				</div>
			</section>	
			<section class="header_text sub">
			<img class="pageBanner" src="<c:url value='/resources/themes/images/pageBanner.png' />" alt="New products" >
				<h4><span>New products</span></h4>
			</section>
			
			
			<!-- ----------------------------------------------------------------------------------------------------------------------------------------------- -->
			<!-- ----------------------------------------------------------------------------------------------------------------------------------------------- -->
			<!-- ----------------------------------------------------------------------------------------------------------------------------------------------- -->
			<!-- ----------------------------------------------------------------------------------------------------------------------------------------------- -->
			
			<section class="main-content">
				
				<div class="row">			
	
					<div class="span9">		
						<div class="row">
						<div class="span9">
							<h4 class="title">
								<span class="pull-left"><span class="text"><span
										class="line">Feature <strong>Products</strong></span></span></span> <span
									class="pull-right"> <a class="left button"
									href="#myCarousel" data-slide="prev"></a><a
									class="right button" href="#myCarousel" data-slide="next"></a>
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
												<c:forEach begin="0" end="8" varStatus="status"
													items="${productListByPcate }">
													<!-- 1번째 // 4 개씩 출력 -->
													<li class="span3">
														<div class="product-box">
															<span class="sale_tag">
																<%--  #index : ${4 * page + status.index} --%>
															</span>
															<p>
																<a
																	href="pDetail?p_no=${productListByPcate[9 * page + status.index].p_no }"><img
																	src="${productListByPcate[9 * page + status.index].p_img }" /></a>
															</p>
															<a
																href="pDetail?p_no=${productListByPcate[9 * page + status.index].p_no }"
																class="title">${productListByPcate[9 * page + status.index].p_name }</a><br>
															<a
																href="pDetail?p_no=${productListByPcate[9 * page + status.index].p_no }"
																class="category">${productListByPcate[9 * page + status.index].p_cate2}</a>
															<!-- 카테고리 -->
															<%-- <p class="price">₩ ${productList[4 * page + status.index].p_price }</p>	  --%>
															<p class="price">
																<fmt:formatNumber
																	value="${productListByPcate[9 * page + status.index].p_price}"
																	groupingUsed="true" />
																원
															</p>
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
														<c:forEach begin="0" end="8" varStatus="status"
															items="${productListByPcate }">
															<!-- 2번째 // 4 개씩 출력 -->
															<li class="span3">
																<div class="product-box">
																	<span class="sale_tag">
																		<%--  #index : ${4 * page + status.index} --%>
																	</span>
																	<p>
																		<a
																			href="pDetail?p_no=${productListByPcate[9 * page + status.index].p_no }"><img
																			src="${productListByPcate[9 * page + status.index].p_img }" /></a>
																	</p>
																	<a
																		href="pDetail?p_no=${productListByPcate[8 * page + status.index].p_no }"
																		class="title">${productListByPcate[9 * page + status.index].p_name }</a><br>
																	<a
																		href="pDetail?p_no=${productListByPcate[9 * page + status.index].p_no }"
																		class="category">${productListByPcate[9 * page + status.index].p_cate2}</a>
																	<!-- 카테고리 -->
																	<p class="price">
																		<fmt:formatNumber
																			value="${productListByPcate[9 * page + status.index].p_price}"
																			groupingUsed="true" />
																		원
																	</p>

																</div>
															</li>
														</c:forEach>

													</ul>
												</div>
											</c:forEach>
										</c:if>


										<!-- 마지막 페이지 -->
										<c:if test="${remainder != 0}">
											<c:forEach begin="${numOfPage-1}" end="${numOfPage-1}"
												var="page">
												<div class="item">
													<ul class="thumbnails">
														<%-- <c:forEach begin="0" end="4" var="i"> --%>
														<%-- ${productList.list[4 * page + i] } --%>
														<c:forEach begin="0" end="${remainder-1}"
															varStatus="status" items="${productListByPcate }">
															<!-- 3번째 // 4 개씩 출력 -->
															<li class="span3">
																<div class="product-box">
																	<span class="sale_tag">
																		<%--  #index : ${4 * page + status.index} --%>
																	</span>
																	<p>
																		<a
																			href="pDetail?p_no=${productListByPcate[9 * page + status.index].p_no }"><img
																			src="${productListByPcate[9 * page + status.index].p_img }" /></a>
																	</p>
																	<a
																		href="pDetail?p_no=${productListByPcate[9 * page + status.index].p_no }"
																		class="title">${productListByPcate[9 * page + status.index].p_name }</a><br>
																	<a
																		href="pDetail?p_no=${productListByPcate[9 * page + status.index].p_no }"
																		class="category">${productListByPcate[9 * page + status.index].p_cate2}</a>
																	<!-- 카테고리 -->
																	<p class="price">
																		<fmt:formatNumber
																			value="${productListByPcate[9 * page + status.index].p_price}"
																			groupingUsed="true" />
																		원
																	</p>

																</div>
															</li>
														</c:forEach>

													</ul>
												</div>
											</c:forEach>
										</c:if>
										<c:if test="${remainder == 0}">
											<c:forEach begin="${numOfPage-1}" end="${numOfPage-1}"
												var="page">
												<div class="item">
													<ul class="thumbnails">
														<%-- <c:forEach begin="0" end="4" var="i"> --%>
														<%-- ${productList.list[4 * page + i] } --%>
														<c:forEach begin="0" end="8" varStatus="status"
															items="${productListByPcate }">
															<!-- 3번째 // 4 개씩 출력 -->
															<li class="span3">
																<div class="product-box">
																	<span class="sale_tag">
																		<%--  #index : ${4 * page + status.index} --%>
																	</span>
																	<p>
																		<a
																			href="pDetail?p_no=${productListByPcate[9 * page + status.index].p_no }"><img
																			src="${productListByPcate[9 * page + status.index].p_img }" /></a>
																	</p>
																	<a
																		href="pDetail?p_no=${productListByPcate[9 * page + status.index].p_no }"
																		class="title">${productListByPcate[9 * page + status.index].p_name }</a><br>
																	<a
																		href="pDetail?p_no=${productListByPcate[9 * page + status.index].p_no }"
																		class="category">${productListByPcate[9 * page + status.index].p_cate2}</a>
																	<!-- 카테고리 -->
																	<p class="price">
																		<fmt:formatNumber
																			value="${productListByPcate[9 * page + status.index].p_price}"
																			groupingUsed="true" />
																		원
																	</p>

																</div>
															</li>
														</c:forEach>

													</ul>
												</div>
											</c:forEach>
										</c:if>

									</c:if>



									<!-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// -->
									<!-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// -->
									<!-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// -->





								</div>
							</div>
						</div>
					</div>				
						
						<%-- <ul class="thumbnails listing-products">
						
						
						<!-- ********** -->
						<!-- \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/ -->
						
						<c:forEach begin="0" end="8" varStatus="status" items="${productList }"><!-- 4 개씩 출력 -->
								<li class="span3">
								<div class="product-box">
									<span class="sale_tag"> #index : ${4 * page + status.index} </span>
										<p><a href="pDetail?p_no=${productList[4 * page + status.index].p_no }"><img src="${productList[4 * page + status.index].p_img }" /></a></p>
										<a href="pDetail?p_no=${productList[4 * page + status.index].p_no }" class="title">${productList[4 * page + status.index].p_name }</a><br>
										<a href="pDetail?p_no=${productList[4 * page + status.index].p_no }" class="category">${productList[4 * page + status.index].p_cate1}</a><!-- 카테고리 -->
										<p class="price"><fmt:formatNumber value="${productList[4 * page + status.index].p_price}" groupingUsed="true"/> 원</p>	
									</div>
								</li>
						</c:forEach>
						
						
						
						<!-- \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/ -->
						
							
							<li class="span3">
								<div class="product-box">
									<span class="sale_tag"></span>												
									<a href="product_detail.html"><img alt="" src="<c:url value='/resources/themes/images/ladies/9.jpg' />"></a><br/>
									<a href="product_detail.html" class="title">Fusce id molestie massa</a><br/>
									<a href="#" class="category">Phasellus consequat</a>
									<p class="price">$341</p>
								</div>
							</li>       
							<li class="span3">
								<div class="product-box">												
									<a href="product_detail.html"><img alt="" src="<c:url value='/resources/themes/images/ladies/8.jpg' />"></a><br/>
									<a href="product_detail.html" class="title">Praesent tempor sem</a><br/>
									<a href="#" class="category">Erat gravida</a>
									<p class="price">$28</p>
								</div>
							</li>
							<li class="span3">
								<div class="product-box">
									<span class="sale_tag"></span>												
									<a href="product_detail.html"><img alt="" src="<c:url value='/resources/themes/images/ladies/7.jpg' />"></a><br/>
									<a href="product_detail.html" class="title">Wuam ultrices rutrum</a><br/>
									<a href="#" class="category">Suspendisse aliquet</a>
									<p class="price">$341</p>
								</div>
							</li>
							
							<li class="span3">
								<div class="product-box">												
									<span class="sale_tag"></span>
									<a href="product_detail.html"><img alt="" src="<c:url value='/resources/themes/images/ladies/6.jpg' />"></a><br/>
									<a href="product_detail.html" class="title">Praesent tempor sem sodales</a><br/>
									<a href="#" class="category">Nam imperdiet</a>
									<p class="price">$49</p>
								</div>
							</li>
							<li class="span3">
								<div class="product-box">                                        												
									<a href="product_detail.html"><img alt="" src="<c:url value='/resources/themes/images/ladies/1.jpg' />"></a><br/>
									<a href="product_detail.html" class="title">Fusce id molestie massa</a><br/>
									<a href="#" class="category">Congue diam congue</a>
									<p class="price">$35</p>
								</div>
							</li>       
							<li class="span3">
								<div class="product-box">												
									<a href="product_detail.html"><img alt="" src="<c:url value='/resources/themes/images/ladies/2.jpg' />"></a><br/>
									<a href="product_detail.html" class="title">Tempor sem sodales</a><br/>
									<a href="#" class="category">Gravida placerat</a>
									<p class="price">$61</p>
								</div>
							</li>
							
							<li class="span3">
								<div class="product-box">												
									<a href="product_detail.html"><img alt="" src="<c:url value='/resources/themes/images/ladies/3.jpg' />"></a><br/>
									<a href="product_detail.html" class="title">Quam ultrices rutrum</a><br/>
									<a href="#" class="category">Orci et nisl iaculis</a>
									<p class="price">$233</p>
								</div>
							</li>
							<li class="span3">
								<div class="product-box">												
									<a href="product_detail.html"><img alt="" src="<c:url value='/resources/themes/images/ladies/4.jpg' />"></a><br/>
									<a href="product_detail.html" class="title">Tempor sem sodales</a><br/>
									<a href="#" class="category">Urna nec lectus mollis</a>
									<p class="price">$134</p>
								</div>
							</li>
							<li class="span3">
								<div class="product-box">												
									<a href="product_detail.html"><img alt="" src="<c:url value='/resources/themes/images/ladies/5.jpg' />"></a><br/>
									<a href="product_detail.html" class="title">Luctus quam ultrices</a><br/>
									<a href="#" class="category">Suspendisse aliquet</a>
									<p class="price">$261</p>
								</div>
							</li>
							
							
					<!-- ********** -->	
						</ul> --%>	
					
					
					
					<!-- ----------------------------------------------------------------------------------------------------------------------------------------------- -->
					<!-- ----------------------------------------------------------------------------------------------------------------------------------------------- -->
					<!-- **** 페이징 처리 **** -->								
					
						<!-- <hr>
						
						<div class="pagination pagination-small pagination-centered">
							<ul>
								<li><a href="#">Prev</a></li>
								<li class="active"><a href="#">1</a></li>
								<li><a href="#">2</a></li>
								<li><a href="#">3</a></li>
								<li><a href="#">4</a></li>
								<li><a href="#">Next</a></li>
							</ul>
						</div> -->
						
					</div>
					
					<!-- ----------------------------------------------------------------------------------------------------------------------------------------------- -->
					<!-- ----------------------------------------------------------------------------------------------------------------------------------------------- -->
					<!-- **** 카테고리 **** -->
					
					<div class="span3 col">
						<!-- <div class="block">	
							<ul class="nav nav-list">
								<li class="nav-header">SUB CATEGORIES</li>
								<li><a href="products.html">Nullam semper elementum</a></li>
								<li class="active"><a href="products.html">Phasellus ultricies</a></li>
								<li><a href="products.html">Donec laoreet dui</a></li>
								<li><a href="products.html">Nullam semper elementum</a></li>
								<li><a href="products.html">Phasellus ultricies</a></li>
								<li><a href="products.html">Donec laoreet dui</a></li>
							</ul>
							<br/>
							<ul class="nav nav-list below">
								<li class="nav-header">MANUFACTURES</li>
								<li><a href="products.html">Adidas</a></li>
								<li><a href="products.html">Nike</a></li>
								<li><a href="products.html">Dunlop</a></li>
								<li><a href="products.html">Yamaha</a></li>
							</ul>
						</div> -->
						<div class="block">
							<h4 class="title">
								<span class="pull-left"><span class="text">Randomize</span></span>
								<span class="pull-right">
									<a class="left button" href="#myCarousel" data-slide="prev"></a><a class="right button" href="#myCarousel" data-slide="next"></a>
								</span>
							</h4>
							<div id="myCarousel" class="carousel slide">
								<div class="carousel-inner">
									<div class="active item">
										<ul class="thumbnails listing-products">
											<li class="span3">
												<div class="product-box">
													<span class="sale_tag"></span>												
													<img alt="" src="<c:url value='/resources/themes/images/ladies/1.jpg'/>"><br/>
													<a href="product_detail.html" class="title">Fusce id molestie massa</a><br/>
													<a href="#" class="category">Suspendisse aliquet</a>
													<p class="price">$261</p>
												</div>
											</li>
										</ul>
									</div>
									<div class="item">
										<ul class="thumbnails listing-products">
											<li class="span3">
												<div class="product-box">												
													<img alt="" src="<c:url value='/resources/themes/images/ladies/2.jpg'/>"><br/>
													<a href="product_detail.html" class="title">Tempor sem sodales</a><br/>
													<a href="#" class="category">Urna nec lectus mollis</a>
													<p class="price">$134</p>
												</div>
											</li>
										</ul>
									</div>
								</div>
							</div>
						</div>
						<div class="block">								
							<h4 class="title"><strong>Best</strong> Seller</h4>								
							<ul class="small-product">
								<li>
									<a href="#" title="Praesent tempor sem sodales">
										<img src="<c:url value='/resources/themes/images/ladies/3.jpg' />" alt="Praesent tempor sem sodales">
									</a>
									<a href="#">Praesent tempor sem</a>
								</li>
								<li>
									<a href="#" title="Luctus quam ultrices rutrum">
										<img src="<c:url value='/resources/themes/images/ladies/4.jpg' />" alt="Luctus quam ultrices rutrum">
									</a>
									<a href="#">Luctus quam ultrices rutrum</a>
								</li>
								<li>
									<a href="#" title="Fusce id molestie massa">
										<img src="<c:url value='/resources/themes/images/ladies/5.jpg' />" alt="Fusce id molestie massa">
									</a>
									<a href="#">Fusce id molestie massa</a>
								</li>   
							</ul>
						</div>
					</div>
				</div>
			</section>
			
			
			<!-- ----------------------------------------------------------------------------------------------------------------------------------------------- -->
			<!-- ----------------------------------------------------------------------------------------------------------------------------------------------- -->
			<!-- ----------------------------------------------------------------------------------------------------------------------------------------------- -->
			<!-- ----------------------------------------------------------------------------------------------------------------------------------------------- -->
			
			
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
							<li><a href="seller/pRegister">pRegister</a></li>
						</ul>
					</div>
					<div class="span5">
						<p class="logo"><img src="<c:url value='/resources/themes/images/logo.png' />" class="site_logo" alt=""></p>
						<!-- <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. the  Lorem Ipsum has been the industry's standard dummy text ever since the you.</p> -->
						<br/>
						<span class="social_icons">
							<a class="facebook" href="#">Facebook</a>
							<a class="twitter" href="#">Twitter</a>
							<a class="skype" href="#">Skype</a>
							<a class="vimeo" href="#">Vimeo</a>
						</span>
					</div>					
				</div>	
			</section>
			<section id="copyright">
				<span>Copyright 2016. Monday To Friday all rights reserved.</span>
			</section>
		</div>
		<script src="<c:url value='/resources/themes/js/common.js'/>"></script>	
    </body>
</html>