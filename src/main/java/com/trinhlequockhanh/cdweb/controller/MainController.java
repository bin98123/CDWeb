package com.trinhlequockhanh.cdweb.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.security.GeneralSecurityException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken.Payload;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdTokenVerifier;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.gson.GsonFactory;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.restfb.types.User;
import com.trinhlequockhanh.cdweb.common.RestFB;
import com.trinhlequockhanh.cdweb.mail.Mail;
import com.trinhlequockhanh.cdweb.model.Filter;
import com.trinhlequockhanh.cdweb.model.Sort;
import com.trinhlequockhanh.cdweb.model.Status;
import com.trinhlequockhanh.cdweb.repository.CartRepository;
import com.trinhlequockhanh.cdweb.repository.ImgRepository;
import com.trinhlequockhanh.cdweb.repository.ProductRepository;
import com.trinhlequockhanh.cdweb.repository.ShopRepository;
import com.trinhlequockhanh.cdweb.repository.UserRepository;
import com.trinhlequockhanh.cdweb.config.Config;
import com.trinhlequockhanh.cdweb.entities.Cart;
import com.trinhlequockhanh.cdweb.entities.Product;

@Controller
public class MainController {
	@Autowired
	private Config config;
	@Autowired
	private Mail mail = new Mail();
	@Autowired
	private UserRepository userRepository;
	@Autowired
	private ProductRepository productRepository;
	@Autowired
	private ShopRepository shopRepository;
	@Autowired
	private CartRepository cartRepository;
	@Autowired
	private ImgRepository imgRepository;
	@Autowired
	private RestFB restFB;

	@RequestMapping(value = { "/login" }, method = RequestMethod.GET)
	public String login(HttpServletRequest request, Model model) throws MessagingException {
		HttpSession session = request.getSession();
		if (session.getAttribute("username") != null) {
			model.addAttribute("nameUser", session.getAttribute("username"));
			return "index";
		}

		return "login";
	}

	@RequestMapping(value = { "/search" }, method = RequestMethod.GET)
	public String search(HttpServletRequest request, Model model) {
		String search = request.getParameter("search");
		model.addAttribute("seachList", productRepository.getSearch(search));

		return "search";
	}

	@RequestMapping(value = { "/forget-pasword" }, method = RequestMethod.GET)
	public String forgetPasword(HttpServletRequest request, Model model) {

		return "forgetPassword";
	}

	@RequestMapping(value = { "/history" }, method = RequestMethod.GET)
	public String history(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");
		model.addAttribute("historycarts", cartRepository.getHistoryCart(id));

		return "history";
	}

	@RequestMapping(value = { "/mycart" }, method = RequestMethod.GET)
	public String mycart(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");
		// DANH SÁCH ĐƠN HÀNG CHƯA ĐƯỢC GIAO, CÓ THỂ HỦY, các đơn hàng đã xác nhận đặt
		// hàng
		String status0 = Status.WAITING_CONFIRM.toString();
		String status1 = Status.WAITING_DELIVERING.toString();
		model.addAttribute("Status", status1);
		model.addAttribute("mycarts", cartRepository.getCartMyCart(id, status0, status1));

		return "mycart";
	}

	@RequestMapping(value = { "/cartorder" }, method = RequestMethod.GET)
	public String cartorder(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");
		// DANH SÁCH ĐƠN HÀNG CHƯA ĐƯỢC GIAO, CÓ THỂ HỦY, các đơn hàng đã xác nhận đặt
		// hàng
		String status = Status.WAITING_CONFIRM.toString();
		model.addAttribute("mycarts", cartRepository.getMyCartOrderShop(id, status));

		return "cartorder";
	}

	@RequestMapping(value = { "/store" }, method = RequestMethod.GET)
	public String store(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");
		model.addAttribute("imgRepository", imgRepository);
		session.setAttribute("shops", productRepository.findByidshop(id));

		return "store";
	}

