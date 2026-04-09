package com.aniket.ecommerce.controller;

import java.util.List;
import java.util.Optional;

import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.aniket.ecommerce.entity.CartItem;
import com.aniket.ecommerce.entity.Product;
import com.aniket.ecommerce.entity.User;
import com.aniket.ecommerce.service.CartItemService;
import com.aniket.ecommerce.service.ProductService;
import com.aniket.ecommerce.service.UserService;

@Controller
public class CartController {

    @Autowired
    private ProductService productService;

    @Autowired
    private UserService userService;

    @Autowired
    private CartItemService cartItemService;

    // ─────────────────────────────────────────────────────────────
    // VIEW CART
    // ─────────────────────────────────────────────────────────────
    @GetMapping("/cartView")
    public String viewCart(HttpSession session, Model model) {
        User sessionUser = (User) session.getAttribute("user");
        if (sessionUser == null) {
            return "redirect:/userLogin";
        }

        User currentUser = userService.findById(sessionUser.getId());
        List<CartItem> cartItems = cartItemService.findByUser(currentUser);

        double total = cartItems.stream()
                .mapToDouble(item -> item.getProduct().getProductPrice() * item.getQuantity())
                .sum();

        model.addAttribute("cartItems", cartItems);
        model.addAttribute("cartTotal", total);

        session.setAttribute("user", currentUser);
        return "cartView";
    }

    // ─────────────────────────────────────────────────────────────
    // ADD TO CART
    // ─────────────────────────────────────────────────────────────
    @PostMapping("/addToCart/{productId}")
    public String addToCart(@PathVariable("productId") int productId,
                            HttpSession session,
                            RedirectAttributes redirectAttributes) {

        User sessionUser = (User) session.getAttribute("user");
        if (sessionUser == null) {
            redirectAttributes.addFlashAttribute("message", "Please login to add items to cart");
            return "redirect:/userLogin";
        }

        User currentUser = userService.findById(sessionUser.getId());
        Product product = productService.findProductById(productId);

        if (product == null) {
            redirectAttributes.addFlashAttribute("error", "Product not found");
            return "redirect:/cartView";
        }

        Optional<CartItem> existing = cartItemService.findByUserAndProduct(currentUser, product);

        if (existing.isPresent()) {
            // Already in cart → increment quantity by 1
            CartItem cartItem = existing.get();
            cartItem.setQuantity(cartItem.getQuantity() + 1);
            cartItemService.save(cartItem);
        } else {
            // Not in cart yet → create new CartItem with qty 1
            CartItem newItem = new CartItem();
            newItem.setUser(currentUser);
            newItem.setProduct(product);
            newItem.setQuantity(1);
            cartItemService.save(newItem);
        }

        session.setAttribute("user", userService.findById(currentUser.getId()));
        redirectAttributes.addFlashAttribute("success", product.getProductName() + " added to cart!");
        return "redirect:/cartView";
    }

    // ─────────────────────────────────────────────────────────────
    // UPDATE QUANTITY
    // ─────────────────────────────────────────────────────────────
    @PostMapping("/updateCartQuantity")
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

        User currentUser = userService.findById(sessionUser.getId());
        Product product = productService.findProductById(productId);

        if (product == null) {
            redirectAttributes.addFlashAttribute("error", "Product not found");
            return "redirect:/cartView";
        }

        Optional<CartItem> existing = cartItemService.findByUserAndProduct(currentUser, product);

        if (existing.isPresent()) {
            CartItem cartItem = existing.get();
            cartItem.setQuantity(quantity);
            cartItemService.save(cartItem);
        } else {
            // Edge case: not in cart yet — create it
            CartItem newItem = new CartItem();
            newItem.setUser(currentUser);
            newItem.setProduct(product);
            newItem.setQuantity(quantity);
            cartItemService.save(newItem);
        }

        session.setAttribute("user", userService.findById(currentUser.getId()));
        redirectAttributes.addFlashAttribute("success", "Quantity updated successfully");
        return "redirect:/cartView";
    }

    // ─────────────────────────────────────────────────────────────
    // REMOVE FROM CART
    // ─────────────────────────────────────────────────────────────
    @GetMapping("/removeFromCart/{productId}")
    public String removeFromCart(@PathVariable("productId") int productId,
                                 HttpSession session,
                                 RedirectAttributes redirectAttributes) {

        User sessionUser = (User) session.getAttribute("user");
        if (sessionUser == null) {
            return "redirect:/userLogin";
        }

        User currentUser = userService.findById(sessionUser.getId());
        Product product = productService.findProductById(productId);

        if (product == null) {
            redirectAttributes.addFlashAttribute("error", "Product not found");
            return "redirect:/cartView";
        }

        Optional<CartItem> existing = cartItemService.findByUserAndProduct(currentUser, product);

        if (existing.isPresent()) {
            cartItemService.delete(existing.get());
            session.setAttribute("user", userService.findById(currentUser.getId()));
            redirectAttributes.addFlashAttribute("success", "Product removed from cart");
        } else {
            redirectAttributes.addFlashAttribute("error", "Product not found in cart");
        }

        return "redirect:/cartView";
    }

    // ─────────────────────────────────────────────────────────────
    // CLEAR ENTIRE CART
    // ─────────────────────────────────────────────────────────────
    @GetMapping("/clear")
    public String clearCart(HttpSession session, RedirectAttributes redirectAttributes) {
        User sessionUser = (User) session.getAttribute("user");
        if (sessionUser == null) {
            return "redirect:/userLogin";
        }

        User currentUser = userService.findById(sessionUser.getId());
        cartItemService.deleteAllByUser(currentUser);

        session.setAttribute("user", userService.findById(currentUser.getId()));
        redirectAttributes.addFlashAttribute("success", "Cart cleared successfully");
        return "redirect:/cartView";
    }
}