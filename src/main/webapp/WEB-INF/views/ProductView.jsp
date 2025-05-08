<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.util.*" %>
<%@ page import="com.aniket.ecommerce.entity.Product" %>
<%@ page import="java.util.Base64" %>
<%@ page import="java.util.stream.Collectors" %>

<%
    List<Product> allProducts = (List<Product>) request.getAttribute("products");
    Map<String, List<Product>> categoryMap = allProducts.stream()
        .collect(Collectors.groupingBy(Product::getCategory));
    request.setAttribute("categoryMap", categoryMap);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>All Products by Category</title>
<style>
    :root {
        --primary-color: #4361ee;
        --secondary-color: #3f37c9;
        --accent-color: #4cc9f0;
        --light-color: #f8f9fa;
        --dark-color: #212529;
        --success-color: #4bb543;
        --shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
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
    }
    
    .page-header {
        text-align: center;
        padding: 2rem 0;
        background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
        color: white;
        margin-bottom: 2rem;
        box-shadow: var(--shadow);
    }
    
    .page-header h1 {
        font-size: 2.5rem;
        font-weight: 700;
        letter-spacing: 1px;
    }
    
    .category-section {
        margin: 2rem auto;
        max-width: 1200px;
        padding: 0 1rem;
    }
    
    .category-header {
        display: flex;
        align-items: center;
        margin-bottom: 1.5rem;
        padding-bottom: 0.5rem;
        border-bottom: 2px solid var(--accent-color);
    }
    
    .category-title {
        font-size: 1.8rem;
        color: var(--secondary-color);
        margin-right: 1rem;
        font-weight: 600;
    }
    
    .product-count {
        background-color: var(--accent-color);
        color: white;
        padding: 0.2rem 0.8rem;
        border-radius: 20px;
        font-size: 0.9rem;
        font-weight: 500;
    }
    
    .product-grid {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(240px, 1fr));
        gap: 1.5rem;
        margin-bottom: 3rem;
    }
    
    .product-card {
        background: white;
        border-radius: 10px;
        overflow: hidden;
        box-shadow: var(--shadow);
        transition: var(--transition);
        position: relative;
    }
    
    .product-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 10px 20px rgba(0, 0, 0, 0.15);
    }
    
    .product-image-container {
        height: 180px;
        overflow: hidden;
        position: relative;
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
    
    .product-badge {
        position: absolute;
        top: 10px;
        right: 10px;
        background-color: var(--success-color);
        color: white;
        padding: 0.3rem 0.6rem;
        border-radius: 4px;
        font-size: 0.7rem;
        font-weight: bold;
    }
    
    .product-details {
        padding: 1.2rem;
    }
    
    .product-name {
        font-size: 1.1rem;
        font-weight: 600;
        margin-bottom: 0.5rem;
        color: var(--dark-color);
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
    }
    
    .product-description {
        color: #666;
        font-size: 0.9rem;
        margin-bottom: 0.8rem;
        display: -webkit-box;
        -webkit-line-clamp: 2;
        -webkit-box-orient: vertical;
        overflow: hidden;
    }
    
    .product-price {
        font-size: 1.3rem;
        font-weight: 700;
        color: var(--primary-color);
        margin-bottom: 0.5rem;
    }
    
    .product-id {
        font-size: 0.8rem;
        color: #888;
    }
    
    .product-actions {
        display: flex;
        justify-content: space-between;
        margin-top: 1rem;
    }
    
    .btn {
        padding: 0.5rem 1rem;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        font-weight: 500;
        transition: var(--transition);
    }
    
    .btn-primary {
        background-color: var(--primary-color);
        color: white;
        flex-grow: 1;
        margin-right: 0.5rem;
    }
    
    .btn-primary:hover {
        background-color: var(--secondary-color);
    }
    
    .btn-secondary {
        background-color: var(--light-color);
        color: var(--dark-color);
        border: 1px solid #ddd;
    }
    
    .btn-secondary:hover {
        background-color: #e9ecef;
    }
    
    @media (max-width: 768px) {
        .product-grid {
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
        }
        
        .page-header h1 {
            font-size: 2rem;
        }
        
        .category-title {
            font-size: 1.5rem;
        }
    }
</style>
</head>
<body>

<header class="page-header">
    <h1>Our Product Collection</h1>
</header>

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
                        <span class="product-badge">New</span>
                    </div>
                    <div class="product-details">
                        <h3 class="product-name" title="${product.productName}">
                            <c:out value="${product.productName}"/>
                        </h3>
                        <p class="product-description">
                            <c:out value="${product.productDescription}"/>
                        </p>
                        <div class="product-price">₹<c:out value="${product.productPrice}"/></div>
                        <div class="product-id">ID: <c:out value="${product.id}"/></div>
                        <div class="product-actions">
                            <button class="btn btn-primary">Add to Cart</button>
                            <button class="btn btn-secondary">
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" viewBox="0 0 16 16">
                                    <path d="m8 2.748-.717-.737C5.6.281 2.514.878 1.4 3.053c-.523 1.023-.641 2.5.314 4.385.92 1.815 2.834 3.989 6.286 6.357 3.452-2.368 5.365-4.542 6.286-6.357.955-1.886.838-3.362.314-4.385C13.486.878 10.4.28 8.717 2.01L8 2.748zM8 15C-7.333 4.868 3.279-3.04 7.824 1.143c.06.055.119.112.176.171a3.12 3.12 0 0 1 .176-.17C12.72-3.042 23.333 4.867 8 15z"/>
                                </svg>
                            </button>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </section>
</c:forEach>

</body>
</html>