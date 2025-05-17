package com.aniket.ecommerce.service;

import org.springframework.stereotype.Service;

import com.aniket.ecommerce.dao.MerchantDao;
import com.aniket.ecommerce.entity.Merchant;

@Service
public class MerchantService {
	
	MerchantDao dao = new MerchantDao();

	public Merchant saveMerchant(Merchant merchant) {
		
		Merchant saveMerchant = dao.saveMerchant(merchant);
		
		if(saveMerchant!=null)
			return saveMerchant;
		return null;
	}

	public Object findByEmail(String email) {
		// TODO Auto-generated method stub
		dao.findByEmail(email);
		return null;
	}

	public Merchant authenticate(String email, String password) {
		Merchant merchant = dao.authenticate(email,password);
		if(merchant!=null)
			return merchant;
					
		return null;
	}

	public Merchant findMerchantById(int merchantId) {
		// TODO Auto-generated method stub
		
		Merchant merchant = dao.findMerchantById(merchantId);
		if(merchant!=null)
			return merchant;
		return null;
	}

}