	@RequestMapping(value = { "/shop" }, method = RequestMethod.GET)
	public String shop(HttpServletRequest request, Model model, @RequestParam(value = "id") String id) {
		HttpSession session = request.getSession();
		model.addAttribute("imgRepository", imgRepository);
		session.setAttribute("shops", productRepository.findByidshop(id));

		return "shop";
	}

	@RequestMapping(value = { "/details" }, method = RequestMethod.GET)
	public String details(HttpServletRequest request, Model model, @RequestParam(value = "id") String id) {
		HttpSession session = request.getSession();
		model.addAttribute("imgRepository", imgRepository);
		session.setAttribute("shopRepository", shopRepository);
		session.setAttribute("imgRepository", imgRepository);
		session.setAttribute("productRepository", productRepository);
		session.setAttribute("cartRepository", cartRepository);
		session.setAttribute("product", productRepository.findById(id).get());

		return "details";
	}

	@RequestMapping(value = { "/process-login" }, method = RequestMethod.POST)
	public String doLogin(HttpServletRequest request, Model model, @RequestParam(value = "email") String email,
			@RequestParam(value = "password") String password) throws MessagingException {
		HttpSession session = request.getSession();
		if (userRepository.login(email, password).isEmpty()) {
			session.setAttribute("errorLogin", "Email hoặc mật khẩu không chính xác!!!");
			return "login";
		} else {

			session.setAttribute("sortDefault", "Giá tăng dần");
			session.setAttribute("imgRepository", imgRepository);
			session.setAttribute("shopRepository", shopRepository);
			session.setAttribute("productRepository", productRepository);
			session.setAttribute("cartRepository", cartRepository);
			String id = (String) session.getAttribute("id");
			if (id != null) {
				String status = Status.WAITING_ORDER.toString();
				session.setAttribute("lengthCart", cartRepository.getPurchase(id, status).size());
			}
			session.setAttribute("username", session.getAttribute("username"));
			List<String> filterBy = new ArrayList<String>();
			filterBy.add(0, Filter.COST.toString());
			filterBy.add(1, Filter.BRAND.toString());
			List<String> sortBy = new ArrayList<String>();
			sortBy.add(0, Sort.BY_COST_G.toString());
			sortBy.add(1, Sort.BY_COST_L.toString());
			sortBy.add(2, Sort.BY_SALE_G.toString());
			sortBy.add(3, Sort.BY_SALE_L.toString());
			session.setAttribute("filterBy", filterBy);
			session.setAttribute("sortBy", sortBy);

			List<String> name = new ArrayList<String>();
			List<Product> productListSale = new ArrayList<Product>();
			for (int i = 0; i < productRepository.getProductSaleDESC().size(); i++) {
				if (!name.contains((String) ((Product) productRepository.getProductSaleDESC().get(i)).getId())) {
					name.add((String) ((Product) productRepository.getProductSaleDESC().get(i)).getId());
					productListSale.add((Product) productRepository.getProductSaleDESC().get(i));
				}

			}
			session.setAttribute("productListSale", productListSale);
			session.setAttribute("productListView", productRepository.getProductMostView());
			session.setAttribute("productListNew", productRepository.getProductNew());

			String nameU = (String) userRepository.login(email, password).get();

			session.setAttribute("username", nameU);
			session.setAttribute("id", (String) userRepository.getID(email));
			session.setAttribute("yearDefault", com.trinhlequockhanh.cdweb.model.Date.YEAR_DEFAULT);
			session.setAttribute("monthDefault", com.trinhlequockhanh.cdweb.model.Date.MONTH_DEFAULT);

			return "index";
		}
	}

