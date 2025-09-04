package com.aniket.ecommerce.controller;

import com.aniket.ecommerce.entity.User;
import com.razorpay.Order;
import com.razorpay.RazorpayClient;
import com.razorpay.RazorpayException;
import com.razorpay.Utils;

import org.json.JSONObject;
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
import java.util.HashMap;
import java.util.Map;

@Controller
public class PaymentController {

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
    public String processPayment(@RequestParam("addressId") String addressId,
                               @RequestParam("paymentMethod") String paymentMethod,
                               @RequestParam("paymentId") String paymentId,
                               HttpSession session) {
        try {
            User user = (User) session.getAttribute("user");
            if (user == null) {
                return "redirect:/userLogin";
            }

            // Your order processing logic here
            System.out.println("Processing order for user: " + user.getName());
            System.out.println("Address ID: " + addressId);
            System.out.println("Payment Method: " + paymentMethod);
            System.out.println("Payment ID: " + paymentId);

            // Clear cart, create order, etc.
            // orderService.createOrder(user, addressId, paymentMethod, paymentId);

            return "redirect:/orderConfirmation?success=true";

        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/paymentPage?error=Payment+processing+failed";
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

        return "orderConfirmation"; // This should match your JSP file name
    }
}