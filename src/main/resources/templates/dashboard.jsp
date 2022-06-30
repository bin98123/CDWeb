<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<title>Trang Thống Kê Doanh Thu</title>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link rel="stylesheet" type="text/css" href="${host}/bootstrap-5.2.0/css/bootstrap.min.css"/>
<script src="${host}/bootstrap-5.2.0/js/bootstrap.min.js"></script>

<link
	href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/assets/styles.css" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="${host}/js/jquery-3.6.0.min.js"></script>
<script src="${host}/js/cart.js"></script>
<style type="text/css">
#graph {
	position: relative;
	width: 950px;
	height: 216px;
	margin: 8px;
	padding: 0;
}

#btn {
	margin-top: 15px;
}

#graph ul {
	position: absolute;
	top: 0;
	left: 32px;
	width: 950px;
	height: 200px;
	border-left: 1px solid black;
	border-bottom: 1px solid black;
}

#graph li {
	position: absolute;
	list-style: none;
	background: lightblue;
	width: 50px;
	left: 12px;
	text-align: center;
	border: 1px solid black;
	visibility: hidden;
}

label {
	display: block;
	font: 1rem 'Fira Sans', sans-serif;
}

input, label {
	margin: .4rem 0;
}
</style>
<script type="text/javascript">
	function makeGraph(container, labels) {
		container = document.getElementById(container);
		labels = document.getElementById(labels)
		var dnl = container.getElementsByTagName("li");
		for (var i = 0; i < dnl.length; i++) {
			var item = dnl.item(i);
			var value = item.innerHTML;
			var color = item.style.background = color;
			var content = value.split(":");
			value = content[0];
			item.style.height = value + "px";
			item.style.top = (199 - value * 5) + "px";
			item.style.left = (i * 50 + 8) + "px";
			item.style.height = value * 5 + "px";
			item.innerHTML = value;
			item.style.visibility = "visible";
			color = content[2];
			if (color != false)
				item.style.background = color;
			labels.innerHTML = labels.innerHTML
					+ "<span style='margin-right:38px;background:"+ color+"'>"
					+ content[1] + "</span>";
		}
	}

	window.onload = function() {
		makeGraph("graph", "labels")
	}
</script>
</head>

<body>
	<div id="graph">


		<h3>Thống kê doanh thu theo tháng trong năm ${yearDefault}</h3>
		<!-- 				<table id="categoryTable"> -->
		Triệu <br /> <br /> <br /> <br /> <br /> <br /> <br /> <br />
		<br />
		<ul style="white-space: nowrap;">
			<c:forEach var="i" begin="1" end="12">
				<li style="display: inline;">${report.get(i)}:${i}:cyan</li>&nbsp;
			</c:forEach>
		</ul>

		<br>
		<div id="labels" style="margin-right: 24px">Tháng:&emsp;</div>
		<label for="start">Chọn năm:</label> <select name="year" id="year"
			onchange="chooseYear()">
			<option value="${yearDefault}">${yearDefault}</option>
			<c:forEach items="${years}" var="year">
				<c:if test="${year ne yearDefault}">
					<option value="${year}">${year}</option>
				</c:if>
			</c:forEach>
		</select>

		<script type="text/javascript">
			function chooseYear() {
				var url = "choose-year?year=" + $("#year").val();
				$.ajax({
					type : "POST",
					url : url,
					success : processChooseYear,
					cache : false
				});
			}

			function processChooseYear(responseData) {

				location.reload();
			}
			function chooseMonth() {
				var url = "choose-month?month=" + $("#month").val();
				$.ajax({
					type : "POST",
					url : url,
					success : processChooseMonth,
					cache : false
				});
			}

			function processChooseMonth(responseData) {

				location.reload();
			}
		</script>
	</div>
	<br>
	<br>
	<br>
	<br>
	<button type="button" class="btn btn-primary" id="btn"
		onclick="circleChart()">Biểu đồ tròn</button>
	<button type="button" class="btn btn-primary" id="btn"
		onclick="document.location.href ='${pageContext.request.contextPath}/store'">Về
		cửa hàng</button>
	<h3>Thống kê doanh thu trong tháng ${monthDefault} theo tên thương
		hiệu</h3>
	<label for="start">Chọn tháng:</label>
	<!-- 		</table> -->

	<select name="month" id="month" onchange="chooseMonth()"
		onchange="circleChart()">
		<option value="${monthDefault}">${monthDefault}</option>
		<c:forEach items="${months}" var="month">
			<c:if test="${month ne monthDefault}">
				<option value="${month}">${month}</option>
			</c:if>
		</c:forEach>
	</select>

	<br>
	<br>
	<input id="user-id" value="${id}" style="display: none">
	<div id="chart">
		<script type="text/javascript">
			function circleChart() {

				var data = [];
				var label = [];
				var dataForDataSets = [];
				$.ajax({
					type : "GET",
					data : data,
					contentType : "application/json",
					url : "api/product/report-by-brand?id="
							+ $("#user-id").val(),
					success : function(data) {
						for (var i = 0; i < data.length; i++) {
							label.push(data[i][0]);
							dataForDataSets.push(data[i][1]);

						}
						console.log("1 " + label);
						console.log("1 " + dataForDataSets);
					},
					error : function(e) {
						alert("Error: ", e);
						console.log("Error", e);
					}
				});
				console.log(data);
				console.log(label);
				console.log(dataForDataSets);
				var options = {
					series : dataForDataSets,
					chart : {
						width : 380,
						type : 'pie',
					},
					labels : label,
					responsive : [ {
						breakpoint : 480,
						options : {
							chart : {
								width : 200
							},
							legend : {
								position : 'bottom'
							}
						}
					} ]
				};

				var chart = new ApexCharts(document.querySelector("#chart"),
						options);
				chart.render();
			}
		</script>

		<div id="chart">
			<apexchart type="pie" :options="chartOptions" :series="series"></apexchart>
		</div>
	</div>
</body>
</html>