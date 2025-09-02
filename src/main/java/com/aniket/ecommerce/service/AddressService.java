package com.aniket.ecommerce.service;

import com.aniket.ecommerce.dao.AddressDao;
import com.aniket.ecommerce.entity.Address;
import com.aniket.ecommerce.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

import javax.transaction.Transactional;

@Service
@Transactional
public class AddressService {
    
  
     AddressDao addressDao = new AddressDao();
    
    public Address saveAddress(Address address) {
        return addressDao.saveAddress(address);
    }
    
    @Transactional
    public Address getAddressById(int id) {
        return addressDao.getAddressById(id);
    }
    
    @Transactional
    public List<Address> getAddressesByUser(User user) {
        return addressDao.getAddressesByUser(user);
    }
    
    @Transactional
    public List<Address> getAddressesByUserId(int i) {
        return addressDao.getAddressesByUserId(i);
    }
    
    @Transactional
    public Optional<Address> getDefaultAddress(User user) {
        return addressDao.getDefaultAddress(user);
    }
    
    @Transactional
    public Optional<Address> getDefaultAddressByUserId(int userId) {
        // You'll need to create a User object with just the ID or modify the DAO method
        User user = new User();
        user.setId(userId);
        return addressDao.getDefaultAddress(user);
    }
    
    public void unsetDefaultAddresses(User user) {
        addressDao.unsetDefaultAddresses(user);
    }
    
    public void deleteAddress(Long id) {
        addressDao.deleteAddress(id);
    }
    
    public void deleteAddress(Address address) {
        addressDao.deleteAddress(address);
    }
    
    @Transactional
    public long countAddressesByUser(User user) {
        return addressDao.countAddressesByUser(user);
    }
}