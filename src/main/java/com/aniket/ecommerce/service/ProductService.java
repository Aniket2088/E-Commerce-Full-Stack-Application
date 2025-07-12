package com.aniket.ecommerce.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aniket.ecommerce.dao.ProductDao;
import com.aniket.ecommerce.entity.Product;

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


}
