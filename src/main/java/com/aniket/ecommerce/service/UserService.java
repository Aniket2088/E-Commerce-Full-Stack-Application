package com.aniket.ecommerce.service;
 
import org.springframework.stereotype.Service;
 
import com.aniket.ecommerce.dao.UserDao;
import com.aniket.ecommerce.entity.User;
 
@Service
public class UserService {
 
    UserDao userDao = new UserDao();
 
    public User signUpUser(String firstName, String lastName, String email, String password) {
        return userDao.signUpUser(firstName, lastName, email, password);
    }
 
    public User loginUser(String email, String password) {
        return userDao.loginUser(email, password);
    }
 
    public void save(User user) {
        userDao.save(user);
    }
 
    public User findById(int id) {
        return userDao.findById(id);
    }
 
    public void deleteUser(User user) {
        userDao.deleteUser(user);
    }
 
    // ✅ REMOVED: syncCartQuantities(User user)
    // Reason: User no longer has cartItems (List<Product>) or
    //         cartQuantities (Map<Integer,Integer>) fields.
    //         Cart is now managed entirely through CartItem entity.
    //         Quantity lives in CartItem.quantity — no sync needed.
}
 