	@RequestMapping(value = { "/", "/index" }, method = RequestMethod.GET)
	public String index(Model model, HttpServletRequest request, HttpServletResponse response)
			throws GeneralSecurityException, IOException, MessagingException {
		HttpSession session = request.getSession();
		session.setAttribute("sortDefault", "Giá tăng dần");
		session.setAttribute("imgRepository", imgRepository);
		session.setAttribute("shopRepository", shopRepository);
		session.setAttribute("productRepository", productRepository);
		session.setAttribute("cartRepository", cartRepository);
		String id = (String) session.getAttribute("id");
		if (id != null) {
			String status = Status.WAITING_ORDER.toString();
			session.setAttribute("lengthCart", cartRepository.getPurchase(id, status).size());
		}
		session.setAttribute("username", session.getAttribute("username"));
		List<String> filterBy = new ArrayList<String>();
		filterBy.add(0, Filter.COST.toString());
		filterBy.add(1, Filter.BRAND.toString());
		List<String> sortBy = new ArrayList<String>();
		sortBy.add(0, Sort.BY_COST_G.toString());
		sortBy.add(1, Sort.BY_COST_L.toString());
		sortBy.add(2, Sort.BY_SALE_G.toString());
		sortBy.add(3, Sort.BY_SALE_L.toString());
		session.setAttribute("filterBy", filterBy);
		session.setAttribute("sortBy", sortBy);

		List<String> name = new ArrayList<String>();
		List<Product> productListSale = new ArrayList<Product>();
		for (int i = 0; i < productRepository.getProductSaleDESC().size(); i++) {
			if (!name.contains((String) ((Product) productRepository.getProductSaleDESC().get(i)).getId())) {
				name.add((String) ((Product) productRepository.getProductSaleDESC().get(i)).getId());
				productListSale.add((Product) productRepository.getProductSaleDESC().get(i));
			}

		}
		session.setAttribute("productListSale", productListSale);
		session.setAttribute("productListView", productRepository.getProductMostView());
		session.setAttribute("productListNew", productRepository.getProductNew());

		return "index";

	}

	@RequestMapping(value = { "login-google-process" }, method = RequestMethod.GET)
	public String loginGoogle(Model model, HttpServletRequest request) {
		HttpSession session = request.getSession();
		model.addAttribute("username", session.getAttribute("username"));
		return "index";

	}

	@RequestMapping(value = { "/", "/index" }, method = RequestMethod.POST)
	public String indexPost(Model model, HttpServletRequest request, HttpServletResponse response)
			throws GeneralSecurityException, IOException, MessagingException {
		return "index";

	}

	@RequestMapping(value = { "choose-year" }, method = RequestMethod.POST)
	public void chooseYear(HttpServletResponse response, HttpServletRequest request, Model model) throws IOException {
		String year = (String) request.getParameter("year");
		HttpSession session = request.getSession();
		int yearDefault = Integer.parseInt(year);
		session.setAttribute("yearDefault", yearDefault);
		response.setContentType("text/xml");
		response.setHeader("Cache-Control", "no-cache");
		response.getWriter().write("<valid>true</valid>");

	}

	@RequestMapping(value = { "choose-month" }, method = RequestMethod.POST)
	public void chooseMonth(HttpServletResponse response, HttpServletRequest request, Model model) throws IOException {
		HttpSession session = request.getSession();
		String month = (String) request.getParameter("month");
		int monthDefault = Integer.parseInt(month);
		session.setAttribute("monthDefault", monthDefault);
		response.setContentType("text/xml");
		response.setHeader("Cache-Control", "no-cache");
		response.getWriter().write("<valid>true</valid>");

	}

