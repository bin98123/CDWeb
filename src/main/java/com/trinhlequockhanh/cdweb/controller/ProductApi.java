package com.trinhlequockhanh.cdweb.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.trinhlequockhanh.cdweb.repository.CartRepository;

@RestController
@RequestMapping("/api/product")
public class ProductApi {

	@Autowired
	private CartRepository cartRepository;

	// lấy dữ liệu làm báo cáo thống kê
	@GetMapping("/report")
	public List<Object> test(@RequestParam(value = "id") String id) {
		return cartRepository.getReport(id);
	}

	@GetMapping("/report-by-brand")
	public List<Object> getReportByBrand(@RequestParam(value = "id") String id, HttpServletRequest request) {
		HttpSession session = request.getSession();
		int monthDefault = (int) session.getAttribute("monthDefault");
		int yearDefault = (int) session.getAttribute("yearDefault");
		return cartRepository.getReportByBrand(yearDefault, monthDefault, id);
	}

}
