<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shipping Address</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .address-card {
            transition: all 0.3s ease;
            border-left: 4px solid #0d6efd;
        }
        .address-card:hover {
            box-shadow: 0 0.5rem 1rem rgba(0,0,0,0.1);
        }
        .saved-address {
            cursor: pointer;
            border: 2px solid #e9ecef;
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 15px;
            transition: all 0.2s ease;
        }
        .saved-address:hover, .saved-address.selected {
            border-color: #0d6efd;
            background-color: #f8f9fa;
        }
        .saved-address.selected {
            border-width: 3px;
        }
        .form-control:focus, .form-select:focus {
            border-color: #86b7fe;
            box-shadow: 0 0 0 0.25rem rgba(13, 110, 253, 0.25);
        }
        .error-message {
            color: #dc3545;
            font-size: 0.875rem;
            margin-top: 0.25rem;
        }
    </style>
</head>
<body class="bg-light">

    <!-- Navigation Bar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="#">
                <i class="fas fa-shopping-bag me-2"></i>ShopEasy
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/products">
                            <i class="fas fa-home me-1"></i> Home
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/cart">
                            <i class="fas fa-shopping-cart me-1"></i> Cart
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">
                            <i class="fas fa-user me-1"></i> Account
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-10">
                <div class="card shadow-sm">
                    <div class="card-header bg-white py-3">
                        <h3 class="mb-0">
                            <i class="fas fa-map-marker-alt me-2 text-primary"></i>Shipping Address
                        </h3>
                        <p class="text-muted mb-0">Please provide your shipping information</p>
                    </div>
                    <div class="card-body">
<!-- Address Form -->
<form id="addressForm" action="${pageContext.request.contextPath}/saveAddress" method="post">
    <h5 class="mb-3 border-bottom pb-2">Add / Edit Address</h5>
    
    <input type="hidden" name="id" value="${address.id}"/>

    <div class="row">
        <div class="col-md-6 mb-3">
            <label for="addressType" class="form-label">Address Type <span class="text-danger">*</span></label>
            <select class="form-select" id="addressType" name="addressType" required>
                <option value="">Select Type</option>
                <option value="Home" ${address.addressType eq 'Home' ? 'selected' : ''}>Home</option>
                <option value="Work" ${address.addressType eq 'Work' ? 'selected' : ''}>Work</option>
                <option value="Other" ${address.addressType eq 'Other' ? 'selected' : ''}>Other</option>
            </select>
        </div>
        
    </div>
    
    <div class="row">
        <div class="col-md-6 mb-3">
            <label for="firstName" class="form-label">First Name <span class="text-danger">*</span></label>
            <input type="text" class="form-control" id="firstName" name="firstName" value="${address.firstName}" required>
        </div>
        <div class="col-md-6 mb-3">
            <label for="lastName" class="form-label">Last Name <span class="text-danger">*</span></label>
            <input type="text" class="form-control" id="lastName" name="lastName" value="${address.lastName}" required>
        </div>
    </div>
    
    <div class="mb-3">
        <label for="email" class="form-label">Email <span class="text-danger">*</span></label>
        <input type="email" class="form-control" id="email" name="email" value="${address.email}" required>
    </div>
    
    <div class="mb-3">
        <label for="phone" class="form-label">Phone Number <span class="text-danger">*</span></label>
        <input type="tel" class="form-control" id="phone" name="phone" value="${address.phone}" required>
    </div>
    
    <div class="mb-3">
        <label for="addressLine1" class="form-label">Address Line 1 <span class="text-danger">*</span></label>
        <input type="text" class="form-control" id="addressLine1" name="addressLine1" value="${address.addressLine1}" required>
    </div>
    
    <div class="mb-3">
        <label for="addressLine2" class="form-label">Address Line 2 (Optional)</label>
        <input type="text" class="form-control" id="addressLine2" name="addressLine2" value="${address.addressLine2}">
    </div>
    
    <div class="row">
        <div class="col-md-6 mb-3">
            <label for="city" class="form-label">City <span class="text-danger">*</span></label>
            <input type="text" class="form-control" id="city" name="city" value="${address.city}" required>
        </div>
        <div class="col-md-6 mb-3">
            <label for="state" class="form-label">State <span class="text-danger">*</span></label>
            <input type="text" class="form-control" id="state" name="state" value="${address.state}" required>
        </div>
    </div>
    
    <div class="row">
        <div class="col-md-6 mb-3">
            <label for="postalCode" class="form-label">Postal Code <span class="text-danger">*</span></label>
            <input type="text" class="form-control" id="postalCode" name="postalCode" value="${address.postalCode}" required>
        </div>
        <div class="col-md-6 mb-3">
            <label for="country" class="form-label">Country <span class="text-danger">*</span></label>
            <select class="form-select" id="country" name="country" required>
                <option value="">Select Country</option>
                <option value="US" ${address.country eq 'US' ? 'selected' : ''}>United States</option>
                <option value="IN" ${address.country eq 'IN' ? 'selected' : ''}>India</option>
                <option value="UK" ${address.country eq 'UK' ? 'selected' : ''}>United Kingdom</option>
                <option value="CA" ${address.country eq 'CA' ? 'selected' : ''}>Canada</option>
                <option value="AU" ${address.country eq 'AU' ? 'selected' : ''}>Australia</option>
                <option value="DE" ${address.country eq 'DE' ? 'selected' : ''}>Germany</option>
                <option value="FR" ${address.country eq 'FR' ? 'selected' : ''}>France</option>
                <option value="JP" ${address.country eq 'JP' ? 'selected' : ''}>Japan</option>
            </select>
        </div>
    </div>
    
    <div class="d-flex justify-content-between">
        <a href="${pageContext.request.contextPath}/cart" class="btn btn-outline-secondary">
            <i class="fas fa-arrow-left me-2"></i>Back to Cart
        </a>
        <button type="submit" class="btn btn-primary">
            Continue to Payment<i class="fas fa-arrow-right ms-2"></i>
        </button>
    </div>
