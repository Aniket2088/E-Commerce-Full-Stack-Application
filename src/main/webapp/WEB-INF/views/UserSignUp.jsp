<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <title>Join ShopEase</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
            max-width: 500px;
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
        
        .auth-logo {
            display: inline-block;
            margin-bottom: 1rem;
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
        
        /* Password Requirements */
        .password-requirements {
            background: rgba(52, 152, 219, 0.05);
            border: 1px solid rgba(52, 152, 219, 0.1);
            border-radius: 8px;
            padding: 1rem;
            margin-top: 1rem;
            display: none;
        }
        
        .requirements-title {
            font-weight: 600;
            color: var(--primary);
            margin-bottom: 0.5rem;
            font-size: 0.9rem;
        }
        
        .requirement-item {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            margin-bottom: 0.3rem;
            font-size: 0.85rem;
            color: #666;
        }
        
        .requirement-item.valid {
            color: var(--success);
        }
        
        .requirement-item.invalid {
            color: #666;
        }
        
        .requirement-icon {
            font-size: 0.8rem;
        }
        
        /* Terms Agreement */
        .terms-agreement {
            margin: 1.5rem 0;
        }
        
        .terms-checkbox {
            display: flex;
            align-items: flex-start;
            gap: 0.75rem;
        }
        
        .terms-checkbox input[type="checkbox"] {
            width: 20px;
            height: 20px;
            margin-top: 0.25rem;
            border: 2px solid #ddd;
            border-radius: 4px;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .terms-checkbox input[type="checkbox"]:checked {
            background-color: var(--primary);
            border-color: var(--primary);
        }
        
        .terms-label {
            color: #555;
            font-size: 0.9rem;
            line-height: 1.4;
            cursor: pointer;
        }
        
        .terms-link {
            color: var(--accent);
            text-decoration: none;
            font-weight: 500;
            transition: color 0.3s ease;
        }
        
        .terms-link:hover {
            color: var(--primary);
            text-decoration: underline;
        }
        
        /* Submit Button */
        .btn-submit {
            width: 100%;
            padding: 1rem;
            background: linear-gradient(135deg, var(--secondary), #ff6b6b);
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
            background: linear-gradient(135deg, #ff6b6b, var(--secondary));
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(231, 76, 60, 0.3);
        }
        
        /* Divider */
        .divider {
            display: flex;
            align-items: center;
            margin: 1.5rem 0;
            color: #999;
        }
        
        .divider::before,
        .divider::after {
            content: "";
            flex: 1;
            border-bottom: 1px solid #e1e5e9;
        }
        
        .divider::before {
            margin-right: 1rem;
        }
        
        .divider::after {
            margin-left: 1rem;
        }
        
        /* Social Login */
        .social-login {
            display: flex;
            gap: 1rem;
            margin-bottom: 1.5rem;
        }
        
        .social-btn {
            flex: 1;
            padding: 0.875rem;
            border: 2px solid #e1e5e9;
            border-radius: 8px;
            background: white;
            color: var(--primary);
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }
        
        .social-btn:hover {
            border-color: var(--accent);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(52, 152, 219, 0.1);
        }
        
        .social-btn.google {
            color: #db4437;
        }
        
        .social-btn.facebook {
            color: #4267B2;
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
        
        /* Error Message */
        .alert-error {
            background-color: rgba(231, 76, 60, 0.1);
            border: 1px solid rgba(231, 76, 60, 0.2);
            color: #c0392b;
            padding: 0.875rem 1rem;
            border-radius: 8px;
            margin-bottom: 1.5rem;
            font-size: 0.9rem;
        }
        
        /* Success Message */
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
        
        .form-group:nth-child(1) { animation-delay: 0.1s; }
        .form-group:nth-child(2) { animation-delay: 0.2s; }
        .form-group:nth-child(3) { animation-delay: 0.3s; }
        .form-group:nth-child(4) { animation-delay: 0.4s; }
        .form-group:nth-child(5) { animation-delay: 0.5s; }
        
        /* Responsive */
        @media (max-width: 768px) {
            .auth-container {
                padding: 1.5rem 1rem;
            }
            
            .auth-card {
                padding: 2rem 1.5rem;
            }
            
            .social-login {
                flex-direction: column;
            }
        }
        
        @media (max-width: 480px) {
            .auth-card {
                padding: 1.5rem;
            }
            
            .auth-title {
                font-size: 1.5rem;
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
                        <a class="nav-link" href="#">
                            <i class="fas fa-info-circle me-1"></i>About
                        </a>
                    </li>
                </ul>
                
                <div class="d-flex align-items-center">
                    <a href="${pageContext.request.contextPath}/userLogin" class="btn btn-outline-primary me-2">
                        <i class="fas fa-sign-in-alt me-1"></i>Login
                    </a>
                    <a href="${pageContext.request.contextPath}/userSignUp" class="btn btn-primary">
                        <i class="fas fa-user-plus me-1"></i>Register
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
                    <a href="${pageContext.request.contextPath}/homePage" class="auth-logo">
                        <h1 class="auth-title">Join ShopEase</h1>
                    </a>
                    <p class="auth-subtitle">Create your account to start shopping</p>
                </div>

                <!-- Messages -->
                <c:if test="${not empty error}">
                    <div class="alert-error">
                        <i class="fas fa-exclamation-circle me-2"></i>${error}
                    </div>
                </c:if>
                
                <c:if test="${not empty message}">
                    <div class="alert-success">
                        <i class="fas fa-check-circle me-2"></i>${message}
                    </div>
                </c:if>

                <!-- Registration Form -->
                <form action="${pageContext.request.contextPath}/signUpUser" method="POST" id="registerForm">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="firstName" class="form-label">
                                    <i class="fas fa-user"></i>First Name
                                </label>
                                <input type="text" 
                                       class="form-control" 
                                       id="firstName" 
                                       name="firstName" 
                                       placeholder="Enter your first name" 
                                       required
                                       autofocus>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="lastName" class="form-label">
                                    <i class="fas fa-user"></i>Last Name
                                </label>
                                <input type="text" 
                                       class="form-control" 
                                       id="lastName" 
                                       name="lastName" 
                                       placeholder="Enter your last name" 
                                       required>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="email" class="form-label">
                            <i class="fas fa-envelope"></i>Email Address
                        </label>
                        <input type="email" 
                               class="form-control" 
                               id="email" 
                               name="email" 
                               placeholder="your@email.com" 
                               required>
                    </div>

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
                        
                        <!-- Password Requirements -->
                        <div class="password-requirements" id="passwordRequirements">
                            <div class="requirements-title">Password Requirements:</div>
                            <div class="requirement-item" id="reqLength">
                                <i class="fas fa-circle requirement-icon"></i>
                                At least 8 characters
                            </div>
                            <div class="requirement-item" id="reqUppercase">
                                <i class="fas fa-circle requirement-icon"></i>
                                One uppercase letter
                            </div>
                            <div class="requirement-item" id="reqLowercase">
                                <i class="fas fa-circle requirement-icon"></i>
                                One lowercase letter
                            </div>
                            <div class="requirement-item" id="reqNumber">
                                <i class="fas fa-circle requirement-icon"></i>
                                One number
                            </div>
                            <div class="requirement-item" id="reqSpecial">
                                <i class="fas fa-circle requirement-icon"></i>
                                One special character
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="confirmPassword" class="form-label">
                            <i class="fas fa-lock"></i>Confirm Password
                        </label>
                        <div class="password-input">
                            <input type="password" 
                                   class="form-control" 
                                   id="confirmPassword" 
                                   name="confirmPassword" 
                                   placeholder="Confirm your password" 
                                   required>
                            <button type="button" class="password-toggle" id="toggleConfirmPassword">
                                <i class="fas fa-eye"></i>
                            </button>
                        </div>
                        <div class="invalid-feedback" id="passwordMatchError">Passwords do not match</div>
                    </div>

                    <div class="terms-agreement">
                        <div class="terms-checkbox">
                            <input type="checkbox" id="termsAgree" name="termsAgree" required>
                            <label for="termsAgree" class="terms-label">
                                I agree to the <a href="#" class="terms-link">Terms of Service</a> and 
                                <a href="#" class="terms-link">Privacy Policy</a>
                            </label>
                        </div>
                    </div>

                    <button type="submit" class="btn-submit">
                        <i class="fas fa-user-plus"></i> Create Account
                    </button>
                </form>

                <!-- Divider -->
                <div class="divider">or sign up with</div>

                <!-- Social Login -->
                <div class="social-login">
                    <button type="button" class="social-btn google" id="googleSignup">
                        <i class="fab fa-google"></i> Google
                    </button>
                    <button type="button" class="social-btn facebook" id="facebookSignup">
                        <i class="fab fa-facebook-f"></i> Facebook
                    </button>
                </div>

                <!-- Login Link -->
                <div class="login-link">
                    Already have an account? 
                    <a href="${pageContext.request.contextPath}/userLogin">Sign In</a>
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
            
            // Toggle confirm password visibility
            const toggleConfirmPassword = document.getElementById('toggleConfirmPassword');
            const confirmPasswordInput = document.getElementById('confirmPassword');
            
            toggleConfirmPassword.addEventListener('click', function() {
                const type = confirmPasswordInput.getAttribute('type') === 'password' ? 'text' : 'password';
                confirmPasswordInput.setAttribute('type', type);
                
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
            const passwordRequirements = document.getElementById('passwordRequirements');
            
            passwordInput.addEventListener('focus', function() {
                passwordRequirements.style.display = 'block';
            });
            
            passwordInput.addEventListener('blur', function() {
                if (this.value === '') {
                    passwordRequirements.style.display = 'none';
                }
            });
            
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
                
                // Update requirement indicators
                updateRequirement('reqLength', hasLength);
                updateRequirement('reqUppercase', hasUppercase);
                updateRequirement('reqLowercase', hasLowercase);
                updateRequirement('reqNumber', hasNumber);
                updateRequirement('reqSpecial', hasSpecial);
                
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
                
                // Check password match
                checkPasswordMatch();
            }
            
            function updateRequirement(elementId, isValid) {
                const element = document.getElementById(elementId);
                if (isValid) {
                    element.classList.add('valid');
                    element.classList.remove('invalid');
                    element.querySelector('i').className = 'fas fa-check-circle requirement-icon';
                } else {
                    element.classList.add('invalid');
                    element.classList.remove('valid');
                    element.querySelector('i').className = 'fas fa-circle requirement-icon';
                }
            }
            
            // Password match checker
            function checkPasswordMatch() {
                const password = passwordInput.value;
                const confirmPassword = confirmPasswordInput.value;
                const errorElement = document.getElementById('passwordMatchError');
                
                if (confirmPassword && password !== confirmPassword) {
                    confirmPasswordInput.classList.add('is-invalid');
                    errorElement.style.display = 'block';
                } else {
                    confirmPasswordInput.classList.remove('is-invalid');
                    errorElement.style.display = 'none';
                }
            }
            
            confirmPasswordInput.addEventListener('input', checkPasswordMatch);
            
            // Form validation
            const registerForm = document.getElementById('registerForm');
            const firstNameInput = document.getElementById('firstName');
            const lastNameInput = document.getElementById('lastName');
            const emailInput = document.getElementById('email');
            const termsCheckbox = document.getElementById('termsAgree');
            
            registerForm.addEventListener('submit', function(e) {
                let isValid = true;
                
                // Name validation
                if (!firstNameInput.value.trim()) {
                    showError(firstNameInput, 'First name is required');
                    isValid = false;
                } else {
                    clearError(firstNameInput);
                }
                
                if (!lastNameInput.value.trim()) {
                    showError(lastNameInput, 'Last name is required');
                    isValid = false;
                } else {
                    clearError(lastNameInput);
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
                
                // Password match validation
                if (passwordInput.value !== confirmPasswordInput.value) {
                    showError(confirmPasswordInput, 'Passwords do not match');
                    isValid = false;
                } else {
                    clearError(confirmPasswordInput);
                }
                
                // Terms validation
                if (!termsCheckbox.checked) {
                    alert('Please agree to the Terms of Service and Privacy Policy');
                    isValid = false;
                }
                
                if (!isValid) {
                    e.preventDefault();
                }
            });
            
            // Social signup buttons
            document.getElementById('googleSignup').addEventListener('click', function() {
                alert('Google signup would be implemented here');
                // window.location.href = '/auth/google';
            });
            
            document.getElementById('facebookSignup').addEventListener('click', function() {
                alert('Facebook signup would be implemented here');
                // window.location.href = '/auth/facebook';
            });
            
            // Helper functions
            function isValidEmail(email) {
                const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                return re.test(email);
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
            
            // Auto-focus first name field
            firstNameInput.focus();
            
            // Add click animation to buttons
            const buttons = document.querySelectorAll('.btn-submit, .social-btn');
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
        });
    </script>
</body>
</html>