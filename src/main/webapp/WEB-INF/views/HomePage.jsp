<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.Base64" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>ShopEase - Premium Online Shopping</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #2a3f54;
            --secondary: #e74c3c;
            --accent: #3498db;
            --light: #f8f9fa;
            --dark: #212529;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f5f5;
        }
        
        /* Navigation */
        .navbar {
            background-color: white;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        
        .navbar-brand {
            font-weight: 700;
            font-size: 1.8rem;
            color: var(--primary);
        }
        
        .nav-link {
            font-weight: 500;
        }
        
        /* Hero Section */
        .hero {
            background: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)), 
                        url('https://images.unsplash.com/photo-1555529669-e69e7aa0ba9a?ixlib=rb-4.0.3&auto=format&fit=crop&w=1600&q=80');
            background-size: cover;
            background-position: center;
            color: white;
            padding: 6rem 0;
        }
        
        .hero-title {
            font-size: 3.5rem;
            font-weight: 700;
        }
        
        /* Product Cards */
        .product-card {
            border: none;
            border-radius: 10px;
            overflow: hidden;
            transition: all 0.3s ease;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
            margin-bottom: 1.5rem;
        }
        
        .product-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 30px rgba(0,0,0,0.15);
        }
        
        .product-img-container {
            height: 200px;
            overflow: hidden;
        }
        
        .product-img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.5s ease;
        }
        
        .product-card:hover .product-img {
            transform: scale(1.05);
        }
        
        .discount-badge {
            position: absolute;
            top: 10px;
            right: 10px;
            background-color: var(--secondary);
        }
        
        .category-card {
            border-radius: 10px;
            overflow: hidden;
            transition: all 0.3s ease;
        }
        
        .category-card:hover {
            transform: translateY(-5px);
        }
        
        /* Footer */
        .footer {
            background-color: var(--primary);
            color: white;
        }
        
        .footer-links a {
            color: rgba(255,255,255,0.7);
            text-decoration: none;
            transition: color 0.3s;
        }
        
        .footer-links a:hover {
            color: white;
        }
        
        .section-title {
            position: relative;
            padding-bottom: 15px;
            margin-bottom: 30px;
        }
        
        .section-title:after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 60px;
            height: 3px;
            background-color: var(--secondary);
        }
        
        .btn-primary {
            background-color: var(--secondary);
            border-color: var(--secondary);
        }
        
        .btn-primary:hover {
            background-color: #c0392b;
            border-color: #c0392b;
        }
        
        .btn-outline-primary {
            color: var(--secondary);
            border-color: var(--secondary);
        }
        
        .btn-outline-primary:hover {
            background-color: var(--secondary);
            color: white;
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-light sticky-top">
        <div class="container">
            <a class="navbar-brand" href="/homePage">ShopEase</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/homePage">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/products">Products</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Categories</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">About</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Contact</a>
                    </li>
                </ul>
                <%
    String message = (String) request.getAttribute("message");
    if (message != null) {
%>
    <div class="alert alert-danger mt-3" role="alert">
        <%= message %>
    </div>
<%
    }
%>
                
                <div class="d-flex">
                    <c:choose>
                        <c:when test="${not empty sessionScope.user}">
                            <div class="dropdown">
                                <button class="btn btn-outline-primary dropdown-toggle" type="button" id="userDropdown" data-bs-toggle="dropdown">
                                    <i class="fas fa-user-circle me-1"></i> ${sessionScope.user.name}
                                </button>
                                <ul class="dropdown-menu">
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/user/profile">Profile</a></li>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/user/orders">Orders</a></li>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/logout">Logout</a></li>
                                </ul>
                            </div>
                            <a href="${pageContext.request.contextPath}/cartView" class="btn btn-primary ms-2">
                                <i class="fas fa-shopping-cart"></i> Cart
                            </a>
                        </c:when>
                        <c:otherwise>
                           <%
    Object user = session.getAttribute("user");
    if (user == null) {
%>
    <a href="${pageContext.request.contextPath}/userLogin" class="btn btn-outline-primary me-2">
        <i class="fas fa-user me-1"></i> User Login
    </a>
    <a href="${pageContext.request.contextPath}/merchantLogin" class="btn btn-primary">
        <i class="fas fa-store me-1"></i> Merchant Login
    </a>
<%
    } else {
%>
    <p class="text-success">Welcome, <%= ((com.aniket.ecommerce.entity.User) user).getName() %>!</p>
<%
    }
%>

                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="hero">
        <div class="container text-center">
            <h1 class="hero-title mb-4">Premium Products at Affordable Prices</h1>
            <p class="lead mb-5">Discover our wide range of high-quality products with exclusive discounts</p>
            <a href="#featured-products" class="btn btn-primary btn-lg px-4 me-2">Shop Now</a>
            <a href="#categories" class="btn btn-outline-light btn-lg px-4">Browse Categories</a>
        </div>
    </section>

    <!-- Featured Products -->
    <section class="py-5 bg-white" id="featured-products">
        <div class="container">
            <h2 class="section-title">Featured Products</h2>
            <div class="row">
                <c:forEach var="product" items="${featuredProducts}">
                    <div class="col-lg-3 col-md-6 mb-4">
                        <div class="product-card h-100">
                            <div class="product-img-container position-relative">
                                <c:if test="${product.image != null}">
                                    <img src="data:image/jpeg;base64,${Base64.getEncoder().encodeToString(product.image)}" 
                                         class="product-img" alt="${product.productName}">
                                </c:if>
                                <c:if test="${product.discount > 0}">
                                    <span class="badge discount-badge">${product.discount}% OFF</span>
                                </c:if>
                            </div>
                            <div class="card-body">
                                <h5 class="card-title">${product.productName}</h5>
                                <p class="card-text text-muted">${product.category}</p>
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <span class="fw-bold text-primary">₹${product.productPrice - (product.productPrice * product.discount / 100)}</span>
                                        <c:if test="${product.discount > 0}">
                                            <small class="text-decoration-line-through text-muted ms-2">₹${product.productPrice}</small>
                                        </c:if>
                                    </div>
                                    <a href="${pageContext.request.contextPath}/cart/add?productId=${product.id}" class="btn btn-sm btn-outline-primary">
                                        <i class="fas fa-cart-plus"></i>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
            <div class="text-center mt-4">
                <a href="${pageContext.request.contextPath}/products" class="btn btn-primary">View All Products</a>
            </div>
        </div>
    </section>

<!-- Categories Section -->
<section class="py-5 bg-light" id="categories">
    <div class="container">
        <h2 class="section-title">Shop by Category</h2>
        <div class="row">
            <c:forEach var="category" items="${categories}">
                <div class="col-lg-3 col-md-6 mb-4">
                    <a href="${pageContext.request.contextPath}/products?category=${category}" class="text-decoration-none">
                        <div class="category-card card h-100 border-0 shadow-sm">
                            <div class="card-body text-center">
                                <i class="fas fa-${category == 'Electronics' ? 'laptop' : 
                                                 category == 'Clothing' ? 'tshirt' : 
                                                 category == 'Home' ? 'home' : 
                                                 'shopping-bag'} fa-3x mb-3 text-primary"></i>
                                <h5 class="card-title">${category}</h5>
                                <p class="text-muted">${categoryProductsCount[category]} products</p>
                            </div>
                        </div>
                    </a>
                </div>
            </c:forEach>
        </div>
    </div>
