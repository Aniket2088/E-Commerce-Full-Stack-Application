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
        session.setAttribute("cartItems", cartItems);

        return "cartView";
    }
    
    @PostMapping("/addToCart/{productId}")
    @Transactional
    public String addToCart(@PathVariable("productId") int productId,
                            HttpSession session,
                            RedirectAttributes redirectAttributes) {

        User sessionUser = (User) session.getAttribute("user");
        if (sessionUser == null) {
            redirectAttributes.addFlashAttribute("message", "Please login to add items to cart");
            return "redirect:/userLogin";
        }

        // Get fresh user from DB
        User currentUser = userService.findById(sessionUser.getId());
        Product product = productService.findProductById(productId);

        // 1️⃣ Always update quantity map
        Map<Integer, Integer> qtyMap = currentUser.getCartQuantities();
        qtyMap.put(productId, qtyMap.getOrDefault(productId, 0) + 1);

        // 2️⃣ Add product to cart list ONLY once
        boolean alreadyInCart = currentUser.getCartItems()
                .stream()
                .anyMatch(p -> p.getId() == productId);

        if (!alreadyInCart) {
            currentUser.getCartItems().add(product);
        }

        userService.save(currentUser);

        // Update session
        session.setAttribute("user", currentUser);

        redirectAttributes.addFlashAttribute(
                "success",
                product.getProductName() + " added to cart!"
        );

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
        List<Product> cartItems = user.getCartItems();

        if (product == null) {
            redirectAttributes.addFlashAttribute("error", "Product not found");
            return "redirect:/cartView";
        }

        // ================= EXISTING LOGIC (UNCHANGED) =================
        user.getCartItems().removeIf(p -> p.getId() == productId);

        int count = 0;
        for (int i = 0; i < quantity; i++) {
            user.getCartItems().add(product);
            count++;
        }

              // ===============================================================

        // ===================== 🔥 ADDED PART 🔥 ========================
        // Store quantity in DB-safe map (productId -> quantity)
        user.getCartQuantities().put(productId, quantity);
        // ===============================================================
        System.out.println(user.getCartQuantities());
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