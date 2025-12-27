<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>ShopEase - Sign In</title>
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
        
        /* Navigation - Same as homepage */
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
            max-width: 400px;
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
        
        /* Remember Me & Forgot Password */
        .form-options {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
        }
        
        .remember-me {
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .remember-me input[type="checkbox"] {
            width: 18px;
            height: 18px;
            border: 2px solid #ddd;
            border-radius: 4px;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .remember-me input[type="checkbox"]:checked {
            background-color: var(--primary);
            border-color: var(--primary);
        }
        
        .remember-me label {
            cursor: pointer;
            color: #555;
            font-size: 0.9rem;
        }
        
        .forgot-password {
            color: var(--accent);
            text-decoration: none;
            font-size: 0.9rem;
            font-weight: 500;
            transition: color 0.3s ease;
        }
        
        .forgot-password:hover {
            color: var(--primary);
            text-decoration: underline;
        }
        
        /* Submit Button */
        .btn-submit {
            width: 100%;
            padding: 1rem;
            background: linear-gradient(135deg, var(--primary), var(--accent));
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
            background: linear-gradient(135deg, var(--accent), var(--primary));
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(52, 152, 219, 0.3);
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
        
        /* Register Link */
        .register-link {
            text-align: center;
            color: #666;
            font-size: 0.95rem;
            margin-top: 1.5rem;
            padding-top: 1.5rem;
            border-top: 1px solid #e1e5e9;
        }
        
        .register-link a {
            color: var(--accent);
            font-weight: 600;
            text-decoration: none;
            transition: color 0.3s ease;
        }
        
        .register-link a:hover {
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
        
        /* Footer - Same as homepage */
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
            
            .form-options {
                flex-direction: column;
                align-items: flex-start;
                gap: 1rem;
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
        
        /* Additional Animations */
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
        .btn-submit { animation-delay: 0.4s; }
    </style>
</head>
<body>
    <!-- Navigation - Same as homepage -->
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
                </ul>
                
                <div class="d-flex align-items-center">
                    <a href="${pageContext.request.contextPath}/merchantLogin" class="btn btn-primary">
                        <i class="fas fa-user-plus me-1"></i>Merchant Login 
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
                    <div class="auth-logo">
                        <h1 class="auth-title">Welcome Back</h1>
                    </div>
                    <p class="auth-subtitle">Sign in to continue your shopping journey</p>
                </div>

                <!-- Error Message -->
                <c:if test="${not empty error}">
                    <div class="alert-error">
                        <i class="fas fa-exclamation-circle me-2"></i>${error}
                    </div>
                </c:if>

                <!-- Login Form -->
                <form action="${pageContext.request.contextPath}/loginUser" method="POST" id="loginForm">
                    <div class="form-group">
                        <label for="email" class="form-label">
                            <i class="fas fa-envelope"></i>Email Address
                        </label>
                        <input type="email" 
                               class="form-control" 
                               id="email" 
                               name="email" 
                               placeholder="your@email.com" 
                               required
                               autofocus>
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
                                   placeholder="Enter your password" 
                                   required>
                            <button type="button" class="password-toggle" id="togglePassword">
                                <i class="fas fa-eye"></i>
                            </button>
                        </div>
                    </div>

                    <div class="form-options">
                        <div class="remember-me">
                            <input type="checkbox" id="rememberMe" name="rememberMe">
                            <label for="rememberMe">Remember me</label>
                        </div>
                        <a href="${pageContext.request.contextPath}/user/forgot-password" class="forgot-password">
                            Forgot password?
                        </a>
                    </div>

                    <button type="submit" class="btn-submit">
                        <i class="fas fa-sign-in-alt"></i> Sign In
                    </button>
                </form>

                <!-- Divider -->
                <div class="divider">or continue with</div>

                <!-- Social Login -->
                <div class="social-login">
                    <button type="button" class="social-btn google" id="googleLogin">
                        <i class="fab fa-google"></i> Google
                    </button>
                    <button type="button" class="social-btn facebook" id="facebookLogin">
                        <i class="fab fa-facebook-f"></i> Facebook
                    </button>
                </div>

                <!-- Register Link -->
                <div class="register-link">
                    Don't have an account? 
                    <a href="${pageContext.request.contextPath}/userSignUp">Create Account</a>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer - Same as homepage -->
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
            
            // Form validation
            const loginForm = document.getElementById('loginForm');
            const emailInput = document.getElementById('email');
            const passwordInput = document.getElementById('password');
            
            loginForm.addEventListener('submit', function(e) {
                let isValid = true;
                
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
                } else if (passwordInput.value.length < 6) {
                    showError(passwordInput, 'Password must be at least 6 characters');
                    isValid = false;
                } else {
                    clearError(passwordInput);
                }
                
                if (!isValid) {
                    e.preventDefault();
                }
            });
            
            // Social login buttons
            document.getElementById('googleLogin').addEventListener('click', function() {
                alert('Google login would be implemented here');
                // window.location.href = '/auth/google';
            });
            
            document.getElementById('facebookLogin').addEventListener('click', function() {
                alert('Facebook login would be implemented here');
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
            
            // Auto-focus email field
            emailInput.focus();
            
            // Check for saved credentials
            if (localStorage.getItem('rememberEmail')) {
                emailInput.value = localStorage.getItem('rememberEmail');
                document.getElementById('rememberMe').checked = true;
            }
            
            // Save credentials if remember me is checked
            document.getElementById('rememberMe').addEventListener('change', function() {
                if (this.checked) {
                    localStorage.setItem('rememberEmail', emailInput.value);
                } else {
                    localStorage.removeItem('rememberEmail');
                }
            });
        });
    </script>
</body>
</html>