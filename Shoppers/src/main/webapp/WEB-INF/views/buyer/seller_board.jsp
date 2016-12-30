<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>Bootstrap E-commerce Templates</title>
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


</head><!-- -------------------------------------------------------------- -->


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
						<li><a href="#">My Account</a></li>
						<li><a href="cart.html">Your Cart</a></li>
						<li><a href="checkout.html">Checkout</a></li>
						<li><a href="register.html">Login</a></li>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<div id="wrapper" class="container">
		<section class="navbar main-menu">
			<div class="navbar-inner main-menu">
				<a href="index.html" class="logo pull-left">
				<img src="<c:url value='/resources/themes/images/logo.png' />"
					class="site_logo" alt=""></a>
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
			<img class="pageBanner"
				src="<c:url value='/resources/themes/images/pageBanner.png' />"
				alt="New products">
				
				<h3 class="titlem"> 
				<span><strong>${sellerInfo.s_name}</strong> 게시판</span> 
			</h3> 
		
			
		</section>
		<section class="main-content">
			<div class="row">
				<div class="span12">
					<div class="accordion" id="accordion2">
					
						<!-- -------------------------------------------------------------- -->
					
					<h4>게시글 전체 목록</h4> 
					<table class="sbt">
    <tr>
        <th>번호</th>
        <th>제목</th>
        <th>작성자</th>
        <th>작성 시간</th>
    </tr>
    
    <c:forEach var="vo" items="${boardList}">
    <tr>
        <td>${vo.bd_bno }</td>
        <td><a href="${vo.bd_bno }">${vo.bd_title }</a></td>
        <td>${vo.bid }</td>
        <td>
	        <fmt:formatDate value="${vo.bd_reg }" 
	            pattern="yyyy-MM-dd HH:mm:ss"/>
        </td>
    </tr>
    </c:forEach>
</table>									
			
			<br/>
<ul class="pageLinks">
    <c:if test="${pageMaker.hasPrev }">
    <li id="page"><a href="${pageMaker.startPageNum - 1 }">&laquo;이전</a></li>
    </c:if>
    
    <c:forEach begin="${pageMaker.startPageNum }"
        end="${pageMaker.endPageNum }"
        var="num">
    <li id="page"><a href="${num }">${num }</a></li>
    </c:forEach>
    
    <c:if test="${pageMaker.hasNext }">
    <li id="page"><a href="${pageMaker.endPageNum + 1 }">다음&raquo;</a></li>
    </c:if>
    
</ul>

<%-- 현재 페이지, 페이지 당 보여줄 게시글 개수를 서버로 보내주기 위해서,
사용자에게는 보이지 않지만, 서버로 보낼 정보를 양식 데이터로 저장하는 form --%>
<form id="pageForm">
    <input type="hidden" name="bd_bno" />
    <input type="hidden" name="page" value="${pageMaker.criteria.page }" />
    <input type="hidden" name="perPage" value="${pageMaker.criteria.perPage }" />
     <input type="hidden" name="s_id" value="${sellerInfo.s_name}" />   
</form>		

<input type="button" id="btnregister" value="새글 작성"	>
						
						
						<!-- -------------------------------------------------------------- -->
									
					</div><!-- #### -->
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
</body>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script>
$(document).ready(function() {
	var frm = $('#pageForm');
	
    // table 안의 tr 안의 td 안의 a 태그 click 커스터마이징
    $('table tr td a').click(function() {
    	event.preventDefault();
    	var bno = $(this).attr('href');
    	frm.find('[name="bd_bno"]').val(bno);
    	frm.attr('action', 'seller_board_detail?s_id=${sellerInfo.s_name}');
    	frm.attr('method', 'get');
    	frm.submit();
    });
	
	// 클래스 pageLinks 안의 li 태그 안의 a 태그를 찾아서 click 이벤트를 커스터마이징
	$('.pageLinks li a').click(function() {
		event.preventDefault(); // 기본 이벤트 처리 방식을 방지(막음)
		// pageForm 안에 있는 name="page"인 요소를 찾아서
		// 이동할 페이지 번호를 세팅
		var targetPage = $(this).attr('href');
		frm.find('[name="page"]').val(targetPage);
		// 페이징 화면으로 보내기 위한 action 정보
		frm.attr('action', 'seller_board');
		// 페이징 화면을 처리하는 Controller의 method(요청 처리 방식)
		frm.attr('method', 'get');
		// 폼 양식을 서버로 전송
		frm.submit();
	});
	
	if ('${insert_result}' == 'success') {
		alert('새 글이 정상적으로 등록됐습니다.');
	} else if ('${insert_result}' == 'fail') {
		alert('새 글 등록 실패!');
	}
	
	$('#btnregister').click(function() {
		location = 'seller_board_register?s_id=${sellerInfo.s_name}';
	});
	
});
</script>

</html>