package com.aniket.ecommerce.entity;

import java.util.Base64;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
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
	private String productDescription;
	private double productPrice;
	@Lob
    @Column(columnDefinition = "LONGBLOB")
    private byte[] image;
	
	@Column(nullable = false)
	private String category;  // e.g., "phones", "tv", etc.
	
	@ManyToOne
	@JoinColumn(name = "merchant_id")
	private Merchant merchant;
	
	@ManyToOne
	@JoinColumn(name = "user_id")
	private User user;
	
	 @Column(name = "payment_status")
	    private Boolean paymentStatus = false; // Default value
    
	 // Add these methods
    public String getBase64Image() {
        if (this.image == null || this.image.length == 0) {
            return "";
        }
        return Base64.getEncoder().encodeToString(this.image);
    }

    public boolean hasImage() {
        return this.image != null && this.image.length > 0;
    }
    
    @Override
    public String toString() {
        return "Product{" +
                "id=" + id +
                ", productName='" + productName + '\'' +
                ", price=" + productPrice +
                // Don't include merchant here to avoid circular reference
                '}';
    }

}
