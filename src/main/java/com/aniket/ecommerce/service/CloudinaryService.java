package com.aniket.ecommerce.service;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.Map;
import java.util.UUID;

@Service
public class CloudinaryService {

    @Autowired
    private Cloudinary cloudinary;  // ✅ injected from CloudinaryConfig bean

    /**
     * Upload image bytes → returns secure HTTPS URL to store in product.imagePath
     */
    public String uploadImage(byte[] imageBytes, int productId) throws IOException {
        // ✅ UUID ensures every upload gets a unique name — never overwrites
        String uniqueId = UUID.randomUUID().toString().substring(0, 8);

        Map result = cloudinary.uploader().upload(
            imageBytes,
            ObjectUtils.asMap(
                "public_id",     "ecommerce/products/product_" + productId + "_" + uniqueId,
                "overwrite",     false,   // ✅ changed to false — never replace
                "resource_type", "image"
            )
        );
        return (String) result.get("secure_url");
    }

    /**
     * Delete image from Cloudinary when product is deleted
     */
    public void deleteImage(String imageUrl) throws IOException {
        if (imageUrl == null || imageUrl.isEmpty()) return;

        // URL: https://res.cloudinary.com/cloud/image/upload/v123/ecommerce/products/product_42.jpg
        // Extract → ecommerce/products/product_42
        String afterUpload = imageUrl.substring(imageUrl.indexOf("/upload/") + 8);
        if (afterUpload.matches("v\\d+/.*")) {
            afterUpload = afterUpload.substring(afterUpload.indexOf("/") + 1);
        }
        String publicId = afterUpload.replaceAll("\\.[^.]+$", "");

        cloudinary.uploader().destroy(publicId, ObjectUtils.emptyMap());
    }
}