package com.aniket.ecommerce.controller;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.aniket.ecommerce.entity.Product;
import com.aniket.ecommerce.service.ProductService;


@Controller

public class ProductController {
	
	@Autowired
	private ProductService productService;
	
	
	
	@GetMapping(path ="/AddProduct")
	protected String AddProduct()
	{
		return "AddProduct";
	}
	
	
	 @PostMapping("/saveProduct")
	    public String saveProduct( @RequestParam("productName") String productName,
	            @RequestParam("productDescription") String productDescription,
	            @RequestParam("productPrice") double productPrice,
	            @RequestParam("image") MultipartFile imageFile,ModelMap map) {

	        Product product = new Product();
	       
	        product.setProductName(productName);
	        product.setProductDescription(productDescription);
	        product.setProductPrice(productPrice);

	        try {
	            product.setImage(imageFile.getBytes());
	        } catch (IOException e) {
	            e.printStackTrace();
	            // Handle error - log or show message
	        }
	        
	        Product product2 = productService.saveProduct(product);
	        if(product2!=null)
	        {
	        	map.addAttribute("product", product2);
	        }else {
	        	map.addAttribute("message", "Product Not Found");
	        }
	        	

	       
	        return "ProductView"; // Redirect back to form or success page
	    }

}
