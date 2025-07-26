package com.aniket.ecommerce.controller;

import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.aniket.ecommerce.entity.Product;
import com.aniket.ecommerce.entity.User;
import com.aniket.ecommerce.service.ProductService;
import com.aniket.ecommerce.service.UserService;

@Controller
public class UserController {
	@Autowired
	private ProductService productService;
	
	@Autowired
	private UserService userService;
	
	@GetMapping(path = "/homePage")
	protected String homePage(Model model)
	{
		 Map<String, Long> categoryCounts = productService.finAllProduct().stream()
		            .collect(Collectors.groupingBy(Product::getCategory, Collectors.counting()));

		        model.addAttribute("categories", categoryCounts.keySet());
		        model.addAttribute("categoryProductsCount", categoryCounts);
		        
		return "HomePage";
	}
	
	@GetMapping(path="/userLogin")
	protected String userLogin()
	{
		return "UserLogin";
	}
	@GetMapping(path="/userSignUp")
	protected String userSignUp()
	{
		return "UserSignUp";
	}
	
	@PostMapping(path="/signUpUser")
	protected String signUpUser(@RequestParam("firstName") String firstName, @RequestParam("lastName") String lastName,@RequestParam("email") String email,@RequestParam("password") String password,ModelMap map) {
			User user = userService.signUpUser(firstName,lastName,email,password);
			if(user!=null)
			{
				map.addAttribute("message", "SignUp successfully");
			}else
			{
				map.addAttribute("message", "Invalid Credentials");
			}
		
		return "UserLogin";
	}
	@PostMapping(path="/loginUser")
	protected String loginUser(@RequestParam("email") String email,@RequestParam("password")String password,ModelMap map, HttpSession session)
	{
		User user = userService.loginUser(email,password);
		if(user!=null) {
			map.addAttribute("message", "Sign In SucessFully");
		session.setAttribute("user", user);
		}
			else
				map.addAttribute("message", "Invalid Credentials");
				
		Map<String, Long> categoryCounts = productService.finAllProduct().stream()
	            .collect(Collectors.groupingBy(Product::getCategory, Collectors.counting()));

	        map.addAttribute("categories", categoryCounts.keySet());
	        map.addAttribute("categoryProductsCount", categoryCounts);
		return "HomePage";
	}
	@GetMapping("/logout")
	public String logoutUser(HttpSession session, HttpServletResponse response,ModelMap map) {
	    // Invalidate the session
	    session.invalidate();
	    
	    // Optional: Clear any cookies
	    Cookie cookie = new Cookie("JSESSIONID", null);
	    cookie.setPath("/");
	    cookie.setMaxAge(0);
	    response.addCookie(cookie);
	    Map<String, Long> categoryCounts = productService.finAllProduct().stream()
	            .collect(Collectors.groupingBy(Product::getCategory, Collectors.counting()));

	        map.addAttribute("categories", categoryCounts.keySet());
	        map.addAttribute("categoryProductsCount", categoryCounts);
	    // Redirect to login page with logout message
	    return "HomePage";
	}

}
