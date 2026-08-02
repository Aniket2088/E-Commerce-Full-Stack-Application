<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Merchant Signup - ShopEase</title>
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
        min-height: 100vh;
        display: flex;
        flex-direction: column;
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
    
    /* Auth Container */
    .auth-container {
        flex: 1;
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 3rem 1rem;
    }
    
    .auth-wrapper {
        width: 100%;
        max-width: 600px;
        animation: fadeIn 0.6s ease-out;
    }
    
    @keyframes fadeIn {
        from { opacity: 0; transform: translateY(20px); }
        to { opacity: 1; transform: translateY(0); }
    }
    
    /* Auth Card */
    .auth-card {
        background: white;
        border-radius: 16px;
        padding: 2.5rem;
        box-shadow: 0 10px 40px rgba(42, 63, 84, 0.12);
        position: relative;
        overflow: hidden;
        border: 1px solid rgba(42, 63, 84, 0.1);
    }
    
    .auth-card::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        height: 4px;
        background: linear-gradient(90deg, var(--primary), var(--accent));
    }
    
    /* Auth Header */
    .auth-header {
        text-align: center;
        margin-bottom: 2rem;
    }
    
    .merchant-icon {
        width: 80px;
        height: 80px;
        background: linear-gradient(135deg, var(--primary), var(--accent));
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 0 auto 1.5rem;
        color: white;
        font-size: 2rem;
    }
    
    .auth-title {
        font-size: 1.8rem;
        font-weight: 700;
        color: var(--primary);
        margin-bottom: 0.5rem;
    }
    
    .auth-subtitle {
        color: #666;
        font-size: 0.95rem;
    }
    
    /* Form Styles */
    .form-group {
        margin-bottom: 1.5rem;
    }
    
    .form-label {
        font-weight: 600;
        color: var(--primary);
        margin-bottom: 0.5rem;
        display: flex;
        align-items: center;
        gap: 0.5rem;
    }
    
    .form-control {
        padding: 0.875rem 1rem;
        border: 2px solid #e1e5e9;
        border-radius: 8px;
        font-size: 0.95rem;
        transition: all 0.3s ease;
        background-color: #f8f9fa;
    }
    
    .form-control:focus {
        border-color: var(--accent);
        box-shadow: 0 0 0 0.25rem rgba(52, 152, 219, 0.15);
        background-color: white;
    }
    
    /* Password Input */
    .password-input {
        position: relative;
    }
    
    .password-toggle {
        position: absolute;
        right: 12px;
        top: 50%;
        transform: translateY(-50%);
        background: none;
        border: none;
        color: #666;
        cursor: pointer;
        padding: 0.5rem;
        transition: color 0.3s ease;
    }
    
    .password-toggle:hover {
        color: var(--primary);
    }
    
    /* Section Title */
    .section-title {
        font-size: 1.2rem;
        font-weight: 700;
        color: var(--primary);
        margin: 2rem 0 1rem;
        padding-bottom: 0.5rem;
        border-bottom: 2px solid rgba(42, 63, 84, 0.1);
        display: flex;
        align-items: center;
        gap: 0.5rem;
    }
    
    /* Password Strength Meter */
    .password-strength {
        margin-top: 0.5rem;
        display: flex;
        align-items: center;
        gap: 0.5rem;
    }
    
    .strength-meter {
        flex: 1;
        height: 4px;
        background: #e1e5e9;
        border-radius: 2px;
        overflow: hidden;
    }
    
    .strength-fill {
        height: 100%;
        width: 0;
        border-radius: 2px;
        transition: all 0.3s ease;
    }
    
    .strength-text {
        font-size: 0.8rem;
        font-weight: 600;
        min-width: 60px;
    }
    
    /* Bank Details Section */
    .bank-details {
        background: linear-gradient(135deg, rgba(42, 63, 84, 0.05), rgba(52, 152, 219, 0.05));
        border-radius: 12px;
        padding: 1.5rem;
        margin: 1.5rem 0;
        border-left: 4px solid var(--accent);
    }
    
    /* Submit Button */
    .btn-submit {
        width: 100%;
        padding: 1rem;
        background: linear-gradient(135deg, var(--success), #27ae60);
        border: none;
        color: white;
        font-weight: 600;
        border-radius: 8px;
        cursor: pointer;
        transition: all 0.3s ease;
        font-size: 1rem;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 0.5rem;
    }
    
    .btn-submit:hover {
        background: linear-gradient(135deg, #27ae60, var(--success));
        transform: translateY(-2px);
        box-shadow: 0 8px 20px rgba(46, 204, 113, 0.3);
    }
    
    /* Login Link */
    .login-link {
        text-align: center;
        color: #666;
        font-size: 0.95rem;
        margin-top: 1.5rem;
        padding-top: 1.5rem;
        border-top: 1px solid #e1e5e9;
    }
    
    .login-link a {
        color: var(--accent);
        font-weight: 600;
        text-decoration: none;
        transition: color 0.3s ease;
    }
    
    .login-link a:hover {
        color: var(--primary);
        text-decoration: underline;
    }
    
    /* Alerts */
    .alert-error {
        background-color: rgba(231, 76, 60, 0.1);
        border: 1px solid rgba(231, 76, 60, 0.2);
        color: #c0392b;
        padding: 0.875rem 1rem;
        border-radius: 8px;
        margin-bottom: 1.5rem;
        font-size: 0.9rem;
    }
    
    .alert-success {
        background-color: rgba(46, 204, 113, 0.1);
        border: 1px solid rgba(46, 204, 113, 0.2);
        color: #27ae60;
        padding: 0.875rem 1rem;
        border-radius: 8px;
        margin-bottom: 1.5rem;
        font-size: 0.9rem;
    }
    
    /* Footer */
    .footer {
        background: linear-gradient(135deg, var(--primary), #1a2530);
        color: white;
        position: relative;
        overflow: hidden;
        margin-top: auto;
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
    @keyframes slideIn {
        from {
            opacity: 0;
            transform: translateX(-20px);
        }
        to {
            opacity: 1;
            transform: translateX(0);
        }
    }
    
    .form-group {
        animation: slideIn 0.6s ease-out;
        animation-fill-mode: both;
    }
    
    /* Responsive */
    @media (max-width: 768px) {
        .auth-container {
            padding: 1.5rem 1rem;
        }
        
        .auth-card {
            padding: 2rem 1.5rem;
        }
        
        .merchant-icon {
            width: 70px;
            height: 70px;
            font-size: 1.8rem;
        }
        
        .auth-title {
            font-size: 1.5rem;
        }
        
        .bank-details {
            padding: 1.25rem;
        }
    }
    
    @media (max-width: 480px) {
        .auth-card {
            padding: 1.5rem;
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
                            <i class="fas fa-store me-1"></i>Products
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="#">
                            <i class="fas fa-store-alt me-1"></i>Merchant
                        </a>
                    </li>
                </ul>
                
                <div class="d-flex align-items-center">
                    <a href="${pageContext.request.contextPath}/merchantLogin" class="btn btn-outline-primary">
                        <i class="fas fa-sign-in-alt me-1"></i>Merchant Login
                    </a>
                </div>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="auth-container">
        <div class="auth-wrapper">
            <div class="auth-card">
                <div class="auth-header">
                    <div class="merchant-icon">
                        <i class="fas fa-user-tie"></i>
                    </div>
                    <h1 class="auth-title">Merchant Signup</h1>
                    <p class="auth-subtitle">Create your merchant account to start selling on ShopEase</p>
                </div>

                <!-- Messages -->
                <c:if test="${not empty error}">
                    <div class="alert-error">
                        <i class="fas fa-exclamation-circle me-2"></i>${error}
                    </div>
                </c:if>
                
                <c:if test="${not empty success}">
                    <div class="alert-success">
                        <i class="fas fa-check-circle me-2"></i>${success}
                    </div>
                </c:if>

                <!-- Signup Form -->
                <form action="${pageContext.request.contextPath}/registerMerchant" method="POST" id="signupForm">
                    <!-- Merchant Details -->
                    <h3 class="section-title">
                        <i class="fas fa-user-tie"></i>Merchant Information
                    </h3>
                    
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="name" class="form-label">
                                    <i class="fas fa-user"></i>Full Name
                                </label>
                                <input type="text" 
                                       class="form-control" 
                                       id="name" 
                                       name="name" 
                                       placeholder="Enter your full name" 
                                       required
                                       autofocus>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="email" class="form-label">
                                    <i class="fas fa-envelope"></i>Email Address
                                </label>
                                <input type="email" 
                                       class="form-control" 
                                       id="email" 
                                       name="email" 
                                       placeholder="merchant@example.com" 
                                       required>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="phone" class="form-label">
                                    <i class="fas fa-phone"></i>Phone Number
                                </label>
                                <input type="tel" 
                                       class="form-control" 
                                       id="phone" 
                                       name="phone" 
                                       placeholder="Enter 10-digit phone number" 
                                       pattern="[0-9]{10}"
                                       required>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="password" class="form-label">
                                    <i class="fas fa-lock"></i>Password
                                </label>
                                <div class="password-input">
                                    <input type="password" 
                                           class="form-control" 
                                           id="password" 
                                           name="password" 
                                           placeholder="Create a strong password" 
                                           required>
                                    <button type="button" class="password-toggle" id="togglePassword">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                </div>
                                
                                <!-- Password Strength Meter -->
                                <div class="password-strength">
                                    <div class="strength-meter">
                                        <div class="strength-fill" id="strengthFill"></div>
                                    </div>
                                    <div class="strength-text" id="strengthText">Weak</div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Bank Details Section -->
                    <div class="bank-details">
                        <h3 class="section-title" style="border-bottom: none; margin-top: 0; padding-bottom: 0;">
                            <i class="fas fa-university"></i>Bank Details
                        </h3>
                        <p class="text-muted small mb-3">Provide your bank details for receiving payments</p>
                        
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="accountNumber" class="form-label">
                                        <i class="fas fa-credit-card"></i>Account Number
                                    </label>
                                    <input type="text" 
                                           class="form-control" 
                                           id="accountNumber" 
                                           name="accountNumber" 
                                           placeholder="Enter account number" 
                                           required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="bankName" class="form-label">
                                        <i class="fas fa-bank"></i>Bank Name
                                    </label>
                                    <input type="text" 
                                           class="form-control" 
                                           id="bankName" 
                                           name="bankName" 
                                           placeholder="Enter bank name" 
                                           required>
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="ifscCode" class="form-label">
                                <i class="fas fa-code"></i>IFSC Code
                            </label>
                            <input type="text" 
                                   class="form-control" 
                                   id="ifscCode" 
                                   name="ifscCode" 
                                   placeholder="Enter IFSC code" 
                                   required>
                        </div>
                    </div>

                    <button type="submit" class="btn-submit">
                        <i class="fas fa-user-plus"></i> Create Merchant Account
                    </button>
                </form>

                <!-- Login Link -->
                <div class="login-link">
                    Already have a merchant account? 
                    <a href="${pageContext.request.contextPath}/merchantLogin">Login here</a>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="footer py-4">
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
            // Toggle password visibility
            const togglePassword = document.getElementById('togglePassword');
            const passwordInput = document.getElementById('password');
            
            togglePassword.addEventListener('click', function() {
                const type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
                passwordInput.setAttribute('type', type);
                
                // Toggle icon
                const icon = this.querySelector('i');
                if (type === 'text') {
                    icon.classList.remove('fa-eye');
                    icon.classList.add('fa-eye-slash');
                } else {
                    icon.classList.remove('fa-eye-slash');
                    icon.classList.add('fa-eye');
                }
            });
            
            // Password strength checker
            passwordInput.addEventListener('input', function() {
                const password = this.value;
                checkPasswordStrength(password);
            });
            
            function checkPasswordStrength(password) {
                // Requirements
                const hasLength = password.length >= 8;
                const hasUppercase = /[A-Z]/.test(password);
                const hasLowercase = /[a-z]/.test(password);
                const hasNumber = /[0-9]/.test(password);
                const hasSpecial = /[^A-Za-z0-9]/.test(password);
                
                // Calculate strength score
                let strength = 0;
                if (hasLength) strength += 20;
                if (hasUppercase) strength += 20;
                if (hasLowercase) strength += 20;
                if (hasNumber) strength += 20;
                if (hasSpecial) strength += 20;
                
                // Update strength meter
                const strengthFill = document.getElementById('strengthFill');
                const strengthText = document.getElementById('strengthText');
                
                strengthFill.style.width = strength + '%';
                
                if (strength <= 40) {
                    strengthFill.style.backgroundColor = '#e74c3c';
                    strengthText.textContent = 'Weak';
                    strengthText.style.color = '#e74c3c';
                } else if (strength <= 80) {
                    strengthFill.style.backgroundColor = '#f39c12';
                    strengthText.textContent = 'Medium';
                    strengthText.style.color = '#f39c12';
                } else {
                    strengthFill.style.backgroundColor = '#2ecc71';
                    strengthText.textContent = 'Strong';
                    strengthText.style.color = '#2ecc71';
                }
            }
            
            // Form validation
            const signupForm = document.getElementById('signupForm');
            const nameInput = document.getElementById('name');
            const emailInput = document.getElementById('email');
            const phoneInput = document.getElementById('phone');
            const accountNumberInput = document.getElementById('accountNumber');
            const bankNameInput = document.getElementById('bankName');
            const ifscInput = document.getElementById('ifscCode');
            
            signupForm.addEventListener('submit', function(e) {
                let isValid = true;
                
                // Name validation
                if (!nameInput.value.trim()) {
                    showError(nameInput, 'Full name is required');
                    isValid = false;
                } else {
                    clearError(nameInput);
                }
                
                // Email validation
                if (!emailInput.value.trim()) {
                    showError(emailInput, 'Email is required');
                    isValid = false;
                } else if (!isValidEmail(emailInput.value)) {
                    showError(emailInput, 'Please enter a valid email address');
                    isValid = false;
                } else {
                    clearError(emailInput);
                }
                
                // Phone validation
                if (!phoneInput.value.trim()) {
                    showError(phoneInput, 'Phone number is required');
                    isValid = false;
                } else if (!isValidPhone(phoneInput.value)) {
                    showError(phoneInput, 'Please enter a valid 10-digit phone number');
                    isValid = false;
                } else {
                    clearError(phoneInput);
                }
                
                // Password validation
                if (!passwordInput.value.trim()) {
                    showError(passwordInput, 'Password is required');
                    isValid = false;
                } else if (passwordInput.value.length < 8) {
                    showError(passwordInput, 'Password must be at least 8 characters');
                    isValid = false;
                } else {
                    clearError(passwordInput);
                }
                
                // Account number validation
                if (!accountNumberInput.value.trim()) {
                    showError(accountNumberInput, 'Account number is required');
                    isValid = false;
                } else {
                    clearError(accountNumberInput);
                }
                
                // Bank name validation
                if (!bankNameInput.value.trim()) {
                    showError(bankNameInput, 'Bank name is required');
                    isValid = false;
                } else {
                    clearError(bankNameInput);
                }
                
                // IFSC validation
                if (!ifscInput.value.trim()) {
                    showError(ifscInput, 'IFSC code is required');
                    isValid = false;
                } else {
                    clearError(ifscInput);
                }
                
                if (!isValid) {
                    e.preventDefault();
                }
            });
            
            // Helper functions
            function isValidEmail(email) {
                const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                return re.test(email);
            }
            
            function isValidPhone(phone) {
                const re = /^[0-9]{10}$/;
                return re.test(phone);
            }
            
            function showError(input, message) {
                const formGroup = input.closest('.form-group');
                input.classList.add('is-invalid');
                
                // Remove existing error
                let errorElement = formGroup.querySelector('.invalid-feedback');
                if (!errorElement) {
                    errorElement = document.createElement('div');
                    errorElement.className = 'invalid-feedback';
                    formGroup.appendChild(errorElement);
                }
                errorElement.textContent = message;
                errorElement.style.display = 'block';
            }
            
            function clearError(input) {
                const formGroup = input.closest('.form-group');
                input.classList.remove('is-invalid');
                
                const errorElement = formGroup.querySelector('.invalid-feedback');
                if (errorElement) {
                    errorElement.style.display = 'none';
                }
            }
            
            // Add validation styles
            const style = document.createElement('style');
            style.textContent = `
                .is-invalid {
                    border-color: var(--secondary) !important;
                    background-color: rgba(231, 76, 60, 0.05) !important;
                }
                
                .is-invalid:focus {
                    box-shadow: 0 0 0 0.25rem rgba(231, 76, 60, 0.15) !important;
                }
                
                .invalid-feedback {
                    color: var(--secondary);
                    font-size: 0.85rem;
                    margin-top: 0.25rem;
                    display: none;
                }
            `;
            document.head.appendChild(style);
            
            // Auto-focus name field
            nameInput.focus();
            
            // Add click animation to buttons
            const buttons = document.querySelectorAll('.btn-submit');
            buttons.forEach(btn => {
                btn.addEventListener('mousedown', function() {
                    this.style.transform = 'scale(0.98)';
                });
                
                btn.addEventListener('mouseup', function() {
                    this.style.transform = '';
                });
                
                btn.addEventListener('mouseleave', function() {
                    this.style.transform = '';
                });
            });
            
            // Format phone number input
            phoneInput.addEventListener('input', function(e) {
                let value = e.target.value.replace(/\D/g, '');
                if (value.length > 10) value = value.substring(0, 10);
                e.target.value = value;
            });
            
            // Format account number input
            accountNumberInput.addEventListener('input', function(e) {
                let value = e.target.value.replace(/\D/g, '');
                e.target.value = value;
            });
        });
    </script>
</body>
</html>