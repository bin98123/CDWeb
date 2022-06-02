package com.trinhlequockhanh.cdweb.controller;

import java.io.UnsupportedEncodingException;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.trinhlequockhanh.cdweb.entities.Student;
import com.trinhlequockhanh.cdweb.repository.StudentRepository;

@Controller
public class MainController {
	@Autowired
	private StudentRepository studentRepository;

	@RequestMapping(value = { "/", "/student-list" })
	public String liststudent(Model model)
			throws UnsupportedEncodingException {
		System.out.println(studentRepository.findAll());
		model.addAttribute("listStudent", studentRepository.findAll());
		return "student-list";
	}

	@RequestMapping("/student-save")
	public String insertstudent(Model model) {
		model.addAttribute("student", new Student());
		return "student-save";
	}

	@RequestMapping("/student-view/{studentid}")
	public String viewstudent(@PathVariable String studentid, Model model) {
		Optional<Student> student = studentRepository.findById(Integer.parseInt(studentid));
		if (student.isPresent()) {
			model.addAttribute("student", student.get());
		}
		return "student-view";
	}

	@RequestMapping("/student-update/{studentid}")
	public String updatestudent(@PathVariable String studentid, Model model) {
		Optional<Student> student = studentRepository.findById(Integer.parseInt(studentid));
		if (student.isPresent()) {
			model.addAttribute("student", student.get());
		}
		return "student-update";
	}

	@RequestMapping("/saveStudent")
	public String doSavestudent(@ModelAttribute("student") Student student, Model model, HttpServletRequest request) {

//		student.setBirthday(java.sql.Date.valueOf(request.getParameter("birthday")));
		studentRepository.save(student);
		model.addAttribute("listStudent", studentRepository.findAll());
		return "student-list";
	}

	@RequestMapping("/updateStudent")
	public String doUpdatestudent(@ModelAttribute("student") Student student, Model model) {
		studentRepository.save(student);
		model.addAttribute("listStudent", studentRepository.findAll());
		return "student-list";
	}

	@RequestMapping("/studentDelete/{studentid}")
	public String doDeletestudent(@PathVariable String studentid, Model model) {
		studentRepository.deleteById(Integer.parseInt(studentid));
		model.addAttribute("listStudent", studentRepository.findAll());
		return "student-list";
	}
}