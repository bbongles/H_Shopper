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
		<link href="<c:url value='/resources/bootstrap/css/bootstrap.min.css'/>" rel="stylesheet"> 
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
								<c:if test="${not empty b_login_id }">
							<li><a href="../mypage/buyermypage">My Page</a></li>	
							<li><a href="../cart/selectCart">Cart</a></li>
							</c:if>
							<c:if test="${empty s_login_id && empty b_login_id }">
								<c:url value="login" var="login" />
								<li><a href="${login}">Login</a></li>	
							</c:if>
							<c:if test="${not empty s_login_id || not empty b_login_id }">
								<!-- 세션에 로그인 정보가 있는 경우 -->
								<c:url value="../logout" var="logout" />
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
					<a href="index.html" class="logo pull-left"><img src="<c:url value='/resources/themes/images//logo.png" class="site_logo'/>" alt=""></a>
					<nav id="menu" class="pull-right">
						<ul>
							<li><a href="../products?p_cate1=home_deco">Home / Deco</a>					
								<ul>
									<li><a href="../products?p_cate2=furniture">furniture</a></li>	<!-- 가구 -->									
									<li><a href="../products?p_cate2=pottery">pottery</a></li>		<!-- 도자기 -->		
									<li><a href="../products?p_cate2=lamp">lamp</a></li>			<!-- 조명 -->									
								</ul>
							</li>															
							<li><a href="../products?p_cate1=candle_diffuser">Candle / Diffuser</a>
								<ul>
									<li><a href="../products?p_cate2=candle">candle</a></li>			<!-- 양초 -->										
									<li><a href="../products?p_cate2=diffuser">diffuser</a></li>			<!-- 디퓨저 -->
									<li><a href="../products?p_cate2=aromatic oils">aromatic oils</a></li>	<!-- 아로마오일 -->									
								</ul>		
								</li>	
							<li><a href="../products?p_cate1=art_fancy">Art / Fancy</a>
								<ul>									
									<li><a href="../products?p_cate2=picture">picture</a></li>		<!-- 사진 -->
									<li><a href="../products?p_cate2=fancy">fancy</a></li>		<!-- 문구 -->
									<li><a href="../products?p_cate2=paper">paper</a></li>		<!-- 페이퍼 -->
								</ul>
							</li>							
							<li><a href="../products?p_cate1=jewellery">Jewellery</a>
								<ul>									
									<li><a href="../products?p_cate2=earring">earring</a></li>		<!-- 귀걸이 -->
									<li><a href="../products?p_cate2=necklace">necklace</a></li>		<!-- 목걸이 -->
									<li><a href="../products?p_cate2=ring">ring</a></li>			<!-- 반지 -->
								</ul>
							</li>
							<li><a href="../products">Event</a></li>
						</ul>
					</nav>
				</div>
			</section>		 
		<section class="header_text sub">
		 
			<h3 class="titlem"> 
				<span><a href="buyermypage"><strong>MY</strong>  페이지</a></span>  
			</h3> 
			
		</section>
		<section class="main-content">
				
			<div class="row">
			
				<div class="span5 sp"> 
				
					<h3 class="title">
						<span class="text"><strong>구매</strong> 정보</span>
					</h3>
					<form action="#" method="post">
						<input type="hidden" name="next" value="/">
						<fieldset>
							<div class="control-group">
								<label class="control-label"><a href="buyermypage_orderlist" id="test">주문 배송 조회</a></label>

							</div>
							<div class="control-group">
								<label class="control-label"><a href="buyermypage_completelist">구매 내역</a></label>
							</div>
							
							</fieldset>
							
							
				<h3 class="title">
					<span class="text"><strong>개인</strong> 정보</span>
				</h3>
						<fieldset>
							<div class="control-group">
								<label class="control-label"><a
									href="#">개인 정보 수정</a></label>
							</div>
							<div class="control-group">
								<label class="control-label"><a
									href="#">회원 탈퇴</a></label>
							</div>
							
							<hr>
						</fieldset>
					</form>
				</div>
				
				<div id="maindi" class="span7">
					<h3 class="title">
						<span class="text"><strong>주문 배송</strong> 조회</span>
					</h3>
					
					
						<fieldset class="bm">
							<div class="control-buyer">
								
								
							</div> 
							<div id="maindiv" class="control-group">
							<table id="ordert">
									<caption><b>주문 배송 내역</b></caption>
									<tr>
										<th>주문번호</th>
										<th>주문일자</th>
										<th>상품명(옵션)</th>
										<th>판매자</th>
										<th>주문상태</th>
									</tr>		
							</table> 
						<ul class="pageLinks">
							
			
						</ul>
		
							
							
							
							
							</div>


						

						</fieldset>
						<%-- 현재 페이지, 페이지 당 보여줄 게시글 개수를 서버로 보내주기 위해서, 사용자에게는 보이지 않지만, 서버로 보낼 정보를 양식 데이터로 저장하는 form --%>
						<form id="pageForm">
			
			
						</form>
					
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
	