	@RequestMapping(value = { "dashboard" }, method = RequestMethod.GET)
	public String cartContent(Model model, HttpServletRequest request) {

		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");
		int yearDefault = (int) session.getAttribute("yearDefault");
		List<Integer> years = new ArrayList<Integer>();
		List<Integer> months = new ArrayList<Integer>();
		LocalDate date = LocalDate.now();
		int year = date.getYear();
		int yearStart = 2020;
		for (int i = 2020; i <= year; i++) {
			years.add(i);
		}
		for (int i = 1; i <= 12; i++) {
			months.add(i);
		}

		session.setAttribute("years", years);
		session.setAttribute("months", months);
		session.setAttribute("thisYear", year);
		session.setAttribute("yearStart", yearStart);
		Map<Integer, Double> map = new HashMap<Integer, Double>();
//		int yearDefault = 2022;
		for (int i = 1; i < 13; i++) {

			if (cartRepository.getReportOfMonth(yearDefault, i, id) == null) {
				map.put(i, (double) 0);
			} else {
				map.put(i, (Double) cartRepository.getReportOfMonth(yearDefault, i, id) / 1000000);
			}
		}
		session.setAttribute("report", map);
		return "dashboard";

	}

	@RequestMapping(value = { "forget-pass" }, method = RequestMethod.POST)
	public String getPassword(@RequestParam(value = "email") String email, Model model, HttpServletRequest request)
			throws MessagingException {
		HttpSession session = request.getSession();
		model.addAttribute("username", session.getAttribute("username"));
		mail.getPassword(email);
		return "index";

	}

	@RequestMapping(value = { "forget-password" }, method = RequestMethod.GET)
	public String forgetPassword() {
		return "forgetPassword";

	}

	@RequestMapping(value = { "home" }, method = RequestMethod.GET)
	public String home() {
		return "home";

	}

	@RequestMapping(value = { "process-active" }, method = RequestMethod.GET)
	public String activeMail(@RequestParam(value = "id") String id, @RequestParam(value = "confirm") String confirm,
			Model model, HttpServletRequest request) {

		userRepository.getActive(id);
		HttpSession session = request.getSession();
		model.addAttribute("username", session.getAttribute("username"));
		return "index";

	}

	@RequestMapping(value = { "process-register" }, method = RequestMethod.POST)
	public String doRegister(@RequestParam(value = "fullname") String fullname,
			@RequestParam(value = "email") String email, @RequestParam(value = "phone") String phone,
			@RequestParam(value = "address") String address, @RequestParam(value = "username") String username,
			@RequestParam(value = "password") String password, @RequestParam(value = "birthday") String birthday,
			Model model, HttpServletRequest request) throws MessagingException {
		long time = System.currentTimeMillis();
		HttpSession session = request.getSession();
		if (!userRepository.checkExistMail(email).isEmpty()) {
//			errorRegister
			session.setAttribute("errorRegister", "Email đã được sử dụng!!!");
			return "register";
		} else if (!userRepository.checkExistPhone(phone).isEmpty()) {
//			errorRegister
			session.setAttribute("errorRegister", "Số điện thoại đã được sử dụng!!!");
			return "register";

		}

		else {
			String id = "u" + time;
			com.trinhlequockhanh.cdweb.entities.User user = new com.trinhlequockhanh.cdweb.entities.User();
			user.setId(id);
			user.setFullname(fullname);
			user.setEmail(email);
			user.setPhonenumber(phone);
			user.setAddress(address);
			user.setUsername(username);
			user.setPassword(password);
			user.setActived(false);
			user.setShop(false);
			user.setBirthday(java.sql.Date.valueOf(birthday));

			if (userRepository.save(user) == null) {
				return "index";

			} else {
				mail.sendMail(email, user.getId());
				model.addAttribute("username", session.getAttribute("username"));
			}
		}
		return "index";
	}

//	id, fullname , email, address, username, password,phonenumber,actived,shop,admin, birthday
	@RequestMapping(value = { "confirm-api" }, method = RequestMethod.POST)
	public String confirmApi() {
		return "confirm";
	}

