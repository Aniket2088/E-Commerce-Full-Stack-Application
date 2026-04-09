package com.aniket.ecommerce.service;
 
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
 
import org.springframework.stereotype.Service;
 
import com.aniket.ecommerce.dao.ProductDao;
import com.aniket.ecommerce.entity.Merchant;
import com.aniket.ecommerce.entity.Product;
 
@Service
public class ProductService {
 
    ProductDao productDao = new ProductDao();
 
    public Product saveProduct(Product product) {
        Product saved = productDao.saveProduct(product);
        return saved != null ? saved : null;
    }
 
    public List<Product> finAllProduct() {
        List<Product> products = productDao.findAllProduct();
        return products != null ? products : Collections.emptyList();
    }
 
    public List<Product> getProductsByMerchantId(int merchantId) {
        return productDao.getProductsByMerchantId(merchantId);
    }
 
    public Product findProductById(Integer productId) {
        return productDao.findProductById(productId);
    }
 
    public Product findByProductNameAndMerchant(String productName, Merchant merchant) {
        return productDao.findByProductNameAndMerchant(productName, merchant);
    }
 
    public List<Product> getProductsByCategory(String category) {
        List<Product> products = productDao.findByCategory(category);
        return products != null ? products : Collections.emptyList();
    }
 
    public List<String> getAllCategories() {
        List<String> categories = productDao.findAllDistinctCategories();
        return categories != null ? categories : Collections.emptyList();
    }
 
    public Map<String, Long> getCategoryProductCounts() {
        List<String> categories = getAllCategories();
        Map<String, Long> categoryCounts = new HashMap<>();
        for (String category : categories) {
            Long count = productDao.countByCategory(category);
            categoryCounts.put(category, count);
        }
        return categoryCounts;
    }
 
    public List<Product> getAllProducts() {
        List<Product> products = productDao.getAllProducts();
        return products != null ? products : Collections.emptyList();
    }
 
    // ✅ REMOVED: findByPaymentStatusTrue(User user)
    // Reason: paymentStatus and user FK no longer exist on Product.
    //         Purchase history is now in Order + OrderItem.
    //         Use OrderService.findByUser(user) instead.
}