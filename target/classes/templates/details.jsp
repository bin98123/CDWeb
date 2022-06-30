<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="${host}/bootstrap-5.2.0/css/bootstrap.min.css"/>
<script src="${host}/bootstrap-5.2.0/js/bootstrap.min.js"></script>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/assets/details.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/assets/styles.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/all.css">
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
<style type="text/css">
</style>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<meta charset="utf-8">
<title>Chi tiết sản phẩm</title>
<style type="text/css">
.product-selling-price-old {
	text-decoration: line-through;
	color: rgb(117, 117, 117);
}
</style>
</head>

<!--Important link from https://bootsnipp.com/snippets/XqvZr-->
<link
	href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css">

<script
	src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<script
	src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<!------ Include the above in your HEAD tag ---------->

<link
	href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600,700,800&display=swap"
	rel="stylesheet">
<link rel="stylesheet" type="text/css"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.12.1/css/all.min.css">
<link rel="stylesheet" type="text/css"
	href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css">
<link rel="stylesheet" type="text/css"
	href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.theme.default.min.css">
<body>
	<div id="header">
		<jsp:include page="header.jsp" />
	</div>
	<div class="pd-wrap">
		<div class="container">
			<div class="heading-section">
				<h2>${product.name}</h2>
			</div>
			<div class="row">
				<div class="col-md-6">
					<div id="slider" class="owl-carousel product-slider">
						<c:forEach var="i" begin="0"
							end="${imgRepository.findByidproduct(product.id).size()-1}">
							<div class="item">
								<img
									src="${host}${imgRepository.findByidproduct(product.id).get(i).srcimg}" />
							</div>
						</c:forEach>
					</div>
					<div id="thumb" class="owl-carousel product-thumb">
						<c:forEach var="i" begin="0"
							end="${imgRepository.findByidproduct(product.id).size()-1}">
							<div class="item">
								<img
									src="${host}${imgRepository.findByidproduct(product.id).get(i).srcimg}" />
							</div>
						</c:forEach>
					</div>
				</div>
				<div class="col-md-6">
					<div class="product-dtl">
						<div class="product-info">
							<div class="product-name">Số sao đánh giá:</div>
							<div class="reviews-counter">
								<div class="rate">
									<input type="radio" id="star5" name="rate" value="5" checked />
									<label for="star5" title="text">5 stars</label> <input
										type="radio" id="star4" name="rate" value="4" checked /> <label
										for="star4" title="text">4 stars</label> <input type="radio"
										id="star3" name="rate" value="3" checked /> <label
										for="star3" title="text">3 stars</label> <input type="radio"
										id="star2" name="rate" value="2" /> <label for="star2"
										title="text">2 stars</label> <input type="radio" id="star1"
										name="rate" value="1" /> <label for="star1" title="text">1
										star</label>
								</div>
								<!--                 <span>3 Reviews</span> -->
							</div>

							<div class="product-price-discount">
								<div class="product-selling-price-old">${product.cost*110/100}</div>
								<div>${product.cost}</div>
							</div>
						</div>
						<div class="product-count">
							<c:if
								test="${productRepository.getProductSaledById(product.id).isEmpty()}">
								<label for="size">Đã bán: 0</label>
							</c:if>
							<c:if
								test="${!productRepository.getProductSaledById(product.id).isEmpty()}">
								<label for="size">Đã bán:
									${productRepository.getProductSaledById(product.id).get(0)} </label>
							</c:if>
						</div>
						<div class="product-count">
							<label for="size">Còn:
								${productRepository.getTotal(product.id).get()}</label>
						</div>
						<div class="shop-name">
							Shop: <a
								href="${pageContext.request.contextPath}/shop?id=${product.idshop}">${shopRepository.findByiduser(product.idshop).name}</a>
						</div>
						<p>${product.description}.</p>
						<div class="product-count">
							<label for="size">Số lượng</label>
							<form action="#" class="display-flex">
								<!-- 								<div class="qtyminus">-</div> -->
								<input type="number" name="quantity" value="1" class="qty" readonly="readonly">
								<!-- 								<div class="qtyplus">+</div> -->
							</form>
						</div>
						<div class="btn-add-cart-box">
							<button class="btn btn-primary" id="${product.id}"
								onclick="addCart(this.id)">Thêm vào giỏ hàng</button>
						</div>
					</div>
				</div>
			</div>
			<div class="product-info-tabs">
				<ul class="nav nav-tabs" id="myTab" role="tablist">
					<li class="nav-item"><a class="nav-link active"
						id="description-tab" data-toggle="tab" href="#description"
						role="tab" aria-controls="description" aria-selected="true">Mô
							tả sản phẩm</a></li>
					<li class="nav-item"><a class="nav-link" id="review-tab"
						data-toggle="tab" href="#review" role="tab" aria-controls="review"
						aria-selected="false">Bình luận (0)</a></li>
				</ul>
				<div class="tab-content" id="myTabContent">
					<div class="tab-pane fade show active" id="description"
						role="tabpanel" aria-labelledby="description-tab">${product.description}.</div>
					<div class="tab-pane fade" id="review" role="tabpanel"
						aria-labelledby="review-tab">
						<div class="review-heading">Bình luận</div>
						<p class="mb-20">Chưa có bình luận.</p>
						<form class="review-form">
							<div class="form-group">
								<label>Lượt đánh giá của bạn</label>
								<div class="reviews-counter">
									<div class="rate">
										<input type="radio" id="star5" name="rate" value="5" /> <label
											for="star5" title="text">5 stars</label> <input type="radio"
											id="star4" name="rate" value="4" /> <label for="star4"
											title="text">4 stars</label> <input type="radio" id="star3"
											name="rate" value="3" /> <label for="star3" title="text">3
											stars</label> <input type="radio" id="star2" name="rate" value="2" />
										<label for="star2" title="text">2 stars</label> <input
											type="radio" id="star1" name="rate" value="1" /> <label
											for="star1" title="text">1 star</label>
									</div>
								</div>
							</div>
							<div class="form-group">
								<label>Your message</label>
								<textarea class="form-control" rows="10"></textarea>
							</div>
							<div class="row">
								<div class="col-md-6">
									<div class="form-group">
										<input type="text" name="" class="form-control"
											placeholder="Name*">
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<input type="text" name="" class="form-control"
											placeholder="Email Id*">
									</div>
								</div>
							</div>
							<button class="round-black-btn">Submit Review</button>
						</form>
					</div>
				</div>
			</div>

		</div>
	</div>
	<script type="text/javascript">
		function addCart(name) {
			// cost
			var url = "ajax/add-cart?id=" + name;
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
				alert("Sản phẩm đã được thêm vào giỏ hàng!!!");
				$('#header').load('https://localhost/index' + " #header");
			}
		}
	</script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
	<script type="text/javascript">
		$(document)
				.ready(
						function() {
							var slider = $("#slider");
							var thumb = $("#thumb");
							var slidesPerPage = 4; //globaly define number of elements per page
							var syncedSecondary = true;
							slider.owlCarousel({
								items : 1,
								slideSpeed : 2000,
								nav : false,
								autoplay : false,
								dots : false,
								loop : true,
								responsiveRefreshRate : 200
							}).on('changed.owl.carousel', syncPosition);
							thumb
									.on(
											'initialized.owl.carousel',
											function() {
												thumb.find(".owl-item").eq(0)
														.addClass("current");
											})
									.owlCarousel(
											{
												items : slidesPerPage,
												dots : false,
												nav : true,
												item : 4,
												smartSpeed : 200,
												slideSpeed : 500,
												slideBy : slidesPerPage,
												navText : [
														'<svg width="18px" height="18px" viewBox="0 0 11 20"><path style="fill:none;stroke-width: 1px;stroke: #000;" d="M9.554,1.001l-8.607,8.607l8.607,8.606"/></svg>',
														'<svg width="25px" height="25px" viewBox="0 0 11 20" version="1.1"><path style="fill:none;stroke-width: 1px;stroke: #000;" d="M1.054,18.214l8.606,-8.606l-8.606,-8.607"/></svg>' ],
												responsiveRefreshRate : 100
											}).on('changed.owl.carousel',
											syncPosition2);
							function syncPosition(el) {
								var count = el.item.count - 1;
								var current = Math.round(el.item.index
										- (el.item.count / 2) - .5);
								if (current < 0) {
									current = count;
								}
								if (current > count) {
									current = 0;
								}
								thumb.find(".owl-item").removeClass("current")
										.eq(current).addClass("current");
								var onscreen = thumb.find('.owl-item.active').length - 1;
								var start = thumb.find('.owl-item.active')
										.first().index();
								var end = thumb.find('.owl-item.active').last()
										.index();
								if (current > end) {
									thumb.data('owl.carousel').to(current, 100,
											true);
								}
								if (current < start) {
									thumb.data('owl.carousel').to(
											current - onscreen, 100, true);
								}
							}
							function syncPosition2(el) {
								if (syncedSecondary) {
									var number = el.item.index;
									slider.data('owl.carousel').to(number, 100,
											true);
								}
							}
							thumb.on("click", ".owl-item", function(e) {
								e.preventDefault();
								var number = $(this).index();
								slider.data('owl.carousel').to(number, 300,
										true);
							});

							$(".qtyminus").on("click", function() {
								var now = $(".qty").val();
								if ($.isNumeric(now)) {
									if (parseInt(now) - 1 > 0) {
										now--;
									}
									$(".qty").val(now);
								}
							})
							$(".qtyplus").on("click", function() {
								var now = $(".qty").val();
								if ($.isNumeric(now)) {
									$(".qty").val(parseInt(now) + 1);
								}
							});
						});
	</script>
</body>
</html>