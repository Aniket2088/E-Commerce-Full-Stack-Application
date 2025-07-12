<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.util.*" %>
<%@ page import="com.aniket.ecommerce.entity.Product" %>
<%@ page import="java.util.Base64" %>
<%@ page import="java.util.stream.Collectors" %>

<%
    List<Product> allProducts = (List<Product>) request.getAttribute("products");
    Map<String, List<Product>> categoryMap = new HashMap<>();
    if (allProducts != null && !allProducts.isEmpty()) {
        categoryMap = allProducts.stream()
            .collect(Collectors.groupingBy(Product::getCategory));
    }
    request.setAttribute("categoryMap", categoryMap);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Product Collection</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<style>
    :root {
        --primary-color: #4361ee;
        --primary-dark: #3a0ca3;
        --secondary-color: #f72585;
        --light-color: #f8f9fa;
        --dark-color: #212529;
        --gray-color: #6c757d;
        --success-color: #4bb543;
        --danger-color: #dc3545;
        --border-radius: 8px;
        --box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        --transition: all 0.3s ease;
    }
    
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }
    
    body {
        background-color: #f5f7fa;
        color: var(--dark-color);
        line-height: 1.6;
        display: flex;
        flex-direction: column;
        min-height: 100vh;
    }
    
    /* Navigation Bar */
    .nav-bar {
        background: white;
        padding: 1rem 2rem;
        box-shadow: var(--box-shadow);
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    
    .nav-title {
        font-size: 1.5rem;
        font-weight: 700;
        color: var(--primary-color);
    }
    
    .nav-buttons {
        display: flex;
        gap: 1rem;
    }
    
    .nav-btn {
        padding: 0.5rem 1rem;
        border-radius: var(--border-radius);
        text-decoration: none;
        font-weight: 500;
        transition: var(--transition);
        display: flex;
        align-items: center;
        gap: 0.5rem;
    }
    
    .primary-btn {
        background: var(--primary-color);
        color: white;
        border: 2px solid var(--primary-color);
    }
    
    .primary-btn:hover {
        background: var(--primary-dark);
        border-color: var(--primary-dark);
    }
    
    .secondary-btn {
        background: white;
        color: var(--primary-color);
        border: 2px solid var(--primary-color);
    }
    
    .secondary-btn:hover {
        background: #f0f2f5;
    }
    
    .danger-btn {
        background: var(--danger-color);
        color: white;
        border: 2px solid var(--danger-color);
    }
    
    .danger-btn:hover {
        background: #c82333;
        border-color: #bd2130;
    }
    
    /* Main Content - Your Original Product Cards */
    .main-content {
        flex: 1;
        display: flex;
        flex-direction: column;
        align-items: center;
        padding: 2rem;
        width: 100%;
    }
    
    .page-header {
        text-align: center;
        margin-bottom: 2rem;
        max-width: 1200px;
        width: 100%;
    }
    
    .page-header h1 {
        font-size: 2.2rem;
        color: var(--primary-dark);
        margin-bottom: 0.5rem;
    }
    
    .products-container {
        max-width: 1200px;
        width: 100%;
    }
    
    .category-section {
        margin-bottom: 3rem;
    }
    
    .category-header {
        display: flex;
        align-items: center;
        margin-bottom: 1.5rem;
        padding-bottom: 0.5rem;
        border-bottom: 2px solid var(--primary-color);
    }
    
    .category-title {
        font-size: 1.5rem;
        color: var(--primary-dark);
        margin-right: 1rem;
    }
    
    .product-count {
        background: var(--primary-color);
        color: white;
        padding: 0.2rem 0.8rem;
        border-radius: 20px;
        font-size: 0.9rem;
    }
    
    .product-grid {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
        gap: 1.5rem;
    }
    
    .product-card {
        background: white;
        border-radius: var(--border-radius);
        overflow: hidden;
        box-shadow: var(--box-shadow);
        transition: var(--transition);
    }
    
    .product-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
    }
    
    .product-image-container {
        height: 180px;
        overflow: hidden;
    }
    
    .product-image {
        width: 100%;
        height: 100%;
        object-fit: cover;
        transition: var(--transition);
    }
    
    .product-card:hover .product-image {
        transform: scale(1.05);
    }
    
    .product-details {
        padding: 1.2rem;
    }
    
    .product-name {
        font-size: 1.1rem;
        font-weight: 600;
        margin-bottom: 0.5rem;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
    }
    
    .product-description {
        color: var(--gray-color);
        font-size: 0.9rem;
        margin-bottom: 0.8rem;
        display: -webkit-box;
        -webkit-line-clamp: 2;
        -webkit-box-orient: vertical;
        overflow: hidden;
    }
    
    .product-price {
        font-size: 1.2rem;
        font-weight: 700;
        color: var(--primary-color);
        margin-bottom: 0.5rem;
    }
    
    .product-actions {
        display: flex;
        gap: 0.5rem;
    }
    
    .action-btn {
        flex: 1;
        padding: 0.5rem;
        border: none;
        border-radius: var(--border-radius);
        cursor: pointer;
        font-weight: 500;
        transition: var(--transition);
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 0.3rem;
    }
    
    /* Footer */
    .footer {
        background: var(--dark-color);
        color: white;
        padding: 1.5rem;
        text-align: center;
    }
    
    .footer-links {
        display: flex;
        justify-content: center;
        gap: 1.5rem;
        margin-bottom: 1rem;
    }
    
    .footer-link {
        color: #aaa;
        text-decoration: none;
        transition: var(--transition);
    }
    
    .footer-link:hover {
        color: white;
    }
    
    .copyright {
        color: #777;
        font-size: 0.9rem;
    }
    
    @media (max-width: 768px) {
        .nav-bar {
            flex-direction: column;
            gap: 1rem;
            padding: 1rem;
        }
        
        .nav-buttons {
            width: 100%;
            justify-content: space-between;
        }
        
        .product-grid {
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
        }
    }
