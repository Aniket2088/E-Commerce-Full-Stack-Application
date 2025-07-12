package com.aniket.ecommerce.controller;

import java.util.List;

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
import com.aniket.ecommerce.entity.Product;
import com.aniket.ecommerce.service.MerchantService;
import com.aniket.ecommerce.service.ProductService;

@Controller
public class MerchanController {
	
	@Autowired
	private MerchantService merchantService;
	
	@Autowired
	private ProductService productService;
	
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
  
        
        
            Merchant merchant = merchantService.authenticate(email, password);
           
            
            if (merchant != null) {
                // Store merchant ID in session (better than storing whole object)
                session.setAttribute("merchantId", merchant.getId());
                redirectAttributes.addFlashAttribute("merchant", merchant);
                return "redirect:/merchantproductview";
            } else {
                redirectAttributes.addFlashAttribute("error", "Invalid email or password");
                return "redirect:/merchantLogin";
            }
       }
    
    @GetMapping("/merchantproductview")
    public String viewMerchantProducts(HttpSession session, Model model) {
        // Get the merchantId from session
        Integer merchantId = (Integer) session.getAttribute("merchantId");
        
        if (merchantId == null) {
            return "redirect:/merchantLogin"; // Not logged in
        }

        // Fetch only that merchant’s products
        List<Product> products = productService.getProductsByMerchantId(merchantId);

        model.addAttribute("products", products);
        return "MerchantproductView"; // JSP page
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
