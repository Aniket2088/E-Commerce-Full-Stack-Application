package com.aniket.ecommerce.service;
 
import java.util.List;
 
import org.springframework.stereotype.Service;
 
import com.aniket.ecommerce.dao.OrderDao;
import com.aniket.ecommerce.entity.Order;
import com.aniket.ecommerce.entity.User;
 
@Service
public class OrderService {
 
    // ✅ Plain DAO — same pattern as your existing services
    private OrderDao orderDao = new OrderDao();
 
    /** Save a new order (CascadeType.ALL on orderItems saves them too) */
    public Order save(Order order) {
        return orderDao.save(order);
    }
 
    /** Get all orders for a user, newest first */
    public List<Order> findByUser(User user) {
        return orderDao.findByUser(user);
    }
 
    /** Get a single order by its ID */
    public Order findById(int id) {
        return orderDao.findById(id);
    }
}
 