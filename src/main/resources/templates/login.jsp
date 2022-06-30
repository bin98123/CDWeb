<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Trang đăng nhập</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style type="text/css">
#error-login {
	color: red;
}
</style>
</head>
<!-- Google function API -->
<script src="https://accounts.google.com/gsi/client" async defer></script>
<script src="https://unpkg.com/jwt-decode/build/jwt-decode.js"></script>
<div id="g_id_onload"
	data-client_id="757029011142-bcohjjqnca15ucgnu1d91mrlvus5c4i6.apps.googleusercontent.com"
	data-callback="handleCredentialResponse"></div>
<!-- 	data-ux_mode="redirect" -->
<%-- 	data-login_uri="${pageContext.request.contextPath}/" --%>
<!-- 	data-callback="handleCredentialResponse"  -->
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
		xhr.open('POST', '${pageContext.request.contextPath}/login-google');
		xhr.setRequestHeader('Content-Type',
				'application/x-www-form-urlencoded');
		xhr.onload = function() {
			console.log('Signed in as: ' + xhr.responseText);
		};
		xhr.send('idtoken=' + response.credential);
		window.location.href = "${pageContext.request.contextPath}/login-google-process";
	}
</script>
<!-- END Google function API -->
<script>
	window.fbAsyncInit = function() {
		FB.init({
			appId : '402075408498842',
			cookie : true,
			xfbml : true,
			version : 'v14.0'
		});

		FB.AppEvents.logPageView();

	};

	(function(d, s, id) {
		var js, fjs = d.getElementsByTagName(s)[0];
		if (d.getElementById(id)) {
			return;
		}
		js = d.createElement(s);
		js.id = id;
		js.src = "https://connect.facebook.net/en_US/sdk.js";
		fjs.parentNode.insertBefore(js, fjs);
	}(document, 'script', 'facebook-jssdk'));
</script>




<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/assets/styles.css" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

</head>
<body>
	<div class="menu">
		<div class="container">
			<ul class="nav">
				<li><a href="${pageContext.request.contextPath}/">VỀ TRANG
						CHỦ</a></li>
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
	<section>
		<div class="noi-dung">
			<div class="form">
				<h2 class="greeting">Chào mừng bạn đến với ShoesLand</h2>
				<br> <span id="error-login">${errorLogin}</span>
				<form action="process-login" method="post">
					<div class="input-form">
						<input type="email" name="email" id="username" required
							placeholder="SĐT Hoặc Email"
							oninvalid="this.setCustomValidity('Tài khoản không được bỏ trống')"
							oninput="this.setCustomValidity('')" class="inValid">
					</div>

					<div class="input-form">
						<input type="password" name="password" id="password" required
							placeholder="Mật Khẩu"
							oninvalid="this.setCustomValidity('Mật khẩu không được bỏ trống')"
							oninput="this.setCustomValidity('')" class="inValid">
					</div>
					<div class="nho-dang-nhap">
						<label><input type="checkbox" name=""> Nhớ Đăng
							Nhập</label>
					</div>
					<div class="input-form">
						<input type="submit" value="Đăng Nhập">
					</div>
					<div class="input-form">
						<p>
							Bạn Chưa Có Tài Khoản? <a
								href="${pageContext.request.contextPath}/register">Đăng Ký
								Ngay</a> <a
								href="${pageContext.request.contextPath}/forget-password">Quên
								mật khẩu</a>
						</p>
					</div>
				</form>
				<h3>Đăng Nhập Bằng Mạng Xã Hội</h3>
				<ul class="icon-dang-nhap">
					<li
						onclick="window.location.href='https://www.facebook.com/dialog/oauth?client_id=402075408498842&redirect_uri=https://localhost:443/login-fb'">
						<i class="fa fa-facebook" aria-hidden="true"></i>
					</li>

					<div class="g_id_signin" data-type="icon"></div>
					<!-- 					<div class="g-signin2" data-onsuccess="onSignIn" data-theme="dark"></div> -->

					<li><i class="fa fa-twitter" aria-hidden="true"></i></li>
				</ul>
			</div>
		</div>
	</section>

</body>
</html>

