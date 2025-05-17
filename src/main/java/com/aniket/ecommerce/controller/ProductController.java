package com.aniket.ecommerce.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.aniket.ecommerce.entity.Merchant;
import com.aniket.ecommerce.entity.Product;
import com.aniket.ecommerce.service.MerchantService;
import com.aniket.ecommerce.service.ProductService;


@Controller

public class ProductController {
	
	@Autowired
	private ProductService productService;
	
	@Autowired
	private MerchantService merchantService;
	
	
	
	@GetMapping(path ="/AddProduct")
	protected String AddProduct()
	{
		return "AddProduct";
	}
	
	
	@PostMapping("/saveProduct/{merchantId}")
	@Transactional
	public String saveProduct(
	        @PathVariable("merchantId") int merchantId,
	        @RequestParam("productName") String productName,
	        @RequestParam("productDescription") String productDescription,
	        @RequestParam("productPrice") double productPrice,
	        @RequestParam("category") String category,
	        @RequestParam("image") MultipartFile imageFile,
	        HttpSession session,
	        RedirectAttributes redirectAttributes,ModelMap map) {

	    try {
	        // 1. Get the merchant (attached to current session)
	        Merchant merchant = merchantService.findMerchantById(merchantId);
	        if (merchant == null) {
	            throw new RuntimeException("Merchant not found");
	        }

	        // 2. Create and populate product
	        Product product = new Product();
	        product.setProductName(productName);
	        product.setProductDescription(productDescription);
	        product.setProductPrice(productPrice);
	        product.setCategory(category);
	        product.setMerchant(merchant);

	        // 3. Handle image
	        if (!imageFile.isEmpty()) {
	            product.setImage(imageFile.getBytes());
	        }

	        // 4. Save product (this should automatically update both sides if cascade is set)
	        productService.saveProduct(product);

	        // 5. Add to merchant's collection (if not cascading)
	        merchant.getProducts().add(product);
	        map.addAttribute("products", merchant.getProducts());
		   
	        
	        // 6. Set success message
	        redirectAttributes.addFlashAttribute("success", "Product added successfully!");
	        return "ProductView";

	    } catch (Exception e) {
	        redirectAttributes.addFlashAttribute("error", "Error saving product: " + e.getMessage());
	        return "redirect:/AddProduct";
	    }
	}
}
