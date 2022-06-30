<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE HTML>
<html>
<head>
<meta charset="UTF-8" />
<title>Tìm kiếm sản phẩm</title>
<script src="https://accounts.google.com/gsi/client" async defer></script>
<script src="https://unpkg.com/jwt-decode/build/jwt-decode.js"></script>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="${host}/font-awesome-4.7.0/css/font-awesome.min.css"
	rel="stylesheet" type="text/css">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/all.css">
<!-- <link rel="stylesheet" href="../css/main.css"> -->
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/main.css" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/grid.css" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/home.css" />
<link rel="icon"
	href="https://tonycongmmo.com/wp-content/uploads/2020/09/cropped-landingpage-clean-studio-logo-4-flatsome-theme-uxbuilder-32x32.png"
	sizes="32x32">
<link rel="icon"
	href="https://tonycongmmo.com/wp-content/uploads/2020/09/cropped-landingpage-clean-studio-logo-4-flatsome-theme-uxbuilder-192x192.png"
	sizes="192x192">
<script src="${host}/js/jquery-3.6.0.min.js"></script>
<style>
</style>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<!-- add-cart -->
<script type="text/javascript">
	function addCart(id) {
		// cost
		console.log(id);
		var url = "ajax/add-cart?id=" + id;
		$.ajax({
			url : url,
			success : processAddCart,
			cache : false
		});
	}

	function processAddCart(responseData) {
		alert("Sản phẩm đã được thêm vào giỏ hàng!!!")
		// 		$('#cart-table').load('https://localhost/cart');
		// 		$('#total-cost').load('https://localhost/cart');
	}
</script>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/assets/styles.css" />
</head>
<body>
	<div class="wrapper">
		<div class="masthead">
			<div class="grid wide header-masthread">
				<label for="nav-mobile-input" class="icon-bar-mobile"> <i
					class="fa fa-bars"></i>
				</label>
				<!-- Logo -->
				<div class="logo">
				</div>
				<!-- TÌm kiếm -->
				<div class="masthead-search">
					<div class="masthead-search-box">
						<form action="search" class="header-search-form">
							<input type="text" placeholder="Tìm kiếm sản phẩm theo tên"
								class="header-search-input" name="search">
							<button type="submit" class="header-search-icon">
								<i class="fa fa-search"></i>
							</button>
						</form>
					</div>
				</div>
				<div class="masthead-right">
					<div class="masthead-right-box">
						<!-- Giỏ hàng -->
						<!-- Đây là giỏ hàng nhỏ -->
						<div class="cart">
							<span class="cart-text">GIỎ HÀNG</span>
							<div class="logo-cart-box">
								<div class="logo-cart">0</div>
							</div>
							<ul class="nav-dropdown">
								<a href="${pageContext.request.contextPath}/cart" class="tag-a"
									style="color: #fff;">
									<div class="btn-cart-view btn">
										<span>XEM GIỎ HÀNG</span>
									</div>
								</a>
								<div class="nav-dropdown-hover"></div>
							</ul>
						</div>
						<!-- Đăng kí -->
						<div class="login">
							<a href="${pageContext.request.contextPath}/register"
								class="tag-a" style="color: #000;"><span class="">ĐĂNG
									KÝ</span></a>
						</div>
						<div class="login">
							<a href="${pageContext.request.contextPath}/login" class="tag-a"
								style="color: #000;"><span class="">ĐĂNG NHẬP</span></a>
						</div>
					</div>
				</div>
			</div>
			<input type="checkbox" name="" class="nav__input"
				id="nav-mobile-input" hidden=""> <label
				for="nav-mobile-input" class="nav__overlay"></label>

			<div class="wide-nav">
				<label for="nav-mobile-input" class="close__overlay"> <i
					class="fa fa-times"></i>
				</label>
				<div class="wide-nav-box">
					<div class="masthead-search-mobile">
						<div class="masthead-search-box">
						</div>
					</div>
					<div class="menu">
						<div class="container">
							<ul class="nav">
								<li><a href="${pageContext.request.contextPath}/">VỀ
										TRANG CHỦ</a></li>
								<li class="hidden1">
									<div class="nam">
										<a href="">NAM</a>
										<ul class="nam-item">
											<li><a href="">Sandal</a></li>
											<li><a href="">Giày Thể Thao</a></li>
											<li><a href="">Giày Chạy Bộ</a></li>
											<li><a href="">Giày Đá Banh</a></li>
											<li><a href="">Giày Tây</a></li>
											<li><a href="">Dép</a></li>
										</ul>
									</div>
								</li>
								<li class="hidden2">
									<div class="nu">
										<a href="">NỮ</a>
										<ul class="nu-item">
											<li><a href="">Sandal</a></li>
											<li><a href="">Giày Búp Bê</a></li>
											<li><a href="">Giày Thể Thao</a></li>
											<li><a href="">Giày Chạy Bộ</a></li>
											<li><a href="">Giày Thời Trang</a></li>
											<li><a href="">Dép</a></li>
										</ul>
									</div>
								</li>
								<li class="hidden3">
									<div class="betrai">
										<a href="">BÉ TRAI</a>
										<ul class="betrai-item">
											<li><a href="">Sandal</a></li>
											<li><a href="">Giày Thể Thao</a></li>
											<li><a href="">Dép</a></li>
											<li><a href="">Giày Tập Đi</a></li>
										</ul>
									</div>
								</li>
								<li class="hidden4">
									<div class="begai">
										<a href="">BÉ GÁI</a>
										<ul class="begai-item">
											<li><a href="">Sandal</a></li>
											<li><a href="">Giày Thể Thao</a></li>
											<li><a href="">Giày Búp Bê</a></li>
											<li><a href="">Dép</a></li>
											<li><a href="">Giày Tập Đi</a></li>
										</ul>
									</div>
								</li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	</header>
	</div>

	<style>
