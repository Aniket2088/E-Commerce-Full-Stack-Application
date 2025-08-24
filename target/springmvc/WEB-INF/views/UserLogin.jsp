<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Welcome to ShopEase</title>
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
        
        .remember-forgot {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin: 1rem 0;
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
                <h2>Welcome Back!</h2>
                <p>Sign in to access your personalized shopping experience, wishlist, and order history.</p>
                <img src="https://cdn-icons-png.flaticon.com/512/3144/3144456.png" alt="Online Shopping" class="auth-hero-img">
                <div style="margin-top: auto; position: relative; z-index: 1;">
                    <p>New to ShopEase?</p>
                    <a href="${pageContext.request.contextPath}/user/register" class="btn btn-outline-light">Create Account</a>
                </div>
            </div>
            
            <!-- Right Side - Form Section -->
            <div class="auth-form-container">
                <a href="${pageContext.request.contextPath}/" class="auth-logo">ShopEase</a>
                <h1 class="auth-title">Welcome Back</h1>
                <p class="auth-subtitle">Sign in to continue your shopping journey</p>
                
                <form action="${pageContext.request.contextPath}/loginUser" method="POST">
                    <div class="form-floating mb-3">
                        <input type="email" class="form-control" id="email" name="email" placeholder="your@email.com" required>
                        <label for="email">Email Address</label>
                    </div>
                    
                    <div class="form-floating mb-3 position-relative">
                        <input type="password" class="form-control" id="password" name="password" placeholder="Password" required>
                        <label for="password">Password</label>
                        <button type="button" class="password-toggle" id="togglePassword">
                            <i class="fas fa-eye"></i>
                        </button>
                    </div>
                    
                    <div class="remember-forgot">
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" id="rememberMe">
                            <label class="form-check-label" for="rememberMe">Remember me</label>
                        </div>
                        <a href="${pageContext.request.contextPath}/user/forgot-password" class="auth-link">Forgot password?</a>
                    </div>
                    
                    <button type="submit" class="btn btn-auth">
                        <i class="fas fa-sign-in-alt me-2"></i> Sign In
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
                    Don't have an account? <a href="${pageContext.request.contextPath}/userSignUp" class="auth-link">Sign Up</a>
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
        
        // Focus on email field when page loads
        document.addEventListener('DOMContentLoaded', function() {
            document.getElementById('email').focus();
        });
    </script>
</body>
</html>