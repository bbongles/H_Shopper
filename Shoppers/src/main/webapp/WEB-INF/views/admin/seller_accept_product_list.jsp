
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
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
										<c:if test="${s_login_id eq 'admin'}">
							<li><a href="../admin/admin_mypage">My Page</a></li>
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
					</ul>
				</div>
			</div>
		</div>
	</div>
	<div id="wrapper" class="container">
		<section class="navbar main-menu">
			<div class="navbar-inner main-menu">
				<a href="../seller/main" class="logo pull-left"><img
					src="<c:url value='/resources/themes/images//logo.png" class="site_logo'/>"
					alt=""></a>
				<nav id="menu" class="pull-right">
					<ul>
						<li><a href="./products.html">Woman</a>
							<ul>
								<li><a href="./products.html">Lacinia nibh</a></li>
								<li><a href="./products.html">Eget molestie</a></li>
								<li><a href="./products.html">Varius purus</a></li>
							</ul></li>
						<li><a href="./products.html">Man</a></li>
						<li><a href="./products.html">Sport</a>
							<ul>
								<li><a href="./products.html">Gifts and Tech</a></li>
								<li><a href="./products.html">Ties and Hats</a></li>
								<li><a href="./products.html">Cold Weather</a></li>
							</ul></li>
						<li><a href="./products.html">Hangbag</a></li>
						<li><a href="./products.html">Best Seller</a></li>
						<li><a href="./products.html">Top Seller</a></li>
					</ul>
				</nav>
			</div>
		</section>
		<section class="header_text sub">
			
			<h3 class="titlem">
				<span><a href="admin_mypage"><strong>관리자</strong> 페이지</a></span>
			</h3> 
			
		</section>
		<section class="main-content">
			<div class="row">
				<div class="span5 sp">
					<h3 class="title">
						<span class="text"><strong>판매</strong> 관리</span>
					</h3>
					<form action="#" method="post">
						<input type="hidden" name="next" value="/">
						<fieldset>
							<div class="control-group">
								<label class="control-label"><a href="buyr" id="test">전체
										주문 요청 내역</a></label>

							</div>
							<div class="control-group">
								<label class="control-label"><a href="buyf">전체 판매 내역</a></label>
							</div>
							<!-- <div class="control-group">
								<label class="control-label"><a href="#">전체 판매
										통계</a></label>
							</div> -->
							</fieldset>
					<h3 class="title">
						<span class="text"><strong>회원</strong> 관리</span>
					</h3>
					<fieldset>
							<div class="control-group">
								<label class="control-label"><a
									href="seller_accept_list">판매자 회원 목록</a></label>
							</div>
							<div class="control-group">
								<label class="control-label"><a
									href="seller_accept_product_list">판매물 등록 승인</a></label>
							</div>
							<div class="control-group">
								<label class="control-label"><a href="listview">구매자
										회원 목록</a></label>
							</div>
							<hr>
						</fieldset>
					</form>
				</div>
				<div id="maindi" class="span7">
					<h3 class="title">
						<span class="text"><strong>판매물 </strong> 승인 내역</span>
					</h3>
					
					
						<fieldset>
							<div class="control-group cg">
								<select name = "searchType" class="searchSelect">
		<option value="n" <c:out value="${cri.searchType == null?'selected':'' }"/>>---</option>
		<option value="i" <c:out value="${cri.searchType eq 'i'?'selected':'' }"/>>판매자 ID</option>
		<option value="n" <c:out value="${cri.searchType eq 'n'?'selected':'' }"/>>상품번호</option>
		<option value="p" <c:out value="${cri.searchType eq 'p'?'selected':'' }"/>>상품명</option>
		<option value="in" <c:out value="${cri.searchType eq 'in'?'selected':'' }"/>>판매자 ID or 상품번호</option>
		<option value="ip" <c:out value="${cri.searchType eq 'ip'?'selected':'' }"/>>판매자 ID or 상품명</option>
		<option value="np" <c:out value="${cri.searchType eq 'np'?'selected':'' }"/>>상품번호 or 상품명</option>
		<option value="inp" <c:out value="${cri.searchType eq 'inp'?'selected':'' }"/>>판매자 ID or 상품번호 or 상품명</option>
	</select>
	
	<input type="text" name="keyword" id="keywordInput" class="searchi" value="${cri.keyword }">
	<button id='searchBtn'>Search</button>


	<table class="productT">
		<tr>
			<th>회원번호</th>
			<th>판매자 ID</th>
			<th>상품번호</th>
			<th>상품명(옵션)</th>
			<th>승인여부</th>
		</tr>

			<c:forEach var="pvo" items="${productList }">
			<c:forEach var="svo" items="${sellerList }">

				<tr>
				<c:if test="${pvo.s_id == svo.s_id }">
					<td>${svo.s_no}</td>
					<td>${pvo.s_id}</td>
					<td>${pvo.p_no }</td>
					<td>${pvo.p_name}<!--옵션정보 추가해줘야함 정훈이 코드 참고 --></td>
					<td class="s_acc">
						<c:if test="${pvo.p_acc == 0 }">
							<span class="sp">미승인&nbsp;&nbsp;&nbsp;</span>
							<button class="detail" name="accept">승인</button>
						</c:if>
						<c:if test="${pvo.p_acc == 1 }">
							승인
						</c:if>
					</td>
				</c:if>
				</tr>
			</c:forEach>
			</c:forEach>
	</table>
	
	
								<ul class="pageLinks">
									<li>-</li>
									<c:if test="${pageMaker.hasPrev }">
										<li id="page"><a href="${pageMaker.startPageNum - 1 }">&laquo;이전</a></li>
									</c:if>

									<c:forEach begin="${pageMaker.startPageNum }"
										end="${pageMaker.endPageNum }" var="num">
										<li id="page"><a href="${num }">${num }</a></li>
									</c:forEach>

									<c:if test="${pageMaker.hasNext }">
										<li id="page"><a href="${pageMaker.endPageNum + 1 }">다음&raquo;</a></li>
									</c:if>
									<li>-</li>

								</ul>
					
					<%-- 현재 페이지, 페이지 당 보여줄 게시글 개수를 서버로 보내주기 위해서, 사용자에게는 보이지 않지만, 서버로 보낼 정보를 양식 데이터로 저장하는 form --%>
					<form id="pageForm">
						<input type="hidden" name="page"
							value="${pageMaker.criteria.page }" /> <input type="hidden"
							name="perPage" value="${pageMaker.criteria.perPage }" />

					</form>

							</div>
							

						

						</fieldset>
				<hr>
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
					</ul>
				</div>
				<div class="span5">
					<p class="logo">
						<img src="<c:url value='../resources/themes/images/logo.png' />"
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
			<span>Copyright 2013 bootstrappage template All right
				reserved.</span>
		</section>
	</div>
	<script src="<c:url value='/resources/themes/js/common.js' />"></script>

	<script>
		$(document).ready(function() {
			$('#checkout').click(function(e) {
				document.location.href = "checkout.html";
			});

		});
	</script>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<script>
		$(document).ready(
				function() {

					var frm = $('#pageForm');

					// 클래스 pageLinks 안의 li 태그 안의 a 태그를 찾아서 click 이벤트를 커스터마이징
					$('.pageLinks li a').click(function() {
						event.preventDefault(); // 기본 이벤트 처리 방식을 방지(막음)
						// pageForm 안에 있는 name="page"인 요소를 찾아서
						// 이동할 페이지 번호를 세팅
						var targetPage = $(this).attr('href');
						console.log('targetPage=' + targetPage);
						frm.find('[name="page"]').val(targetPage);
						// 페이징 화면으로 보내기 위한 action 정보
						frm.attr('action', 'seller_accept_product_list');
						// 페이징 화면을 처리하는 Controller의 method(요청 처리 방식)
						frm.attr('method', 'get');
						// 폼 양식을 서버로 전송
						frm.submit();
					});

					$('#searchBtn').on( "click", function(event) { 
						
						self.location = "seller_accept_product_searchlist" 
							+ "?page=1"
							+ "&perPage=5"
							+ "&searchType="
							+ $("select option:selected").val()
							+ "&keyword=" + encodeURI($('#keywordInput').val());
				 	
					});
					
					$('.detail').on("click", function() {
						// s_no 값 찾기 	
						var p_no = this.parentNode.parentNode.childNodes[5].innerHTML;
						var p_acc = $(this).parent().children('.sp');
						var btn = $(this);
						console.log(p_no);
						
						 
						   $.ajax({
				                 type: "get",
				                 url: "productAcc",
				                 headers : {
				                  'Accept' : 'application/json',
				                  'Content-Type' : 'application/json'
				               },
				               dataType: "json",
				                 data: {p_no: p_no},
				                 success: function(data){
				                        if (data == 1){	
				                    	p_acc.text("승인");
				                    	btn.hide();
				                    	
				                    }
				                 },
				             });  
					});
					
				});
	</script>


</body>
</html>