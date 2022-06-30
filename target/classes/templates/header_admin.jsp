<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
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
<title>Shoes Land</title>
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
							<span
								onclick="window.location.href='${pageContext.request.contextPath}/cart'"
								class="cart-text">GIỎ HÀNG </span>
							<div class="logo-cart-box">
								<c:choose>
									<c:when test="${lengthCart==null}">
										<!-- 										<div class="logo-cart">0</div> -->
										<div class="logo-cart"
											onclick="window.location.href='${pageContext.request.contextPath}/cart'">0</div>
									</c:when>
									<c:otherwise>
										<%-- 										<div class="logo-cart">${lengthCart}</div> --%>
										<div class="logo-cart"
											onclick="window.location.href='${pageContext.request.contextPath}/cart'">${lengthCart}</div>
									</c:otherwise>
								</c:choose>
							</div>
							<ul class="nav-dropdown">
								<div class="btn-cart-view btn">
									<span><a href="${pageContext.request.contextPath}/cart"
										class="tag-a" style="color: #fff;"> XEM GIỎ HÀNG </a> </span>
								</div>
								<div class="nav-dropdown-hover"></div>
							</ul>
						</div>
						<!-- Đăng kí -->
						<div class="login">
							<a href="${pageContext.request.contextPath}/register"
								class="tag-a" style="color: #000;"><span class="">ĐĂNG
									KÝ</span></a>
						</div>
						<c:if test="${id==null}">
							<div class="login">
								<a href="${pageContext.request.contextPath}/login" class="tag-a"
									style="color: #000;"><span class="">ĐĂNG NHẬP</span></a>
							</div>
						</c:if>
						<c:if test="${id!=null}">
							<div class="login">
								<div class="menu1">
									<div class="container">
										<ul class="nav">
											<li class="hidden3">
												<div class="nam">
													<span class="">${username}</span>
													<ul class="nam-item">
														<li><a
															href="${pageContext.request.contextPath}/store">Cửa
																hàng của tôi</a></li>
														<li><a
															href="${pageContext.request.contextPath}/forget-pasword">Quên
																mật khẩu</a></li>
														<li><a
															href="${pageContext.request.contextPath}/mycart">Đơn
																hàng</a></li>
														<li><a
															href="${pageContext.request.contextPath}/history">Lịch
																sử mua hàng</a></li>
														<li><a
															href="${pageContext.request.contextPath}/logout">Đăng
																xuất</a></li>
													</ul>
												</div>
											</li>
										</ul>
									</div>
								</div>
							</div>
						</c:if>
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
						<div class="masthead-search-box"></div>
					</div>
					<div class="menu">
						<div class="container">
							<ul class="nav">
								<li><a href="${pageContext.request.contextPath}/">VỀ
										TRANG CHỦ</a></li>
								<li class="hidden1">
									<div class="nam">
										<a href="${pageContext.request.contextPath}/cartorder">ĐƠN
											HÀNG</a>
									</div>
								</li>
								<li class="hidden2">
									<div class="nu">
										<a href="${pageContext.request.contextPath}/dashboard">DOANH
											THU</a>
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