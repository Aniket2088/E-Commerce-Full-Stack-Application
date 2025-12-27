<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>
        <c:choose>
            <c:when test="${not empty selectedCategory}">
                ${selectedCategory} - ShopEase
            </c:when>
            <c:otherwise>
                All Products - ShopEase
            </c:otherwise>
        </c:choose>
    </title>
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
        
        /* Page Header */
        .page-header {
            background: linear-gradient(135deg, rgba(42, 63, 84, 0.9), rgba(52, 152, 219, 0.9));
            color: white;
            padding: 3rem 0;
            margin-bottom: 2rem;
            position: relative;
            overflow: hidden;
        }
        
        .page-header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: radial-gradient(circle at 70% 50%, rgba(231, 76, 60, 0.2) 0%, transparent 50%);
        }
        
        .page-title {
            font-size: 2.5rem;
            font-weight: 800;
            margin-bottom: 0.5rem;
        }
        
        /* Search Bar */
        .search-container {
            max-width: 500px;
            margin: 0 auto 2rem;
            position: relative;
        }
        
        .search-input {
            width: 100%;
            padding: 1rem 1.5rem;
            padding-right: 3rem;
            border: 2px solid #e1e5e9;
            border-radius: 12px;
            font-size: 1rem;
            transition: all 0.3s ease;
            background-color: white;
            box-shadow: 0 3px 10px rgba(0,0,0,0.05);
        }
        
        .search-input:focus {
            border-color: var(--accent);
            box-shadow: 0 0 0 0.25rem rgba(52, 152, 219, 0.15);
            outline: none;
        }
        
        .search-icon {
            position: absolute;
            right: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: var(--primary);
            font-size: 1.1rem;
        }
        
        /* Categories Filter */
        .categories-filter {
            display: flex;
            flex-wrap: wrap;
            gap: 0.75rem;
            justify-content: center;
            margin-bottom: 2rem;
            padding: 0 1rem;
        }
        
        .category-btn {
            background: rgba(42, 63, 84, 0.1);
            color: var(--primary);
            border: 2px solid rgba(42, 63, 84, 0.2);
            padding: 0.5rem 1.5rem;
            border-radius: 25px;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s ease;
            white-space: nowrap;
        }
        
        .category-btn:hover {
            background: var(--primary);
            color: white;
            border-color: var(--primary);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(42, 63, 84, 0.2);
        }
        
        .category-btn.active {
            background: linear-gradient(135deg, var(--primary), var(--accent));
            color: white;
            border-color: var(--primary);
            box-shadow: 0 5px 15px rgba(42, 63, 84, 0.2);
        }
        
        /* Products Grid */
        .products-grid {
            padding: 1rem 0;
        }
        
        /* Product Card */
        .product-card {
            border: none;
            border-radius: 15px;
            overflow: hidden;
            transition: all 0.3s ease;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
            background: white;
            height: 100%;
            display: flex;
            flex-direction: column;
            margin-bottom: 1.5rem;
        }
        
        .product-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 40px rgba(0,0,0,0.15);
        }
        
        .product-image-container {
            height: 220px;
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
            top: 12px;
            left: 12px;
            background: linear-gradient(135deg, var(--secondary), #ff6b6b);
            color: white;
            padding: 0.3rem 0.8rem;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
            z-index: 2;
        }
        
        .product-details {
            padding: 1.5rem;
            flex: 1;
            display: flex;
            flex-direction: column;
        }
        
        .product-category {
            background: linear-gradient(135deg, var(--accent), rgba(52, 152, 219, 0.1));
            color: var(--accent);
            padding: 0.3rem 0.8rem;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
            margin-bottom: 0.75rem;
            display: inline-block;
            align-self: flex-start;
        }
        
        .product-name {
            font-size: 1.1rem;
            font-weight: 700;
            color: var(--primary);
            margin-bottom: 0.5rem;
            line-height: 1.3;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
            flex: 1;
        }
        
        .product-description {
            color: #666;
            font-size: 0.9rem;
            line-height: 1.4;
            margin-bottom: 1rem;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
            flex: 1;
        }
        
        .product-price {
            font-size: 1.3rem;
            font-weight: 800;
            color: var(--secondary);
            margin-bottom: 1rem;
        }
        
        .add-to-cart-btn {
            width: 100%;
            background: linear-gradient(135deg, var(--primary), var(--accent));
            border: none;
            color: white;
            padding: 0.875rem;
            border-radius: 10px;
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
        
        /* No Results */
        .no-results {
            text-align: center;
            padding: 4rem 2rem;
            grid-column: 1 / -1;
        }
        
        .no-results-icon {
            font-size: 4rem;
            color: rgba(42, 63, 84, 0.2);
            margin-bottom: 1.5rem;
        }
        
        .no-results-title {
            color: var(--primary);
            font-weight: 600;
            margin-bottom: 0.5rem;
        }
        
        .no-results-text {
            color: #666;
            margin-bottom: 2rem;
            max-width: 400px;
            margin-left: auto;
            margin-right: auto;
        }
        
        /* Filters Sidebar */
        .filters-sidebar {
            position: sticky;
            top: 100px;
            background: white;
            border-radius: 15px;
            padding: 1.5rem;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
            margin-bottom: 2rem;
        }
        
        .filter-title {
            font-size: 1.1rem;
            font-weight: 700;
            color: var(--primary);
            margin-bottom: 1rem;
            padding-bottom: 0.5rem;
            border-bottom: 2px solid rgba(42, 63, 84, 0.1);
        }
        
        .filter-group {
            margin-bottom: 1.5rem;
        }
        
        .filter-item {
            display: flex;
            align-items: center;
            margin-bottom: 0.5rem;
            cursor: pointer;
            padding: 0.5rem;
            border-radius: 8px;
            transition: all 0.3s ease;
        }
        
        .filter-item:hover {
            background-color: rgba(52, 152, 219, 0.05);
        }
        
        .filter-item input {
            margin-right: 0.75rem;
            width: 18px;
            height: 18px;
            cursor: pointer;
        }
        
        .filter-item label {
            cursor: pointer;
            color: #555;
            font-size: 0.95rem;
            flex: 1;
        }
        
        .filter-count {
            background: rgba(42, 63, 84, 0.1);
            color: var(--primary);
            padding: 0.2rem 0.6rem;
            border-radius: 12px;
            font-size: 0.8rem;
            font-weight: 600;
        }
        
        /* Products Counter */
        .products-counter {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
            padding: 1rem;
            background: white;
            border-radius: 12px;
            box-shadow: 0 3px 10px rgba(0,0,0,0.05);
        }
        
        .sort-dropdown {
            background: rgba(42, 63, 84, 0.1);
            border: 2px solid rgba(42, 63, 84, 0.2);
            color: var(--primary);
            padding: 0.5rem 1rem;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .sort-dropdown:hover {
            background: var(--primary);
            color: white;
            border-color: var(--primary);
        }
        
        /* Pagination */
        .pagination-container {
            margin-top: 3rem;
        }
        
        .pagination .page-link {
            color: var(--primary);
            border: 2px solid rgba(42, 63, 84, 0.2);
            margin: 0 0.25rem;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .pagination .page-item.active .page-link {
            background: linear-gradient(135deg, var(--primary), var(--accent));
            border-color: var(--primary);
            color: white;
        }
        
        .pagination .page-link:hover {
            background: var(--primary);
            color: white;
            border-color: var(--primary);
        }
        
        /* Footer */
        .footer {
            background: linear-gradient(135deg, var(--primary), #1a2530);
            color: white;
            position: relative;
            overflow: hidden;
            margin-top: 4rem;
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
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        .fade-in {
            animation: fadeIn 0.6s ease-out;
        }
        
        /* Responsive */
        @media (max-width: 768px) {
            .page-title {
                font-size: 2rem;
            }
            
            .categories-filter {
                overflow-x: auto;
                padding-bottom: 0.5rem;
                justify-content: flex-start;
            }
            
            .category-btn {
                flex: 0 0 auto;
            }
            
            .product-image-container {
                height: 180px;
            }
            
            .product-details {
                padding: 1.25rem;
            }
            
            .filters-sidebar {
                position: static;
                margin-bottom: 2rem;
            }
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
                        <a class="nav-link active" href="${pageContext.request.contextPath}/products">
                            <i class="fas fa-store me-1"></i>All Products
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/cartView">
                            <i class="fas fa-shopping-cart me-1"></i>Cart
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/orders">
                            <i class="fas fa-box me-1"></i>Orders
                        </a>
                    </li>
                </ul>
                
                <!-- Search Bar -->
                <div class="search-container">
                    <input type="text" id="searchInput" class="search-input" placeholder="Search products...">
                    <i class="fas fa-search search-icon"></i>
                </div>
                
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
                            <a href="${pageContext.request.contextPath}/register" class="btn btn-primary">
                                <i class="fas fa-user-plus me-1"></i>Register
                            </a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </nav>

    <!-- Page Header -->
    <div class="page-header">
        <div class="container">
            <h1 class="page-title fade-in">
                <c:choose>
                    <c:when test="${not empty selectedCategory}">
                        <i class="fas fa-tag me-2"></i>${selectedCategory}
                    </c:when>
                    <c:otherwise>
                        <i class="fas fa-store me-2"></i>All Products
                    </c:otherwise>
                </c:choose>
            </h1>
            <p class="lead mb-0 fade-in" style="animation-delay: 0.2s">
                Discover amazing products at unbeatable prices
            </p>
        </div>
    </div>

    <!-- Main Content -->
    <div class="container py-4">
        <!-- Categories Filter -->
        <div class="categories-filter fade-in">
            <a href="${pageContext.request.contextPath}/products" 
               class="category-btn ${empty selectedCategory ? 'active' : ''}">
                <i class="fas fa-border-all me-2"></i>All Products
            </a>
            <c:forEach var="category" items="${categories}">
                <a href="${pageContext.request.contextPath}/products?category=${category}" 
                   class="category-btn ${selectedCategory eq category ? 'active' : ''}">
                    <c:choose>
                        <c:when test="${category == 'Electronics'}"><i class="fas fa-laptop me-2"></i></c:when>
                        <c:when test="${category == 'Clothing'}"><i class="fas fa-tshirt me-2"></i></c:when>
                        <c:when test="${category == 'Home'}"><i class="fas fa-home me-2"></i></c:when>
                        <c:when test="${category == 'Books'}"><i class="fas fa-book me-2"></i></c:when>
                        <c:when test="${category == 'Sports'}"><i class="fas fa-futbol me-2"></i></c:when>
                        <c:otherwise><i class="fas fa-shopping-bag me-2"></i></c:otherwise>
                    </c:choose>
                    ${category}
                </a>
            </c:forEach>
        </div>

        <!-- Products Counter -->
        <div class="products-counter fade-in" style="animation-delay: 0.1s">
            <div class="d-flex align-items-center">
                <span class="text-primary fw-bold">
                    <c:choose>
                        <c:when test="${not empty products}">
                            ${products.size()} Product<c:if test="${products.size() != 1}">s</c:if> 
                            <c:if test="${not empty selectedCategory}">in ${selectedCategory}</c:if>
                        </c:when>
                        <c:otherwise>
                            0 Products
                        </c:otherwise>
                    </c:choose>
                </span>
            </div>
            <div class="sort-dropdown">
                <i class="fas fa-sort me-2"></i>Sort By: Price
            </div>
        </div>

        <!-- Products Grid -->
        <div class="products-grid">
            <div id="productsContainer">
                <c:choose>
                    <c:when test="${not empty products}">
                        <div class="row">
                            <c:forEach var="product" items="${products}" varStatus="status">
                                <div class="col-xl-3 col-lg-4 col-md-6 product-item fade-in" 
                                     style="animation-delay: ${status.index * 0.05}s"
                                     data-name="${product.productName.toLowerCase()}" 
                                     data-description="${product.productDescription.toLowerCase()}"
                                     data-category="${product.category.toLowerCase()}">
                                    <div class="product-card">
                                        <div class="product-image-container">
                                            <c:choose>
                                                <c:when test="${product.hasImage()}">
                                                    <img src="data:image/jpeg;base64,${product.getBase64Image()}" 
                                                         class="product-image" alt="${product.productName}">
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="d-flex align-items-center justify-content-center h-100">
                                                        <i class="fas fa-image fa-3x text-muted"></i>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                            <c:if test="${product.productPrice < 50}">
                                                <span class="product-badge">Sale</span>
                                            </c:if>
                                        </div>
                                        <div class="product-details">
                                            <span class="product-category">${product.category}</span>
                                            <h3 class="product-name">${product.productName}</h3>
                                            <p class="product-description">${product.productDescription}</p>
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
                    </c:when>
                    <c:otherwise>
                        <div class="no-results fade-in">
                            <div class="no-results-icon">
                                <i class="fas fa-search"></i>
                            </div>
                            <h4 class="no-results-title">No products found</h4>
                            <p class="no-results-text">
                                <c:choose>
                                    <c:when test="${not empty selectedCategory}">
                                        No products found in category: ${selectedCategory}
                                    </c:when>
                                    <c:otherwise>
                                        No products available at the moment.
                                    </c:otherwise>
                                </c:choose>
                            </p>
                            <a href="${pageContext.request.contextPath}/products" class="btn btn-primary">
                                <i class="fas fa-sync-alt me-2"></i>Browse All Products
                            </a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
            
            <!-- No Results Message -->
            <div class="no-results" id="noResultsMessage" style="display: none;">
                <div class="no-results-icon">
                    <i class="fas fa-search"></i>
                </div>
                <h4 class="no-results-title">No matching products</h4>
                <p class="no-results-text">Try adjusting your search terms or browse all categories</p>
                <button class="btn btn-primary" onclick="clearSearch()">
                    <i class="fas fa-times me-2"></i>Clear Search
                </button>
            </div>
        </div>

        <!-- Pagination -->
        <c:if test="${not empty products and products.size() >= 12}">
            <div class="pagination-container fade-in">
                <nav aria-label="Page navigation">
                    <ul class="pagination justify-content-center">
                        <li class="page-item">
                            <a class="page-link" href="#" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                        <li class="page-item active"><a class="page-link" href="#">1</a></li>
                        <li class="page-item"><a class="page-link" href="#">2</a></li>
                        <li class="page-item"><a class="page-link" href="#">3</a></li>
                        <li class="page-item">
                            <a class="page-link" href="#" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                    </ul>
                </nav>
            </div>
        </c:if>
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
            const searchInput = document.getElementById('searchInput');
            const productItems = document.querySelectorAll('.product-item');
            const noResultsMessage = document.getElementById('noResultsMessage');
            const productsContainer = document.getElementById('productsContainer');
            const productsCounter = document.querySelector('.products-counter span');
            
            // Search functionality
            searchInput.addEventListener('input', function() {
                const searchTerm = this.value.toLowerCase().trim();
                let visibleCount = 0;
                
                productItems.forEach(item => {
                    const name = item.dataset.name;
                    const description = item.dataset.description;
                    const category = item.dataset.category;
                    
                    if (searchTerm === '' || 
                        name.includes(searchTerm) || 
                        description.includes(searchTerm) || 
                        category.includes(searchTerm)) {
                        item.style.display = 'block';
                        visibleCount++;
                    } else {
                        item.style.display = 'none';
                    }
                });
                
                // Show/hide no results message
                if (visibleCount === 0 && searchTerm !== '') {
                    noResultsMessage.style.display = 'block';
                    productsContainer.style.display = 'none';
                    productsCounter.textContent = '0 Products found';
                } else {
                    noResultsMessage.style.display = 'none';
                    productsContainer.style.display = 'block';
                    productsCounter.textContent = visibleCount + ' Product' + (visibleCount !== 1 ? 's' : '') + ' found';
                }
                
                // Add animation to visible items
                productItems.forEach((item, index) => {
                    if (item.style.display === 'block') {
                        item.style.animation = `fadeIn 0.5s ease-out ${index * 0.05}s both`;
                    }
                });
            });
            
            // Focus on search input when '/' key is pressed
            document.addEventListener('keydown', function(e) {
                if (e.key === '/' && e.target.tagName !== 'INPUT' && e.target.tagName !== 'TEXTAREA') {
                    e.preventDefault();
                    searchInput.focus();
                }
            });
            

            
            // Category filter animation
            document.querySelectorAll('.category-btn').forEach(btn => {
                btn.addEventListener('click', function(e) {
                    // Add loading state
                    document.querySelector('.products-grid').style.opacity = '0.7';
                    
                    // Remove active class from all buttons
                    document.querySelectorAll('.category-btn').forEach(b => b.classList.remove('active'));
                    
                    // Add active class to clicked button
                    this.classList.add('active');
                    
                    // Reset after navigation
                    setTimeout(() => {
                        document.querySelector('.products-grid').style.opacity = '1';
                    }, 300);
                });
            });
            
            // Product card hover effects
            document.querySelectorAll('.product-card').forEach(card => {
                card.addEventListener('mouseenter', function() {
                    this.style.transform = 'translateY(-10px) scale(1.02)';
                });
                
                card.addEventListener('mouseleave', function() {
                    this.style.transform = 'translateY(0) scale(1)';
                });
            });
            
            // Sort functionality
            const sortDropdown = document.querySelector('.sort-dropdown');
            if (sortDropdown) {
                sortDropdown.addEventListener('click', function() {
                    // Toggle sort options
                    alert('Sort functionality would be implemented here');
                });
            }
            
            function clearSearch() {
                searchInput.value = '';
                searchInput.dispatchEvent(new Event('input'));
                searchInput.focus();
            }
        });
    </script>
</body>
</html>