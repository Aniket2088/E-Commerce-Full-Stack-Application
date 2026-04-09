package com.aniket.ecommerce.controller;
 
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
 
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
 
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
 
import com.aniket.ecommerce.entity.Address;
import com.aniket.ecommerce.entity.CartItem;
import com.aniket.ecommerce.entity.Product;
import com.aniket.ecommerce.entity.User;
import com.aniket.ecommerce.service.AddressService;
import com.aniket.ecommerce.service.CartItemService;
import com.aniket.ecommerce.service.ProductService;
import com.aniket.ecommerce.service.UserService;
 
@Controller
public class UserController {
 
    @Autowired
    private ProductService productService;
 
    @Autowired
    private UserService userService;
 
    @Autowired
    private AddressService addressService;
 
    @Autowired
    private CartItemService cartItemService;
 
    // ─────────────────────────────────────────────────────────────
    // HOME PAGE
    // ─────────────────────────────────────────────────────────────
    @GetMapping(path = "/homePage")
    protected String homePage(Model model) {
        List<Product> allProducts = productService.finAllProduct();
 
        Map<String, Long> categoryCounts = allProducts.stream()
                .collect(Collectors.groupingBy(Product::getCategory, Collectors.counting()));
 
        model.addAttribute("categories", categoryCounts.keySet());
        model.addAttribute("categoryProductsCount", categoryCounts);
 
        model.addAttribute("featuredProducts", allProducts.stream().limit(8).collect(Collectors.toList()));
        model.addAttribute("latestProducts",   allProducts.stream().limit(8).collect(Collectors.toList()));
 
        Map<String, List<Product>> productsByCategory = new HashMap<>();
        for (String category : categoryCounts.keySet()) {
            productsByCategory.put(category, allProducts.stream()
                    .filter(p -> p.getCategory().equals(category))
                    .limit(6)
                    .collect(Collectors.toList()));
        }
        model.addAttribute("productsByCategory", productsByCategory);
 
        return "HomePage";
    }
 
    // ─────────────────────────────────────────────────────────────
    // PAYMENT PAGE
    // ─────────────────────────────────────────────────────────────
    @GetMapping("/paymentPage")
    public String paymentPage(HttpSession session, Model model) {
        User sessionUser = (User) session.getAttribute("user");
        if (sessionUser == null) {
            return "redirect:/userLogin";
        }
 
        User currentUser = userService.findById(sessionUser.getId());
 
        // ✅ CartItems with quantity from cart_item table
        List<CartItem> cartItems = cartItemService.findByUser(currentUser);
        List<Address> savedAddresses = addressService.getAddressesByUserId(currentUser.getId());
 
        double cartTotal = cartItems.stream()
                .mapToDouble(item -> item.getProduct().getProductPrice() * item.getQuantity())
                .sum();
 
        model.addAttribute("savedAddresses", savedAddresses);
        model.addAttribute("cartItems", cartItems);
        model.addAttribute("cartTotal", cartTotal);
 
        return "PaymentPage";
    }
 
    // ─────────────────────────────────────────────────────────────
    // AUTH
    // ─────────────────────────────────────────────────────────────
    @GetMapping(path = "/userLogin")
    protected String userLogin() { return "UserLogin"; }
 
    @GetMapping(path = "/userSignUp")
    protected String userSignUp() { return "UserSignUp"; }
 
    @PostMapping(path = "/signUpUser")
    protected String signUpUser(@RequestParam("firstName") String firstName,
                                @RequestParam("lastName") String lastName,
                                @RequestParam("email") String email,
                                @RequestParam("password") String password,
                                ModelMap map) {
        User user = userService.signUpUser(firstName, lastName, email, password);
        map.addAttribute("message", user != null ? "SignUp successfully" : "Invalid Credentials");
        return "UserLogin";
    }
 
    @PostMapping(path = "/loginUser")
    protected String loginUser(@RequestParam("email") String email,
                               @RequestParam("password") String password,
                               ModelMap map,
                               HttpSession session) {
 
        User user = userService.loginUser(email, password);
        if (user != null) {
            map.addAttribute("message", "Sign In Successfully");
            session.setAttribute("user", user);
        } else {
            map.addAttribute("message", "Invalid Credentials");
        }
 
        return buildHomeModel(map);
    }
 
    @GetMapping("/logout")
    public String logoutUser(HttpSession session, HttpServletResponse response, ModelMap map) {
        session.invalidate();
        Cookie cookie = new Cookie("JSESSIONID", null);
        cookie.setPath("/");
        cookie.setMaxAge(0);
        response.addCookie(cookie);
        return buildHomeModel(map);
    }
 
    // ── shared helper: populates homepage model and returns view name ──
    private String buildHomeModel(ModelMap map) {
        List<Product> allProducts = productService.finAllProduct();
 
        Map<String, Long> categoryCounts = allProducts.stream()
                .collect(Collectors.groupingBy(Product::getCategory, Collectors.counting()));
 
        map.addAttribute("categories", categoryCounts.keySet());
        map.addAttribute("categoryProductsCount", categoryCounts);
        map.addAttribute("featuredProducts", allProducts.stream().limit(8).collect(Collectors.toList()));
        map.addAttribute("latestProducts",   allProducts.stream().limit(8).collect(Collectors.toList()));
 
        Map<String, List<Product>> productsByCategory = new HashMap<>();
        for (String cat : categoryCounts.keySet()) {
            productsByCategory.put(cat, allProducts.stream()
                    .filter(p -> p.getCategory().equals(cat))
                    .limit(6).collect(Collectors.toList()));
        }
        map.addAttribute("productsByCategory", productsByCategory);
        return "HomePage";
    }
}