</form>

                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Toggle between saved addresses and new address form
            const toggleAddressForm = document.getElementById('toggleAddressForm');
            const addressForm = document.getElementById('addressForm');
            const savedAddressesSection = document.getElementById('savedAddressesSection');
            
            if (toggleAddressForm && savedAddressesSection) {
                toggleAddressForm.addEventListener('click', function(e) {
                    e.preventDefault();
                    savedAddressesSection.style.display = 'none';
                    addressForm.style.display = 'block';
                });
            }
            
            // Handle saved address selection
            const savedAddresses = document.querySelectorAll('.saved-address');
            savedAddresses.forEach(address => {
                address.addEventListener('click', function() {
                    // Remove selected class from all addresses
                    savedAddresses.forEach(addr => addr.classList.remove('selected'));
                    
                    // Add selected class to clicked address
                    this.classList.add('selected');
                    
                    // Check the radio button
                    const radio = this.querySelector('input[type="radio"]');
                    if (radio) {
                        radio.checked = true;
                    }
                });
            });
            
            // Form validation
            const addressFormElement = document.getElementById('addressForm');
            if (addressFormElement) {
                addressFormElement.addEventListener('submit', function(e) {
                    // Basic validation - you can add more specific validations
                    const requiredFields = addressFormElement.querySelectorAll('[required]');
                    let isValid = true;
                    
                    requiredFields.forEach(field => {
                        if (!field.value.trim()) {
                            isValid = false;
                            field.classList.add('is-invalid');
                        } else {
                            field.classList.remove('is-invalid');
                        }
                    });
                    
                    if (!isValid) {
                        e.preventDefault();
                        alert('Please fill in all required fields.');
                    }
                });
            }
        });
    </script>
</body>
</html>