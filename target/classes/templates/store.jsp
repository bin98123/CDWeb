<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE HTML>
<html>
<head>
<meta charset="UTF-8" />
<title>Cửa hàng</title>
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
	}
</script>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/assets/styles.css" />
</head>
<body>
	<div class="wrapper">

		<div id="header">
			<jsp:include page="header_admin.jsp" />
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
			<div class="grid wide">
				<div class="product-selling-title">
					<hr>
					<span>DANH SÁCH SẢN PHẨM TRONG SHOP
						${shopRepository.findByiduser(param.id).name}</span>
					<hr>
				</div>
				<div class="product-selling-main">
					<div class="row">


						<c:forEach var="shopde" items="${shops}">
							<div class="col l-3 c-6 product-selling-items">
								<div class="product-selling-box-img">
									<a><img class="product-selling-img"
										src="${host}${imgRepository.findByidproduct(shopde.id).get(0).srcimg}"
										alt=""></a>
									<div class="btn btn-product-selling" data-prog="168">
										<a
											href="${pageContext.request.contextPath}/details?id=${shopde.id}">XEM
											CHI TIẾT</a>

									</div>
									<div class="product-selling-info">
										<div class="product-selling-name">
											<span>${shopde.description}</span>
										</div>
										<div class="product-selling-price">
											<div class="product-selling-price-old">
												${(shopde.cost*120)/100}<sup>đ</sup>
											</div>
											<div class="product-selling-price-now">
												${shopde.cost}<sup>đ</sup>
											</div>
										</div>
										<div class="btn-add-cart-box" id="${shopde.id}"
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
