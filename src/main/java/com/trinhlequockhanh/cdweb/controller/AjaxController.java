package com.trinhlequockhanh.cdweb.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.trinhlequockhanh.cdweb.model.CostFilter;
import com.trinhlequockhanh.cdweb.model.Filter;
import com.trinhlequockhanh.cdweb.model.Sort;
import com.trinhlequockhanh.cdweb.model.Status;
import com.trinhlequockhanh.cdweb.repository.CartRepository;
import com.trinhlequockhanh.cdweb.repository.ProductRepository;
import com.trinhlequockhanh.cdweb.entities.Cart;
import com.trinhlequockhanh.cdweb.entities.Product;

@RestController
@RequestMapping("/ajax")
public class AjaxController {
	@Autowired
	private CartRepository cartRepository;
	@Autowired
	private ProductRepository productRepository;

	@GetMapping("/add-cart")
	public void totalChange(HttpServletResponse response, HttpServletRequest request, Model model) throws IOException {
		String id = (String) request.getParameter("id");
		HttpSession session = request.getSession();
		String idUser = (String) session.getAttribute("id");
		if (idUser != null) {
			Cart cart = new Cart();
			System.out.println(
					"don hang cho dat: " + cartRepository.checkCart(id, idUser, Status.WAITING_ORDER.toString()));
			if (!cartRepository.checkCart(id, idUser, Status.WAITING_ORDER.toString()).isEmpty()) {
				cart = (Cart) cartRepository.checkCart(id, idUser, Status.WAITING_ORDER.toString()).get();
				int newTotal = (int) ((Cart) cartRepository.checkCart(id, idUser, Status.WAITING_ORDER.toString())
						.get()).getTotal() + 1;
				cart.setTotal(newTotal);
				cartRepository.save(cart);

			} else {
				long time = System.currentTimeMillis();
				cart.setId("c" + time);
				cart.setIdproduct(id);
				cart.setIduser(idUser);
				cart.setTotal(1);
				cart.setStatus(Status.WAITING_ORDER.toString());
				cart.setOrderdate(null);
				cart.setDelivereddate(null);
				cartRepository.save(cart);
			}
			response.setContentType("text/xml");
			response.setHeader("Cache-Control", "no-cache");
			response.getWriter().write("<valid>true</valid>");
		} else {
			response.setContentType("text/xml");
			response.setHeader("Cache-Control", "no-cache");
			response.getWriter().write("<valid>false</valid>");
		}

	}

	@GetMapping("/delete-cart")
	public void getDeleteCart(@RequestParam(value = "id") String id, HttpServletRequest request) {
		cartRepository.deleteById(id);
	}

	@GetMapping("/cancel")
	public void cancel(@RequestParam(value = "id") String id, HttpServletRequest request) {
		Cart cart = (Cart) cartRepository
				.getCartSubAjaxCancel(id, Status.WAITING_ORDER.toString(), Status.WAITING_CONFIRM.toString()).get();
		cart.setStatus(Status.CANCEL.toString());
		cartRepository.save(cart);
	}

	@GetMapping("/submit-order")
	public void submitOrder(@RequestParam(value = "id") String id, HttpServletRequest request) {
		Cart cart = (Cart) cartRepository.submitOrderAjax(id, Status.WAITING_CONFIRM.toString()).get();
		cart.setStatus(Status.WAITING_DELIVERING.toString());
		cartRepository.save(cart);
	}

