<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Join ShopEase</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #2a3f54;
            --secondary: #e74c3c;
            --accent: #3498db;
            --light: #f8f9fa;
            --dark: #212529;
            --light-bg: #f5f7fa;
        }
        
        body {
            font-family: 'Poppins', sans-serif;
            background-color: var(--light-bg);
            color: var(--dark);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        
        .auth-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem;
        }
        
        .auth-card {
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0,0,0,0.08);
            display: flex;
            min-height: 600px;
        }
        
        .auth-hero {
            flex: 1;
            background: linear-gradient(135deg, var(--primary) 0%, #1e2b3d 100%);
            color: white;
            padding: 3rem;
            display: flex;
            flex-direction: column;
            justify-content: center;
            position: relative;
            overflow: hidden;
        }
        
        .auth-hero::before {
            content: "";
            position: absolute;
            top: -50px;
            right: -50px;
            width: 200px;
            height: 200px;
            border-radius: 50%;
            background: rgba(255,255,255,0.1);
        }
        
        .auth-hero::after {
            content: "";
            position: absolute;
            bottom: -80px;
            left: -80px;
            width: 300px;
            height: 300px;
            border-radius: 50%;
            background: rgba(255,255,255,0.05);
        }
        
        .auth-hero h2 {
            font-weight: 700;
            font-size: 2rem;
            margin-bottom: 1.5rem;
            position: relative;
            z-index: 1;
        }
        
        .auth-hero p {
            opacity: 0.9;
            margin-bottom: 2rem;
            position: relative;
            z-index: 1;
        }
        
        .auth-hero-img {
            max-width: 100%;
            height: auto;
            margin-top: 2rem;
            position: relative;
            z-index: 1;
            filter: drop-shadow(0 10px 20px rgba(0,0,0,0.2));
        }
        
        .auth-form-container {
            flex: 1;
            background: white;
            padding: 3rem;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }
        
        .auth-logo {
            font-weight: 700;
            font-size: 1.8rem;
            color: var(--primary);
            margin-bottom: 2rem;
            display: inline-block;
        }
        
        .auth-title {
            font-weight: 600;
            font-size: 1.8rem;
            margin-bottom: 0.5rem;
            color: var(--primary);
        }
        
        .auth-subtitle {
            color: #6c757d;
            margin-bottom: 2rem;
        }
        
        .form-floating label {
            color: #6c757d;
            font-weight: 400;
        }
        
        .form-control {
            padding: 1rem;
            border-radius: 8px;
            border: 1px solid #e0e0e0;
            transition: all 0.3s;
        }
        
        .form-control:focus {
            border-color: var(--accent);
            box-shadow: 0 0 0 0.25rem rgba(52, 152, 219, 0.15);
        }
        
        .password-toggle {
            position: absolute;
            right: 10px;
            top: 50%;
            transform: translateY(-50%);
            background: none;
            border: none;
            color: #6c757d;
            cursor: pointer;
        }
        
        .btn-auth {
            background: var(--secondary);
            color: white;
            border: none;
            padding: 1rem;
            font-weight: 500;
            border-radius: 8px;
            transition: all 0.3s;
            width: 100%;
        }
        
        .btn-auth:hover {
            background: #c0392b;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(231, 76, 60, 0.3);
        }
        
        .auth-divider {
            display: flex;
            align-items: center;
            margin: 1.5rem 0;
            color: #6c757d;
        }
        
        .auth-divider::before,
        .auth-divider::after {
            content: "";
            flex: 1;
            border-bottom: 1px solid #e0e0e0;
        }
        
        .auth-divider::before {
            margin-right: 1rem;
        }
        
        .auth-divider::after {
            margin-left: 1rem;
        }
        
        .social-auth {
            display: flex;
            gap: 1rem;
            margin-bottom: 1.5rem;
        }
        
        .social-btn {
            flex: 1;
            padding: 0.75rem;
            border-radius: 8px;
            border: 1px solid #e0e0e0;
            background: white;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.3s;
        }
        
        .social-btn:hover {
            background: #f8f9fa;
            transform: translateY(-2px);
        }
        
        .social-btn i {
            margin-right: 0.5rem;
        }
        
        .auth-footer {
            text-align: center;
            margin-top: 1.5rem;
            color: #6c757d;
        }
        
        .auth-link {
            color: var(--accent);
            text-decoration: none;
            font-weight: 500;
        }
        
        .auth-link:hover {
            text-decoration: underline;
        }
        
        .password-strength {
            height: 4px;
            background: #e9ecef;
            border-radius: 2px;
            margin-top: 0.5rem;
            overflow: hidden;
        }
        
        .strength-meter {
            height: 100%;
            width: 0;
            transition: width 0.3s, background-color 0.3s;
        }
        
        @media (max-width: 992px) {
            .auth-hero {
                display: none;
            }
            
            .auth-card {
                min-height: auto;
            }
        }
    </style>
</head>
<body>
    <div class="auth-container">
        <div class="auth-card">
            <!-- Left Side - Hero Section -->
            <div class="auth-hero">
                <h2>Join ShopEase Today</h2>
                <p>Create your account to enjoy personalized shopping experience, faster checkout, and order tracking.</p>
                <img src="https://cdn-icons-png.flaticon.com/512/3144/3144456.png" alt="Online Shopping" class="auth-hero-img">
                <div style="margin-top: auto; position: relative; z-index: 1;">
                    <p>Already have an account?</p>
                    <a href="${pageContext.request.contextPath}/userLogin" class="btn btn-outline-light">Sign In</a>
                </div>
            </div>
            <c:if test="${not empty message}">
    <div class="alert alert-info mt-3" role="alert">
        ${message}
    </div>
</c:if>
            
            <!-- Right Side - Form Section -->
            <div class="auth-form-container">
                <a href="${pageContext.request.contextPath}/" class="auth-logo">ShopEase</a>
                <h1 class="auth-title">Create Account</h1>
                <p class="auth-subtitle">Join thousands of happy shoppers</p>
                
                <form action="${pageContext.request.contextPath}/signUpUser" method="POST">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <div class="form-floating">
                                <input type="text" class="form-control" id="firstName" name="firstName" placeholder="John" required>
                                <label for="firstName">First Name</label>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-floating">
                                <input type="text" class="form-control" id="lastName" name="lastName" placeholder="Doe" required>
                                <label for="lastName">Last Name</label>
                            </div>
                        </div>
                    </div>
                    
                    <div class="form-floating mt-3">
                        <input type="email" class="form-control" id="email" name="email" placeholder="your@email.com" required>
                        <label for="email">Email Address</label>
                    </div>
                    
                    <div class="form-floating mt-3 position-relative">
                        <input type="password" class="form-control" id="password" name="password" placeholder="Password" required>
                        <label for="password">Password</label>
                        <button type="button" class="password-toggle" id="togglePassword">
                            <i class="fas fa-eye"></i>
                        </button>
                        <div class="password-strength">
                            <div class="strength-meter" id="strengthMeter"></div>
                        </div>
                        <small class="text-muted">Use 8+ characters with mix of letters, numbers & symbols</small>
                    </div>
                    
                    <div class="form-floating mt-3">
                        <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" placeholder="Confirm Password" required>
                        <label for="confirmPassword">Confirm Password</label>
                        <div class="invalid-feedback" id="passwordMatchError">Passwords don't match</div>
                    </div>
                    
                    <div class="form-check mt-3">
                        <input class="form-check-input" type="checkbox" id="termsAgree" required>
                        <label class="form-check-label" for="termsAgree">
                            I agree to the <a href="#" class="auth-link">Terms of Service</a> and <a href="#" class="auth-link">Privacy Policy</a>
                        </label>
                    </div>
                    
                    <button type="submit" class="btn btn-auth mt-4">
                        <i class="fas fa-user-plus me-2"></i> Create Account
                    </button>
                    
                    <div class="auth-divider">or</div>
                    
                    <div class="social-auth">
                        <button type="button" class="social-btn">
                            <i class="fab fa-google text-danger"></i> Google
                        </button>
                        <button type="button" class="social-btn">
                            <i class="fab fa-facebook-f text-primary"></i> Facebook
                        </button>
                    </div>
                    
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger mt-3">
                            ${error}
                        </div>
                    </c:if>
                </form>
                
                <div class="auth-footer">
                    Already have an account? <a href="${pageContext.request.contextPath}/user/login" class="auth-link">Sign In</a>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Toggle password visibility
        document.getElementById('togglePassword').addEventListener('click', function() {
            const passwordInput = document.getElementById('password');
            const icon = this.querySelector('i');
            
            if (passwordInput.type === 'password') {
                passwordInput.type = 'text';
                icon.classList.remove('fa-eye');
                icon.classList.add('fa-eye-slash');
            } else {
                passwordInput.type = 'password';
                icon.classList.remove('fa-eye-slash');
                icon.classList.add('fa-eye');
            }
        });
        
        // Password strength meter
        document.getElementById('password').addEventListener('input', function() {
            const password = this.value;
            const strengthMeter = document.getElementById('strengthMeter');
            let strength = 0;
            
            // Length check
            if (password.length >= 8) strength += 1;
            if (password.length >= 12) strength += 1;
            
            // Character type checks
            if (/[A-Z]/.test(password)) strength += 1;
            if (/[0-9]/.test(password)) strength += 1;
            if (/[^A-Za-z0-9]/.test(password)) strength += 1;
            
            // Update meter
            const width = (strength / 5) * 100;
            strengthMeter.style.width = width + '%';
            
            // Update color based on strength
            if (strength <= 2) {
                strengthMeter.style.backgroundColor = '#e74c3c'; // Weak
            } else if (strength <= 4) {
                strengthMeter.style.backgroundColor = '#f39c12'; // Medium
            } else {
                strengthMeter.style.backgroundColor = '#2ecc71'; // Strong
            }
        });
        
        // Password confirmation check
        document.getElementById('confirmPassword').addEventListener('input', function() {
            const password = document.getElementById('password').value;
            const confirmPassword = this.value;
            const errorElement = document.getElementById('passwordMatchError');
            
            if (password !== confirmPassword && confirmPassword.length > 0) {
                this.classList.add('is-invalid');
                errorElement.style.display = 'block';
            } else {
                this.classList.remove('is-invalid');
                errorElement.style.display = 'none';
            }
        });
        
        // Focus on first name field when page loads
        document.addEventListener('DOMContentLoaded', function() {
            document.getElementById('firstName').focus();
        });
    </script>
</body>
</html>