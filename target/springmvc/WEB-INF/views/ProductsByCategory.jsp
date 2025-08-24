<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>
        <c:choose>
            <c:when test="${not empty selectedCategory}">
                ${selectedCategory} Products
            </c:when>
            <c:otherwise>
                All Products
            </c:otherwise>
        </c:choose>
    </title>
    <!-- Include Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
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
            padding-top: 72px;
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
            padding: 0.5rem 1rem;
        }
        
        .nav-item.active .nav-link {
            color: var(--secondary);
        }

        /* Search Bar */
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
            border-radius: 6px;
            border: 1px solid #ddd;
            font-size: 0.95rem;
            transition: all 0.3s;
        }
        
        .search-input:focus {
            outline: none;
            border-color: var(--accent);
            box-shadow: 0 0 0 2px rgba(52, 152, 219, 0.2);
        }
        
        .search-icon {
            position: absolute;
            right: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: #6c757d;
        }
        
        /* Products Section */
        .section-title {
            position: relative;
            padding-bottom: 15px;
            margin-bottom: 30px;
            font-weight: 600;
            color: var(--primary);
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
        
        /* Product Cards - Compact & Stylish */
        .product-card {
            border: 1px solid #dee2e6;
            border-radius: 10px;
            overflow: hidden;
            transition: all 0.3s ease;
            box-shadow: 0 2px 6px rgba(0,0,0,0.05);
            margin-bottom: 20px;
            background: white;
            height: 100%;
            display: flex;
            flex-direction: column;
            padding: 0.75rem;
        }

        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 18px rgba(0,0,0,0.12);
        }

        .product-img-container {
            height: 160px;
            overflow: hidden;
            background: #f1f3f5;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 8px;
        }

        .product-img {
            max-height: 100%;
            max-width: 100%;
            object-fit: contain;
            transition: transform 0.4s ease;
        }

        .product-card:hover .product-img {
            transform: scale(1.05);
        }

        .no-image {
            font-size: 2rem;
            color: #ced4da;
        }

        .card-body {
            padding: 0.75rem 0 0;
            flex-grow: 1;
            display: flex;
            flex-direction: column;
        }

        .category-badge {
            display: inline-block;
            background-color: var(--accent);
            color: white;
            padding: 0.2rem 0.5rem;
            border-radius: 3px;
            font-size: 0.7rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
        }

        .card-title {
            font-size: 0.95rem;
            font-weight: 600;
            margin-bottom: 0.25rem;
            color: var(--primary);
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .card-text {
            font-size: 0.8rem;
            color: #6c757d;
            line-height: 1.3;
            margin-bottom: 0.75rem;
            flex-grow: 1;
            overflow: hidden;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
        }

        .price-container {
            margin-top: auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .product-price {
            color: var(--secondary);
            font-weight: 700;
            font-size: 1rem;
        }

        .btn-cart {
            background-color: var(--secondary);
            border-color: var(--secondary);
            color: white;
            border-radius: 5px;
            font-size: 0.85rem;
            font-weight: 500;
            padding: 0.3rem 0.75rem;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
        }

        .btn-cart:hover {
            background-color: #c0392b;
            border-color: #c0392b;
            transform: translateY(-1px);
            box-shadow: 0 3px 6px rgba(233, 76, 60, 0.25);
        }

        .btn-cart i {
            margin-right: 6px;
        }

        /* No results message */
        .no-results {
            text-align: center;
            padding: 3rem;
            grid-column: 1 / -1;
            display: none;
        }
        
        /* Hidden class for search functionality */
        .hidden {
            display: none !important;
        }
        
        /* Footer */
        .footer {
            background-color: var(--primary);
            color: white;
            padding: 3rem 0 0;
        }
        
        .footer h4, .footer h5 {
            color: white;
            margin-bottom: 1.5rem;
        }
        
        .footer-links {
            list-style: none;
            padding: 0;
        }
        
        .footer-links a {
            color: rgba(255,255,255,0.7);
            text-decoration: none;
            transition: color 0.3s;
            display: block;
            margin-bottom: 0.5rem;
        }
        
        .footer-links a:hover {
            color: white;
        }
        
        .social-icons a {
            color: white;
            font-size: 1.2rem;
            margin-right: 1rem;
            transition: all 0.3s;
        }
        
        .social-icons a:hover {
            transform: translateY(-3px);
        }
        
        .copyright {
            border-top: 1px solid rgba(255,255,255,0.1);
            padding-top: 1.5rem;
            margin-top: 2rem;
        }
        
        /* Responsive adjustments */
        @media (max-width: 767.98px) {
            .navbar-collapse {
                padding-top: 1rem;
            }
            
            .search-container {
                order: -1;
                width: 100%;
                max-width: none;
                margin: 0.5rem 0 1rem;
            }
            
            .product-img-container {
                height: 160px;
            }
            
            .card-body {
                padding: 1rem;
            }
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-light fixed-top">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/homePage">ShopEase</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/homePage">Home</a>
                    </li>
                    <li class="nav-item active">
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
                
                <!-- Search Bar -->
                <div class="search-container">
                    <input type="text" id="searchInput" class="search-input" placeholder="Search products...">
                    <i class="fas fa-search search-icon"></i>
                </div>
                
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
                            <a href="${pageContext.request.contextPath}/cart" class="btn btn-primary ms-2">
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

    <!-- Products Section -->
    <section class="py-5">
        <div class="container">
            <h2 class="section-title text-center">
                <c:choose>
                    <c:when test="${not empty selectedCategory}">
                        ${selectedCategory} Collection
                    </c:when>
                    <c:otherwise>
                        Our Premium Products
                    </c:otherwise>
                </c:choose>
            </h2>
            
            <div class="row" id="productsContainer">
                <div class="no-results">
                    <i class="fas fa-search fa-2x mb-3" style="color: #6c757d;"></i>
                    <h4>No products found</h4>
                    <p class="text-muted">Try adjusting your search or filter to find what you're looking for.</p>
                </div>
                
                <c:choose>
                    <c:when test="${not empty products}">
                        <c:forEach var="product" items="${products}">
                            <div class="col-xl-3 col-lg-4 col-md-6 mb-4 product-item" 
                                 data-name="${product.productName.toLowerCase()}" 
                                 data-description="${product.productDescription.toLowerCase()}"
                                 data-category="${product.category.toLowerCase()}">
                                <div class="product-card">
                                    <div class="product-img-container">
                                        <c:choose>
                                            <c:when test="${product.hasImage()}">
                                                <img class="product-img" 
                                                     src="data:image/jpeg;base64,${product.base64Image}" 
                                                     alt="${product.productName}">
                                            </c:when>
                                            <c:otherwise>
                                                <div class="no-image">
                                                    <i class="fas fa-image"></i>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="card-body">
                                        <span class="category-badge">${product.category}</span>
                                        <h5 class="card-title">${product.productName}</h5>
                                        <p class="card-text">${product.productDescription}</p>
                                        <div class="price-container">
    <span class="product-price">${product.productPrice}</span>
    <form action="${pageContext.request.contextPath}/addToCart/${product.id}" method="post" style="margin:0;">
        <input type="hidden" name="productId" value="${product.id}">
        <input type="hidden" name="quantity" value="1">
        <button type="submit" class="btn btn-cart">
            <i class="fas fa-cart-plus"></i> Add
        </button>
    </form>
</div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="col-12 text-center py-5">
                            <div class="alert alert-info">
                                No products found
                                <c:if test="${not empty selectedCategory}">
                                    in category: ${selectedCategory}
                                </c:if>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </section>
    
    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <div class="row">
                <div class="col-lg-4 mb-4 mb-lg-0">
                    <h4 class="mb-4">ShopEase</h4>
                    <p>Your one-stop destination for all your shopping needs. Quality products at affordable prices.</p>
                    <div class="social-icons mt-3">
                        <a href="#"><i class="fab fa-facebook-f"></i></a>
                        <a href="#"><i class="fab fa-twitter"></i></a>
                        <a href="#"><i class="fab fa-instagram"></i></a>
                        <a href="#"><i class="fab fa-linkedin-in"></i></a>
                    </div>
                </div>
                <div class="col-lg-2 col-md-6 mb-4 mb-md-0">
                    <h5 class="mb-4">Quick Links</h5>
                    <ul class="footer-links">
                        <li><a href="${pageContext.request.contextPath}/">Home</a></li>
                        <li><a href="${pageContext.request.contextPath}/products">Products</a></li>
                        <li><a href="#">About Us</a></li>
                        <li><a href="#">Contact</a></li>
                    </ul>
                </div>
                <div class="col-lg-2 col-md-6 mb-4 mb-md-0">
                    <h5 class="mb-4">Categories</h5>
                    <ul class="footer-links">
                        <c:forEach var="category" items="${categories}">
                            <li><a href="${pageContext.request.contextPath}/products?category=${category}">${category}</a></li>
                        </c:forEach>
                    </ul>
                </div>
                <div class="col-lg-4">
                    <h5 class="mb-4">Newsletter</h5>
                    <p>Subscribe to get updates on new products and special offers</p>
                    <form class="mt-3">
                        <div class="input-group">
                            <input type="email" class="form-control" placeholder="Your email">
                            <button class="btn btn-light" type="submit">Subscribe</button>
                        </div>
                    </form>
                </div>
            </div>
            <div class="copyright text-center">
                <div class="row">
                    <div class="col-md-6 text-md-start">
                        <p class="mb-0">&copy; 2023 ShopEase. All rights reserved.</p>
                    </div>
                    <div class="col-md-6 text-md-end">
                        <a href="#" class="me-3">Privacy Policy</a>
                        <a href="#">Terms of Service</a>
                    </div>
                </div>
            </div>
        </div>
    </footer>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const searchInput = document.getElementById('searchInput');
            const productItems = document.querySelectorAll('.product-item');
            const noResultsMessage = document.querySelector('.no-results');
            
           
            // Search functionality
            searchInput.addEventListener('input', function() {
                const searchTerm = this.value.toLowerCase().trim();
                let hasResults = false;
                
                productItems.forEach(item => {
                    const name = item.dataset.name;
                    const description = item.dataset.description;
                    const category = item.dataset.category;
                    
                    if (searchTerm === '' || 
                        name.includes(searchTerm) || 
                        description.includes(searchTerm) || 
                        category.includes(searchTerm)) {
                        item.classList.remove('hidden');
                        hasResults = true;
                    } else {
                        item.classList.add('hidden');
                    }
                });
                
                // Show/hide no results message
                if (!hasResults && searchTerm !== '') {
                    noResultsMessage.style.display = 'block';
                } else {
                    noResultsMessage.style.display = 'none';
                }
            });
            
            // Focus on search input when '/' key is pressed
            document.addEventListener('keydown', function(e) {
                if (e.key === '/' && e.target.tagName !== 'INPUT' && e.target.tagName !== 'TEXTAREA') {
                    e.preventDefault();
                    searchInput.focus();
                }
            });
        });
    </script>
</body>
</html>