<input type="hidden" value="${b_login_id}" id="b_login_id">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
</body>

<script>
$(document).ready(function() {

	var b_id = $("b_login_id").val();


getOrderList();
getPageLinker();
getPageForm();

function getOrderList() {
	var url = '/shop05/userid/all5/' + b_id;
	$.getJSON(url, function(data) {
		var td = '';
		$(data).each(function(){ 
			var list = this['list']; 
			/* console.log(list); */
			var num = 0;
			$(list).each(function() {
				/* console.log(list); */
				var date = new Date(list[num].buy_date);
				var year = date.getFullYear();
				var month = date.getMonth();
				var day = date.getDate();
				var dateString = year + '년' + month + '월' + day + '일';
			
				var a = ''; 
				if (list[num].buy_status == 0){
				a = '입금대기'
				} else if (list[num].buy_status == 1){
				a = '결제확인중'
				} else if (list[num].buy_status == 2){
				a = '결제완료'
				} else if (list[num].buy_status == 3){ 
				a = '배송준비'
				}
			 
			
				 td += '<tr><td>' + list[num].buy_no + '</td>'
					+ '<td>' + dateString + '</td>'
					+ '<td>' + list[num].p_name + '&emsp;(' + list[num].o_cont + ')</td>'
				+ '<td>' + list[num].s_id + '&emsp;</td>'
				+ '<td>' + a + '</td></tr>';
				
				num++;
				});
		});
		
		$('#ordert > tbody:last').append(td);
		
		
	});
};  


function getPageLinker() {
	var url = '/shop05/userid/all5/' + b_id;
	$.getJSON(url, function(data) {
		var pi = '';
		var li = '';
		var ni = '';
		var l = ' <li>-</li> ';
		var frm = $('#pageForm');
		$(data).each(function(){ 
			var page = this['pageMaker']; 
			console.log(page); 
			if (page.hasPrev == true){
				pi ='<li id="page"><a href="' + page.startPageNum - 1 +'">&laquo;이전</a></li>';
			}
			if (page.hasNext == true){
				ni ='<li id="page"><a href="' + page.endPageNum + 1 +'">다음&raquo;</a></li>'
			}
			for (var num=page.startPageNum; num <= page.endPageNum; num++){
				
					li += '<li id="page"><a href=' + num + '>' + num + '</a></li> ' 
			}
			$('.pageLinks').append(l);
			$('.pageLinks').append(pi);		
			$('.pageLinks').append(li);
			$('.pageLinks').append(ni);
			$('.pageLinks').append(l);
			
			
			
			// 클래스 pageLinks 안의 li 태그 안의 a 태그를 찾아서 click 이벤트를 커스터마이징
			$('.pageLinks li a').click(function(event) {
				event.preventDefault(); // 기본 이벤트 처리 방식을 방지(막음)
				// pageForm 안에 있는 name="page"인 요소를 찾아서
				// 이동할 페이지 번호를 세팅
				var targetPage = $(this).attr('href');
				console.log('targetPage=' + targetPage);
				alert('targetPage=' + targetPage);
				frm.find('[name="page"]').val(targetPage);
				// 페이징 화면으로 보내기 위한 action 정보
				frm.attr('action', 'userid/all/'+ b_id);
				// 페이징 화면을 처리하는 Controller의 method(요청 처리 방식)
				frm.attr('method', 'get');
				// 폼 양식을 서버로 전송
				frm.submit(); 
			});
		});
		
		
		
		
	});
}; 

function getPageForm() {
	var url = '/shop05/userid/all5/' + b_id;
	$.getJSON(url, function(data) {
		var lnput = '';
		$(data).each(function(){ 
			var page = this['pageMaker']; 
			console.log(page); 
			
					lnput += '<input type="hidden" name="page" value="' + page.criteria.page + '" /> ' 
					 +	'<input type="hidden" name="perPage" value="' + page.criteria.perPage + '" /> ' 
			   
			$('#pageForm').append(lnput);
			
		});
		
		
		
		
	});
};   





	
	
});
</script>


</html>