<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Order Confirmation - ShopEase</title>
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
        
        /* Confirmation Container */
        .confirmation-container {
            padding: 4rem 1rem;
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 70vh;
        }
        
        /* Confirmation Card */
        .confirmation-card {
            border: none;
            border-radius: 20px;
            box-shadow: 0 15px 40px rgba(0,0,0,0.1);
            overflow: hidden;
            max-width: 600px;
            width: 100%;
            background: white;
            position: relative;
            overflow: hidden;
        }
        
        .confirmation-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 8px;
            background: linear-gradient(90deg, var(--success), var(--accent));
        }
        
        .confirmation-card.error::before {
            background: linear-gradient(90deg, var(--secondary), #ff6b6b);
        }
        
        .confirmation-body {
            padding: 3rem 2rem;
            text-align: center;
        }
        
        /* Icon Animation */
        .confirmation-icon {
            width: 120px;
            height: 120px;
            margin: 0 auto 2rem;
            position: relative;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .success-icon {
            font-size: 4rem;
            color: var(--success);
            animation: successScale 0.6s ease-out;
        }
        
        .error-icon {
            font-size: 4rem;
            color: var(--secondary);
            animation: shake 0.5s ease-out;
        }
        
        @keyframes successScale {
            0% { transform: scale(0); opacity: 0; }
            70% { transform: scale(1.2); }
            100% { transform: scale(1); opacity: 1; }
        }
        
        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            10%, 30%, 50%, 70%, 90% { transform: translateX(-5px); }
            20%, 40%, 60%, 80% { transform: translateX(5px); }
        }
        
        /* Title Styling */
        .confirmation-title {
            font-size: 2.2rem;
            font-weight: 800;
            margin-bottom: 1rem;
            background: linear-gradient(135deg, var(--success), #27ae60);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
        
        .confirmation-card.error .confirmation-title {
            background: linear-gradient(135deg, var(--secondary), #ff6b6b);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
        
        /* Message Styling */
        .confirmation-message {
            color: #666;
            font-size: 1.1rem;
            line-height: 1.6;
            margin-bottom: 2rem;
            max-width: 80%;
            margin-left: auto;
            margin-right: auto;
        }
        
        /* Order Details */
        .order-details {
            background: linear-gradient(135deg, rgba(42, 63, 84, 0.05), rgba(52, 152, 219, 0.05));
            border-radius: 12px;
            padding: 1.5rem;
            margin: 2rem auto;
            max-width: 80%;
            border-left: 4px solid var(--accent);
        }
        
        .detail-item {
            display: flex;
            justify-content: space-between;
            padding: 0.5rem 0;
            border-bottom: 1px solid rgba(0,0,0,0.05);
        }
        
        .detail-item:last-child {
            border-bottom: none;
        }
        
        .detail-label {
            color: var(--primary);
            font-weight: 600;
        }
        
        .detail-value {
            color: #666;
            font-weight: 500;
        }
        
        /* Buttons */
        .confirmation-buttons {
            display: flex;
            justify-content: center;
            gap: 1rem;
            margin-top: 2rem;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, var(--primary), var(--accent));
            color: white;
            border: none;
            padding: 0.875rem 2rem;
            border-radius: 10px;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.3s ease;
            text-decoration: none;
        }
        
        .btn-primary:hover {
            background: linear-gradient(135deg, var(--accent), var(--primary));
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(52, 152, 219, 0.3);
            color: white;
        }
        
        .btn-secondary {
            background: rgba(42, 63, 84, 0.1);
            color: var(--primary);
            border: 2px solid rgba(42, 63, 84, 0.2);
            padding: 0.875rem 2rem;
            border-radius: 10px;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.3s ease;
            text-decoration: none;
        }
        
        .btn-secondary:hover {
            background: var(--primary);
            color: white;
            border-color: var(--primary);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(42, 63, 84, 0.2);
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
        
        /* Confetti Animation */
        @keyframes confettiRain {
            0% {
                opacity: 1;
                margin-top: -100px;
                margin-left: -200px;
            } 
            100% {
                opacity: 1;
                margin-top: 1000px;
                margin-left: 250px;
            }
        }
        
        .confetti {
            position: absolute;
            width: 15px;
            height: 15px;
            opacity: 0;
            animation: confettiRain 5s infinite;
        }
        
        /* Additional Message */
        .additional-info {
            color: #888;
            font-size: 0.9rem;
            margin-top: 1.5rem;
            font-style: italic;
        }
        
        /* Responsive */
        @media (max-width: 768px) {
            .confirmation-container {
                padding: 2rem 1rem;
            }
            
            .confirmation-body {
                padding: 2rem 1rem;
            }
            
            .confirmation-title {
                font-size: 1.8rem;
            }
            
            .confirmation-message {
                max-width: 100%;
            }
            
            .confirmation-buttons {
                flex-direction: column;
                gap: 0.75rem;
            }
            
            .btn-primary, .btn-secondary {
                width: 100%;
                justify-content: center;
            }
            
            .order-details {
                max-width: 100%;
            }
        }
        
        /* Animations */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        .fade-in {
            animation: fadeIn 0.8s ease-out;
        }
        
        .delay-1 { animation-delay: 0.1s; }
        .delay-2 { animation-delay: 0.2s; }
        .delay-3 { animation-delay: 0.3s; }
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
                        <a class="nav-link active" href="${pageContext.request.contextPath}/orders">
                            <i class="fas fa-box me-1"></i>Orders
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

    <!-- Confetti Animation for Success -->
    <c:if test="${isSuccess}">
        <div id="confettiContainer"></div>
    </c:if>

    <!-- Confirmation Content -->
    <div class="confirmation-container">
        <div class="confirmation-card ${isSuccess ? '' : 'error'} fade-in">
            <div class="confirmation-body">
                <div class="confirmation-icon">
                    <c:choose>
                        <c:when test="${isSuccess}">
                            <i class="fas fa-check-circle success-icon"></i>
                        </c:when>
                        <c:otherwise>
                            <i class="fas fa-times-circle error-icon"></i>
                        </c:otherwise>
                    </c:choose>
                </div>
                
                <h1 class="confirmation-title fade-in">
                    <c:choose>
                        <c:when test="${isSuccess}">
                            Order Placed Successfully!
                        </c:when>
                        <c:otherwise>
                            Order Failed
                        </c:otherwise>
                    </c:choose>
                </h1>
                
                <p class="confirmation-message fade-in delay-1">
                    <c:choose>
                        <c:when test="${isSuccess}">
                            Thank you for your purchase! Your order has been confirmed and will be processed shortly.
                        </c:when>
                        <c:otherwise>
                            ${message}
                        </c:otherwise>
                    </c:choose>
                </p>
                
                <!-- Order Details for Success -->
                <c:if test="${isSuccess and not empty orderDetails}">
                    <div class="order-details fade-in delay-2">
                        <div class="detail-item">
                            <span class="detail-label">Order ID:</span>
                            <span class="detail-value">${orderDetails.orderId}</span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">Total Amount:</span>
                            <span class="detail-value">₹${orderDetails.totalAmount}</span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">Payment Method:</span>
                            <span class="detail-value">${orderDetails.paymentMethod}</span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">Estimated Delivery:</span>
                            <span class="detail-value">${orderDetails.estimatedDelivery}</span>
                        </div>
                    </div>
                </c:if>
                
                <!-- Additional Info -->
                <c:if test="${isSuccess}">
                    <p class="additional-info fade-in delay-2">
                        You will receive an email confirmation shortly with order details.
                    </p>
                </c:if>
                
                <div class="confirmation-buttons fade-in delay-3">
                    <a href="${pageContext.request.contextPath}/homePage" class="btn-primary">
                        <i class="fas fa-home me-2"></i>Continue Shopping
                    </a>
                    <c:if test="${isSuccess}">
                        <a href="${pageContext.request.contextPath}/orders" class="btn-secondary">
                            <i class="fas fa-list me-2"></i>View Orders
                        </a>
                    </c:if>
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
            // Confetti animation for success
            <c:if test="${isSuccess}">
                createConfetti();
            </c:if>
            
            // Button hover effects
            const buttons = document.querySelectorAll('.btn-primary, .btn-secondary');
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
            
            // Auto-redirect after 10 seconds for success
            <c:if test="${isSuccess}">
                setTimeout(function() {
                    window.location.href = '${pageContext.request.contextPath}/homePage';
                }, 10000); // 10 seconds
            </c:if>
        });
        
        function createConfetti() {
            const colors = ['#2ecc71', '#3498db', '#e74c3c', '#f39c12', '#9b59b6'];
            const container = document.getElementById('confettiContainer');
            
            for (let i = 0; i < 50; i++) {
                const confetti = document.createElement('div');
                confetti.className = 'confetti';
                confetti.style.backgroundColor = colors[Math.floor(Math.random() * colors.length)];
                confetti.style.left = Math.random() * 100 + '%';
                confetti.style.animationDelay = Math.random() * 5 + 's';
                confetti.style.opacity = Math.random() * 0.5 + 0.5;
                container.appendChild(confetti);
            }
            
            // Clear confetti after animation
            setTimeout(() => {
                container.innerHTML = '';
            }, 5000);
        }
        
        // Add confetti on button click for demo
        document.querySelector('.btn-primary')?.addEventListener('click', function(e) {
            if (${isSuccess}) {
                createConfetti();
            }
        });
    </script>
</body>
</html>