	@RequestMapping(value = { "login-google" }, method = RequestMethod.POST)
	public String loginGoogle(Model model, HttpServletRequest request, HttpServletResponse response)
			throws GeneralSecurityException, IOException {
		HttpSession session = request.getSession();
		String token = request.getParameter("idtoken");
		System.out.println("idtoken: " + token);
		GoogleIdTokenVerifier verifier = new GoogleIdTokenVerifier.Builder(new NetHttpTransport(), new GsonFactory())
				// Specify the CLIENT_ID of the app that accesses the backend:
				.setAudience(Collections
						.singletonList("757029011142-bcohjjqnca15ucgnu1d91mrlvus5c4i6.apps.googleusercontent.com"))
				// Or, if multiple clients access the backend:
				// .setAudience(Arrays.asList(CLIENT_ID_1, CLIENT_ID_2, CLIENT_ID_3))
				.build();

		// (Receive idTokenString by HTTPS POST)

		GoogleIdToken idToken = verifier.verify(token);
		if (idToken == null) {
			return "login";
		} else {
			Payload payload = idToken.getPayload();

			// Print user identifier
			String userId = payload.getSubject();
			System.out.println("User ID: " + userId);

			// Get profile information from payload
			String email = payload.getEmail();
			boolean emailVerified = Boolean.valueOf(payload.getEmailVerified());
			String name = (String) payload.get("name");
			String pictureUrl = (String) payload.get("picture");
			String locale = (String) payload.get("locale");
			String familyName = (String) payload.get("family_name");
			String givenName = (String) payload.get("given_name");
			System.out.println(email);
			System.out.println(emailVerified);
			System.out.println(name);
			System.out.println(pictureUrl);
			System.out.println(locale);
			System.out.println(familyName);
			System.out.println(givenName);
			session.setAttribute("id", "u" + userId);
			session.setAttribute("username", familyName);
			// Use or store profile information
			// ...
			return "index";
		}
//		else {
//			System.out.println("Invalid ID token.");
//
//		return "index";
//		}

	}

	@RequestMapping(value = { "/login-fb" }, method = RequestMethod.GET)
	public String loginFB(Model model, HttpServletRequest request, HttpServletResponse response)
			throws GeneralSecurityException, IOException {
		String code = request.getParameter("code");
		HttpSession session = request.getSession();
		if (code == null || code.isEmpty()) {
			return "login";
		} else {
			String accessToken = restFB.getToken(code);
			User user = restFB.getUserInfo(accessToken);
			request.setAttribute("id", user.getId());
			request.setAttribute("name", user.getName());
			request.setAttribute("email", user.getEmail());
			System.out.println("id " + user.getId());
			System.out.println("name " + user.getName());
			System.out.println("email " + user.getEmail());
			System.out.println("ngày sinh " + user.getBirthdayAsDate());
			System.out.println("ngày sinh kiểu string " + user.getBirthday());
			System.out.println("fb api: " + user.getName());
			session.setAttribute("id", "u" + user.getId());
			session.setAttribute("username", user.getName());
			return "index";
		}

	}

	@RequestMapping(value = { "/cart" }, method = RequestMethod.GET)
	public String cart(Model model, HttpServletRequest request) throws ParseException {
		model.addAttribute("productRepository", productRepository);
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");
		String status = Status.WAITING_ORDER.toString();
		model.addAttribute("products", cartRepository.getPurchase(id, status));
		for (Cart cart : cartRepository.getPurchase(id, status)) {
			model.addAttribute("totalCost", new BigDecimal("" + cartRepository.getTotalCost(id)).toBigInteger());
			model.addAttribute("user-id", id);
		}
		return "cart";
	}

	@RequestMapping(value = { "total-change" }, method = RequestMethod.GET)
	public void totalChange(HttpServletResponse response, HttpServletRequest request) throws IOException {
		String total0 = (String) request.getParameter("total-change").trim();
		String id = (String) request.getParameter("id").trim();
		try {
			int total = Integer.parseInt(total0);
			if (total <= cartRepository.getTotalProduct(cartRepository.getIDProduct(id))) {

				response.setContentType("text/xml");
				response.setHeader("Cache-Control", "no-cache");
				response.getWriter().write("<valid>true</valid>");

				Cart cartToUpdate = cartRepository.findById(id).get();
				cartToUpdate.setTotal(total);
				cartRepository.save(cartToUpdate);
			} else {
				response.setContentType("text/xml");
				response.setHeader("Cache-Control", "no-cache");
				response.getWriter().write("<valid>false</valid>");
			}
		} catch (Exception e) {
			response.setContentType("text/xml");
			response.setHeader("Cache-Control", "no-cache");
			response.getWriter().write("<valid>InvaliInput</valid>");
		}

	}

