package com.aniket.ecommerce.service;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aniket.ecommerce.dao.ProductDao;
import com.aniket.ecommerce.entity.Merchant;
import com.aniket.ecommerce.entity.Product;
import com.aniket.ecommerce.entity.User;

@Service
public class ProductService {

	
	 ProductDao productDao=new ProductDao();
	
	public Product saveProduct(Product product) {
		// TODO Auto-generated method stub
		Product product2 = productDao.saveProduct(product);
		
		if(product2!=null)
			return product2;
		
		return null;
		
		
	}

	public List<Product> finAllProduct() {
		// TODO Auto-generated method stub
		List<Product> products = productDao.findAllProduct();
		
		if(products!=null)
			return products;
		return  null;
		
	}

	public List<Product> getProductsByMerchantId(int merchantId) {
	    return productDao.getProductsByMerchantId(merchantId);
	}

	public Product findProductById(Integer productId) {
		// TODO Auto-generated method stub
		
		return productDao.findProductById(productId) ;
	}

	public Product findByProductNameAndMerchant(String productName, Merchant merchant) {
		// TODO Auto-generated method stub
		return productDao.findByProductNameAndMerchant(productName,merchant);
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
			return products;
		}

		public List<Product> findByPaymentStatusTrue(User user) {
			 List<Product> products = productDao.findByPaymentStatusTrue(user);
		        return products != null ? products : Collections.emptyList();
		}

}
