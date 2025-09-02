package com.aniket.ecommerce.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.aniket.ecommerce.entity.Address;
import com.aniket.ecommerce.entity.User;
import com.aniket.ecommerce.service.AddressService;
import com.aniket.ecommerce.service.UserService;

@Controller
public class AddressController {
    
    @Autowired
    private AddressService addressService;
    
    @Autowired
    private UserService userService;
    
    @GetMapping(path="/addressPage")
    protected String addressPage(Model model, HttpSession session)
    {
        // Get current user from session
        User user = getCurrentUser(session);
        if (user == null) {
            return "UserLogin";
        }
        
        // EAGERLY load addresses for the user
        List<Address> userAddresses = addressService.getAddressesByUserId(user.getId());
        
        // Debug: print addresses to console
        System.out.println("Number of addresses found: " + userAddresses.size());
        for (Address addr : userAddresses) {
            System.out.println("Address: " + addr.getId() + " - " + addr.getCity());
        }
        
        if (!userAddresses.isEmpty()) {
            model.addAttribute("address", userAddresses.get(0)); // first record
        } else {
            model.addAttribute("address", new Address());
        }

        model.addAttribute("savedAddresses", userAddresses);
        return "AddressPage";
    }
    @PostMapping(path="/saveAddress")
    protected String saveAddress(@ModelAttribute Address address,
                                @RequestParam(name = "isDefault", required = false) String isDefaultParam,
                                @RequestParam(name = "_isDefault", required = false) String hiddenIsDefaultParam,
                                HttpSession session,
                                Model model)
    {
        try {
            // Get current user from session
            User user = getCurrentUser(session);
            if (user == null) {
                return "UserLogin";
            }
            
            // Set user for the address
            address.setUser(user);
            
            // Handle checkbox - if checkbox is checked, isDefaultParam will be "true"
            // If unchecked, hiddenIsDefaultParam will be "false" and isDefaultParam will be null
            boolean isDefault = "true".equals(isDefaultParam);
            address.setDefault(isDefault);
            
            System.out.println("Checkbox value: " + isDefaultParam);
            System.out.println("Hidden field value: " + hiddenIsDefaultParam);
            System.out.println("Final isDefault: " + isDefault);
            
            // If this is set as default, unset any existing default addresses
            if (isDefault) {
                addressService.unsetDefaultAddresses(user);
            }
            
            // Save the address
            Address savedAddress = addressService.saveAddress(address);
            System.out.println("Saved address with isDefault: " + savedAddress.isDefault());
            
            // Refresh user object in session to include the new address
            User updatedUser = userService.findById(user.getId());
            session.setAttribute("user", updatedUser);
            
            return "redirect:/paymentPage";
            
        } catch (Exception e) {
            System.out.println("Error saving address: " + e.getMessage());
            e.printStackTrace();
            model.addAttribute("error", "Error saving address: " + e.getMessage());
            
            // Reload addresses for the error case
            User user = getCurrentUser(session);
            if (user != null) {
                List<Address> userAddresses = addressService.getAddressesByUserId(user.getId());
                model.addAttribute("savedAddresses", userAddresses);
            }
            
            return "AddressPage";
        }
    }
    
    // Helper method to get current user from session
    private User getCurrentUser(HttpSession session) {
        return (User) session.getAttribute("user");
    }
}