	@RequestMapping(value = { "/register" }, method = RequestMethod.GET)
	public String register() {
		return "register";
	}

	@RequestMapping(value = { "/thong-ke" }, method = RequestMethod.GET)
	public String thongKe() {
		return "thongKe";
	}

	@RequestMapping(value = { "/store-content" }, method = RequestMethod.GET)
	public String storeContent() {
		return "storeContent";
	}

	@RequestMapping(value = { "/logout" }, method = RequestMethod.GET)
	public String logout(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.invalidate();
		return "index";
	}

	@RequestMapping(value = { "/vnpay-return" }, method = RequestMethod.GET)
	@Transactional
	public String vnpayReturn(HttpServletRequest request) throws UnsupportedEncodingException {
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");
		Map fields = new HashMap();
		for (Enumeration params = request.getParameterNames(); params.hasMoreElements();) {
			String fieldName = URLEncoder.encode((String) params.nextElement(), StandardCharsets.US_ASCII.toString());
			String fieldValue = URLEncoder.encode(request.getParameter(fieldName),
					StandardCharsets.US_ASCII.toString());
			if ((fieldValue != null) && (fieldValue.length() > 0)) {
				fields.put(fieldName, fieldValue);
			}
		}

		String vnp_SecureHash = request.getParameter("vnp_SecureHash");
		if (fields.containsKey("vnp_SecureHashType")) {
			fields.remove("vnp_SecureHashType");
		}
		if (fields.containsKey("vnp_SecureHash")) {
			fields.remove("vnp_SecureHash");
		}
		Config config1 = new Config();
		String signValue = config1.hashAllFields(fields);
		if (signValue.equals(vnp_SecureHash)) {
			if ("00".equals(request.getParameter("vnp_TransactionStatus"))) {
				List<Cart> carts = cartRepository.getListCartWaitOrder(id, Status.WAITING_ORDER.toString());
				Map<Integer, String> lCarts0 = new HashMap<Integer, String>();
				Map<String, Integer> lCarts = new HashMap<String, Integer>();

				for (int i = 0; i < carts.size(); i++) {
					lCarts0.put(i, carts.get(i).getIdproduct());
					lCarts.put(carts.get(i).getIdproduct(), carts.get(i).getTotal());

				}
				for (int i = 0; i < lCarts.size(); i++) {
					if (productRepository.findById(lCarts0.get(i)) != null) {
						Product product = productRepository.findById(lCarts0.get(i)).get();
						int total = lCarts.get(lCarts0.get(i));
						product.setTotal(productRepository.findById(lCarts0.get(i)).get().getTotal() - total);
						productRepository.save(product);
					}
				}

				for (Cart cart : carts) {
					LocalDate dateOrder = LocalDate.now();
					cart.setStatus(Status.WAITING_CONFIRM.toString());
					cart.setOrderdate(java.sql.Date.valueOf(dateOrder));
					cartRepository.save(cart);

				}
			}

		}
		return "vnpay_return";

	}

	@RequestMapping(value = { "/payment" }, method = RequestMethod.GET)
	public String pay() {

		return "payment";
	}

