package com.aniket.ecommerce.controller;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.aniket.ecommerce.entity.Merchant;
import com.aniket.ecommerce.service.MerchantService;

@Controller
public class MerchanController {
	
	@Autowired
	private MerchantService merchantService;
	
	@GetMapping(path = "/MerchantSignup")
	protected String MerchantSignup()
	{
		return "MerchantSignup";
	}
	
	@GetMapping(path = "/merchantLogin")
	protected String MerchantLogin()
	{
		return "merchantLogin";
	}


    // Process registration
    @PostMapping("/registerMerchant")
    public String registerMerchant(
            @RequestParam("name") String name,
            @RequestParam("email") String email,
            @RequestParam("phone") long phone,
            @RequestParam("password") String password,
            @RequestParam("accountNumber") String accountNumber,
            @RequestParam("bankName")  String bankName,
            @RequestParam("ifscCode")  String ifscCode,
            Model model) {

        try {
            // Check if email already exists
        

            // Create new merchant
            Merchant merchant = new Merchant();
            merchant.setName(name);
            merchant.setEmail(email);
            merchant.setPhone(phone);
            merchant.setPassword(password); // Note: Password should be encrypted
            merchant.setAccountNumber(accountNumber);
            merchant.setBankName(bankName);
            merchant.setIfscCode(ifscCode);

            // Save merchant
            Merchant saveMerchant = merchantService.saveMerchant(merchant);
            if(saveMerchant!=null) {

            // Registration successful
            model.addAttribute("success", "Registration successful! Please login.");
            return "merchantLogin";}
            
        } catch (Exception e) {
            model.addAttribute("error", "Registration failed: " + e.getMessage());
            return "merchantSignup";
        }
        return "";
    }
    
    @PostMapping("/merchantLogin")
    public String processLogin(
            @RequestParam("email") String email,
            @RequestParam("password") String password,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        
        try {
            Merchant merchant = merchantService.authenticate(email, password);
            
            if (merchant != null) {
                // Store merchant ID in session (better than storing whole object)
                session.setAttribute("merchantId", merchant.getId());
                redirectAttributes.addFlashAttribute("merchant", merchant);
                return "redirect:/AddProduct";
            } else {
                redirectAttributes.addFlashAttribute("error", "Invalid email or password");
                return "redirect:/merchantLogin";
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Login failed: " + e.getMessage());
            return "redirect:/merchantLogin";
        }
    }
    
    @GetMapping("/logout")
    public String logout(HttpSession session, HttpServletResponse response) {
        // Invalidate the session
        session.invalidate();
        
        // Optional: Clear any cookies
        Cookie cookie = new Cookie("JSESSIONID", null);
        cookie.setPath("/");
        cookie.setMaxAge(0);
        response.addCookie(cookie);
        
        // Redirect to login page with logout message
        return "redirect:/merchantLogin";
    }
}
