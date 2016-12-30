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
<script src="<c:url value='/resources/editor/js/HuskyEZCreator.js' />"></script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>


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
			<h4>
				<span>Title</span>
			</h4>
		</section>
		<section class="main-content">
			<div class="row">
				<div class="span12">
					<div class="accordion" id="accordion2">
					
						<!-- -------------------------------------------------------------- -->
					
					<h1>게시글 상세 보기</h1>
	<form>
		글번호<br/>
		<input type="text" name="bd_bno" value="${board.bd_bno }" readonly /><br/>
		제목<br/>
		<input type="text" value="${board.bd_title }" readonly /><br/>
		본문<br/>
		<textarea name="editor" id="editor" rows="10" cols="100" style="width:766px; height:412px;" readonly>${board.editor }</textarea><br/>
		작성자 아이디<br/>
		<input type="text" value="${board.bid }" readonly /><br/>
		작성 시간<br/>
		<fmt:formatDate value="${board.bd_reg }" pattern="yyyy-MM-dd HH:mm:ss" var="regdate" />
		<input type="text" value="${regdate }" readonly /><br/>

		<input type="button" id="btnList" value="메인으로 돌아가기" />

	</form>
						
						
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
    $('#btnList').click(function() {
    	location = 'seller_board?s_id=${sellerInfo.s_name}';
    });
});

$(function(){
    //전역변수
    var obj = [];               
    //스마트에디터 프레임생성
    nhn.husky.EZCreator.createInIFrame({
        oAppRef: obj,
        elPlaceHolder: "editor",
        sSkinURI: "../resources/editor/SmartEditor2Skin.html",  
        htParams : {
            // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
            bUseToolbar : true,             
            // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
            bUseVerticalResizer : true,     
            // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
            bUseModeChanger : true, 
        }
    });
   
})
</script>

</html>