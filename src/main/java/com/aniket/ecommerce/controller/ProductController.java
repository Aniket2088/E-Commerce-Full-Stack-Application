package com.aniket.ecommerce.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
import com.aniket.ecommerce.entity.User;
import com.aniket.ecommerce.service.MerchantService;
import com.aniket.ecommerce.service.ProductService;
import com.aniket.ecommerce.service.UserService;


@Controller

public class ProductController {
	
	@Autowired
	private ProductService productService;
	
	@Autowired
	private MerchantService merchantService;
	
	@Autowired
	private UserService userService;
	
	
	
	@GetMapping(path ="/AddProduct")
	protected String AddProduct()
	{
		return "AddProduct";
	}
	
	 @GetMapping("/orders")
	    public String viewOrders(HttpSession session, Model model) {
	        User user = (User) session.getAttribute("user");
	        if (user == null) {
	            return "redirect:/userLogin";
	        }
	        
	        // Get all products with payment status true for this user
	        List<Product> purchasedProducts = productService.findByPaymentStatusTrue(user);
	        model.addAttribute("purchasedProducts", purchasedProducts);
	        
	        return "orders";
	    }
	@PostMapping("/saveProduct/{merchantId}")
	public String saveProduct(
	        @PathVariable("merchantId") int merchantId,
	        @RequestParam("productName") String productName,
	        @RequestParam("productDescription") String productDescription,
	        @RequestParam("productPrice") double productPrice,
	        @RequestParam("category") String category,
	        @RequestParam("image") MultipartFile imageFile,
	        ModelMap model) {

	    try {
	        Merchant merchant = merchantService.findMerchantById(merchantId);
	        if (merchant == null) {
	            throw new RuntimeException("Merchant not found");
	        }

	        Product product = new Product();
	        product.setProductName(productName);
	        product.setProductDescription(productDescription);
	        product.setProductPrice(productPrice);
	        product.setCategory(category);
	        product.setMerchant(merchant);

	        if (!imageFile.isEmpty()) {
	            product.setImage(imageFile.getBytes());
	        }

	        productService.saveProduct(product);
	        List<Product> products = merchant.getProducts();
	        model.addAttribute("products", products);
	        model.addAttribute("success", "Product saved successfully!");

	        return "MerchantproductView";

	    } catch (Exception e) {
	        model.addAttribute("error", "Error saving product: " + e.getMessage());
	        return "MerchantproductView";
	    }
	}

	
	@GetMapping("/products")
	public String getProductsByCategory(
	      @RequestParam(name = "category", required = false) String category,
	      HttpSession session,
	      Model model) {
	    User sessionUser = (User) session.getAttribute("user");
	    if (sessionUser != null) {
	        User currentUser = userService.findById(sessionUser.getId());
	        session.setAttribute("user", currentUser);
	    }
	    List<String> categories = productService.getAllCategories();
	    model.addAttribute("categories", categories);
	    Map<String, Long> categoryProductsCount = productService.getCategoryProductCounts();
	    model.addAttribute("categoryProductsCount", categoryProductsCount);
	    List<Product> products;
	    if (category != null && !category.isEmpty()) {
	        products = productService.getProductsByCategory(category);
	        model.addAttribute("selectedCategory", category);
	    } else {
	        products = productService.getAllProducts();
	    }
	    model.addAttribute("products", products);
	    
	    return "ProductsByCategory";
	}
	
	
}
