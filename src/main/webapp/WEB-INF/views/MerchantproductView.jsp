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
        align-items: center;
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
    
    /* Search Bar Styles */
    .search-container {
        flex: 1;
        max-width: 400px;
        margin: 0 1rem;
        position: relative;
    }
    
    .search-input {
        width: 100%;
        padding: 0.5rem 1rem;
        padding-right: 2.5rem;
        border-radius: var(--border-radius);
        border: 1px solid #ddd;
        font-size: 0.95rem;
        transition: var(--transition);
    }
    
    .search-input:focus {
        outline: none;
        border-color: var(--primary-color);
        box-shadow: 0 0 0 2px rgba(67, 97, 238, 0.2);
    }
    
    .search-icon {
        position: absolute;
        right: 1rem;
        top: 50%;
        transform: translateY(-50%);
        color: var(--gray-color);
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
    
    /* Search Results Styles */
    .no-results {
        text-align: center;
        padding: 2rem;
        grid-column: 1 / -1;
    }
    
    .hidden {
        display: none !important;
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
        
        .search-container {
            order: -1;
            width: 100%;
            max-width: none;
            margin: 0.5rem 0;
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
    
    <!-- Search Bar -->
    <div class="search-container">
        <input type="text" id="searchInput" class="search-input" placeholder="Search products...">
        <i class="fas fa-search search-icon"></i>
    </div>
    
    <div class="nav-buttons">
        <c:choose>
            <c:when test="${not empty sessionScope.userId || not empty sessionScope.merchantId}">
                <form action="${pageContext.request.contextPath}/logoutMerchant" method="get" style="display: contents;">
                    <button type="submit" class="nav-btn danger-btn">
                        <i class="fas fa-sign-out-alt"></i> Logout
                    </button>
                </form>
                <form action="${pageContext.request.contextPath}/AddProduct" method="get" style="display: contents;">
                    <button type="submit" class="nav-btn danger-btn">
                        <i class="fas fa-sign-out-alt"></i> AddProduct
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
    
    <div class="products-container" id="productsContainer">
        <c:choose>
            <c:when test="${empty categoryMap}">
                <div style="text-align: center; padding: 2rem;">
                    <p>No products available at the moment.</p>
                </div>
            </c:when>
            <c:otherwise>
                <c:forEach var="entry" items="${categoryMap}">
                    <section class="category-section" data-category="${entry.key}">
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
                                <div class="product-card" 
                                     data-name="${product.productName.toLowerCase()}" 
                                     data-description="${product.productDescription.toLowerCase()}"
                                     data-category="${product.category.toLowerCase()}">
                                    <div class="product-image-container">
                                        <img src="data:image/jpeg;base64,<%= base64Image %>" alt="${product.productName}" class="product-image"/>
                                    </div>
                                    <div class="product-details">
                                        <h3 class="product-name">${product.productName}</h3>
                                        <p class="product-description">${product.productDescription}</p>
                                        <div class="product-price">₹${product.productPrice}</div>
                                       
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

<script>
document.addEventListener('DOMContentLoaded', function() {
    const searchInput = document.getElementById('searchInput');
    const productCards = document.querySelectorAll('.product-card');
    const categorySections = document.querySelectorAll('.category-section');
    
    // Add data attributes to all product cards for searching
    productCards.forEach(card => {
        const name = card.querySelector('.product-name').textContent.toLowerCase();
        const description = card.querySelector('.product-description').textContent.toLowerCase();
        const category = card.closest('.category-section').dataset.category.toLowerCase();
        
        card.dataset.name = name;
        card.dataset.description = description;
        card.dataset.category = category;
    });
    
    // Search functionality
    searchInput.addEventListener('input', function() {
        const searchTerm = this.value.toLowerCase().trim();
        
        if (searchTerm === '') {
            // Show all products and categories when search is empty
            categorySections.forEach(section => {
                section.classList.remove('hidden');
                const productsInSection = section.querySelectorAll('.product-card');
                productsInSection.forEach(product => product.classList.remove('hidden'));
                
                // Update product count
                const visibleCount = section.querySelectorAll('.product-card:not(.hidden)').length;
                section.querySelector('.product-count').textContent = `${visibleCount} items`;
            });
            return;
        }
        
        let anyProductsFound = false;
        
        // Search through each category section
        categorySections.forEach(section => {
            const productsInSection = section.querySelectorAll('.product-card');
            let categoryHasVisibleProducts = false;
            
            productsInSection.forEach(product => {
                const name = product.dataset.name;
                const description = product.dataset.description;
                const category = product.dataset.category;
                
                if (name.includes(searchTerm) || 
                    description.includes(searchTerm) || 
                    category.includes(searchTerm)) {
                    product.classList.remove('hidden');
                    categoryHasVisibleProducts = true;
                    anyProductsFound = true;
                } else {
                    product.classList.add('hidden');
                }
            });
            
            // Show/hide the entire category section based on whether it has visible products
            if (categoryHasVisibleProducts) {
                section.classList.remove('hidden');
                
                // Update product count
                const visibleCount = section.querySelectorAll('.product-card:not(.hidden)').length;
                section.querySelector('.product-count').textContent = `${visibleCount} items`;
            } else {
                section.classList.add('hidden');
            }
        });
        
        // Show "no results" message if no products match the search
        const noResultsElement = document.querySelector('.no-results');
        if (!anyProductsFound) {
            if (!noResultsElement) {
                const noResultsDiv = document.createElement('div');
                noResultsDiv.className = 'no-results';
                noResultsDiv.innerHTML = '<p>No products found matching your search.</p>';
                document.getElementById('productsContainer').appendChild(noResultsDiv);
            }
        } else if (noResultsElement) {
            noResultsElement.remove();
        }
    });
});
</script>

</body>
</html>