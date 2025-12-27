<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Orders - ShopEase</title>
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
        
        /* Orders Container */
        .orders-container {
            padding: 2rem 0;
        }
        
        /* Order Card */
        .order-card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
            overflow: hidden;
            transition: all 0.3s ease;
            background: white;
            margin-bottom: 1.5rem;
            position: relative;
        }
        
        .order-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 30px rgba(0,0,0,0.15);
        }
        
        .order-card::before {
            content: '';
            position: absolute;
            left: 0;
            top: 0;
            bottom: 0;
            width: 4px;
            background: linear-gradient(to bottom, var(--accent), var(--primary));
            border-radius: 2px 0 0 2px;
        }
        
        /* Order Header */
        .order-header {
            background: linear-gradient(135deg, rgba(42, 63, 84, 0.05), rgba(52, 152, 219, 0.05));
            padding: 1.5rem;
            border-bottom: 1px solid rgba(0,0,0,0.05);
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 1rem;
        }
        
        .order-info h5 {
            font-weight: 700;
            color: var(--primary);
            margin-bottom: 0.25rem;
            font-size: 1.1rem;
        }
        
        .order-info p {
            color: #666;
            margin-bottom: 0;
            font-size: 0.9rem;
        }
        
        /* Status Badges */
        .status-badge {
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-weight: 600;
            font-size: 0.85rem;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .status-paid {
            background: linear-gradient(135deg, rgba(46, 204, 113, 0.1), rgba(46, 204, 113, 0.2));
            color: var(--success);
            border: 1px solid rgba(46, 204, 113, 0.3);
        }
        
        .status-pending {
            background: linear-gradient(135deg, rgba(243, 156, 18, 0.1), rgba(243, 156, 18, 0.2));
            color: var(--warning);
            border: 1px solid rgba(243, 156, 18, 0.3);
        }
        
        .status-delivered {
            background: linear-gradient(135deg, rgba(52, 152, 219, 0.1), rgba(52, 152, 219, 0.2));
            color: var(--accent);
            border: 1px solid rgba(52, 152, 219, 0.3);
        }
        
        .status-cancelled {
            background: linear-gradient(135deg, rgba(231, 76, 60, 0.1), rgba(231, 76, 60, 0.2));
            color: var(--secondary);
            border: 1px solid rgba(231, 76, 60, 0.3);
        }
        
        /* Product Item */
        .product-item {
            padding: 1.5rem;
            border-bottom: 1px solid rgba(0,0,0,0.05);
            transition: all 0.3s ease;
        }
        
        .product-item:last-child {
            border-bottom: none;
        }
        
        .product-item:hover {
            background-color: rgba(52, 152, 219, 0.03);
        }
        
        .product-image {
            width: 80px;
            height: 80px;
            border-radius: 8px;
            overflow: hidden;
            background: #f8f9fa;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .product-img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.3s ease;
        }
        
        .product-item:hover .product-img {
            transform: scale(1.05);
        }
        
        .product-details h6 {
            font-weight: 600;
            color: var(--primary);
            margin-bottom: 0.25rem;
            font-size: 1rem;
        }
        
        .product-description {
            color: #666;
            font-size: 0.85rem;
            line-height: 1.4;
            margin-bottom: 0.5rem;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }
        
        .product-category {
            background: linear-gradient(135deg, var(--accent), rgba(52, 152, 219, 0.1));
            color: var(--accent);
            padding: 0.2rem 0.6rem;
            border-radius: 12px;
            font-size: 0.75rem;
            font-weight: 600;
            display: inline-block;
        }
        
        .product-price {
            font-weight: 700;
            color: var(--secondary);
            font-size: 1.1rem;
            text-align: right;
        }
        
        .product-quantity {
            color: #666;
            font-size: 0.9rem;
            text-align: center;
        }
        
        /* Empty State */
        .empty-state {
            padding: 4rem 2rem;
            text-align: center;
            background: white;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
        }
        
        .empty-icon {
            font-size: 5rem;
            color: rgba(42, 63, 84, 0.2);
            margin-bottom: 1.5rem;
        }
        
        .empty-title {
            color: var(--primary);
            font-weight: 600;
            margin-bottom: 0.5rem;
        }
        
        .empty-text {
            color: #666;
            margin-bottom: 2rem;
            max-width: 400px;
            margin-left: auto;
            margin-right: auto;
        }
        
        .btn-start-shopping {
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
        
        .btn-start-shopping:hover {
            background: linear-gradient(135deg, var(--accent), var(--primary));
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(52, 152, 219, 0.3);
            color: white;
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
        
        /* Order Actions */
        .order-actions {
            padding: 1rem 1.5rem;
            background: rgba(42, 63, 84, 0.02);
            border-top: 1px solid rgba(0,0,0,0.05);
            display: flex;
            justify-content: flex-end;
            gap: 1rem;
        }
        
        .action-btn {
            background: none;
            border: 2px solid rgba(42, 63, 84, 0.2);
            color: var(--primary);
            padding: 0.5rem 1.2rem;
            border-radius: 8px;
            font-weight: 600;
            font-size: 0.9rem;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.3s ease;
            text-decoration: none;
        }
        
        .action-btn:hover {
            background: var(--primary);
            color: white;
            border-color: var(--primary);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(42, 63, 84, 0.2);
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
            
            .order-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 0.75rem;
            }
            
            .product-item {
                padding: 1rem;
            }
            
            .product-image {
                width: 60px;
                height: 60px;
                margin-bottom: 1rem;
            }
            
            .order-actions {
                flex-direction: column;
                gap: 0.5rem;
            }
            
            .action-btn {
                width: 100%;
                justify-content: center;
            }
        }
        
        /* Load More Button */
        .load-more {
            text-align: center;
            margin-top: 2rem;
        }
        
        .btn-load-more {
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
        }
        
        .btn-load-more:hover {
            background: var(--primary);
            color: white;
            border-color: var(--primary);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(42, 63, 84, 0.2);
        }
        
        /* Counter Animation */
        .count-animation {
            animation: countUp 1s ease-out;
        }
        
        @keyframes countUp {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
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

    <!-- Page Header -->
    <div class="page-header">
        <div class="container">
            <h1 class="page-title fade-in">
                <i class="fas fa-box me-2"></i>My Orders
            </h1>
            <p class="lead mb-0 fade-in" style="animation-delay: 0.2s">
                Track and manage your purchases
            </p>
        </div>
    </div>

    <!-- Orders Content -->
    <div class="container orders-container">
        <div class="row">
            <div class="col-12">
                <!-- Orders Count -->
                <div class="d-flex justify-content-between align-items-center mb-4 fade-in">
                    <h4 class="mb-0">
                        <c:choose>
                            <c:when test="${not empty purchasedProducts}">
                                ${purchasedProducts.size()} Order<c:if test="${purchasedProducts.size() != 1}">s</c:if>
                            </c:when>
                            <c:otherwise>
                                No Orders
                            </c:otherwise>
                        </c:choose>
                    </h4>
                </div>

                <c:choose>
                    <c:when test="${not empty purchasedProducts}">
                        <c:forEach var="product" items="${purchasedProducts}" varStatus="status">
                            <div class="order-card fade-in" style="animation-delay: ${status.index * 0.1}s">
                                <div class="order-header">
                                    <div class="order-info">
                                        <h5>Order #${product.id}</h5>
                                    </div>
                                    <span class="status-badge status-paid">
                                        <i class="fas fa-check-circle"></i> Paid
                                    </span>
                                </div>
                                
                                <div class="product-item">
                                    <div class="row align-items-center">
                                        <div class="col-md-2">
                                            <div class="product-image">
                                                <c:choose>
                                                    <c:when test="${product.hasImage()}">
                                                        <img src="data:image/jpeg;base64,${product.getBase64Image()}" 
                                                             alt="${product.productName}" 
                                                             class="product-img">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <i class="fas fa-box-open fa-2x text-secondary"></i>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                        <div class="col-md-5">
                                            <h6>${product.productName}</h6>
                                            <p class="product-description">${product.productDescription}</p>
                                            <span class="product-category">${product.category}</span>
                                        </div>
                                        <div class="col-md-3 text-center">
                                            <div class="product-quantity">
                                                <i class="fas fa-box me-1"></i>Quantity: 1
                                            </div>
                                        </div>
                                        <div class="col-md-2 text-end">
                                            <div class="product-price">
                                                ₹<fmt:formatNumber value="${product.productPrice}" type="number" maxFractionDigits="2"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="order-actions">
                                    <a href="#" class="action-btn">
                                        <i class="fas fa-eye me-1"></i>View Details
                                    </a>
                                    <a href="#" class="action-btn">
                                        <i class="fas fa-redo me-1"></i>Reorder
                                    </a>
                                    <a href="#" class="action-btn">
                                        <i class="fas fa-file-invoice me-1"></i>Invoice
                                    </a>
                                </div>
                            </div>
                        </c:forEach>
                        
                        <!-- Load More Button (for pagination) -->
                        <c:if test="${purchasedProducts.size() >= 5}">
                            <div class="load-more fade-in">
                                <button class="btn-load-more">
                                    <i class="fas fa-arrow-down me-2"></i>Load More Orders
                                </button>
                            </div>
                        </c:if>
                    </c:when>
                    <c:otherwise>
                        <!-- Empty State -->
                        <div class="empty-state fade-in">
                            <div class="empty-icon">
                                <i class="fas fa-shopping-bag"></i>
                            </div>
                            <h4 class="empty-title">No orders yet</h4>
                            <p class="empty-text">
                                You haven't placed any orders with us yet. Start shopping to discover amazing products!
                            </p>
                            <a href="${pageContext.request.contextPath}/homePage" class="btn-start-shopping">
                                <i class="fas fa-shopping-cart me-2"></i>Start Shopping
                            </a>
                        </div>
                    </c:otherwise>
                </c:choose>
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
            // Add hover effects to order cards
            const orderCards = document.querySelectorAll('.order-card');
            orderCards.forEach(card => {
                card.addEventListener('mouseenter', function() {
                    this.style.transform = 'translateY(-5px) scale(1.005)';
                });
                
                card.addEventListener('mouseleave', function() {
                    this.style.transform = 'translateY(0) scale(1)';
                });
            });
            
            // Add click animation to action buttons
            const actionBtns = document.querySelectorAll('.action-btn, .btn-start-shopping, .btn-load-more');
            actionBtns.forEach(btn => {
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
            
            // Load More functionality
            const loadMoreBtn = document.querySelector('.btn-load-more');
            if (loadMoreBtn) {
                loadMoreBtn.addEventListener('click', function() {
                    this.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Loading...';
                    this.disabled = true;
                    
                    // Simulate API call
                    setTimeout(() => {
                        this.innerHTML = '<i class="fas fa-arrow-down me-2"></i>No More Orders';
                        this.classList.add('disabled');
                        this.style.opacity = '0.6';
                        this.style.cursor = 'not-allowed';
                    }, 1500);
                });
            }
            
            // Add animation to order count
            const orderCount = document.querySelector('h4.mb-0');
            if (orderCount) {
                orderCount.classList.add('count-animation');
            }
            
            // Filter functionality (could be expanded)
            const filterButtons = document.createElement('div');
            filterButtons.className = 'btn-group mb-4 fade-in';
            filterButtons.style.animationDelay = '0.1s';
            filterButtons.innerHTML = `
                <button class="btn btn-outline-primary active">All</button>
                <button class="btn btn-outline-primary">Recent</button>
                <button class="btn btn-outline-primary">Pending</button>
                <button class="btn btn-outline-primary">Delivered</button>
            `;
            
            // Insert filter buttons after the order count
            const orderCountContainer = document.querySelector('.d-flex.justify-content-between');
            if (orderCountContainer && purchasedProducts && purchasedProducts.size() > 0) {
                orderCountContainer.appendChild(filterButtons);
                
                // Add filter functionality
                const filterBtns = filterButtons.querySelectorAll('button');
                filterBtns.forEach(btn => {
                    btn.addEventListener('click', function() {
                        filterBtns.forEach(b => b.classList.remove('active'));
                        this.classList.add('active');
                        
                        // Here you would typically filter orders via AJAX
                        // For now, just show a message
                        console.log('Filter: ' + this.textContent);
                    });
                });
            }
            
            // Add search functionality
            const searchContainer = document.createElement('div');
            searchContainer.className = 'input-group mb-4 fade-in';
            searchContainer.style.maxWidth = '300px';
            searchContainer.style.animationDelay = '0.2s';
            searchContainer.innerHTML = `
                <input type="text" class="form-control" placeholder="Search orders...">
                <button class="btn btn-primary" type="button">
                    <i class="fas fa-search"></i>
                </button>
            `;
            
            // Insert search container
            const ordersContainer = document.querySelector('.orders-container .row .col-12');
            if (ordersContainer && purchasedProducts && purchasedProducts.size() > 0) {
                const orderCountDiv = ordersContainer.querySelector('.d-flex.justify-content-between');
                if (orderCountDiv) {
                    orderCountDiv.parentNode.insertBefore(searchContainer, orderCountDiv.nextSibling);
                }
            }
        });
    </script>
</body>
</html>