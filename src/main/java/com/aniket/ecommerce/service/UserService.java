package com.aniket.ecommerce.service;

import org.springframework.stereotype.Service;

import com.aniket.ecommerce.dao.UserDao;
import com.aniket.ecommerce.entity.User;

@Service
public class UserService {

	UserDao userDao = new UserDao();
	public User signUpUser(String firstName, String lastName, String email, String password) {
	User user= userDao.signUpUser(firstName,lastName,email,password);
	
		return user;
	}
	public User loginUser(String email, String password) {
		return userDao.loginUser(email,password);
				
	}

	public void save(User user)
	{
		 userDao.save(user);
	
	}
	public User findById(int id) {
		// TODO Auto-generated method stub
		return userDao.findById(id);
	}
	public void deleteUser(User user) {
		// TODO Auto-generated method stub
		 userDao.deleteUser(user);
		
	}
}
