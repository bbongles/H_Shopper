<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 

<!DOCTYPE html>
<html>
	<head>
	<style>
		.select1 {
	   		 width: 90px;
		}
		.select2 {
	   		 width: 180px;
		}
		#sellerLogo {
			width: 100px;
			height: 100px;
		}
	</style>
		<meta charset="utf-8">
		<title>H-Shopper : 특별함을 전하는</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<meta name="description" content="">
		<!--[if ie]><meta content='IE=8' http-equiv='X-UA-Compatible'/><![endif]-->
		
		<!-- bootstrap -->
		<link href="<c:url value='/resources/bootstrap/css/bootstrap.min.css' />" rel="stylesheet">      
		<link href="<c:url value='/resources/bootstrap/css/bootstrap-responsive.min.css' />" rel="stylesheet">		
		<link href="<c:url value='/resources/themes/css/bootstrappage.css' />" rel="stylesheet"/>
		
		<!-- global styles -->
		<link href="<c:url value='/resources/themes/css/main.css' />" rel="stylesheet"/>
		<link href="<c:url value='/resources/themes/css/jquery.fancybox.css' />" rel="stylesheet"/>
				
		<!-- scripts -->
		<script src="<c:url value='/resources/themes/js/jquery-1.7.2.min.js' />"></script>
		<script src="<c:url value='/resources/bootstrap/js/bootstrap.min.js' />"></script>				
		<script src="<c:url value='/resources/themes/js/superfish.js' />"></script>	
		<script src="<c:url value='/resources/themes/js/jquery.scrolltotop.js' />"></script>
		<script src="<c:url value='/resources/themes/js/jquery.fancybox.js' />">
		</script>
		
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
							<li><a href="">Cart</a></li>
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
								<li><a href="../${login}">Login</a></li>	
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
					<a href="../buyer/main" class="logo pull-left"><img src="<c:url value='/resources/themes/images/logo.png' />" class="site_logo" alt=""></a>
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
			<img class="pageBanner" src="<c:url value='/resources/themes/images/pageBanner.png' />" alt="New products" >
				<h4><span>Product Detail</span></h4>
			</section>
			<section class="main-content">	
					
				<div class="row">	
				
				<!-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////  -->	
				<!-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////  -->	
				<!-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////  -->	
				<!-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////  -->	
					<form id="frm" action="/shop/cart/insertCart"> <!-- 태훈 수정 -->
						<!-- 김태훈 -->
						<input type="hidden" name="p_no" value="${productVO.p_no }" />    
    					<input type="hidden" name="s_id" value="${productVO.s_id }" />
    					<input type="hidden" name="p_price" value="${productVO.p_price }">
    					<input type="hidden" name="p_name" value="${productVO.p_name }">
    					<input type="hidden" name="p_no" value="${productVO.p_no }">
    					<input type="hidden" name="p_cate2" value="${productVO.p_cate2}">
    					<input type="hidden" value="${b_login_id}" name="b_id">
    					<input type="hidden" value="${productVO.p_img}" name="p_img">
					
					<div class="span9">
				<!-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////  -->	
				
						
						<div class="row">	<!-- 저품 메인정보 : 제품 메인사진 / 제품명 / 제품 정보  -->
						
							<div class="span4">		<!-- 사진 보기  -->
								
								<!-- 큰 이미지 보여주기 -->
								<a href="${productVO.p_img }" class="thumbnail" data-fancybox-group="group1" title="Description 1"><img alt="" src="${productVO.p_img }"></a>												
								
								<ul class="thumbnails small">	
									<c:forEach var="imageList" items="${imageList }" begin="0" end="2">
										<li class="span1">
											<a href="${imageList.i_img }" class="thumbnail" data-fancybox-group="group1" title="Description 2"><img src="${imageList.i_img }" alt=""></a>
										</li>
									</c:forEach>
								
															
									<%-- 
									<li class="span1">
										<a href="<c:url value='/resources/themes/images/ladies/2.jpg' />" class="thumbnail" data-fancybox-group="group1" title="Description 2"><img src="<c:url value='/resources/themes/images/ladies/2.jpg' />" alt=""></a>
									</li>								
									<li class="span1">
										<a href="<c:url value='/resources/themes/images/ladies/3.jpg' />" class="thumbnail" data-fancybox-group="group1" title="Description 3"><img src="<c:url value='/resources/themes/images/ladies/3.jpg' />" alt=""></a>
									</li>													
									<li class="span1">
										<a href="<c:url value='/resources/themes/images/ladies/4.jpg' />" class="thumbnail" data-fancybox-group="group1" title="Description 4"><img src="<c:url value='/resources/themes/images/ladies/4.jpg' />" alt=""></a>
									</li>
									<li class="span1">
										<a href="<c:url value='/resources/themes/images/ladies/5.jpg' />" class="thumbnail" data-fancybox-group="group1" title="Description 5"><img src="<c:url value='/resources/themes/images/ladies/5.jpg' />" alt=""></a>
									</li>
									 --%>
								</ul>
							</div>
							
							<div class="span5">		<!-- 제품 이름, 가격, 재고 -->
								<address>
									<strong>Category : </strong> <span>${productVO.p_cate2 }</span><br>
									<strong>Product Code : </strong> <span>${productVO.p_no }</span><br>
									<strong>Product Name : </strong> <strong>${productVO.p_name }</strong><br>
									<strong>Availability : </strong> <span>${productVO.p_stock }개</span><br>								
									<strong>delivery : </strong> <span>업체조건배송 </span><br>
								</address>									
								<h4><strong><fmt:formatNumber value="${productVO.p_price }" groupingUsed="true"/> 원</strong></h4>
							</div>
							
							<div class="span5" >		<!-- 주문하기 -->
								<br>
								<div id="optionNullCheck" style="display:none;">		<!-- ******** -->
									<select class="select1">		<!-- 옵션 -->
					    				<!-- <option value="">--------</option> -->
					    				<c:forEach var="optionList" items="${optionList}" end="0">
					    					<option>${optionList.o_title }</option>
					    				</c:forEach>
					    			</select>
					    			<select class="select2" name="o_cont">
					    				<!-- <option value="">----------------</option> -->
					    				<c:forEach var="optionList" items="${optionList }">
					    					<option>${optionList.o_cont }</option>
					    				</c:forEach>
					    			</select>
								</div>
								<div class="form-inline">
									<!-- 
										<label class="checkbox">
											<input type="checkbox" value=""> Option one is this and that
										</label>
										<br/>
										<label class="checkbox">
										  <input type="checkbox" value=""> Be sure to include why it's great
										</label>
									 -->
									<p>&nbsp;</p>
									<label>Quantity : </label>
									<input type="number" name="buy_cnt" class="span1" value="1">
									<button class="btn btn-inverse" type="submit">Add to cart</button><!-- TODO  -->
									<input type="button" class="btn btn-inverse" value="Check out" id="directOrder"/><!-- 태훈 수정 -->
									
								</div>
							</div>	
								
												
						</div>
						
						<div class="row">
							<div class="span9">
								<ul class="nav nav-tabs" id="myTab">
									<li class="active"><a href="#tab1">작품정보</a></li>		<!-- 먼저 탭이 열려 있어야 함 -->
									<li class=""><a href="#tab2">구매후기</a></li>
									<li class=""><a href="#tab3">Q&A</a></li>
								</ul>	
														 
								<div class="tab-content">
								
									<!-- 첫번째 탭 -->
									<div class="tab-pane active" id="tab1">
										<!-- Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem -->
										<c:forEach var="imageList" items="${imageList }">
								    		<div style="text-align: center;" id="contentList">
								    			<img src="${imageList.i_img }" class="detailImg" /><br/><br/>
								    			<span class="detailCont">${imageList.i_cont }</span><br/><br/><br/>
								    		</div>
								    	</c:forEach>
									</div>
									
									<!-- 두번째 탭 -->
									<div class="tab-pane" id="tab2">
										<table class="table table-striped shop_attributes">	
											<tbody>
												<tr class="">
													<th>Size</th>
													<td>Large, Medium, Small, X-Large</td>
												</tr>		
												<tr class="alt">
													<th>Colour</th>
													<td>Orange, Yellow</td>
												</tr>
											</tbody>
										</table>
									</div>
									
									<!-- 세번째 탭 -->
									<div class="tab-pane" id="tab3">
										123456789!@#$%^
									</div>
									
								</div>	
							</div>		
							
							
							
							<div class="span9">	
								<br>
								<h4 class="title">
									<span class="pull-left"><span class="text"><strong>Related</strong> Products</span></span>
									<span class="pull-right">
										<a class="left button" href="#myCarousel-1" data-slide="prev"></a><a class="right button" href="#myCarousel-1" data-slide="next"></a>
									</span>
								</h4>
								
								
								
					<!-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////  -->			
					<!-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////  -->			
								
								
								
								<div id="myCarousel-1" class="carousel slide">
									<div class="carousel-inner">
					<!-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////  -->				
										<!-- 첫번째 페이지 -->
											<div class="active item">		
												<ul class="thumbnails">	
													<c:forEach begin="0" end="0" var="page">
													<c:forEach begin="0" end="3" varStatus="status" items="${relativeList }"><!-- 4 개씩 출력 -->
															<li class="span3">
															<div class="product-box">
																<span class="sale_tag"><%--  #index : ${4 * page + status.index} --%> </span>
																	<p><a href="pDetail?p_no=${relativeList[4 * page + status.index].p_no }"><img src="${relativeList[4 * page + status.index].p_img }" /></a></p>
																	<a href="pDetail?p_no=${relativeList[4 * page + status.index].p_no }" class="title">${relativeList[4 * page + status.index].p_name }</a><br>
																	<a href="pDetail?p_no=${relativeList[4 * page + status.index].p_no }" class="category">${relativeList[4 * page + status.index].p_cate1}</a><!-- 카테고리 -->
																	<%-- <p class="price">₩ ${productList[4 * page + status.index].p_price }</p>	  --%>
																	<p class="price"><fmt:formatNumber value="${relativeList[4 * page + status.index].p_price}" groupingUsed="true"/> 원</p>	
																</div>
															</li>
													</c:forEach>
													</c:forEach> 
												</ul>
											</div>
								
									<c:if test="${numOfPage >= 2}">
											<!-- 두번째 페이지 이상 ~ -->
										<c:if test="${numOfPage >= 3}">
												<c:forEach begin="1" end="${numOfPage-2 }" var="page">
												<div class="item">		
													<ul class="thumbnails">	
														<%-- <c:forEach begin="0" end="4" var="i"> --%>
															<%-- ${productList.list[4 * page + i] } --%>
														<c:forEach begin="0" end="3" varStatus="status" items="${relativeList }"><!-- 4 개씩 출력 -->
															<li class="span3">
															<div class="product-box">
																<span class="sale_tag"><%--  #index : ${4 * page + status.index} --%> </span>
																	<p><a href="pDetail?p_no=${relativeList[4 * page + status.index].p_no }"><img src="${relativeList[4 * page + status.index].p_img }" /></a></p>
																	<a href="pDetail?p_no=${relativeList[4 * page + status.index].p_no }" class="title">${relativeList[4 * page + status.index].p_name }</a><br>
																	<a href="pDetail?p_no=${relativeList[4 * page + status.index].p_no }" class="category">${relativeList[4 * page + status.index].p_cate1}</a><!-- 카테고리 -->
																	<p class="price"><fmt:formatNumber value="${relativeList[4 * page + status.index].p_price}" groupingUsed="true"/> 원</p> 
																	
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
														<c:forEach begin="0" end="${remainder-1}" varStatus="status" items="${relativeList }"><!-- 4 개씩 출력 -->
															<li class="span3">
															<div class="product-box">
																<span class="sale_tag"><%--  #index : ${4 * page + status.index} --%> </span>
																	<p><a href="pDetail?p_no=${relativeList[4 * page + status.index].p_no }"><img src="${relativeList[4 * page + status.index].p_img }" /></a></p>
																	<a href="pDetail?p_no=${relativeList[4 * page + status.index].p_no }" class="title">${relativeList[4 * page + status.index].p_name }</a><br>
																	<a href="pDetail?p_no=${relativeList[4 * page + status.index].p_no }" class="category">${relativeList[4 * page + status.index].p_cate1}</a><!-- 카테고리 -->
																	<p class="price"><fmt:formatNumber value="${relativeList[4 * page + status.index].p_price}" groupingUsed="true"/> 원</p> 
																	
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
														<c:forEach begin="0" end="3" varStatus="status" items="${relativeList }"><!-- 4 개씩 출력 -->
															<li class="span3">
															<div class="product-box">
																<span class="sale_tag"><%--  #index : ${4 * page + status.index} --%> </span>
																	<p><a href="pDetail?p_no=${relativeList[4 * page + status.index].p_no }"><img src="${relativeList[4 * page + status.index].p_img }" /></a></p>
																	<a href="pDetail?p_no=${relativeList[4 * page + status.index].p_no }" class="title">${relativeList[4 * page + status.index].p_name }</a><br>
																	<a href="pDetail?p_no=${relativeList[4 * page + status.index].p_no }" class="category">${relativeList[4 * page + status.index].p_cate1}</a><!-- 카테고리 -->
																	<p class="price"><fmt:formatNumber value="${relativeList[4 * page + status.index].p_price}" groupingUsed="true"/> 원</p> 
																	
																</div>
															</li>
														</c:forEach>
													</ul>
												</div>
											</c:forEach> 
										</c:if>	
										
										
									</c:if>
					<!-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////  -->					
									</div>
								</div>
								
								
								
							</div>
						</div>
						
						
						
						<!--  삭제버튼  -->
						<!-- 김태훈 코드시작,  바이어로 로그인했을때 디테일에서 상품 삭제버튼 안보이게함(코드를 지우지는 안았음) -->
						<!-- <input class="btn btn-inverse" type="button" id="delProduct" value="Delete" /> -->
						<!-- 김태훈 코드끝 -->
						<input class="btn btn-inverse" type="button" id="gotoList" value="Home" />
						
						
					<!-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////  -->	
					<!-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////  -->	
					</div>
					</form>
					<!-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////  -->
					<!-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////  -->	
					<!-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////  -->	
					
					<!-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////  -->	
					
					
					<div class="span3 col">
						<!-- 김태훈 코드 추가 로고 눌러서 판매자 홈으로-->
						<div class="block">	
						<h4 class="title"><strong>Seller</strong> Home</h4>
						<a href="sellerHome?s_id=${productVO.s_id}"><img id="sellerLogo" src="${sVo.s_logo}"></a>
						</div>
						<!-- 김태훈 코드 추가 끝 -->
						
						<!-- 현 시점(최종 프로젝트 발표)에서는 필요 없을듯하여 주석처리.... 나중에 사용하게 되면 수정하여 사용하기로.... -->
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
													<a href="product_detail.html"><img alt="" src="<c:url value='/resources/themes/images/ladies/7.jpg' />"></a><br/>
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
													<a href="product_detail.html"><img alt="" src="<c:url value='/resources/themes/images/ladies/8.jpg' />"></a><br/>
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
										<img src="<c:url value='/resources/themes/images/ladies/1.jpg' />" alt="Praesent tempor sem sodales">
									</a>
									<a href="#">Praesent tempor sem</a>
								</li>
								<li>
									<a href="#" title="Luctus quam ultrices rutrum">
										<img src="<c:url value='/resources/themes/images/ladies/2.jpg' />" alt="Luctus quam ultrices rutrum">
									</a>
									<a href="#">Luctus quam ultrices rutrum</a>
								</li>
								<li>
									<a href="#" title="Fusce id molestie massa">
										<img src="<c:url value='/resources/themes/images/ladies/3.jpg' />" alt="Fusce id molestie massa">
									</a>
									<a href="#">Fusce id molestie massa</a>
								</li>   
							</ul>
						</div>
					</div>
				</div>
				
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
							<li><a href="seller/pRegister">pRegister</a></li>
						</ul>
					</div>
					<div class="span5">
						<p class="logo"><img src="<c:url value='/resources/themes/images/logo.png' />" class="site_logo" alt=""></p>
						<p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. the  Lorem Ipsum has been the industry's standard dummy text ever since the you.</p>
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
				<span>Copyright 2013 bootstrappage template  All right reserved.</span>
			</section>
		</div>
		
		<!-- 김태훈 백버튼 리프레시 -->
		<input type="hidden" id="refreshed" value="no" style="display: none">
		<script src="<c:url value='/resources/themes/js/common.js' />"></script>
		<script>
			$(function () {
				$('#myTab a:first').tab('show');
				$('#myTab a').click(function (e) {
					e.preventDefault();
					$(this).tab('show');
				})
			})
			$(document).ready(function() {
				$('.thumbnail').fancybox({
					openEffect  : 'none',
					closeEffect : 'none'
				});
				
				$('#myCarousel-2').carousel({
                    interval: 2500
                });								
			});
		</script>
		
		<script>
	    	// 게시글 삭제
		    $('#delProduct').click(function() {
		    	var result = confirm('정말 삭제하시겠습니까?');
		    	if (result == true) {
		    		$('#frm').attr('action', 'seller/pDelete');
		    		$('#frm').attr('method', 'post');
		    		$('#frm').submit();
		    	}
		    });
		    
	    	// 리스트
		    $('#gotoList').click(function() {
		    	location = 'main';
		    }); 
	    	
	    	// 옵션 없을시 hidden
	    	$(document).ready(function(){
	    		if("${optionList}"!="[]"){
	    			$('#optionNullCheck').show();
	    		}
	    	})
	    	
	    	 // 김태훈 바로주문 코드
		    $('#directOrder').click(function(){
				$('#frm').attr('action', '/shop/cart/insertCertForDirect');
				$('#frm').attr('method', 'get');
				$('#frm').submit();
		    });
	    	
	    	// 김태훈 백버튼 리프레시 코드
			onload=function(){
			var e=document.getElementById("refreshed");
			if(e.value=="no")e.value="yes";
			else{e.value="no";location.reload();}
			}
		</script>
    </body>
</html>