	@RequestMapping(value = { "vnpayajax" }, method = RequestMethod.POST)
	public void validateId(HttpServletResponse resp, HttpServletRequest req) throws IOException {
		String vnp_Version = "2.1.0";
		String vnp_Command = "pay";
		// String vnp_Command = "genqr";
		String vnp_OrderInfo = req.getParameter("vnp_OrderInfo");
		String orderType = req.getParameter("ordertype");
		String vnp_TxnRef = config.getRandomNumber(8);
		int mcId = Integer.parseInt(config.getRandomNumber(8));
		int amountmc = Integer.parseInt(req.getParameter("amount"));
		String vnp_IpAddr = config.getIpAddress(req);
		String vnp_TmnCode = Config.vnp_TmnCode;
		int amount = Integer.parseInt(req.getParameter("amount")) * 100;
		Map<String, String> vnp_Params = new HashMap<>();
		vnp_Params.put("vnp_Version", vnp_Version);
		vnp_Params.put("vnp_Command", vnp_Command);
		vnp_Params.put("vnp_TmnCode", vnp_TmnCode);
		vnp_Params.put("vnp_Amount", String.valueOf(amount));
		vnp_Params.put("vnp_CurrCode", "VND");
		String bank_code = req.getParameter("bankcode");
		if (bank_code != null && !bank_code.isEmpty()) {
			vnp_Params.put("vnp_BankCode", bank_code);
		}
		vnp_Params.put("vnp_TxnRef", vnp_TxnRef);
		vnp_Params.put("vnp_OrderInfo", vnp_OrderInfo);
		vnp_Params.put("vnp_OrderType", orderType);

		String locate = req.getParameter("language");
		if (locate != null && !locate.isEmpty()) {
			vnp_Params.put("vnp_Locale", locate);
		} else {
			vnp_Params.put("vnp_Locale", "vn");
		}
		vnp_Params.put("vnp_ReturnUrl", Config.vnp_Returnurl);
		vnp_Params.put("vnp_IpAddr", vnp_IpAddr);

		Date dt = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
		String vnp_CreateDate = formatter.format(dt);
		vnp_Params.put("vnp_CreateDate", vnp_CreateDate);

		Calendar cldvnp_ExpireDate = Calendar.getInstance();
		cldvnp_ExpireDate.add(Calendar.SECOND, 30);
		Date vnp_ExpireDateD = cldvnp_ExpireDate.getTime();
		String vnp_ExpireDate = formatter.format(vnp_ExpireDateD);

		vnp_Params.put("vnp_ExpireDate", vnp_ExpireDate);

		List fieldNames = new ArrayList(vnp_Params.keySet());
		Collections.sort(fieldNames);
		StringBuilder hashData = new StringBuilder();
		StringBuilder query = new StringBuilder();
		Iterator itr = fieldNames.iterator();
		while (itr.hasNext()) {
			String fieldName = (String) itr.next();
			String fieldValue = (String) vnp_Params.get(fieldName);
			if ((fieldValue != null) && (fieldValue.length() > 0)) {
				// Build hash data
				hashData.append(fieldName);
				hashData.append('=');
				// hashData.append(fieldValue); //sử dụng và 2.0.0 và 2.0.1 checksum sha256
				hashData.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString())); // sử dụng v2.1.0
																										// check sum
																										// sha512
				// Build query
				query.append(URLEncoder.encode(fieldName, StandardCharsets.US_ASCII.toString()));
				query.append('=');
				query.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));
				if (itr.hasNext()) {
					query.append('&');
					hashData.append('&');
				}
			}
		}
		String queryUrl = query.toString();
		// String vnp_SecureHash = Config.Sha256(Config.vnp_HashSecret +
		// hashData.toString());
		String vnp_SecureHash = config.hmacSHA512(Config.vnp_HashSecret, hashData.toString());
		queryUrl += "&vnp_SecureHash=" + vnp_SecureHash;
		String paymentUrl = Config.vnp_PayUrl + "?" + queryUrl;
		JsonObject job = new JsonObject();
		job.addProperty("code", "00");
		job.addProperty("message", "success");
		job.addProperty("data", paymentUrl);
		Gson gson = new Gson();
		resp.getWriter().write(gson.toJson(job));
	}

}
