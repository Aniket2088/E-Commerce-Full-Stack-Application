package com.aniket.ecommerce.service;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.aniket.ecommerce.dao.ProductDao;
import com.aniket.ecommerce.entity.Merchant;
import com.aniket.ecommerce.entity.Product;

@Service
public class ProductService {

    ProductDao productDao = new ProductDao();

    @Autowired
    private CloudinaryService cloudinaryService;  // ✅ injected — no static util needed

    public Product saveProduct(Product product, MultipartFile imageFile) {
        try {
            // Step 1: Save and get managed entity with real ID
            Product saved = productDao.saveProduct(product);
            if (saved == null) return null;

            System.out.println("✅ Saved product ID = " + saved.getId()); // check this in console

            // Step 2: Upload and update same row
            if (imageFile != null && !imageFile.isEmpty()) {
                String imageUrl = cloudinaryService.uploadImage(
                    imageFile.getBytes(),
                    saved.getId()
                );
                System.out.println("✅ Cloudinary URL = " + imageUrl); // check this too

                // ✅ Direct JPQL update — guaranteed to update correct row
                productDao.updateImagePath(saved.getId(), imageUrl);
                saved.setImagePath(imageUrl);
            }

            return saved;

        } catch (Exception e) {
            throw new RuntimeException("Failed to save product: " + e.getMessage(), e);
        }
    }

    // ✅ Overload — for saves with no image
    public Product saveProduct(Product product) {
        return saveProduct(product, null);
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
            categoryCounts.put(category, productDao.countByCategory(category));
        }
        return categoryCounts;
    }

    public List<Product> getAllProducts() {
        List<Product> products = productDao.getAllProducts();
        return products != null ? products : Collections.emptyList();
    }
}