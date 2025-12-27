package com.aniket.ecommerce.controller;

import com.aniket.ecommerce.entity.Product;
import com.aniket.ecommerce.entity.User;
import com.aniket.ecommerce.service.ProductService;
import com.razorpay.Order;
import com.razorpay.RazorpayClient;
import com.razorpay.RazorpayException;
import com.razorpay.Utils;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class PaymentController {
	
	@Autowired
	private ProductService productService;

    private String razorpayKeyId = "rzp_test_AOkSkGp6YQkF2n";
    private String razorpayKeySecret = "SiFDmZWAJ0V8Ir3iQF1Bbjah";

    // Create order for Razorpay - Updated to be more flexible
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
            orderRequest.put("amount", amount); // REMOVED * 100 - frontend already converts to paise
            orderRequest.put("currency", currency);
            orderRequest.put("receipt", "order_rcptid_" + System.currentTimeMillis());
            orderRequest.put("payment_capture", 1);

            Order order = razorpay.orders.create(orderRequest);
            
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
            response.put("error", "Internal server error: " + e.getMessage()); // Added error details
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }

    // Verify payment signature - Updated to be more flexible
    @PostMapping("/verifyPayment")
    @ResponseBody
    public ResponseEntity<Map<String, String>> verifyPayment(@RequestBody Map<String, String> requestData) {
        Map<String, String> response = new HashMap<>();
        
        try {
            String orderId = requestData.get("razorpay_order_id");
            String paymentId = requestData.get("razorpay_payment_id");
            String signature = requestData.get("razorpay_signature");

            // Create verification data
            String verificationData = orderId + "|" + paymentId;
            
            boolean isValidSignature = Utils.verifySignature(verificationData, signature, razorpayKeySecret);
            
            if (isValidSignature) {
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
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        } catch (Exception e) {
            response.put("status", "error");
            response.put("message", "Internal server error");
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }

    @PostMapping("/processPayment")
    public String processPayment(@RequestParam("addressId") int addressId,
                               @RequestParam("paymentMethod") String paymentMethod,
                               @RequestParam("paymentId") String paymentId,
                               @RequestParam("productIds") List<Integer> productIds,
                               HttpSession session) {
        
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/userLogin";
        }
        
        try {
            // Get the current user's cart items
            List<Product> cartItems = user.getCartItems();
            List<Product> productsToRemove = new ArrayList<>();
            
            // Update payment status, set user, and identify products to remove from cart
            for (Integer productId : productIds) {
                Product product = productService.findProductById(productId);
                if (product != null) {
                    product.setPaymentStatus(true);
                    product.setUser(user);
                    productService.saveProduct(product);
                    System.out.println(product);
                    
                    // Find and mark the product for removal from cart
                    cartItems.stream()
                        .filter(cartProduct -> cartProduct.getId() == productId)
                        .findFirst()
                        .ifPresent(productsToRemove::add);
                }
            }
            
            // Remove the purchased products from cart
            cartItems.removeAll(productsToRemove);
            
            // Update user in database (if you have userService)
            // userService.saveUser(user);
           
            // Clear the cart from session and update with new cart
            session.setAttribute("cartItems", cartItems);
            
            // Redirect to confirmation page with success status
            return "redirect:/orderConfirmation?success=true";
        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/orderConfirmation?success=false";
        }
    }
    // Add this method for order confirmation page
    @GetMapping("/orderConfirmation")
    public String orderConfirmation(@RequestParam(value = "success", required = false) Boolean success,
                                  HttpSession session,
                                  Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/userLogin";
        }

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