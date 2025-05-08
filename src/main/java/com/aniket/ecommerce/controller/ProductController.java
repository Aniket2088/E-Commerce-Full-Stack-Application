package com.aniket.ecommerce.controller;

import java.io.IOException;
import java.util.List;

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
	public String saveProduct(@RequestParam("productName") String productName,
	                          @RequestParam("productDescription") String productDescription,
	                          @RequestParam("productPrice") double productPrice,
	                          @RequestParam("category") String category,
	                          @RequestParam("image") MultipartFile imageFile,
	                          ModelMap map) {

	    Product product = new Product();

	    product.setProductName(productName);
	    product.setProductDescription(productDescription);
	    product.setProductPrice(productPrice);
	    product.setCategory(category);  // ✅ Save category from dropdown

	    try {
	        product.setImage(imageFile.getBytes());
	    } catch (IOException e) {
	        e.printStackTrace();
	        // You may also set an error message to show on frontend
	    }

	    productService.saveProduct(product);  // Save the product

	    List<Product> products = productService.finAllProduct();
	    if (products != null) {
	        map.addAttribute("products", products);
	    } else {
	        map.addAttribute("message", "Product Not Found");
	    }

	    return "ProductView"; // Show the list view after adding
	}

}
