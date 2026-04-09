package com.aniket.ecommerce.controller;

import com.aniket.ecommerce.entity.CartItem;
import com.aniket.ecommerce.entity.Order;
import com.aniket.ecommerce.entity.OrderItem;
import com.aniket.ecommerce.entity.Product;
import com.aniket.ecommerce.entity.User;
import com.aniket.ecommerce.service.CartItemService;
import com.aniket.ecommerce.service.OrderService;
import com.aniket.ecommerce.service.ProductService;
import com.aniket.ecommerce.service.UserService;
import com.razorpay.RazorpayClient;
import com.razorpay.RazorpayException;
import com.razorpay.Utils;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Controller
public class PaymentController {

    @Autowired
    private ProductService productService;

    @Autowired
    private UserService userService;

    @Autowired
    private CartItemService cartItemService;

    @Autowired
    private OrderService orderService;

    private String razorpayKeyId = "rzp_test_AOkSkGp6YQkF2n";
    private String razorpayKeySecret = "SiFDmZWAJ0V8Ir3iQF1Bbjah";

    // ─────────────────────────────────────────────────────────────
    // CREATE RAZORPAY ORDER
    // ─────────────────────────────────────────────────────────────
    @PostMapping("/createOrder")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> createOrder(@RequestBody Map<String, Object> requestData,
                                                           HttpSession session) {
        Map<String, Object> response = new HashMap<>();

        try {
            RazorpayClient razorpay = new RazorpayClient(razorpayKeyId, razorpayKeySecret);

            double amount = Double.parseDouble(requestData.get("amount").toString());
            String currency = requestData.get("currency").toString();

            JSONObject orderRequest = new JSONObject();
            orderRequest.put("amount", amount); // frontend already converts to paise
            orderRequest.put("currency", currency);
            orderRequest.put("receipt", "order_rcptid_" + System.currentTimeMillis());
            orderRequest.put("payment_capture", 1);

            com.razorpay.Order order = razorpay.orders.create(orderRequest);

            response.put("id", order.get("id"));
            response.put("amount", order.get("amount"));
            response.put("currency", order.get("currency"));
            response.put("status", "created");

            return ResponseEntity.ok(response);

        } catch (RazorpayException e) {
            response.put("error", e.getMessage());
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        } catch (Exception e) {
            response.put("error", "Internal server error: " + e.getMessage());
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }

    // ─────────────────────────────────────────────────────────────
    // VERIFY RAZORPAY SIGNATURE
    // ─────────────────────────────────────────────────────────────
    @PostMapping("/verifyPayment")
    @ResponseBody
    public ResponseEntity<Map<String, String>> verifyPayment(@RequestBody Map<String, String> requestData) {
        Map<String, String> response = new HashMap<>();

        try {
            String orderId  = requestData.get("razorpay_order_id");
            String paymentId = requestData.get("razorpay_payment_id");
            String signature = requestData.get("razorpay_signature");

            boolean isValid = Utils.verifySignature(orderId + "|" + paymentId, signature, razorpayKeySecret);

            if (isValid) {
                response.put("status", "success");
                response.put("message", "Payment verified successfully");
                return ResponseEntity.ok(response);
            } else {
                response.put("status", "error");
                response.put("message", "Payment verification failed");
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
            }

        } catch (RazorpayException e) {
            response.put("status", "error");
            response.put("message", e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        } catch (Exception e) {
            response.put("status", "error");
            response.put("message", "Internal server error");
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }

    // ─────────────────────────────────────────────────────────────
    // PROCESS PAYMENT
    //  1. Build Order + OrderItems from the user's CartItems
    //  2. Reduce merchant stockQuantity
    //  3. Remove purchased CartItems
    // ─────────────────────────────────────────────────────────────
    @PostMapping("/processPayment")
    public String processPayment(@RequestParam("addressId") int addressId,
                                 @RequestParam("paymentMethod") String paymentMethod,
                                 @RequestParam("paymentId") String paymentId,
                                 @RequestParam("productIds") List<Integer> productIds,
                                 HttpSession session) {

        User sessionUser = (User) session.getAttribute("user");
        if (sessionUser == null) {
            return "redirect:/userLogin";
        }

        try {
            User currentUser = userService.findById(sessionUser.getId());

            // ── Step 1: Build the Order header ──
            Order order = new Order();
            order.setUser(currentUser);
            order.setOrderDate(LocalDateTime.now());
            order.setPaymentStatus("PAID");

            List<OrderItem> orderItems = new ArrayList<>();

            // ── Step 2: For each purchased productId → create an OrderItem ──
            for (Integer productId : productIds) {
                Product product = productService.findProductById(productId);
                if (product == null) continue;

                // Get the quantity the user had in their cart for this product
                Optional<CartItem> cartItemOpt = cartItemService.findByUserAndProduct(currentUser, product);
                int qty = cartItemOpt.map(CartItem::getQuantity).orElse(1);

                // Snapshot price at time of purchase
                OrderItem orderItem = new OrderItem();
                orderItem.setOrder(order);
                orderItem.setProduct(product);
                orderItem.setQuantity(qty);
                orderItem.setPriceAtTime(product.getProductPrice());
                orderItems.add(orderItem);

                // ── Step 3: Reduce merchant stock ──
                int newStock = product.getStockQuantity() - qty;
                product.setStockQuantity(Math.max(newStock, 0));
                productService.saveProduct(product);
            }

            order.setOrderItems(orderItems);
            orderService.save(order); // CascadeType.ALL saves OrderItems too

            // ── Step 4: Remove purchased items from cart ──
            for (Integer productId : productIds) {
                Product product = productService.findProductById(productId);
                if (product != null) {
                    cartItemService.findByUserAndProduct(currentUser, product)
                            .ifPresent(cartItemService::delete);
                }
            }

            // Refresh session
            session.setAttribute("user", userService.findById(currentUser.getId()));

            return "redirect:/orderConfirmation?success=true";

        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/orderConfirmation?success=false";
        }
    }

    // ─────────────────────────────────────────────────────────────
    // ORDER CONFIRMATION PAGE
    // ─────────────────────────────────────────────────────────────
    @GetMapping("/orderConfirmation")
    public String orderConfirmation(@RequestParam(value = "success", required = false) Boolean success,
                                    HttpSession session,
                                    Model model) {

        User sessionUser = (User) session.getAttribute("user");
        if (sessionUser == null) {
            return "redirect:/userLogin";
        }

        // Refresh session user after cart was cleared
        session.setAttribute("user", userService.findById(sessionUser.getId()));

        if (success != null && success) {
            model.addAttribute("message", "Your order has been placed successfully!");
            model.addAttribute("isSuccess", true);
        } else {
            model.addAttribute("message", "There was an error processing your order. Please try again.");
            model.addAttribute("isSuccess", false);
        }

        return "orderConfirmation";
    }
}