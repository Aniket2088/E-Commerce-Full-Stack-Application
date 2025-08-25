package com.aniket.ecommerce.entity;

import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import lombok.Data;

@Data
@Entity
@Table(name = "merchant")
public class Merchant {
	
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	private String name;
	private String email;
	private long phone;
	private String password;

    private String accountNumber;
    private String bankName;
    private String ifscCode;
	
	@OneToMany(mappedBy = "merchant")
	private List<Product> products;

	@Override
	public String toString() {
	    return "Merchant{" +
	            "id=" + id +
	            ", name='" + name + '\'' +
	            // Don't include products here to avoid circular reference
	            '}';
	}

	

}