</style>
</head>
<body>

<!-- Navigation Bar -->
<nav class="nav-bar">
    <div class="nav-title">E-Commerce</div>
    
    <div class="nav-buttons">
        <c:choose>
            <c:when test="${not empty sessionScope.userId || not empty sessionScope.merchantId}">
                <form action="${pageContext.request.contextPath}/logout" method="get" style="display: contents;">
                    <button type="submit" class="nav-btn danger-btn">
                        <i class="fas fa-sign-out-alt"></i> Logout
                    </button>
                </form>
            </c:when>
            <c:otherwise>
                <a href="${pageContext.request.contextPath}/user/login" class="nav-btn primary-btn">
                    <i class="fas fa-user"></i> User Login
                </a>
                <a href="${pageContext.request.contextPath}/merchantLogin" class="nav-btn secondary-btn">
                    <i class="fas fa-store"></i> Merchant Login
                </a>
            </c:otherwise>
        </c:choose>
    </div>
</nav>

<!-- Main Content - Centered Product Cards -->
<main class="main-content">
    <div class="page-header">
        <h1>Our Product Collection</h1>
        <p>Browse through our wide selection of products</p>
    </div>
    
    <div class="products-container">
        <c:choose>
            <c:when test="${empty categoryMap}">
                <div style="text-align: center; padding: 2rem;">
                    <p>No products available at the moment.</p>
                </div>
            </c:when>
            <c:otherwise>
                <c:forEach var="entry" items="${categoryMap}">
                    <section class="category-section">
                        <div class="category-header">
                            <h2 class="category-title">${entry.key}</h2>
                            <span class="product-count">${entry.value.size()} items</span>
                        </div>
                        
                        <div class="product-grid">
                            <c:forEach var="product" items="${entry.value}">
                                <%
                                    Product p = (Product) pageContext.getAttribute("product");
                                    String base64Image = "";
                                    if (p.getImage() != null) {
                                        base64Image = Base64.getEncoder().encodeToString(p.getImage());
                                    }
                                %>
                                <div class="product-card">
                                    <div class="product-image-container">
                                        <img src="data:image/jpeg;base64,<%= base64Image %>" alt="${product.productName}" class="product-image"/>
                                    </div>
                                    <div class="product-details">
                                        <h3 class="product-name">${product.productName}</h3>
                                        <p class="product-description">${product.productDescription}</p>
                                        <div class="product-price">₹${product.productPrice}</div>
                                        <div class="product-actions">
                                            <button class="action-btn primary-btn">
                                                <i class="fas fa-cart-plus"></i> Add to Cart
                                            </button>
                                            <button class="action-btn secondary-btn">
                                                <i class="far fa-heart"></i>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </section>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>
</main>

<!-- Footer -->
<footer class="footer">
    <div class="footer-links">
        <a href="${pageContext.request.contextPath}/" class="footer-link">Home</a>
        <a href="${pageContext.request.contextPath}/products" class="footer-link">Products</a>
        <a href="${pageContext.request.contextPath}/about" class="footer-link">About</a>
        <a href="${pageContext.request.contextPath}/contact" class="footer-link">Contact</a>
    </div>
    <p class="copyright">&copy; 2023 E-Commerce Platform. All rights reserved.</p>
</footer>

</body>
</html>