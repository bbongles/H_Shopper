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
		<link href="<c:url value='/resources/bootstrap/css/bootstrap.min3.css'/>" rel="stylesheet"> 
		<link href="<c:url value='/resources/bootstrap/css/bootstrap-responsive.min3.css' />" rel="stylesheet">		
		<link href="<c:url value='/resources/themes/css/bootstrappage.css' />" rel="stylesheet"/>
		
		<!-- global styles -->
		<link href="<c:url value='/resources/themes/css/flexslider.css' />" rel="stylesheet"/>
		<link href="<c:url value='/resources/themes/css/main2.css' />" rel="stylesheet"/>

		<!-- scripts -->
		<script src="<c:url value='/resources/themes/js/jquery-1.7.2.min.js' />"></script>
		<script src="<c:url value='/resources/bootstrap/js/bootstrap.min.js' />"></script>				
		<script src="<c:url value='/resources/themes/js/superfish.js' />"></script>	
		<script src="<c:url value='/resources/themes/js/jquery.scrolltotop.js' />"></script>
		<!--[if lt IE 9]>			
			<script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
			<script src="js/respond.min.js"></script>
		<![endif]-->
		
<style>
.radio-inline {

  clear: none;
  display: block;
  padding: 2px 1em 0 0;
}

.birth-lbl {
	clear: both;
} 

 label {
 	clear: left;
 }

input[type=radio],
input.radio {
  float: left;
  clear: none;
  margin: 2px 0 0 2px;
}

/* .emailclass {
	display: none;
} */
</style>		
		
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
							<li><a href="#">My Account</a></li>
							<li><a href="cart.html">Your Cart</a></li>
							<li><a href="checkout.html">Checkout</a></li>					
							<li><a href="register.jsp">Login</a></li>		
						</ul>
					</div>
				</div>
			</div>
		</div>
		<div id="wrapper" class="container">
			<section class="navbar main-menu">
				<div class="navbar-inner main-menu">				
					<a href="/shop/buyer/main" class="logo pull-left"><img src="<c:url value='/resources/themes/images//logo.png" class="site_logo'/>" alt=""></a>
					<nav id="menu" class="pull-right">
						<ul>
							<li><a href="./products.html">Woman</a>					
								<ul>
									<li><a href="./products.html">Lacinia nibh</a></li>									
									<li><a href="./products.html">Eget molestie</a></li>
									<li><a href="./products.html">Varius purus</a></li>									
								</ul>
							</li>															
							<li><a href="./products.html">Man</a></li>			
							<li><a href="./products.html">Sport</a>
								<ul>									
									<li><a href="./products.html">Gifts and Tech</a></li>
									<li><a href="./products.html">Ties and Hats</a></li>
									<li><a href="./products.html">Cold Weather</a></li>
								</ul>
							</li>							
							<li><a href="./products.html">Hangbag</a></li>
							<li><a href="./products.html">Best Seller</a></li>
							<li><a href="./products.html">Top Seller</a></li>
						</ul>
					</nav>
				</div>
			</section>		 
		<section class="header_text sub">
		 
			<h3 class="titlem"> 
				<span><a href="buyermypage"><strong>비밀번호</strong>  재설정</a></span>  
			</h3> 
			
		</section>
		<section class="main-content" >
				
			<div class="row" id="mainrow" >
				
				<div id="maindi" class="span5" >
					<h3 class="title">
						<span class="text"><strong>회원님 아이디의 </strong>비밀번호 변경</span>
					</h3>
					
				<section class="main-content">
					<div class="row">
						<div>
							<div class="accordion" id="accordion2">
													<!-- 구매자 회원가입 -->
						<div class="accordion-group">
<!-- 							<div class="accordion-heading">
								<a class="accordion-toggle" data-toggle="collapse"
									data-parent="#accordion2" href="#collapseOne">Sign up for Buyer</a>
							</div> -->
							<div id="collapseOne" class="accordion-body in collapse">
								<div class="accordion-inner">
									<div class="row-fluid">
									<h4 class="title"><span class="text"><strong>Find</strong> Form</span></h4>
									
<!-- 									<form action="findidforlogin" id="findform">** submit -->

												<div class="control-group">
												<label>아이디</label> 
												<div class="controls">
													<input class="input-xlarge" type="text" name="s_id" 
													id="s_id" value="${vo.s_id }" disabled/>
												</div>

												<div class="control-group">
												 	<label for="s_pw">새 비밀번호 입력</label> 
												 	<div class="controls">
													 	<input required name="s_pw" type="password" class="input-xlarge"
															minlength="4" maxlength="16" id="s_pass1" 
															placeholder="비밀번호" style="font-family: verdana" />
													</div>
												 </div><!-- ### 완료 ###-->
	
												 <div class="control-group">
													<label for="s_pw_check">새 비밀번호 확인 &nbsp;&nbsp;
														<span id="s_confirmMessage"></span> 
													</label> 
													<div class="controls">
														<input required name="s_pw_check"
															type="password" class="input-xlarge" minlength="4"
															maxlength="16" placeholder="비밀번호 확인(위와 동일하게 입력하세요)" id="s_pass2"
															onkeyup="s_checkPass(); return false;" style="font-family: verdana" /> 
													</div> <!-- TODO :  -->
												 </div><!-- ### 완료 ###-->
																				 

<!-- 													 <input tabindex="9" class="btn btn-inverse large" 
													type="submit" value="로그인" /> -->

											<!-- -------------------------------------------------------------- -->
									
										</div>
														
 											<div class="actions">
												<button tabindex="9" class="btn btn-inverse large" 
												type="button" id="btnforupdate" disabled >변경완료</button>
											</div>
											<br>

									</div>
								</div>
							</div>
						</div><!-- End 구매자 회원가입 -->
					
					
							</div>
						</div>
						</section>
					</div>
					</div>
				</section>
						<hr>
				</div>


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
						<p class="logo"><img src="<c:url value='../resources/themes/images/logo.png' />" class="site_logo" alt=""></p>
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
	
	<script src=<c:url value='/resources/themes/js/common.js'/>></script>
</body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script>
$(document).ready(function() {

	$('#btnforupdate').click(function() {
		var pw1 = $('#s_pass1').val();
		var pw2 = $('#s_pass2').val();
		if(pw1 == pw2) {
		/* document.location.replace("../login"); */
		var s_pw = $("#s_pass2").val();
		var s_id = $('#s_id').val();
		$.ajax({
			type : 'post',
			url : 'findpwforupdate',
			headers:{
	             'Content-Type': 'application/json',
	             'X-HTTP-Method-Override': 'POST'
	         },
			data : JSON.stringify({
				s_pw: s_pw,
				s_id: s_id,
	         }),
			success : function(result) {
				if (result == 1) {
					alert('비밀번호 재설정 성공.')
					document.location.replace("../login"); 
				} else {
					alert('비밀번호가 틀렸습니다.');
					location.reload();
				}
			}
		});
		} else {
			location.reload();
			alert('입력하신 비밀번호가 일치하지 않습니다..');
		}	
	})


});

</script>

<script src="<c:url value='/resources/css/findpwjs.js?ver=12' />"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>


</html>