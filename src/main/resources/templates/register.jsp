<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Trang đăng kí</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<style type="text/css">
#error-register {
	color: red;
}
</style>
</head>
<!-- Google function API -->
<script src="https://accounts.google.com/gsi/client" async defer></script>
<div id="g_id_onload"
	data-client_id="757029011142-bcohjjqnca15ucgnu1d91mrlvus5c4i6.apps.googleusercontent.com"
	data-ux_mode="redirect"
	data-login_uri="${pageContext.request.contextPath}/"></div>
<script type="text/javascript">
	function onSignIn(googleUser) {
		console.log('ok');
		alert('login');
		var p = googleUser.getBasicProfile();
		console.log(p);
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
				<br> <span id="error-register">${errorRegister}</span>
				<form action="process-register" method="post">

					<div class="input-form">
						<input type="text" name="fullname" id="fullName" required
							placeholder="Họ và tên"
							oninvalid="this.setCustomValidity('Họ và tên không được bỏ trống')"
							oninput="this.setCustomValidity('')" class="inValid">
					</div>
					<div class="input-form">
						<input type="email" name="email" id="email" required
							placeholder="Email"
							oninvalid="this.setCustomValidity('Email không được bỏ trống')"
							oninput="this.setCustomValidity('')" class="inValid">
					</div>
					<div class="input-form">
						<input type="text" name="phone" id="phone" required
							placeholder="Số điện thoại"
							oninvalid="this.setCustomValidity('Số điện thoại không được bỏ trống')"
							oninput="this.setCustomValidity('')" class="inValid">
					</div>
					<div class="input-form">
						<input type="text" name="username" id="username" required
							placeholder="Tên tài khoản"
							oninvalid="this.setCustomValidity('Tài khoản không được bỏ trống')"
							oninput="this.setCustomValidity('')" class="inValid">
					</div>

					<div class="input-form">
						<input type="password" name="password" id="password" required
							placeholder="Mật Khẩu"
							oninvalid="this.setCustomValidity('Mật khẩu không được bỏ trống')"
							oninput="this.setCustomValidity('')" class="inValid">
					</div>


					<div class="input-form">
						<input type="date" name="birthday" id="birthday" required
							placeholder="dd/mm/yyyy"
							oninvalid="this.setCustomValidity('Ngày sinh không được bỏ trống')"
							oninput="this.setCustomValidity('')" class="inValid">
					</div>

					<div class="input-form">
						<input type="text" name="address" id="address" required
							placeholder="Địa chỉ"
							oninvalid="this.setCustomValidity('Địa chỉ không được bỏ trống')"
							oninput="this.setCustomValidity('')" class="inValid">
					</div>

					<!-- 						<div class="nho-dang-nhap"> -->
					<!-- 						<label><input type="checkbox" name=""> Nhớ Đăng -->
					<!-- 							Nhập</label> -->
					<!-- 					</div> -->
					<div class="input-form">
						<input type="submit" value="Đăng Kí">
					</div>
					<div class="input-form">
						<p>
							Bạn Đã Có Tài Khoản? <a
								href="${pageContext.request.contextPath}/login">Đăng Nhập
								Ngay</a>
						</p>
					</div>
				</form>
				<h3>Đăng Nhập Bằng Mạng Xã Hội</h3>
				<ul class="icon-dang-nhap">
					<li
						onclick="window.location.href='https://www.facebook.com/dialog/oauth?client_id=402075408498842&redirect_uri=https://localhost:443'">
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

