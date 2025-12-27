<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.Base64" %>
<%@ page import="java.util.*" %>
<%@ page import="com.aniket.ecommerce.entity.Product" %>

<%
    // Get products by category from request attribute
    Map<String, List<Product>> productsByCategory = 
        (Map<String, List<Product>>) request.getAttribute("productsByCategory");
    
    // Convert categories to list for easier access
    Set<String> categoriesSet = (Set<String>) request.getAttribute("categories");
    List<String> categoriesList = new ArrayList<>(categoriesSet != null ? categoriesSet : new HashSet<>());
    request.setAttribute("categoriesList", categoriesList);
%>

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
        
        /* Hero Section */
        .hero {
            background: linear-gradient(135deg, rgba(42, 63, 84, 0.9), rgba(52, 152, 219, 0.9)),
                        url('https://cdn.pixabay.com/photo/2017/08/30/12/45/board-2697950_1280.jpg');
            background-size: cover;
            background-position: center;
            color: white;
            padding: 8rem 0;
            position: relative;
            overflow: hidden;
        }
        
        .hero::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: radial-gradient(circle at 30% 50%, rgba(231, 76, 60, 0.3) 0%, transparent 50%);
        }
        
        .hero-title {
            font-size: 4rem;
            font-weight: 800;
            margin-bottom: 1.5rem;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
        }
        
        /* Category Navigation Tabs */
        .category-nav-container {
            background: white;
            border-radius: 15px;
            padding: 1rem;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
            margin-top: -50px;
            position: relative;
            z-index: 100;
        }
        
        .category-nav-scroll {
            display: flex;
            overflow-x: auto;
            gap: 0.5rem;
            padding-bottom: 0.5rem;
            scrollbar-width: thin;
        }
        
        .category-nav-scroll::-webkit-scrollbar {
            height: 6px;
        }
        
        .category-nav-scroll::-webkit-scrollbar-track {
            background: #f1f1f1;
            border-radius: 3px;
        }
        
        .category-nav-scroll::-webkit-scrollbar-thumb {
            background: var(--primary);
            border-radius: 3px;
        }
        
        .category-nav-item {
            flex: 0 0 auto;
            padding: 0.8rem 1.5rem;
            background: #f8f9fa;
            border: 2px solid transparent;
            border-radius: 30px;
            cursor: pointer;
            transition: all 0.3s ease;
            white-space: nowrap;
            font-weight: 600;
            color: var(--primary);
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .category-nav-item:hover {
            background: rgba(52, 152, 219, 0.1);
            transform: translateY(-2px);
        }
        
        .category-nav-item.active {
            background: var(--primary);
            color: white;
            border-color: var(--primary);
            box-shadow: 0 4px 12px rgba(42, 63, 84, 0.2);
        }
        
        /* Category Products Section */
        .category-products-section {
            padding: 3rem 0;
            scroll-margin-top: 100px; /* For smooth scrolling offset */
        }
        
        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
        }
        
        .section-title {
            font-size: 1.8rem;
            font-weight: 700;
            color: var(--primary);
            position: relative;
            padding-left: 1rem;
        }
        
        .section-title::before {
            content: '';
            position: absolute;
            left: 0;
            top: 0;
            bottom: 0;
            width: 4px;
            background: linear-gradient(to bottom, var(--secondary), var(--accent));
            border-radius: 2px;
        }
        
        .view-all-btn {
            color: var(--primary);
            font-weight: 600;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.3s ease;
        }
        
        .view-all-btn:hover {
            color: var(--accent);
            transform: translateX(5px);
        }
        
        /* Products Slider Container */
        .products-slider-container {
            position: relative;
        }
        
        .products-slider {
            display: flex;
            overflow-x: auto;
            gap: 1.5rem;
            padding: 1rem 0.5rem;
            scroll-behavior: smooth;
            scrollbar-width: none;
            -ms-overflow-style: none;
        }
        
        .products-slider::-webkit-scrollbar {
            display: none;
        }
        
        .slider-item {
            flex: 0 0 auto;
            width: 250px;
        }
        
        /* Product Cards */
        .product-card {
            border: none;
            border-radius: 12px;
            overflow: hidden;
            transition: all 0.3s ease;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
            background: white;
            height: 100%;
        }
        
        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 30px rgba(0,0,0,0.15);
        }
        
        .product-image-container {
            height: 200px;
            overflow: hidden;
            position: relative;
            background: #f8f9fa;
        }
        
        .product-image {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.5s ease;
        }
        
        .product-card:hover .product-image {
            transform: scale(1.05);
        }
        
        .product-badge {
            position: absolute;
            top: 10px;
            left: 10px;
            background: var(--secondary);
            color: white;
            padding: 0.3rem 0.8rem;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
        }
        
        .product-details {
            padding: 1.2rem;
        }
        
        .product-name {
            font-size: 1rem;
            font-weight: 600;
            color: var(--dark);
            margin-bottom: 0.5rem;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
            height: 2.5rem;
        }
        
        .product-price {
            font-size: 1.3rem;
            font-weight: 700;
            color: var(--secondary);
            margin-bottom: 1rem;
        }
        
        .add-to-cart-btn {
            width: 100%;
            background: linear-gradient(135deg, var(--primary), var(--accent));
            border: none;
            color: white;
            padding: 0.7rem;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }
        
        .add-to-cart-btn:hover {
            background: linear-gradient(135deg, var(--accent), var(--primary));
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(52, 152, 219, 0.3);
        }
        
        /* Slider Navigation Buttons */
        .slider-nav-btn {
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            width: 40px;
            height: 40px;
            background: white;
            border: none;
            border-radius: 50%;
            box-shadow: 0 3px 10px rgba(0,0,0,0.15);
            z-index: 10;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--primary);
            font-size: 1.2rem;
            cursor: pointer;
            opacity: 0;
            transition: all 0.3s ease;
        }
        
        .products-slider-container:hover .slider-nav-btn {
            opacity: 1;
        }
        
        .slider-nav-btn:hover {
            background: var(--primary);
            color: white;
            transform: translateY(-50%) scale(1.1);
            box-shadow: 0 5px 15px rgba(42, 63, 84, 0.3);
        }
        
        .slider-nav-btn.prev {
            left: -20px;
        }
        
        .slider-nav-btn.next {
            right: -20px;
        }
        
        /* Categories Grid */
        .categories-grid-section {
            padding: 5rem 0;
            background: white;
        }
        
        .grid-title {
            text-align: center;
            margin-bottom: 3rem;
        }
        
        .category-grid-card {
            border-radius: 12px;
            overflow: hidden;
            transition: all 0.3s ease;
            height: 100%;
            border: none;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
            cursor: pointer;
        }
        
        .category-grid-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 30px rgba(0,0,0,0.15);
        }
        
        .category-grid-icon {
            width: 70px;
            height: 70px;
            background: linear-gradient(135deg, var(--primary), var(--accent));
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1rem;
            color: white;
            font-size: 1.8rem;
        }
        
        /* Footer */
        .footer {
            background: linear-gradient(135deg, var(--primary), #1a2530);
            color: white;
            position: relative;
            overflow: hidden;
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
        
        .btn-primary {
            background: linear-gradient(135deg, var(--secondary), #ff6b6b);
            border: none;
            padding: 0.8rem 2rem;
            border-radius: 10px;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(231, 76, 60, 0.3);
        }
        
        .btn-outline-primary {
            color: var(--primary);
            border: 2px solid var(--primary);
            background: transparent;
            padding: 0.8rem 2rem;
            border-radius: 10px;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .btn-outline-primary:hover {
            background: var(--primary);
            color: white;
            transform: translateY(-2px);
        }
        
        /* Animations */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        .fade-in {
            animation: fadeIn 0.6s ease-out;
        }
        
        /* Highlight animation for category section */
        @keyframes highlight {
            0% { background-color: transparent; }
            50% { background-color: rgba(52, 152, 219, 0.1); }
            100% { background-color: transparent; }
        }
        
        .highlight-section {
            animation: highlight 2s ease-out;
            border-radius: 10px;
        }
        
        /* Responsive */
        @media (max-width: 768px) {
            .hero-title {
                font-size: 2.5rem;
            }
            
            .category-nav-item {
                padding: 0.6rem 1rem;
                font-size: 0.9rem;
            }
            
            .slider-item {
                width: 200px;
            }
            
            .product-image-container {
                height: 160px;
            }
            
            .slider-nav-btn {
                display: none;
            }
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-light sticky-top">
        <div class="container">
            <a class="navbar-brand" href="/homePage">
                <i class="fas fa-shopping-bag me-2"></i>ShopEase
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/homePage">
                            <i class="fas fa-home me-1"></i>Home
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/products">
                            <i class="fas fa-store me-1"></i>All Products
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#categories">Categories</a>
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
                                    <li><a class="dropdown-item" href="#">
                                        <i class="fas fa-heart me-2"></i>Wishlist</a></li>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/logout">
                                        <i class="fas fa-sign-out-alt me-2"></i>Logout</a></li>
                                </ul>
                            </div>
                            <a href="${pageContext.request.contextPath}/cartView" class="btn btn-primary ms-3 position-relative">
                                <i class="fas fa-shopping-cart"></i>
                                <c:if test="${cartCount > 0}">
                                    <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
                                        ${cartCount}
                                    </span>
                                </c:if>
                            </a>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/userLogin" class="btn btn-outline-primary me-2">
                                <i class="fas fa-sign-in-alt me-1"></i>Login
                            </a>
                            <a href="${pageContext.request.contextPath}/userSignUp" class="btn btn-primary">
                                <i class="fas fa-user-plus me-1"></i>Register
                            </a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="hero">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-6">
                    <h1 class="hero-title fade-in">Discover Amazing Products</h1>
                    <p class="lead mb-4 fade-in" style="animation-delay: 0.2s">
                        Shop the latest trends with exclusive discounts and premium quality products
                    </p>
                    <div class="d-flex gap-3 fade-in" style="animation-delay: 0.4s">
                        <a href="#categories" class="btn btn-light btn-lg px-4">
                            <i class="fas fa-shopping-bag me-2"></i>Browse Categories
                        </a>
                        <a href="${pageContext.request.contextPath}/products" class="btn btn-outline-light btn-lg px-4">
                            <i class="fas fa-store me-2"></i>All Products
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Category Navigation Tabs -->
    <c:if test="${not empty categoriesList}">
        <section class="container">
            <div class="category-nav-container">
                <div class="category-nav-scroll" id="categoryNav">
                    <c:forEach var="category" items="${categoriesList}" varStatus="status">
                        <div class="category-nav-item ${status.first ? 'active' : ''}" 
                             onclick="scrollToCategory('${category}', ${status.index})"
                             data-category="${category}"
                             data-index="${status.index}">
                            <i class="fas fa-${category == 'Electronics' ? 'laptop' : 
                                           category == 'Clothing' ? 'tshirt' : 
                                           category == 'Home' ? 'home' : 
                                           category == 'Books' ? 'book' : 
                                           category == 'Sports' ? 'futbol' : 
                                           category == 'Beauty' ? 'spa' :
                                           category == 'Toys' ? 'gamepad' :
                                           'shopping-bag'}"></i>
                            ${category}
                        </div>
                    </c:forEach>
                </div>
            </div>
        </section>
    </c:if>

    <!-- ALL Category Products Sections (ALL VISIBLE) -->
    <c:if test="${not empty productsByCategory}">
        <c:forEach var="category" items="${categoriesList}" varStatus="catStatus">
            <c:if test="${not empty productsByCategory[category] && productsByCategory[category].size() > 0}">
                <section class="category-products-section" id="category-section-${catStatus.index}">
                    <div class="container">
                        <div class="section-header">
                            <h2 class="section-title">${category}</h2>
                            <a href="${pageContext.request.contextPath}/products?category=${category}" class="view-all-btn">
                                View All <i class="fas fa-arrow-right"></i>
                            </a>
                        </div>
                        
                        <div class="products-slider-container">
                            <button class="slider-nav-btn prev" onclick="slideLeft(${catStatus.index})">
                                <i class="fas fa-chevron-left"></i>
                            </button>
                            
                            <div class="products-slider" id="slider-${catStatus.index}">
                                <c:forEach var="product" items="${productsByCategory[category]}">
                                    <div class="slider-item">
                                        <div class="product-card">
                                            <div class="product-image-container">
                                                <c:choose>
                                                    <c:when test="${not empty product.image}">
                                                        <img src="data:image/jpeg;base64,${Base64.getEncoder().encodeToString(product.image)}" 
                                                             class="product-image" alt="${product.productName}">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div class="product-image d-flex align-items-center justify-content-center">
                                                            <i class="fas fa-image fa-3x text-muted"></i>
                                                        </div>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                            <div class="product-details">
                                                <h3 class="product-name">${product.productName}</h3>
                                                <div class="product-price">₹${product.productPrice}</div>
                                                <form action="${pageContext.request.contextPath}/addToCart/${product.id}" method="post">
                                                    <button type="submit" class="add-to-cart-btn">
                                                        <i class="fas fa-cart-plus"></i> Add to Cart
                                                    </button>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                            
                            <button class="slider-nav-btn next" onclick="slideRight(${catStatus.index})">
                                <i class="fas fa-chevron-right"></i>
                            </button>
                        </div>
                    </div>
                </section>
            </c:if>
        </c:forEach>
    </c:if>

    <!-- Categories Grid Section -->
    <c:if test="${not empty categoriesList}">
        <section class="categories-grid-section" id="categories">
            <div class="container">
                <h2 class="section-title text-center grid-title">Shop by Category</h2>
                <div class="row">
                    <c:forEach var="category" items="${categoriesList}" varStatus="status">
                        <div class="col-lg-3 col-md-4 col-sm-6 mb-4">
                            <div class="category-grid-card">
                                <div class="card-body text-center p-4">
                                    <div class="category-grid-icon">
                                        <i class="fas fa-${category == 'Electronics' ? 'laptop' : 
                                                       category == 'Clothing' ? 'tshirt' : 
                                                       category == 'Home' ? 'home' : 
                                                       category == 'Books' ? 'book' : 
                                                       category == 'Sports' ? 'futbol' : 
                                                       category == 'Beauty' ? 'spa' :
                                                       category == 'Toys' ? 'gamepad' :
                                                       'shopping-bag'}"></i>
                                    </div>
                                    <h5 class="card-title">${category}</h5>
                                    <p class="text-muted">
                                        <c:choose>
                                            <c:when test="${not empty categoryProductsCount and not empty categoryProductsCount[category]}">
                                                ${categoryProductsCount[category]} products
                                            </c:when>
                                            <c:otherwise>
                                                <c:choose>
                                                    <c:when test="${not empty productsByCategory[category]}">
                                                        ${productsByCategory[category].size()} products
                                                    </c:when>
                                                    <c:otherwise>
                                                        0 products
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:otherwise>
                                        </c:choose>
                                    </p>
                                    <a href="${pageContext.request.contextPath}/products?category=${category}">
                                    <button class="btn btn-outline-primary btn-sm mt-2">
                                        Browse <i class="fas fa-arrow-right ms-1"></i>
                                    </button>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </section>
    </c:if>

    <!-- Footer -->
    <footer class="footer py-5">
        <div class="container position-relative">
            <div class="row g-4">
                <div class="col-lg-4">
                    <h4 class="text-white mb-4">
                        <i class="fas fa-shopping-bag me-2"></i>ShopEase
                    </h4>
                    <p class="text-light mb-4">
                        Your trusted destination for quality products and exceptional shopping experience.
                    </p>
                    <div class="social-icons">
                        <a href="#" class="btn btn-sm btn-light rounded-circle me-2">
                            <i class="fab fa-facebook-f"></i>
                        </a>
                        <a href="#" class="btn btn-sm btn-light rounded-circle me-2">
                            <i class="fab fa-twitter"></i>
                        </a>
                        <a href="#" class="btn btn-sm btn-light rounded-circle me-2">
                            <i class="fab fa-instagram"></i>
                        </a>
                        <a href="#" class="btn btn-sm btn-light rounded-circle">
                            <i class="fab fa-linkedin-in"></i>
                        </a>
                    </div>
                </div>
                
                <div class="col-lg-2 col-md-4">
                    <h5 class="text-white mb-4">Quick Links</h5>
                    <ul class="list-unstyled">
                        <li class="mb-2"><a href="#categories" class="text-light text-decoration-none">Categories</a></li>
                        <li class="mb-2"><a href="${pageContext.request.contextPath}/products" class="text-light text-decoration-none">All Products</a></li>
                        <li class="mb-2"><a href="#" class="text-light text-decoration-none">About Us</a></li>
                        <li class="mb-2"><a href="#" class="text-light text-decoration-none">Contact</a></li>
                    </ul>
                </div>
                
                <div class="col-lg-3 col-md-4">
                    <h5 class="text-white mb-4">Top Categories</h5>
                    <ul class="list-unstyled">
                        <c:forEach var="category" items="${categoriesList}" end="4" varStatus="status">
                            <li class="mb-2">
                                <a href="javascript:void(0)" onclick="scrollToCategoryByIndex(${status.index})" 
                                   class="text-light text-decoration-none">
                                    <i class="fas fa-chevron-right me-2"></i>${category}
                                </a>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
                
                <div class="col-lg-3 col-md-4">
                    <h5 class="text-white mb-4">Newsletter</h5>
                    <p class="text-light mb-3">Subscribe for exclusive offers</p>
                    <form class="subscribe-form">
                        <div class="input-group">
                            <input type="email" class="form-control" placeholder="Email address" required>
                            <button class="btn btn-light" type="submit">
                                <i class="fas fa-paper-plane"></i>
                            </button>
                        </div>
                    </form>
                </div>
            </div>
            
            <hr class="my-4 opacity-25">
            
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
        // Store categories array from JSP
        const categories = [
            <c:forEach var="category" items="${categoriesList}" varStatus="status">
                '${category}'<c:if test="${!status.last}">,</c:if>
            </c:forEach>
        ];
        
        // Map category names to indices
        const categoryIndices = {};
        categories.forEach((category, index) => {
            categoryIndices[category] = index;
        });
        
        document.addEventListener('DOMContentLoaded', function() {
            console.log('Page loaded with categories:', categories);
            
            // Initialize all sliders
            initializeSliders();
            
            // Add click animation to product cards
            document.querySelectorAll('.product-card').forEach(card => {
                card.addEventListener('click', function(e) {
                    if (!e.target.closest('.add-to-cart-btn') && !e.target.closest('form')) {
                        this.style.transform = 'scale(0.98)';
                        setTimeout(() => {
                            this.style.transform = '';
                        }, 200);
                    }
                });
            });
            
            // Initialize Intersection Observer for category navigation
            if (categories.length > 0) {
                initCategoryObserver();
            }
            
            // Check if there's a hash in URL for direct category navigation
            const hash = window.location.hash;
            if (hash && hash.startsWith('#category-')) {
                const index = parseInt(hash.replace('#category-', ''));
                if (!isNaN(index)) {
                    setTimeout(() => {
                        scrollToCategoryByIndex(index, true);
                    }, 500);
                }
            }
            
            // Test that functions are working
            console.log('JavaScript initialized successfully');
        });
        
        function scrollToCategory(categoryName, index) {
            console.log('Scrolling to category:', categoryName, 'Index:', index);
            scrollToCategoryByIndex(index);
        }
        
        function scrollToCategoryByIndex(index, fromHash = false) {
            console.log('Scrolling to category index:', index);
            
            // Get the section element
            const element = document.getElementById('category-section-' + index);
            if (element) {
                // Update URL hash
                if (!fromHash) {
                    window.history.pushState(null, '', '#category-' + index);
                }
                
                // Scroll to section with smooth behavior
                element.scrollIntoView({ 
                    behavior: 'smooth', 
                    block: 'start',
                    inline: 'nearest'
                });
                
                // Highlight the section
                element.classList.add('highlight-section');
                setTimeout(() => {
                    element.classList.remove('highlight-section');
                }, 2000);
                
                // Update active nav
                updateActiveNavByIndex(index);
                
                // Auto-scroll the product slider to start if it has content
                const slider = document.getElementById('slider-' + index);
                if (slider && slider.scrollWidth > slider.clientWidth) {
                    setTimeout(() => {
                        slider.scrollTo({ left: 0, behavior: 'smooth' });
                    }, 300);
                }
            }
        }
        
        function updateActiveNavByIndex(index) {
            console.log('Updating active nav for index:', index);
            // Remove active class from all nav items
            document.querySelectorAll('.category-nav-item').forEach(item => {
                item.classList.remove('active');
            });
            
            // Add active class to clicked category
            const activeNav = document.querySelector(`.category-nav-item[data-index="${index}"]`);
            if (activeNav) {
                activeNav.classList.add('active');
                
                // Scroll nav item into view
                activeNav.scrollIntoView({ 
                    behavior: 'smooth', 
                    inline: 'center', 
                    block: 'nearest' 
                });
            }
        }
        
        function slideLeft(index) {
            console.log('Sliding left for index:', index);
            const slider = document.getElementById('slider-' + index);
            if (!slider) {
                console.error('Slider not found for index:', index);
                return;
            }
            
            const scrollAmount = 600; // Width to scroll
            slider.scrollBy({ left: -scrollAmount, behavior: 'smooth' });
            console.log('Slider scrolled left');
        }
        
        function slideRight(index) {
            console.log('Sliding right for index:', index);
            const slider = document.getElementById('slider-' + index);
            if (!slider) {
                console.error('Slider not found for index:', index);
                return;
            }
            
            const scrollAmount = 600; // Width to scroll
            slider.scrollBy({ left: scrollAmount, behavior: 'smooth' });
            console.log('Slider scrolled right');
        }
        
        function initializeSliders() {
            console.log('Initializing sliders');
            // Initialize all sliders
            categories.forEach((category, index) => {
                initSlider(index);
            });
        }
        
        function initSlider(index) {
            const slider = document.getElementById('slider-' + index);
            if (!slider) {
                console.warn('Slider not found for index:', index);
                return;
            }
            
            // Add scroll event listeners to update button visibility
            slider.addEventListener('scroll', function() {
                updateSliderButtons(this, index);
            });
            
            // Initialize button visibility
            updateSliderButtons(slider, index);
            console.log('Slider initialized for index:', index);
        }
        
        function updateSliderButtons(slider, index) {
            const container = slider.closest('.products-slider-container');
            const prevBtn = container.querySelector('.slider-nav-btn.prev');
            const nextBtn = container.querySelector('.slider-nav-btn.next');
            
            if (!prevBtn || !nextBtn) {
                console.warn('Slider buttons not found for index:', index);
                return;
            }
            
            // Show/hide previous button
            if (slider.scrollLeft > 0) {
                prevBtn.style.display = 'flex';
            } else {
                prevBtn.style.display = 'none';
            }
            
            // Show/hide next button
            if (slider.scrollLeft < (slider.scrollWidth - slider.clientWidth - 1)) {
                nextBtn.style.display = 'flex';
            } else {
                nextBtn.style.display = 'none';
            }
        }
        
        function initCategoryObserver() {
            console.log('Initializing Intersection Observer');
            const observerOptions = {
                root: null,
                rootMargin: '-100px 0px -100px 0px', // Adjust margins for better detection
                threshold: 0.3
            };
            
            const observer = new IntersectionObserver((entries) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        const id = entry.target.id;
                        const index = parseInt(id.replace('category-section-', ''));
                        if (!isNaN(index)) {
                            updateActiveNavByIndex(index);
                            console.log('Category in view:', index);
                        }
                    }
                });
            }, observerOptions);
            
            // Observe all category sections
            categories.forEach((category, index) => {
                const section = document.getElementById('category-section-' + index);
                if (section) {
                    observer.observe(section);
                    console.log('Observing section:', index);
                }
            });
        }
        
        // Handle window resize
        window.addEventListener('resize', function() {
            console.log('Window resized, updating sliders');
            // Update all slider buttons
            categories.forEach((category, index) => {
                const slider = document.getElementById('slider-' + index);
                if (slider) {
                    updateSliderButtons(slider, index);
                }
            });
        });
        
        // Newsletter subscription
        document.querySelector('.subscribe-form')?.addEventListener('submit', function(e) {
            e.preventDefault();
            const email = this.querySelector('input[type="email"]').value;
            
            // Show success message
            alert('Thank you for subscribing! You will receive our updates at ' + email);
            this.reset();
        });
        
        // Handle browser back/forward buttons
        window.addEventListener('popstate', function(event) {
            const hash = window.location.hash;
            if (hash && hash.startsWith('#category-')) {
                const index = parseInt(hash.replace('#category-', ''));
                if (!isNaN(index)) {
                    scrollToCategoryByIndex(index, true);
                }
            }
        });
        
        // Debug: Log when functions are called
        console.log('All JavaScript functions defined');
    </script>
</body>
</html>