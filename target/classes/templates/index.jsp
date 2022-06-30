<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE HTML>
<html>
<head>
<meta charset="UTF-8" />
<title>Trang Chủ ShoesLand</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<!-- Optional theme -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<!-- Latest compiled and minified JavaScript -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="${host}/js/index.js"></script>
<script src="https://accounts.google.com/gsi/client" async defer></script>
<script src="https://unpkg.com/jwt-decode/build/jwt-decode.js"></script>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" type="text/css" href="${host}/bootstrap-5.2.0/css/bootstrap.min.css"/>
<script src="${host}/bootstrap-5.2.0/js/bootstrap.min.js"></script>

<link href="${host}/font-awesome-4.7.0/css/font-awesome.min.css"
	rel="stylesheet" type="text/css">
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
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/assets/styles.css" />
<script src="${host}/js/jquery-3.6.0.min.js"></script>
<style>
</style>


<!-- add-cart -->

</head>
<body>
<div id="header">
		<jsp:include page="header.jsp" />
	</div>
	<div class="main">
		<div class="filter">
			<b>Lọc sản phẩm theo:</b> <select name="filter-by" id="choose-filter"
				onchange="chooseFilter()">

				<option value="${filterDefault}">${filterDefault}</option>
				<c:forEach items="${filterBy}" var="filter">
					<c:if test="${filter ne filterDefault}">
						<option value="${filter}">${filter}</option>
					</c:if>
				</c:forEach>
			</select> <b>Chọn:</b> <select name="filter-by" id="get-filter"
				onchange="getFilter()">
				<option value="${selectfilterDefault}">${selectfilterDefault}</option>
				<c:forEach items="${select}" var="selectfilter">
					<c:if test="${selectfilter ne selectfilterDefault}">
						<option value="${selectfilter}">${selectfilter}</option>
					</c:if>
				</c:forEach>
			</select>
		</div>
		<div class="sort" style="float: right;">
			<b>Sắp xếp theo:</b> <select name="sort-by" id="sort-by"
				onchange="getSort()">
				<option value="${sortDefault}">${sortDefault}</option>
				<c:forEach items="${sortBy}" var="sort">
					<c:if test="${sort ne sortDefault}">
						<option value="${sort}">${sort}</option>
					</c:if>
				</c:forEach>
			</select>
		</div>

		<div class="main-content">

			<div class="grid wide">
				<div id="sort-list">
					<c:if test="${productListSale1!=null}">
						<div class="product-selling-title">
							<hr>
							<span>DANH SÁCH SẢN PHẨM</span>
							<hr>
						</div>
						<div class="product-selling-main">
							<div class="row">
								<c:forEach var="produc1" items="${productListSale1}">

									<div class="col  l-3 c-6 product-selling-items">
										<div class="product-selling-box-img">
											<a><img class="product-selling-img"
												src="${host}${imgRepository.findByidproduct(produc1.id).get(0).srcimg}"
												alt=""></a>
											<div class="btn btn-product-selling"
												name="btn-product-selling" data-prog="145">
												<a
													href="${pageContext.request.contextPath}/details?id=${produc1.id}">XEM
													CHI TIẾT</a>
											</div>
										</div>
										<div class="product-selling-info">
											<div class="product-selling-name">
												<span>${produc1.description}</span>
											</div>
											<c:if
												test="${productRepository.getProductSaledById(produc1.id).isEmpty()}">
												<div class="product-selling-name">
													<span>Đã bán: 0</span>
												</div>
											</c:if>
											<c:if
												test="${!productRepository.getProductSaledById(produc1.id).isEmpty()}">
												<div class="product-selling-name">
													<span>Đã bán:
														${productRepository.getProductSaledById(produc1.id).get(0)}</span>
												</div>
											</c:if>
											<div class="product-selling-price">
												<div class="product-selling-price-old">
													${(produc1.cost*120)/100}<sup>đ</sup>
												</div>
												<div class="product-selling-price-now">
													${produc1.cost}<sup>đ</sup>
												</div>
											</div>
											<div class="btn-add-cart-box" id="${produc1.id}"
												onclick="addCart(this.id)">
												<a class="tag-a link-add-cart"><span
													class="btn-add-cart">THÊM VÀO GIỎ HÀNG</span></a>
											</div>
										</div>
									</div>
								</c:forEach>
							</div>
						</div>
					</c:if>
				</div>


				<div class="grid wide">
					<div class="product-selling-title">
						<hr>
						<span>SẢN PHẨM BÁN CHẠY</span>
						<hr>
					</div>
					<div class="product-selling-main">
						<div class="row">
							<c:forEach var="produc" items="${productListSale}">

								<div class="col  l-3 c-6 product-selling-items">
									<div class="product-selling-box-img">
										<a><img class="product-selling-img"
											src="${host}${imgRepository.findByidproduct(produc.id).get(0).srcimg}"
											alt=""></a>
										<div class="btn btn-product-selling"
											name="btn-product-selling" data-prog="145">
											<a
												href="${pageContext.request.contextPath}/details?id=${produc.id}">XEM
												CHI TIẾT</a>
										</div>
									</div>
									<div class="product-selling-info">
										<div class="product-selling-name">
											<span>${produc.description}</span>
										</div>
											<c:if
												test="${productRepository.getProductSaledById(produc.id).isEmpty()}">
												<div class="product-selling-name">
													<span>Đã bán: 0</span>
												</div>
											</c:if>
											<c:if
												test="${!productRepository.getProductSaledById(produc.id).isEmpty()}">
												<div class="product-selling-name">
													<span>Đã bán:
														${productRepository.getProductSaledById(produc.id).get(0)}</span>
												</div>
											</c:if>
										<div class="product-selling-price">
											<div class="product-selling-price-old">
												${(produc.cost*120)/100}<sup>đ</sup>
											</div>
											<div class="product-selling-price-now">
												${produc.cost}<sup>đ</sup>
											</div>
										</div>
										<div class="btn-add-cart-box" id="${produc.id}"
											onclick="addCart(this.id)">
											<a class="tag-a link-add-cart"><span class="btn-add-cart">THÊM
													VÀO GIỎ HÀNG</span></a>
										</div>
									</div>
								</div>
							</c:forEach>
						</div>
					</div>

					<div class="grid wide">
						<div class="product-selling-title">
							<hr>
							<span>SẢN PHẨM MỚI NHẤT</span>
							<hr>
						</div>
						<div class="product-selling-main">
							<div class="row">


								<c:forEach var="producN" items="${productListNew}">
									<div class="col l-3 c-6 product-selling-items">
										<div class="product-selling-box-img">
											<a><img class="product-selling-img"
												src="${host}${imgRepository.findByidproduct(producN.id).get(0).srcimg}"
												alt=""></a>
											<div class="btn btn-product-selling" data-prog="168">
												<a
													href="${pageContext.request.contextPath}/details?id=${producN.id}">XEM
													CHI TIẾT</a>
											</div>
										</div>
										<div class="product-selling-info">
											<div class="product-selling-name">
												<span>${producN.description}</span>
											</div>
											<c:if
												test="${productRepository.getProductSaledById(producN.id).isEmpty()}">
												<div class="product-selling-name">
													<span>Đã bán: 0</span>
												</div>
											</c:if>
											<c:if
												test="${!productRepository.getProductSaledById(producN.id).isEmpty()}">
												<div class="product-selling-name">
													<span>Đã bán:
														${productRepository.getProductSaledById(producN.id).get(0)}</span>
												</div>
											</c:if>
											<div class="product-selling-price">
												<div class="product-selling-price-old">
													${(producN.cost*120)/100}<sup>đ</sup>
												</div>
												<div class="product-selling-price-now">
													${producN.cost}<sup>đ</sup>
												</div>
											</div>
											<div class="btn-add-cart-box" id="${producN.id}"
												onclick="addCart(this.id)">
												<a class="tag-a link-add-cart"><span
													class="btn-add-cart">THÊM VÀO GIỎ HÀNG</span></a>
											</div>
										</div>
									</div>
								</c:forEach>
							</div>
						</div>
						<div class="grid wide">
							<div class="product-selling-title">
								<hr>
								<span>SẢN PHẨM ĐƯỢC XEM NHIỀU NHẤT</span>
								<hr>
							</div>
							<div class="product-selling-main">
								<div class="row">
									<c:forEach var="producV" items="${productListView}">
										<div class="col l-3 c-6 product-selling-items">
											<div class="product-selling-box-img">
												<a><img class="product-selling-img"
													src="${host}${imgRepository.findByidproduct(producV.id).get(0).srcimg}"
													alt=""></a>
												<div class="btn btn-product-selling" data-prog="168">
													<a
														href="${pageContext.request.contextPath}/details?id=${producV.id}">XEM
														CHI TIẾT</a>
												</div>
											</div>
											<div class="product-selling-info">
												<div class="product-selling-name">
													<span>${producV.description}</span>
												</div>
												<c:if
												test="${productRepository.getProductSaledById(producV.id).isEmpty()}">
												<div class="product-selling-name">
													<span>Đã bán: 0</span>
												</div>
											</c:if>
											<c:if
												test="${!productRepository.getProductSaledById(producV.id).isEmpty()}">
												<div class="product-selling-name">
													<span>Đã bán:
														${productRepository.getProductSaledById(producV.id).get(0)}</span>
												</div>
											</c:if>
												<div class="product-selling-price">
													<div class="product-selling-price-old">
														${(producV.cost*120)/100}<sup>đ</sup>
													</div>
													<div class="product-selling-price-now">
														${producV.cost}<sup>đ</sup>
													</div>
												</div>
												<div class="btn-add-cart-box" id="${producV.id}"
													onclick="addCart(this.id)">
													<a class="tag-a link-add-cart"><span
														class="btn-add-cart">THÊM VÀO GIỎ HÀNG</span></a>
												</div>
											</div>
										</div>
									</c:forEach>
								</div>
							</div>
							<!-- Danh mục sản phẩm -->
							<div class="grid wide policy">
								<div class="row">
									<div class="col l-4">
										<div class="icon-cart-ship icon-policy">
											<i class="fa fa-truck"></i>
										</div>
										<div class="policy-title">
											<span>Giao Hàng Toàn Quốc</span>
										</div>
										<div class="policy-content">
											<span>Ship COD toàn quốc. Nhận hàng trong vòng 2-3
												ngày</span>
										</div>
									</div>
									<div class="col l-4 return-free">
										<div class="icon-cart-ship icon-policy">
											<i class="fa fa-undo"></i>
										</div>
										<div class="policy-title">
											<span>Hoàn Trả Miễn Phí</span>
										</div>
										<div class="policy-content">
											<span>Xem hàng trước khi nhận. Hoàn trả miễn phí nếu
												không hài lòng</span>
										</div>
									</div>
									<div class="col l-4">
										<div class="icon-cart-ship icon-policy">
											<i class="fa fa-home"></i>
										</div>
										<div class="policy-title">
											<span>Bảo hành 1 năm</span>
										</div>
										<div class="policy-content">
											<span>Bảo hành 1 năm. Lỗi 1 đổi 1 tất cả các sản phẩm
											</span>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>

			</div>
		</div>
	</div>

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

		var message = $(responseData).find("valid").text();
		console.log(message);
		if (message == "false") {
			alert("Vui lòng đăng nhập!!!");
		} else if (message == "true") {
			// 			location.reload();
			alert("Sản phẩm đã được thêm vào giỏ hàng!!!");
			$('#header').load('https://localhost/index' + " #header");
		}
	}
	// 	$('#sort-list').prop('disabled', 'disabled');
	function getSort() {
		// cost
		// 		console.log(id);
		var url = "ajax/get-sort?sort=" + $("#sort-by").val();
		$.ajax({
			url : url,
			success : processGetSort(),
			cache : false
		});
	}

	function processGetSort(responseData) {

		$(document).ready(function() {
			$('#sort-list').load('https://localhost/index' + " #sort-list");
			console.log('ok!!!');
		});
	}
	function chooseFilter() {
		// cost
		// 		console.log(id);
		var url = "ajax/get-filter-select?filter-select="
				+ $("#choose-filter").val();
		$.ajax({
			url : url,
			success : processChooseFilter(),
			cache : false
		});
	}

	function processChooseFilter(responseData) {

		$(document).ready(function() {
			$('.filter').load('https://localhost/index' + " .filter");
			console.log('ok!!!');
		});
	}
	function getFilter() {
		var url = "ajax/get-filter?filter-select=" + $("#get-filter").val()
				+ "&choose=" + $("#choose-filter").val();
		$.ajax({
			url : url,
			success : processGetFilter(),
			cache : false
		});
	}

	function processGetFilter(responseData) {

		$(document).ready(function() {
			$('.filter').load('https://localhost/index' + " .filter");
			$('#sort-list').load('https://localhost/index' + " #sort-list");
			console.log('ok!!!');
		});
	}
</script>

</html>


