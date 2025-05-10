package com.aniket.ecommerce.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
}
