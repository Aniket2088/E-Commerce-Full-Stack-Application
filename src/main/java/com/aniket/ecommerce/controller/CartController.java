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

        // Get fresh data from database
        User currentUser = userService.findById(user.getId());
        List<Product> cartItems = currentUser.getCartItems();
  
        model.addAttribute("cartItems", cartItems);
        // Update session with latest user data
        session.setAttribute("user", currentUser);

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
            userService.save(currentUser);
            
            // Update session with the saved user
            session.setAttribute("user", currentUser);
            redirectAttributes.addFlashAttribute("success", product.getProductName()+ " added to cart!");
        } else {
            redirectAttributes.addFlashAttribute("info", product.getProductName() + " is already in your cart");
        }

        return "redirect:/cartView";
    }

    @PostMapping("/updateCartQuantity")
    @Transactional
    public String updateCartQuantity(@RequestParam("productId") int productId,
                                   @RequestParam("quantity") int quantity,
                                   HttpSession session,
                                   RedirectAttributes redirectAttributes) {
        User sessionUser = (User) session.getAttribute("user");
        
        if (sessionUser == null) {
            return "redirect:/userLogin";
        }
        
        if (quantity < 1) {
            redirectAttributes.addFlashAttribute("error", "Quantity must be at least 1");
            return "redirect:/cartView";
        }
        
        // Get fresh user from database
        User user = userService.findById(sessionUser.getId());
        Product product = productService.findProductById(productId);
        
        if (product == null) {
            redirectAttributes.addFlashAttribute("error", "Product not found");
            return "redirect:/cartView";
        }
        
        // Since your current model doesn't track quantity per product,
        // we need to implement quantity tracking
        // This is a temporary implementation - you'll need to modify your data model
        // to properly support quantities
        
        // For now, we'll just add/remove the product multiple times
        // First remove all instances of this product
        user.getCartItems().removeIf(p -> p.getId() == productId);
        
        // Then add the product the requested number of times
        for (int i = 0; i < quantity; i++) {
            user.getCartItems().add(product);
        }
        
        userService.save(user);
        session.setAttribute("user", user);
        
        redirectAttributes.addFlashAttribute("success", "Quantity updated successfully");
        return "redirect:/cartView";
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
        
        if (removed) {
            userService.save(user);
            // Update session with the latest user data
            session.setAttribute("user", user);
            redirectAttributes.addFlashAttribute("success", "Product removed from cart");
        } else {
            redirectAttributes.addFlashAttribute("error", "Product not found in cart");
        }
        
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
        
        // Update session with the latest user data
        session.setAttribute("user", user);
        
        redirectAttributes.addFlashAttribute("success", "Cart cleared successfully");
        return "redirect:/cartView";
    }
}