	@GetMapping("/get-sort")
	public void getSort(HttpServletRequest request) {
		List<Product> productListSale = new ArrayList<Product>();
		HttpSession session = request.getSession();
		session.removeAttribute("productListSale1");
		String sort = (String) request.getParameter("sort");
		System.out.println("sortttttttt: " + sort);
		List<String> name = new ArrayList<String>();
		for (int i = 0; i < productRepository.getProductSaleDESC().size(); i++) {
			if (!name.contains((String) ((Product) productRepository.getProductSaleDESC().get(i)).getId())) {
				name.add((String) ((Product) productRepository.getProductSaleDESC().get(i)).getId());
				productListSale.add((Product) productRepository.getProductSaleDESC().get(i));
			}

		}
		if (sort.equals(Sort.BY_COST_G.toString())) {
			productListSale = productRepository.getProductASC();
			session.setAttribute("productListSale1", productListSale);
			session.setAttribute("sortDefault", sort);
			System.out.println("Sắp xếp ajax: " + productListSale);
		} else if (sort.equals(Sort.BY_COST_L.toString())) {

			productListSale = productRepository.getProductDESC();
			session.setAttribute("productListSale1", productListSale);
			session.setAttribute("sortDefault", sort);
			System.out.println("Sắp xếp ajax: " + productListSale);
		} else if (sort.equals(Sort.BY_SALE_L.toString())) {

			session.setAttribute("productListSale1", productListSale);
//			session.setAttribute("productListSale1", productRepository.getProductSaleDESC());
			session.setAttribute("sortDefault", sort);
			System.out.println("Sắp xếp ajax: " + productListSale);
		} else {
			List<Product> productListSale1 = new ArrayList<Product>();
			for (int i = productListSale.size() - 1; i >= 0; i--) {
				productListSale1.add(productListSale.get(i));
			}

			session.setAttribute("productListSale1", productListSale1);
			session.setAttribute("sortDefault", sort);
			System.out.println("Sắp xếp ajax: " + productListSale);
		}

	}

	@GetMapping("/get-filter-select")
	public void getFilterSelect(HttpServletRequest request) {
		List<Product> productListSale = new ArrayList<Product>();
		HttpSession session = request.getSession();
		session.removeAttribute("productListSale1");
		String filterSelect = (String) request.getParameter("filter-select");
		System.out.println("filterSelect: " + filterSelect);
		List<String> listBrand = new ArrayList<String>();
		if (filterSelect.equals(Filter.BRAND.toString())) {
			listBrand = productRepository.getBrand();
			session.setAttribute("select", listBrand);
			session.setAttribute("filterDefault", filterSelect);
			session.removeAttribute("selectfilterDefault");
			System.out.println("Sắp xếp ajax: " + productListSale);
		} else {
			productListSale = productRepository.getProductSaleASC();
			listBrand.add(0, CostFilter.L.toString());
			listBrand.add(1, CostFilter.AVG.toString());
			listBrand.add(2, CostFilter.G.toString());
			session.setAttribute("select", listBrand);
			session.removeAttribute("selectfilterDefault");
			session.setAttribute("filterDefault", filterSelect);
			System.out.println("Sắp xếp ajax: " + productListSale);
		}

	}

	@GetMapping("/get-filter")
	public void getFilter(HttpServletRequest request) {
		List<Product> productListSale = new ArrayList<Product>();
		HttpSession session = request.getSession();
		session.removeAttribute("productListSale1");
		String filterSelect = (String) request.getParameter("filter-select");
		String choose = (String) request.getParameter("choose");
		System.out.println("filterSelect: " + filterSelect);
		if (choose.equals("Giá")) {
			if (filterSelect.equals(CostFilter.L.toString())) {
				session.setAttribute("productListSale1", productRepository.getProductByCostL());
				session.setAttribute("selectfilterDefault", filterSelect);
				System.out.println("Sắp xếp ajax: " + productListSale);
			} else if (filterSelect.equals(CostFilter.AVG.toString())) {
				session.setAttribute("productListSale1", productRepository.getProductByCostAVG());
				session.setAttribute("selectfilterDefault", filterSelect);
				System.out.println("Sắp xếp ajax: " + productListSale);
			} else {
				session.setAttribute("productListSale1", productRepository.getProductByCostG());
				session.setAttribute("selectfilterDefault", filterSelect);
				System.out.println("Sắp xếp ajax: " + productListSale);
			}
		} else {

			session.setAttribute("productListSale1", productRepository.getProductByBrand(filterSelect));
			session.setAttribute("selectfilterDefault", filterSelect);
			System.out.println("Sắp xếp ajax: " + productListSale);
		}
	}
}
