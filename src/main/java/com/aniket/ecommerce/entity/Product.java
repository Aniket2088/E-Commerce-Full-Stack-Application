package com.aniket.ecommerce.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;

import lombok.Data;
@Entity
@Data
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



}
