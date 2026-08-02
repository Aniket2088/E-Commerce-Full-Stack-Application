package com.aniket.ecommerce.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.aniket.ecommerce.entity.Merchant;
import com.aniket.ecommerce.entity.Order;
import com.aniket.ecommerce.entity.Product;
import com.aniket.ecommerce.entity.User;
import com.aniket.ecommerce.service.MerchantService;
import com.aniket.ecommerce.service.OrderService;
import com.aniket.ecommerce.service.ProductService;
import com.aniket.ecommerce.service.UserService;

@Controller
public class ProductController {

    @Autowired private ProductService  productService;
    @Autowired private MerchantService merchantService;
    @Autowired private UserService     userService;
    @Autowired private OrderService    orderService;

    // Folder relative to webapp root — Tomcat serves it at:
    // http://localhost:8090/ecommerce/uploads/products/<filename>
    private static final String UPLOAD_DIR = "uploads" + File.separator + "products";

    // ─────────────────────────────────────────────────────────────
    // ADD PRODUCT PAGE
    // ─────────────────────────────────────────────────────────────
    @GetMapping(path = "/AddProduct")
    protected String AddProduct() {
        return "AddProduct";
    }

    // ─────────────────────────────────────────────────────────────
    // ORDER HISTORY
    // ─────────────────────────────────────────────────────────────
    @GetMapping("/orders")
    public String viewOrders(HttpSession session, Model model) {
        User sessionUser = (User) session.getAttribute("user");
        if (sessionUser == null) return "redirect:/userLogin";
        User currentUser = userService.findById(sessionUser.getId());
        List<Order> orders = orderService.findByUser(currentUser);
        model.addAttribute("orders", orders);
        return "orders";
    }

    // ─────────────────────────────────────────────────────────────
    // SAVE PRODUCT  — writes image to disk, stores only filename
    // ─────────────────────────────────────────────────────────────
    @PostMapping("/saveProduct/{merchantId}")
    public String saveProduct(
            @PathVariable("merchantId")         int           merchantId,
            @RequestParam("productName")        String        productName,
            @RequestParam("productDescription") String        productDescription,
            @RequestParam("productPrice")       double        productPrice,
            @RequestParam("category")           String        category,
            @RequestParam("stockQuantity")      int           stockQuantity,
            @RequestParam("image")              MultipartFile imageFile,
            ModelMap model) {               // ✅ HttpServletRequest removed

        try {
            Merchant merchant = merchantService.findMerchantById(merchantId);
            if (merchant == null) throw new RuntimeException("Merchant not found");

            Product product = new Product();
            product.setProductName(productName);
            product.setProductDescription(productDescription);
            product.setProductPrice(productPrice);
            product.setCategory(category);
            product.setStockQuantity(stockQuantity);
            product.setMerchant(merchant);

            // ✅ One line — service handles Cloudinary upload
            productService.saveProduct(product, imageFile);

            model.addAttribute("products", merchantService.findMerchantById(merchantId).getProducts());
            model.addAttribute("success", "Product saved successfully!");
            return "MerchantproductView";

        } catch (Exception e) {
            model.addAttribute("error", "Error saving product: " + e.getMessage());
            return "MerchantproductView";
        }
    }
    // ✅ DELETE the entire saveImageToDisk() method
    // ✅ DELETE the UPLOAD_DIR constant

    // ─────────────────────────────────────────────────────────────
    // PRODUCTS BY CATEGORY
    // ─────────────────────────────────────────────────────────────
    @GetMapping("/products")
    public String getProductsByCategory(
            @RequestParam(name = "category", required = false) String category,
            HttpSession session,
            Model model) {

        User sessionUser = (User) session.getAttribute("user");
        if (sessionUser != null) {
            session.setAttribute("user", userService.findById(sessionUser.getId()));
        }

        model.addAttribute("categories",           productService.getAllCategories());
        model.addAttribute("categoryProductsCount", productService.getCategoryProductCounts());

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

    // ─────────────────────────────────────────────────────────────
    // Writes the uploaded file to webapp/uploads/products/
    // Returns the unique filename to store in product.imagePath
    // ─────────────────────────────────────────────────────────────
    private String saveImageToDisk(MultipartFile file,
                                   HttpServletRequest request) throws IOException {

        String webappRoot  = request.getServletContext().getRealPath("/");
        File   uploadFolder = new File(webappRoot + File.separator + UPLOAD_DIR);

        if (!uploadFolder.exists()) uploadFolder.mkdirs();

        // UUID ensures no filename collision even with same product names
        String original  = file.getOriginalFilename();
        String extension = (original != null && original.contains("."))
                           ? original.substring(original.lastIndexOf(".")) : ".jpg";
        String filename  = UUID.randomUUID().toString() + extension;

        file.transferTo(new File(uploadFolder, filename));
        return filename;  // e.g. "a3f8c1d2-4b5e-...jpg"
    }
}