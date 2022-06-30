<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE HTML>
<html>
<head>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/chitietsanpham.css" />
<meta charset="UTF-8" />
<link rel="stylesheet" type="text/css" href="${host}/bootstrap-5.2.0/css/bootstrap.min.css"/>
<script src="${host}/bootstrap-5.2.0/js/bootstrap.min.js"></script>
<title>Đơn Hàng Của Tôi</title>
<style type="text/css">
table {
	border: 1px solid black;
	border-collapse: collapse;
}

.nav-item:nth-child(1) {
	background-color: #c1c1c1;
}

.wide-nav-items-span {
	color: #777;
}

.danhmuc-trangchu {
	color: #000 !important;
}

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
<script src="https://accounts.google.com/gsi/client" async defer></script>
<script src="https://unpkg.com/jwt-decode/build/jwt-decode.js"></script>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="${host}/font-awesome-4.7.0/css/font-awesome.min.css"
	rel="stylesheet" type="text/css">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/all.css"/>
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
<!-- 	integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" -->
<!-- 	crossorigin="anonymous" -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<style>
table {
	border: 1px solid;
}
</style>

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/assets/styles.css" />
</head>
<body>
	<div id="header">
		<jsp:include page="header_admin.jsp" />
	</div>


	<div class="main">
		<div class="main-content">




			<script
				src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

			<div id="orders">
				<div class="grid wide">
					<div class="product-selling-title">
						<hr>
						<span>DANH SÁCH ĐƠN HÀNG CHỜ XÁC NHẬN</span>
						<hr>
					</div>
					<!-- 				<div class="product-selling-main"> -->
					<!-- 					<div class="row"> -->


					<c:forEach var="mycart" items="${mycarts}">
						<table style="width: 100%">
							<tr>
								<td rowspan="7"><a
									href="${pageContext.request.contextPath}/details?id=${mycart.idproduct}"><img
										class="product-selling-img"
										src="${host}${imgRepository.findByidproduct(mycart.idproduct).get(0).srcimg}"
										alt=""></a></td>
								<td>Tên: <strong>${productRepository.getName(mycart.idproduct).get()}</strong></td>
								<td rowspan="7"><button id="${mycart.id}"
										class="btn btn-primary" onclick="submitOrder(this.id)">Xác
										nhận đơn hàng</button></td>
							</tr>
							<tr>
								<td>Số lượng: <strong>${mycart.total}</strong></td>
							</tr>
							<tr>
								<td>Người đặt: <strong>${cartRepository.findIdUser(mycart.id).getFullname()}</strong></td>
							</tr>
							<tr>
								<td>Địa chỉ nhận hàng: <strong>${cartRepository.findIdUser(mycart.id).getAddress()}</strong></td>
							</tr>
							<tr>
								<td>Trạng thái: <strong>${mycart.status}</strong></td>
							</tr>
							<tr>
								<td>Ngày đặt: <strong>${mycart.orderdate}</strong></td>
							</tr>
							<tr>
								<td>Ngày giao: <strong>${mycart.delivereddate}</strong></td>
							</tr>
						</table>
						<br>
						<br>
					</c:forEach>
				</div>
			</div>

		</div>
	</div>
	<script type="text/javascript">
		function submitOrder(id) {
			if (confirm("Bạn có muốn xác nhận đơn hàng!") == true) {
				// 			  text = "You pressed OK!";
				// cost
				console.log(id);
				var url = "ajax/submit-order?id=" + id;
				$.ajax({
					url : url,
					success : processSubmitOrder,
					cache : false
				});
			}
		}

		function processSubmitOrder(responseData) {
			$('#orders').load('https://localhost/cartorder' + ' #orders');
		}
	</script>
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
