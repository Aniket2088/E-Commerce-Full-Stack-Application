package com.aniket.ecommerce.service;
 
import java.util.List;
import java.util.Optional;
 
import org.springframework.stereotype.Service;
 
import com.aniket.ecommerce.dao.CartItemDao;
import com.aniket.ecommerce.entity.CartItem;
import com.aniket.ecommerce.entity.Product;
import com.aniket.ecommerce.entity.User;
 
@Service
public class CartItemService {
 
    // ✅ Plain DAO — no @Autowired needed, instantiate directly like your other services
    private CartItemDao cartItemDao = new CartItemDao();
 
    /** All cart items for a user */
    public List<CartItem> findByUser(User user) {
        return cartItemDao.findByUser(user);
    }
 
    /** One item matching user + product (Optional — empty if not in cart yet) */
    public Optional<CartItem> findByUserAndProduct(User user, Product product) {
        return cartItemDao.findByUserAndProduct(user, product);
    }
 
    /** Insert or update a cart item */
    public CartItem save(CartItem cartItem) {
        return cartItemDao.save(cartItem);
    }
 
    /** Remove a single item from the cart */
    public void delete(CartItem cartItem) {
        cartItemDao.delete(cartItem);
    }
 
    /** Remove all items from a user's cart (used after checkout or on clear) */
    public void deleteAllByUser(User user) {
        cartItemDao.deleteAllByUser(user);
    }
}