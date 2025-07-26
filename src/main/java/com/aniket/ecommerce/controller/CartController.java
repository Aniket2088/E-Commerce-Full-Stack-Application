package com.aniket.ecommerce.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.aniket.ecommerce.entity.Product;
import com.aniket.ecommerce.entity.User;
import com.aniket.ecommerce.service.ProductService;
import com.aniket.ecommerce.service.UserService;

@Controller
public class CartController {
	
	@Autowired
	private ProductService productService;
	
	@Autowired
	private UserService userService;
	
	  @GetMapping("/cartView")
	    public String viewCart(HttpSession session, Model model) {
	        User user = (User) session.getAttribute("user");
	        if (user == null) {
	            return "redirect:/userLogin";
	        }

	        List<Product> cartItems = user.getCartItems();
	  
	        model.addAttribute("cartItems",cartItems );

	        return "cartView";
	    }
	  @PostMapping("/addToCart/{productId}")
	    @Transactional
	    public String addToCart(@PathVariable("productId") int productId,
	                          HttpSession session,
	                          RedirectAttributes redirectAttributes) {
	        
	        
	        User user = (User) session.getAttribute("user");
	        if (user == null) {
	            redirectAttributes.addFlashAttribute("message", "Please login to add items to cart");
	            return "redirect:/userLogin";
	        }

	        // Get fresh user from DB
	        User currentUser = userService.findById(user.getId());
	        Product product = productService.findProductById(productId);

	        // Check if product already in cart
	        if (currentUser.getCartItems().stream().noneMatch(p -> p.getId() == productId)) {
	            currentUser.getCartItems().add(product);
	            userService.save(currentUser); // Save the updated user
	            
	            // Update session with the saved user
	            session.setAttribute("user", currentUser);
	            redirectAttributes.addFlashAttribute("success", product.getProductName()+ " added to cart!");
	        } else {
	            redirectAttributes.addFlashAttribute("info", product.getProductName() + " is already in your cart");
	        }

	        return "redirect:/cartView";
	    }

	  

	    @PostMapping("/updateQuantity")
	    @Transactional
	    public String updateQuantity(@RequestParam int productId,
	                               @RequestParam int quantity,
	                               HttpSession session,
	                               RedirectAttributes redirectAttributes) {
	        User sessionUser = (User) session.getAttribute("user");
	        
	        if (sessionUser == null) {
	            return "redirect:/userLogin";
	        }
	        
	        if (quantity < 1) {
	            redirectAttributes.addFlashAttribute("error", "Quantity must be at least 1");
	            return "redirect:/cart/view";
	        }
	        
	        User user = userService.findById(sessionUser.getId());
	        Product product = productService.findProductById(productId);
	        
	        if (product == null) {
	            redirectAttributes.addFlashAttribute("error", "Product not found");
	            return "redirect:/cart/view";
	        }
	        
	        // For quantity management, you might need to adjust your model
	        // Currently your cart stores products, not quantities
	        // This is a placeholder implementation - see alternative approach below
	        redirectAttributes.addFlashAttribute("info", "Quantity updated");
	        
	        return "redirect:/cart/view";
	    }

	    @GetMapping("/removeFromCart/{productId}")
	    @Transactional
	    public String removeFromCart(@PathVariable("productId") int productId,
	                               HttpSession session,
	                               RedirectAttributes redirectAttributes) {
	        User sessionUser = (User) session.getAttribute("user");
	        
	        if (sessionUser == null) {
	            return "redirect:/userLogin";
	        }
	        
	        // Get fresh user from database
	        User user = userService.findById(sessionUser.getId());
	        
	        // Find and remove the product
	        boolean removed = user.getCartItems().removeIf(product -> product.getId() == productId);
	        System.out.println(user);
	        if (removed) {
	            userService.save(user);
	            redirectAttributes.addFlashAttribute("success", "Product removed from cart");
	        } else {
	            redirectAttributes.addFlashAttribute("error", "Product not found in cart");
	        }
	        System.out.println(user);
	        return "redirect:/cartView";
	    }

	    @GetMapping("/clear")
	    @Transactional
	    public String clearCart(HttpSession session, RedirectAttributes redirectAttributes) {
	        User sessionUser = (User) session.getAttribute("user");
	        
	        if (sessionUser == null) {
	            return "redirect:/userLogin";
	        }
	        
	        User user = userService.findById(sessionUser.getId());
	        user.getCartItems().clear();
	        userService.save(user);
	        
	        redirectAttributes.addFlashAttribute("success", "Cart cleared successfully");
	        return "redirect:/cart/view";
	    }

}
