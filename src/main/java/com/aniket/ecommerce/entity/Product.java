package com.aniket.ecommerce.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import lombok.Data;

@Entity
@Data
@Table(name = "product")
public class Product {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private String productName;
    @Column(columnDefinition = "TEXT")
    private String productDescription;
    private double productPrice;

    @Column(nullable = false)
    private String category;

    @ManyToOne
    @JoinColumn(name = "merchant_id")
    private Merchant merchant;

    @Column(nullable = false)
    private int stockQuantity;

    // ✅ Store only the filename e.g. "product_42_samsung.jpg"
    // The actual file lives in: webapp/uploads/products/
    @Column(name = "image_path")
    private String imagePath;

    // ✅ Convenience method — JSPs use this to check before rendering <img>
    public boolean hasImage() {
        return this.imagePath != null && !this.imagePath.trim().isEmpty();
    }

    // ✅ REMOVED: byte[] image  (was LONGBLOB — slow, bloats DB)
    // ✅ REMOVED: getBase64Image()  (no longer needed)

    @Override
    public String toString() {
        return "Product{" +
                "id=" + id +
                ", productName='" + productName + '\'' +
                ", price=" + productPrice +
                '}';
    }
}