</section>

    <!-- Latest Products -->
    <section class="py-5 bg-white">
        <div class="container">
            <h2 class="section-title">New Arrivals</h2>
            <div class="row">
                <c:forEach var="product" items="${latestProducts}">
                    <div class="col-lg-3 col-md-6 mb-4">
                        <div class="product-card h-100">
                            <div class="product-img-container position-relative">
                                <c:if test="${product.image != null}">
                                    <img src="data:image/jpeg;base64,${Base64.getEncoder().encodeToString(product.image)}" 
                                         class="product-img" alt="${product.productName}">
                                </c:if>
                                <span class="badge bg-success position-absolute top-0 start-0">New</span>
                            </div>
                            <div class="card-body">
                                <h5 class="card-title">${product.productName}</h5>
                                <p class="card-text text-muted">${product.category}</p>
                                <div class="d-flex justify-content-between align-items-center">
                                    <span class="fw-bold text-primary">₹${product.productPrice}</span>
                                    <a href="${pageContext.request.contextPath}/cart/add?productId=${product.id}" class="btn btn-sm btn-outline-primary">
                                        <i class="fas fa-cart-plus"></i>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </section>

    <!-- Features Section -->
    <section class="py-5 bg-primary text-white">
        <div class="container">
            <div class="row text-center">
                <div class="col-md-4 mb-4 mb-md-0">
                    <div class="feature-icon mb-3">
                        <i class="fas fa-truck fa-3x"></i>
                    </div>
                    <h4>Free Shipping</h4>
                    <p>On orders over ₹999</p>
                </div>
                <div class="col-md-4 mb-4 mb-md-0">
                    <div class="feature-icon mb-3">
                        <i class="fas fa-undo fa-3x"></i>
                    </div>
                    <h4>Easy Returns</h4>
                    <p>30-day return policy</p>
                </div>
                <div class="col-md-4">
                    <div class="feature-icon mb-3">
                        <i class="fas fa-lock fa-3x"></i>
                    </div>
                    <h4>Secure Payment</h4>
                    <p>100% secure checkout</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="footer py-5">
        <div class="container">
            <div class="row">
                <div class="col-lg-4 mb-4 mb-lg-0">
                    <h4 class="text-white mb-4">ShopEase</h4>
                    <p>Your one-stop destination for all your shopping needs. Quality products at affordable prices.</p>
                    <div class="social-icons mt-3">
                        <a href="#" class="text-white me-3"><i class="fab fa-facebook-f"></i></a>
                        <a href="#" class="text-white me-3"><i class="fab fa-twitter"></i></a>
                        <a href="#" class="text-white me-3"><i class="fab fa-instagram"></i></a>
                        <a href="#" class="text-white"><i class="fab fa-linkedin-in"></i></a>
                    </div>
                </div>
                <div class="col-lg-2 col-md-6 mb-4 mb-md-0">
                    <h5 class="text-white mb-4">Quick Links</h5>
                    <ul class="list-unstyled footer-links">
                        <li class="mb-2"><a href="#">Home</a></li>
                        <li class="mb-2"><a href="#">Products</a></li>
                        <li class="mb-2"><a href="#">About Us</a></li>
                        <li class="mb-2"><a href="#">Contact</a></li>
                    </ul>
                </div>
                <div class="col-lg-2 col-md-6 mb-4 mb-md-0">
                    <h5 class="text-white mb-4">Categories</h5>
                    <ul class="list-unstyled footer-links">
                        <c:forEach var="category" items="${categories}">
                            <li class="mb-2"><a href="#">${category}</a></li>
                        </c:forEach>
                    </ul>
                </div>
                <div class="col-lg-4">
                    <h5 class="text-white mb-4">Newsletter</h5>
                    <p>Subscribe to get updates on new products and special offers</p>
                    <form class="mt-3">
                        <div class="input-group">
                            <input type="email" class="form-control" placeholder="Your email">
                            <button class="btn btn-light" type="submit">Subscribe</button>
                        </div>
                    </form>
                </div>
            </div>
            <hr class="mt-4 mb-4" style="border-color: rgba(255,255,255,0.1);">
            <div class="row">
                <div class="col-md-6 text-center text-md-start">
                    <p class="mb-0">&copy; 2023 ShopEase. All rights reserved.</p>
                </div>
                <div class="col-md-6 text-center text-md-end">
                    <a href="#" class="text-white me-3">Privacy Policy</a>
                    <a href="#" class="text-white">Terms of Service</a>
                </div>
            </div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Add to cart animation
        document.addEventListener('DOMContentLoaded', function() {
            const addToCartButtons = document.querySelectorAll('.btn-outline-primary');
            
            addToCartButtons.forEach(button => {
                button.addEventListener('click', function(e) {
                    if (!e.target.classList.contains('btn-outline-primary')) return;
                    
                    e.preventDefault();
                    const productName = this.closest('.card-body').querySelector('.card-title').textContent;
                    
                    // Show temporary alert
                    const alert = document.createElement('div');
                    alert.className = 'alert alert-success position-fixed top-0 start-50 translate-middle-x mt-3';
                    alert.style.zIndex = '9999';
                    alert.textContent = `${productName} added to cart!`;
                    document.body.appendChild(alert);
                    
                    // Remove alert after 2 seconds
                    setTimeout(() => {
                        alert.remove();
                        // Proceed with actual navigation
                        window.location.href = e.target.href;
                    }, 1500);
                });
            });
        });
    </script>
</body>
</html>