.nav-item:nth-child(1) {
	background-color: #c1c1c1;
}

.wide-nav-items-span {
	color: #777;
}

.danhmuc-trangchu {
	color: #000 !important;
}
</style>
	<div class="main">
		<div class="sort">
			<b>Lọc sản phẩm theo:</b> <select name="sort-by" id="sort-by"
				onchange="" onchange="">
				<option value="${sortDefault}">${sortDefault}</option>
				<c:forEach items="${sortBy}" var="sort">
					<c:if test="${sort ne sortDefault}">
						<option value="${sort}">${sort}</option>
					</c:if>
				</c:forEach>
			</select> <b>Chọn:</b> <select name="sort-by" id="sort-by" onchange=""
				onchange="">
				<option value="${sortDefault}">${sortDefault}</option>
				<c:forEach items="${sortBy}" var="sort">
					<c:if test="${sort ne sortDefault}">
						<option value="${sort}">${sort}</option>
					</c:if>
				</c:forEach>
			</select>
		</div>
		<div class="main-content">



			<link rel="stylesheet" type="text/css"
				href="${pageContext.request.contextPath}/css/chitietsanpham.css" />
			<style>
.modal_quick_view {
	position: fixed;
	top: 0;
	right: 0;
	left: 0;
	bottom: 0;
	background-color: rgba(0, 0, 0, 0.4);
	z-index: 20;
	display: flex;
	align-items: center;
	justify-content: center;
	display: none;
}

.container_quick_view {
	width: 875px;
	height: 90vh;
	background-color: #fff;
}

.quick_view-box-img {
	overflow: hidden;
	display: flex;
	padding-top: 15px;
	padding-left: 30px;
}

.quick_view-box-img img {
	width: 400px;
	height: 400px;
	object-fit: cover;
}

.flex {
	display: flex;
}

.infor_product-quick-view {
	max-width: 390px;
}
</style>
			<div class="grid wide">
				<div class="product-selling-title">
					<hr>
					<span>SẢN PHẨM MỚI NHẤT</span>
					<hr>
				</div>
				<div class="product-selling-main">
					<div class="row">


						<c:forEach var="seach" items="${seachList}">
							<div class="col l-3 c-6 product-selling-items">
								<div class="product-selling-box-img">
									<a
										><img
										class="product-selling-img"
										src="${host}${imgRepository.findByidproduct(seach.id).get(0).srcimg}"
										alt=""></a>
									<div class="btn btn-product-selling" data-prog="168">
										<a
											href="${pageContext.request.contextPath}/details?id=${produc.id}">XEM
											CHI TIẾT</a>

									</div>
									<div class="product-selling-info">
										<div class="product-selling-name">
											<span>${seach.description}</span>
										</div>
										<div class="product-selling-price">
											<div class="product-selling-price-old">
												${(seach.cost*120)/100}<sup>đ</sup>
											</div>
											<div class="product-selling-price-now">
												${seach.cost}<sup>đ</sup>
											</div>
										</div>
										<div class="btn-add-cart-box" id="${seach.id}"
											onclick="addCart(this.id)">
											<a class="tag-a link-add-cart"><span class="btn-add-cart">THÊM
													VÀO GIỎ HÀNG</span></a>
										</div>
									</div>
								</div>
							</div>
						</c:forEach>
					</div>

				</div>
			</div>
			<script>
				var baseUrl = ''
				var x = baseUrl.concat("FE/sanpham/quickview_ajax.php")
				$(document).ready(function() {
					$('.btn-product-selling').click(function() {
						var id_product = $(this).attr('data-prog')
						$.get(x, {
							id_product_ajax : id_product
						}, function(data) {
							$('.container_quick_view').html(data);
							let a = 1;
							$('.cong').click(function() {
								a += 1
								$('.value-quantity').val(a)
							})
							$('.tru').click(function() {
								if (a > 1) {
									a -= 1
									$('.value-quantity').val(a)
								}
							})
						})
					})
				})
			</script>
			<script src="${host}/js/index.js"></script>
</body>
<script type="text/javascript">
	function handleCredentialResponse(response) {
		// decodeJwtResponse() is a custom function defined by you
		// to decode the credential response.
		//     jwt_decode
		const responsePayload = jwt_decode(response.credential);
		console.log("ID: " + responsePayload.sub);
		console.log('Full Name: ' + responsePayload.name);
		console.log('Given Name: ' + responsePayload.given_name);
		console.log('Family Name: ' + responsePayload.family_name);
		console.log("Image URL: " + responsePayload.picture);
		console.log("Email: " + responsePayload.email);
		var xhr = new XMLHttpRequest();
		xhr.open('POST', '${pageContext.request.contextPath}/');
		xhr.setRequestHeader('Content-Type',
				'application/x-www-form-urlencoded');
		xhr.onload = function() {
			console.log('Signed in as: ' + xhr.responseText);
		};
		xhr.send('idtoken=' + response.credential);
	}
</script>
</html>


