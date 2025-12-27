<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shipping Address - ShopEase</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #2a3f54;
            --secondary: #e74c3c;
            --accent: #3498db;
            --light: #f8f9fa;
            --dark: #212529;
            --success: #2ecc71;
            --warning: #f39c12;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f8f9fa;
        }
        
        /* Navigation */
        .navbar {
            background-color: white;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
            padding: 1rem 0;
        }
        
        .navbar-brand {
            font-weight: 800;
            font-size: 2rem;
            background: linear-gradient(135deg, var(--primary), var(--accent));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
        
        .nav-link {
            font-weight: 600;
            padding: 0.5rem 1.5rem !important;
            border-radius: 20px;
            transition: all 0.3s ease;
        }
        
        .nav-link:hover, .nav-link.active {
            background-color: rgba(42, 63, 84, 0.1);
            color: var(--primary) !important;
        }
        
        /* Page Header */
        .page-header {
            background: linear-gradient(135deg, rgba(42, 63, 84, 0.9), rgba(52, 152, 219, 0.9));
            color: white;
            padding: 3rem 0;
            margin-bottom: 2rem;
            position: relative;
            overflow: hidden;
        }
        
        .page-header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: radial-gradient(circle at 70% 50%, rgba(231, 76, 60, 0.2) 0%, transparent 50%);
        }
        
        .page-title {
            font-size: 2.5rem;
            font-weight: 800;
            margin-bottom: 0.5rem;
        }
        
        /* Address Card */
        .address-card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
            overflow: hidden;
            transition: all 0.3s ease;
            background: white;
        }
        
        .address-header {
            background: linear-gradient(135deg, var(--primary), var(--accent));
            color: white;
            padding: 1.5rem;
            border-bottom: none;
        }
        
        .address-header h3 {
            margin: 0;
            font-weight: 700;
            font-size: 1.5rem;
        }
        
        /* Form Styling */
        .address-form {
            padding: 2rem;
        }
        
        .form-label {
            font-weight: 600;
            color: var(--primary);
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .required {
            color: var(--secondary);
        }
        
        .form-control, .form-select {
            padding: 0.875rem 1rem;
            border: 2px solid #e1e5e9;
            border-radius: 8px;
            font-size: 0.95rem;
            transition: all 0.3s ease;
            background-color: #f8f9fa;
        }
        
        .form-control:focus, .form-select:focus {
            border-color: var(--accent);
            box-shadow: 0 0 0 0.25rem rgba(52, 152, 219, 0.15);
            background-color: white;
        }
        
        .form-section-title {
            font-size: 1.2rem;
            font-weight: 600;
            color: var(--primary);
            padding-bottom: 0.5rem;
            border-bottom: 2px solid rgba(42, 63, 84, 0.1);
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        /* Buttons */
        .btn-back {
            background: rgba(42, 63, 84, 0.1);
            color: var(--primary);
            border: 2px solid rgba(42, 63, 84, 0.2);
            padding: 0.875rem 2rem;
            border-radius: 10px;
            font-weight: 600;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.3s ease;
        }
        
        .btn-back:hover {
            background: var(--primary);
            color: white;
            border-color: var(--primary);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(42, 63, 84, 0.2);
        }
        
        .btn-submit {
            background: linear-gradient(135deg, var(--secondary), #ff6b6b);
            color: white;
            border: none;
            padding: 0.875rem 2rem;
            border-radius: 10px;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.3s ease;
        }
        
        .btn-submit:hover {
            background: linear-gradient(135deg, #ff6b6b, var(--secondary));
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(231, 76, 60, 0.3);
        }
        
        /* Saved Addresses */
        .saved-addresses {
            margin-bottom: 2rem;
        }
        
        .saved-address-card {
            border: 2px solid #e1e5e9;
            border-radius: 10px;
            padding: 1.5rem;
            margin-bottom: 1rem;
            cursor: pointer;
            transition: all 0.3s ease;
            background: white;
            position: relative;
            overflow: hidden;
        }
        
        .saved-address-card:hover {
            border-color: var(--accent);
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(52, 152, 219, 0.1);
        }
        
        .saved-address-card.selected {
            border-color: var(--secondary);
            background: linear-gradient(to right, rgba(231, 76, 60, 0.05), rgba(231, 76, 60, 0.02));
            border-width: 3px;
        }
        
        .saved-address-card.selected::before {
            content: '';
            position: absolute;
            left: 0;
            top: 0;
            bottom: 0;
            width: 4px;
            background: var(--secondary);
        }
        
        .address-type {
            background: linear-gradient(135deg, var(--accent), rgba(52, 152, 219, 0.1));
            color: var(--accent);
            padding: 0.3rem 0.8rem;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
            display: inline-block;
            margin-bottom: 0.5rem;
        }
        
        .address-details h6 {
            font-weight: 700;
            color: var(--primary);
            margin-bottom: 0.25rem;
        }
        
        .address-details p {
            color: #666;
            margin-bottom: 0.5rem;
            line-height: 1.4;
        }
        
        /* Footer */
        .footer {
            background: linear-gradient(135deg, var(--primary), #1a2530);
            color: white;
            position: relative;
            overflow: hidden;
            margin-top: 4rem;
        }
        
        .footer::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1440 320"><path fill="%23000000" fill-opacity="0.1" d="M0,96L48,112C96,128,192,160,288,160C384,160,480,128,576,122.7C672,117,768,139,864,154.7C960,171,1056,181,1152,170.7C1248,160,1344,128,1392,112L1440,96L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z"></path></svg>');
            background-size: cover;
            opacity: 0.1;
        }
        
        /* Animations */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        .fade-in {
            animation: fadeIn 0.6s ease-out;
        }
        
        /* Responsive */
        @media (max-width: 768px) {
            .page-title {
                font-size: 2rem;
            }
            
            .address-form {
                padding: 1.5rem;
            }
            
            .form-section-title {
                font-size: 1.1rem;
            }
            
            .btn-back, .btn-submit {
                width: 100%;
                justify-content: center;
                margin-bottom: 0.5rem;
            }
        }
        
        /* Form Validation */
        .is-invalid {
            border-color: var(--secondary) !important;
            background-color: rgba(231, 76, 60, 0.05) !important;
        }
        
        .invalid-feedback {
            color: var(--secondary);
            font-size: 0.85rem;
            margin-top: 0.25rem;
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-light sticky-top">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/homePage">
                <i class="fas fa-shopping-bag me-2"></i>ShopEase
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/homePage">
                            <i class="fas fa-home me-1"></i>Home
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/products">
                            <i class="fas fa-store me-1"></i>All Products
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/cartView">
                            <i class="fas fa-shopping-cart me-1"></i>Cart
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="#">
                            <i class="fas fa-map-marker-alt me-1"></i>Address
                        </a>
                    </li>
                </ul>
                
                <div class="d-flex align-items-center">
                    <c:choose>
                        <c:when test="${not empty sessionScope.user}">
                            <div class="dropdown">
                                <button class="btn btn-outline-primary dropdown-toggle d-flex align-items-center" 
                                        type="button" id="userDropdown" data-bs-toggle="dropdown">
                                    <i class="fas fa-user-circle me-2 fs-5"></i>
                                    <span>${sessionScope.user.name}</span>
                                </button>
                                <ul class="dropdown-menu dropdown-menu-end">
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/user/profile">
                                        <i class="fas fa-user me-2"></i>Profile</a></li>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/orders">
                                        <i class="fas fa-box me-2"></i>Orders</a></li>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/logout">
                                        <i class="fas fa-sign-out-alt me-2"></i>Logout</a></li>
                                </ul>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/userLogin" class="btn btn-outline-primary me-2">
                                <i class="fas fa-sign-in-alt me-1"></i>Login
                            </a>
                            <a href="${pageContext.request.contextPath}/register" class="btn btn-primary">
                                <i class="fas fa-user-plus me-1"></i>Register
                            </a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </nav>

    <!-- Page Header -->
    <div class="page-header">
        <div class="container">
            <h1 class="page-title fade-in">
                <i class="fas fa-map-marker-alt me-2"></i>Shipping Address
            </h1>
            <p class="lead mb-0 fade-in" style="animation-delay: 0.2s">
                Provide your shipping information for order delivery
            </p>
        </div>
    </div>

    <!-- Main Content -->
    <div class="container py-4">
        <div class="row justify-content-center">
            <div class="col-lg-10">
                <div class="address-card fade-in">
                    <div class="address-header">
                        <h3>Shipping Details</h3>
                        <p class="mb-0 opacity-75">Enter your shipping address for order delivery</p>
                    </div>
                    
                    <div class="address-form">
                        <!-- Address Form -->
                        <form id="addressForm" action="${pageContext.request.contextPath}/saveAddress" method="post">
                            <h5 class="form-section-title">
                                <i class="fas fa-edit"></i>Shipping Information
                            </h5>
                            
                            <input type="hidden" name="id" value="${address.id}"/>

                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="addressType" class="form-label">
                                        <i class="fas fa-tag"></i>Address Type <span class="required">*</span>
                                    </label>
                                    <select class="form-select" id="addressType" name="addressType" required>
                                        <option value="">Select Address Type</option>
                                        <option value="Home" ${address.addressType eq 'Home' ? 'selected' : ''}>Home</option>
                                        <option value="Work" ${address.addressType eq 'Work' ? 'selected' : ''}>Work</option>
                                        <option value="Other" ${address.addressType eq 'Other' ? 'selected' : ''}>Other</option>
                                    </select>
                                </div>
                            </div>
                            
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="firstName" class="form-label">
                                        <i class="fas fa-user"></i>First Name <span class="required">*</span>
                                    </label>
                                    <input type="text" class="form-control" id="firstName" name="firstName" value="${address.firstName}" placeholder="Enter first name" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="lastName" class="form-label">
                                        <i class="fas fa-user"></i>Last Name <span class="required">*</span>
                                    </label>
                                    <input type="text" class="form-control" id="lastName" name="lastName" value="${address.lastName}" placeholder="Enter last name" required>
                                </div>
                            </div>
                            
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="email" class="form-label">
                                        <i class="fas fa-envelope"></i>Email <span class="required">*</span>
                                    </label>
                                    <input type="email" class="form-control" id="email" name="email" value="${address.email}" placeholder="your@email.com" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="phone" class="form-label">
                                        <i class="fas fa-phone"></i>Phone Number <span class="required">*</span>
                                    </label>
                                    <input type="tel" class="form-control" id="phone" name="phone" value="${address.phone}" placeholder="Enter phone number" required>
                                </div>
                            </div>
                            
                            <h5 class="form-section-title mt-4">
                                <i class="fas fa-home"></i>Address Details
                            </h5>
                            
                            <div class="mb-3">
                                <label for="addressLine1" class="form-label">
                                    <i class="fas fa-map-pin"></i>Address Line 1 <span class="required">*</span>
                                </label>
                                <input type="text" class="form-control" id="addressLine1" name="addressLine1" value="${address.addressLine1}" placeholder="Street address, P.O. box, company name" required>
                            </div>
                            
                            <div class="mb-3">
                                <label for="addressLine2" class="form-label">
                                    <i class="fas fa-map-pin"></i>Address Line 2 (Optional)
                                </label>
                                <input type="text" class="form-control" id="addressLine2" name="addressLine2" value="${address.addressLine2}" placeholder="Apartment, suite, unit, building, floor, etc.">
                            </div>
                            
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="city" class="form-label">
                                        <i class="fas fa-city"></i>City <span class="required">*</span>
                                    </label>
                                    <input type="text" class="form-control" id="city" name="city" value="${address.city}" placeholder="Enter city" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="state" class="form-label">
                                        <i class="fas fa-landmark"></i>State <span class="required">*</span>
                                    </label>
                                    <input type="text" class="form-control" id="state" name="state" value="${address.state}" placeholder="Enter state" required>
                                </div>
                            </div>
                            
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="postalCode" class="form-label">
                                        <i class="fas fa-mail-bulk"></i>Postal Code <span class="required">*</span>
                                    </label>
                                    <input type="text" class="form-control" id="postalCode" name="postalCode" value="${address.postalCode}" placeholder="Enter postal code" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="country" class="form-label">
                                        <i class="fas fa-globe"></i>Country <span class="required">*</span>
                                    </label>
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
                            
                            <div class="d-flex flex-wrap gap-3 justify-content-between mt-4 pt-3 border-top">
                                <a href="${pageContext.request.contextPath}/cart" class="btn-back">
                                    <i class="fas fa-arrow-left me-2"></i>Back to Cart
                                </a>
                                <button type="submit" class="btn-submit">
                                    Continue to Payment<i class="fas fa-arrow-right ms-2"></i>
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="footer py-5">
        <div class="container position-relative">
            <div class="row">
                <div class="col-md-6">
                    <p class="text-light mb-0">
                        &copy; 2023 ShopEase. All rights reserved.
                    </p>
                </div>
                <div class="col-md-6 text-md-end">
                    <a href="#" class="text-light me-3 text-decoration-none">Privacy Policy</a>
                    <a href="#" class="text-light text-decoration-none">Terms of Service</a>
                </div>
            </div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Form validation
            const addressForm = document.getElementById('addressForm');
            if (addressForm) {
                addressForm.addEventListener('submit', function(e) {
                    // Remove previous error states
                    const errorFields = addressForm.querySelectorAll('.is-invalid');
                    errorFields.forEach(field => {
                        field.classList.remove('is-invalid');
                        
                        // Remove existing error messages
                        const errorMsg = field.nextElementSibling;
                        if (errorMsg && errorMsg.classList.contains('invalid-feedback')) {
                            errorMsg.remove();
                        }
                    });
                    
                    // Basic validation
                    const requiredFields = addressForm.querySelectorAll('[required]');
                    let isValid = true;
                    
                    requiredFields.forEach(field => {
                        if (!field.value.trim()) {
                            isValid = false;
                            field.classList.add('is-invalid');
                            
                            // Add error message
                            const errorMsg = document.createElement('div');
                            errorMsg.className = 'invalid-feedback';
                            errorMsg.textContent = 'This field is required';
                            field.parentNode.appendChild(errorMsg);
                        }
                    });
                    
                    // Email validation
                    const emailField = document.getElementById('email');
                    if (emailField.value.trim()) {
                        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                        if (!emailRegex.test(emailField.value)) {
                            isValid = false;
                            emailField.classList.add('is-invalid');
                            
                            // Add error message
                            const errorMsg = emailField.nextElementSibling;
                            if (!errorMsg || !errorMsg.classList.contains('invalid-feedback')) {
                                const newErrorMsg = document.createElement('div');
                                newErrorMsg.className = 'invalid-feedback';
                                newErrorMsg.textContent = 'Please enter a valid email address';
                                emailField.parentNode.appendChild(newErrorMsg);
                            }
                        }
                    }
                    
                    // Phone validation
                    const phoneField = document.getElementById('phone');
                    if (phoneField.value.trim()) {
                        const phoneRegex = /^[\+]?[1-9][\d]{0,15}$/;
                        if (!phoneRegex.test(phoneField.value.replace(/[\s\-\(\)]/g, ''))) {
                            isValid = false;
                            phoneField.classList.add('is-invalid');
                            
                            // Add error message
                            const errorMsg = phoneField.nextElementSibling;
                            if (!errorMsg || !errorMsg.classList.contains('invalid-feedback')) {
                                const newErrorMsg = document.createElement('div');
                                newErrorMsg.className = 'invalid-feedback';
                                newErrorMsg.textContent = 'Please enter a valid phone number';
                                phoneField.parentNode.appendChild(newErrorMsg);
                            }
                        }
                    }
                    
                    if (!isValid) {
                        e.preventDefault();
                        
                        // Scroll to first error
                        const firstError = addressForm.querySelector('.is-invalid');
                        if (firstError) {
                            firstError.scrollIntoView({ behavior: 'smooth', block: 'center' });
                            firstError.focus();
                        }
                    }
                });
            }
            
            // Form field animations
            const formFields = document.querySelectorAll('.form-control, .form-select');
            formFields.forEach(field => {
                field.addEventListener('focus', function() {
                    this.parentNode.style.transform = 'translateY(-2px)';
                });
                
                field.addEventListener('blur', function() {
                    this.parentNode.style.transform = 'translateY(0)';
                });
            });
            
            // Auto-format phone number
            const phoneInput = document.getElementById('phone');
            if (phoneInput) {
                phoneInput.addEventListener('input', function(e) {
                    let value = e.target.value.replace(/\D/g, '');
                    if (value.length > 3 && value.length <= 6) {
                        value = value.replace(/(\d{3})(\d+)/, '$1-$2');
                    } else if (value.length > 6) {
                        value = value.replace(/(\d{3})(\d{3})(\d+)/, '$1-$2-$3');
                    }
                    e.target.value = value;
                });
            }
            
            // Auto-focus first field
            const firstField = document.querySelector('#addressForm [required]');
            if (firstField) {
                firstField.focus();
            }
            
            // Add animation to form
            const formGroups = document.querySelectorAll('.mb-3');
            formGroups.forEach((group, index) => {
                group.style.animation = `fadeIn 0.6s ease-out ${index * 0.05}s both`;
            });
        });
    </script>
</body>
</html>