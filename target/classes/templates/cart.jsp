<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE HTML>
<html>
<head>
<meta charset="UTF-8">
<title>Cart</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link href="${host}/font-awesome-4.7.0/css/font-awesome.min.css"
	rel="stylesheet" type="text/css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script src="${host}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	
</script>
</head>
<body>
<div id="header">
		<jsp:include page="header.jsp" />
	</div>
	<div class="container">
		<table id="cart-table" class="table table-hover table-condensed"
			style="padding-top: 20px; width: 100%">

			<thead>
				<tr>
					<th style="width: 50%">Tên sản phẩm</th>
					<th style="width: 10%">Giá</th>
					<th style="width: 10%">Số lượng</th>
					<th style="width: 10%">Tổng tiền</th>
					<th style="width: 20%"></th>
				</tr>
			</thead>

			<!-- 			<div > -->
			<tbody style="width: 100%">
				<c:forEach var="cart" items="${products}">
					<input id="cart-cost"
						value="${productRepository.findById(cart.idproduct).get().getCost()}"
						style="display: none;"></input>
					<tr>
						<td data-th="Product">
							<div class="row">
								<div class="col-sm-2 hidden-xs">
									<a
										href="${pageContext.request.contextPath}/details?id=${cart.idproduct}">
										<img
										src="${host}${imgRepository.findByidproduct(cart.idproduct).get(0).srcimg}"
										alt="img" class="img-responsive" width="100">
									</a>
								</div>
								<div class="col-sm-10">
									<h4 class="nomargin">${productRepository.findById(cart.idproduct).get().getName()}</h4>
									<p>${productRepository.findById(cart.idproduct).get().getDescription()}</p>
								</div>
							</div>
						</td>

						<td data-th="Price">${productRepository.findById(cart.idproduct).get().getCost()}đ</td>
						<td data-th="Quantity"><input size="10" type="number"
							id="${cart.id}" name="total-change" value="${cart.total}"
							onchange="totalChange(this.id)" min="1"
							max="${productRepository.getTotal(cart.idproduct).get()}" />
						<td><input readonly="true" class="cart-id"
							value="${cart.total*productRepository.findById(cart.idproduct).get().getCost()}"></input></td>

						<td class="actions" data-th="">
							<button class="btn btn-danger btn-sm remove" name="${cart.id}"
								onclick="deleteCart(this.name)"
								data-name="${productRepository.findById(cart.idproduct).get().getName()}">
								<i class="fa fa-trash-o remove"
									data-name="${productRepository.findById(cart.idproduct).get().getName()}"></i>
							</button>
						</td>
					</tr>
				</c:forEach>

			</tbody>

			<tfoot>
				<tr class="visible-xs">
					<td class="text-center"></td>
				</tr>
				<tr id="total-cost">
					<td><strong>Tổng tiền: ${totalCost}đ</strong></td>
				</tr>
				<tr>
					<td><a href="${pageContext.request.contextPath}/"
						class="btn btn-warning"><i class="fa fa-angle-left"></i> Tiếp
							tục mua hàng</a></td>
					<td colspan="2" class="hidden-xs"></td>
					<td class="hidden-xs text-center" id="total"></td>
					<td><button
							onclick="document.location.href ='${pageContext.request.contextPath}/payment?totalcost=${totalCost}'"
							class="btn btn-success btn-block">
							Thanh toán <i class="fa fa-angle-right"></i>
						</button></td>
				</tr>
			</tfoot>
		</table>
	</div>
	<script type="text/javascript">
		function totalChange(id) {
			// cost
			var url = "total-change?total-change=" + $.trim($("#" + id).val())
					+ "&id=" + id;
			$.ajax({
				url : url,
				success : processTotalChange,
				cache : false
			});
		}

		function processTotalChange(responseData) {
			var message = $(responseData).find("valid").text();
			if (message == "false") {
				alert("Số được nhập vượt quá số lượng sản phẩm!!!");
				$(".btn-block").prop("disabled", true);
			} else if (message == "InvaliInput") {
				alert("Số được nhập không hợp lệ!!!");
				$(".btn-block").prop("disabled", true);
			} else {
				$('#cart-table')
						.load('https://localhost/cart' + ' #cart-table');
				$('#total-cost')
						.load('https://localhost/cart' + ' #total-cost');
			}

		}
		function deleteCart(name) {
			// cost
			var url = "ajax/delete-cart?id=" + name;
			$.ajax({
				url : url,
				success : processDeleteCart,
				cache : false
			});
		}

		function processDeleteCart(responseData) {
			$('#cart-table').load('https://localhost/cart' + ' #cart-table');
			$('#total-cost').load('https://localhost/cart' + ' #total-cost');
		}
	</script>
	<!--  end content-->

</body>
</html>