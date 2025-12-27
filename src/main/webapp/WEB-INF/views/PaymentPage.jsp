<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Payment - ShopEase</title>
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
        
        /* Cards */
        .payment-card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
            overflow: hidden;
            transition: all 0.3s ease;
            background: white;
            margin-bottom: 2rem;
        }
        
        .payment-header {
            background: linear-gradient(135deg, var(--primary), var(--accent));
            color: white;
            padding: 1.5rem;
            border-bottom: none;
        }
        
        .payment-header h4 {
            margin: 0;
            font-weight: 700;
            font-size: 1.3rem;
        }
        
        /* Address Cards */
        .address-option {
            border: 2px solid #e1e5e9;
            border-radius: 10px;
            padding: 1.5rem;
            margin-bottom: 1rem;
            cursor: pointer;
            transition: all 0.3s ease;
            background: white;
            position: relative;
            overflow: hidden;
        }
        
        .address-option:hover {
            border-color: var(--accent);
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(52, 152, 219, 0.1);
        }
        
        .address-option.selected {
            border-color: var(--success);
            background: linear-gradient(to right, rgba(46, 204, 113, 0.05), rgba(46, 204, 113, 0.02));
            border-width: 3px;
        }
        
        .address-option.selected::before {
            content: '';
            position: absolute;
            left: 0;
            top: 0;
            bottom: 0;
            width: 4px;
            background: var(--success);
        }
        
        .address-type {
            background: linear-gradient(135deg, var(--accent), rgba(52, 152, 219, 0.1));
            color: var(--accent);
            padding: 0.3rem 0.8rem;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
            display: inline-block;
            margin-bottom: 0.5rem;
        }
        
        .address-details h6 {
            font-weight: 700;
            color: var(--primary);
            margin-bottom: 0.25rem;
        }
        
        .address-details p {
            color: #666;
            margin-bottom: 0.5rem;
            line-height: 1.4;
            font-size: 0.9rem;
        }
        
        /* Payment Method Cards */
        .payment-option {
            border: 2px solid #e1e5e9;
            border-radius: 10px;
            padding: 1.5rem;
            margin-bottom: 1rem;
            cursor: pointer;
            transition: all 0.3s ease;
            background: white;
            position: relative;
            overflow: hidden;
        }
        
        .payment-option:hover {
            border-color: var(--accent);
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(52, 152, 219, 0.1);
        }
        
        .payment-option.selected {
            border-color: var(--secondary);
            background: linear-gradient(to right, rgba(231, 76, 60, 0.05), rgba(231, 76, 60, 0.02));
            border-width: 3px;
        }
        
        .payment-option.selected::before {
            content: '';
            position: absolute;
            left: 0;
            top: 0;
            bottom: 0;
            width: 4px;
            background: var(--secondary);
        }
        
        .payment-icon {
            width: 50px;
            height: 50px;
            background: linear-gradient(135deg, var(--primary), rgba(42, 63, 84, 0.1));
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 1rem;
            color: var(--primary);
            font-size: 1.2rem;
        }
        
        .payment-method h6 {
            font-weight: 700;
            color: var(--primary);
            margin-bottom: 0.25rem;
        }
        
        .payment-method p {
            color: #666;
            font-size: 0.85rem;
            margin-bottom: 0;
        }
        
        /* Order Items */
        .order-item {
            padding: 1rem 0;
            border-bottom: 1px solid rgba(0,0,0,0.05);
            transition: all 0.3s ease;
        }
        
        .order-item:last-child {
            border-bottom: none;
        }
        
        .order-item:hover {
            background-color: rgba(52, 152, 219, 0.03);
        }
        
        .product-image {
            width: 70px;
            height: 70px;
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
        }
        
        .product-name {
            font-weight: 600;
            color: var(--primary);
            margin-bottom: 0.25rem;
            font-size: 0.95rem;
        }
        
        .product-quantity {
            color: #666;
            font-size: 0.85rem;
        }
        
        .product-price {
            font-weight: 700;
            color: var(--secondary);
            font-size: 1rem;
        }
        
        /* Summary Card */
        .summary-card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
            overflow: hidden;
            background: white;
            position: sticky;
            top: 20px;
        }
        
        .summary-header {
            background: linear-gradient(135deg, var(--primary), var(--accent));
            color: white;
            padding: 1.5rem;
            border-bottom: none;
        }
        
        .summary-body {
            padding: 1.5rem;
        }
        
        .summary-row {
            display: flex;
            justify-content: space-between;
            padding: 0.8rem 0;
            border-bottom: 1px solid rgba(0,0,0,0.05);
        }
        
        .summary-row:last-child {
            border-bottom: none;
        }
        
        .summary-total {
            font-size: 1.2rem;
            font-weight: 700;
            color: var(--primary);
        }
        
        .summary-value {
            font-weight: 600;
            color: var(--primary);
        }
        
        /* Buttons */
        .btn-add-address {
            background: rgba(42, 63, 84, 0.1);
            color: var(--primary);
            border: 2px solid rgba(42, 63, 84, 0.2);
            padding: 0.875rem 2rem;
            border-radius: 10px;
            font-weight: 600;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.3s ease;
        }
        
        .btn-add-address:hover {
            background: var(--primary);
            color: white;
            border-color: var(--primary);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(42, 63, 84, 0.2);
        }
        
        .btn-pay-now {
            background: linear-gradient(135deg, var(--success), #27ae60);
            color: white;
            border: none;
            padding: 1rem;
            border-radius: 10px;
            font-weight: 600;
            width: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            font-size: 1.1rem;
            transition: all 0.3s ease;
        }
        
        .btn-pay-now:hover {
            background: linear-gradient(135deg, #27ae60, var(--success));
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(46, 204, 113, 0.3);
        }
        
        /* Loading Overlay */
        .loading-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.7);
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            z-index: 9999;
            display: none;
            color: white;
        }
        
        .loading-spinner {
            width: 60px;
            height: 60px;
            border: 4px solid rgba(255,255,255,0.3);
            border-top: 4px solid white;
            border-radius: 50%;
            animation: spin 1s linear infinite;
            margin-bottom: 1rem;
        }
        
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
        
        /* Error Alert */
        .error-alert {
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 10000;
            min-width: 300px;
            border-radius: 10px;
            padding: 1rem;
            display: none;
            animation: slideIn 0.3s ease-out;
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }
        
        @keyframes slideIn {
            from { transform: translateX(100%); opacity: 0; }
            to { transform: translateX(0); opacity: 1; }
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
        
        /* Help Card */
        .help-card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
            background: white;
            margin-top: 1.5rem;
        }
        
        .help-content {
            padding: 1.5rem;
            text-align: center;
        }
        
        .help-contact {
            display: flex;
            justify-content: center;
            gap: 2rem;
            margin-top: 1rem;
        }
        
        .help-link {
            color: var(--accent);
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            transition: color 0.3s ease;
        }
        
        .help-link:hover {
            color: var(--primary);
            text-decoration: underline;
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
            
            .address-option, .payment-option {
                padding: 1rem;
            }
            
            .payment-icon {
                width: 40px;
                height: 40px;
                font-size: 1rem;
            }
            
            .help-contact {
                flex-direction: column;
                gap: 1rem;
            }
        }
        .product-price{
        text-align:center !important;
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
                        <a class="nav-link active" href="#">
                            <i class="fas fa-credit-card me-1"></i>Payment
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
                <i class="fas fa-credit-card me-2"></i>Complete Your Order
            </h1>
            <p class="lead mb-0 fade-in" style="animation-delay: 0.2s">
                Review your order details and proceed to payment
            </p>
        </div>
    </div>

    <!-- Loading Overlay -->
    <div class="loading-overlay" id="loadingOverlay">
        <div class="loading-spinner"></div>
        <p>Processing your payment...</p>
    </div>

    <!-- Error Alert -->
    <div class="error-alert alert alert-danger" role="alert" id="errorAlert">
        <div class="d-flex align-items-center">
            <i class="fas fa-exclamation-circle me-2"></i>
            <span id="errorMessage"></span>
        </div>
    </div>

    <!-- Main Content -->
    <div class="container py-4">
        <div class="row">
            <!-- Left Column -->
            <div class="col-lg-8">
                <!-- Shipping Address Section -->
                <div class="payment-card fade-in">
                    <div class="payment-header">
                        <h4>
                            <i class="fas fa-map-marker-alt me-2"></i>Shipping Address
                        </h4>
                    </div>
                    <div class="card-body">
                        <input type="hidden" id="selectedAddressId" name="selectedAddressId" value="">
                        
                        <c:if test="${not empty savedAddresses}">
                            <div class="row">
                                <c:forEach var="address" items="${savedAddresses}" varStatus="status">
                                    <div class="col-md-6 mb-3">
                                        <div class="address-option ${status.first ? 'selected' : ''}" 
                                             data-address-id="${address.id}">
                                            <div class="address-type">
                                                ${address.addressType} Address
                                            </div>
                                            <div class="address-details">
                                                <h6>${address.firstName} ${address.lastName}</h6>
                                                <p class="mb-1">${address.addressLine1}</p>
                                                <c:if test="${not empty address.addressLine2}">
                                                    <p class="mb-1">${address.addressLine2}</p>
                                                </c:if>
                                                <p class="mb-1">${address.city}, ${address.state} ${address.postalCode}</p>
                                                <p class="mb-1">${address.country}</p>
                                                <p class="mb-0"><i class="fas fa-phone me-1"></i>${address.phone}</p>
                                                <p class="mb-0"><i class="fas fa-envelope me-1"></i>${address.email}</p>
                                            </div>
                                            <input class="form-check-input" type="radio" name="selectedAddress" 
                                                   id="address${address.id}" value="${address.id}" 
                                                   ${status.first ? 'checked' : ''}
                                                   style="position: absolute; opacity: 0;">
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:if>
                        
                        <div class="text-center mt-3">
                            <a href="${pageContext.request.contextPath}/addressPage" class="btn-add-address">
                                <i class="fas fa-plus-circle me-2"></i>Add New Address
                            </a>
                        </div>
                    </div>
                </div>

                <!-- Payment Method Section -->
                <div class="payment-card fade-in" style="animation-delay: 0.1s">
                    <div class="payment-header">
                        <h4>
                            <i class="fas fa-credit-card me-2"></i>Payment Method
                        </h4>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <div class="payment-option selected" data-method="credit-card">
                                    <div class="payment-icon">
                                        <i class="fas fa-credit-card"></i>
                                    </div>
                                    <div class="payment-method">
                                        <h6>Credit/Debit Card</h6>
                                        <p>Pay securely with your card</p>
                                    </div>
                                    <input class="form-check-input" type="radio" name="paymentMethod" 
                                           id="creditCard" value="credit-card" checked
                                           style="position: absolute; opacity: 0;">
                                </div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <div class="payment-option" data-method="paypal">
                                    <div class="payment-icon">
                                        <i class="fab fa-paypal"></i>
                                    </div>
                                    <div class="payment-method">
                                        <h6>PayPal</h6>
                                        <p>Pay with your PayPal account</p>
                                    </div>
                                    <input class="form-check-input" type="radio" name="paymentMethod" 
                                           id="paypal" value="paypal"
                                           style="position: absolute; opacity: 0;">
                                </div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <div class="payment-option" data-method="cod">
                                    <div class="payment-icon">
                                        <i class="fas fa-money-bill-wave"></i>
                                    </div>
                                    <div class="payment-method">
                                        <h6>Cash on Delivery</h6>
                                        <p>Pay when you receive the order</p>
                                    </div>
                                    <input class="form-check-input" type="radio" name="paymentMethod" 
                                           id="cod" value="cod"
                                           style="position: absolute; opacity: 0;">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Order Items Section -->
                <div class="payment-card fade-in" style="animation-delay: 0.2s">
                    <div class="payment-header">
                        <h4>
                            <i class="fas fa-shopping-bag me-2"></i>Order Items
                        </h4>
                    </div>
                    <div class="card-body">
                        <c:if test="${not empty cartItems}">
                            <div class="list-group list-group-flush">
                                <c:set var="processedProductIds" value="" />
                                <c:forEach var="product" items="${cartItems}">
                                    <c:set var="alreadyProcessed" value="false" />
                                    <c:if test="${not empty processedProductIds}">
                                        <c:forTokens items="${processedProductIds}" delims="," var="processedId">
                                            <c:if test="${processedId eq product.id}">
                                                <c:set var="alreadyProcessed" value="true" />
                                            </c:if>
                                        </c:forTokens>
                                    </c:if>
                                    
                                    <c:if test="${not alreadyProcessed}">
                                        <c:set var="quantity" value="0" />
                                        <c:forEach var="item" items="${cartItems}">
                                            <c:if test="${item.id == product.id}">
                                                <c:set var="quantity" value="${quantity + 1}" />
                                            </c:if>
                                        </c:forEach>
                                        
                                        <div class="order-item">
                                            <div class="row align-items-center">
                                                <div class="col-2">
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
                                                <div class="col-7">
                                                    <h6 class="product-name">${product.productName}</h6>
                                                    <span class="product-quantity">Quantity: ${quantity}</span>
                                                </div>
                                                <div class="col-3 text-end">
                                                    <div class="product-price">
                                                        ₹<fmt:formatNumber value="${product.productPrice * quantity}" 
                                                                          type="number" maxFractionDigits="2"/>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <c:set var="processedProductIds" value="${processedProductIds},${product.id}" />
                                    </c:if>
                                </c:forEach>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>

            <!-- Right Column - Order Summary -->
            <div class="col-lg-4">
                <div class="summary-card fade-in" style="animation-delay: 0.3s">
                    <div class="summary-header">
                        <h5>Order Summary</h5>
                    </div>
                    <div class="summary-body">
                        <c:set var="totalPrice" value="0" />
                        <c:if test="${not empty cartItems}">
                            <c:set var="processedProductIds" value="" />
                            <c:forEach var="product" items="${cartItems}">
                                <c:set var="alreadyProcessed" value="false" />
                                <c:if test="${not empty processedProductIds}">
                                    <c:forTokens items="${processedProductIds}" delims="," var="processedId">
                                        <c:if test="${processedId eq product.id}">
                                            <c:set var="alreadyProcessed" value="true" />
                                        </c:if>
                                    </c:forTokens>
                                </c:if>
                                
                                <c:if test="${not alreadyProcessed}">
                                    <c:set var="quantity" value="0" />
                                    <c:forEach var="item" items="${cartItems}">
                                        <c:if test="${item.id == product.id}">
                                            <c:set var="quantity" value="${quantity + 1}" />
                                        </c:if>
                                    </c:forEach>
                                    <c:set var="totalPrice" value="${totalPrice + (product.productPrice * quantity)}" />
                                    <c:set var="processedProductIds" value="${processedProductIds},${product.id}" />
                                </c:if>
                            </c:forEach>
                        </c:if>

                        <div class="summary-row">
                            <span>Subtotal:</span>
                            <span class="summary-value">₹<fmt:formatNumber value="${totalPrice}" type="number" maxFractionDigits="2"/></span>
                        </div>
                        <div class="summary-row">
                            <span>Shipping:</span>
                            <span class="text-success">
                                <i class="fas fa-check-circle me-1"></i>FREE
                            </span>
                        </div>
                        <div class="summary-row">
                            <span>Tax (18%):</span>
                            <span class="summary-value">₹<fmt:formatNumber value="${totalPrice * 0.18}" type="number" maxFractionDigits="2"/></span>
                        </div>
                        <hr>
                        <div class="summary-row summary-total">
                            <span>Total:</span>
                            <span>₹<fmt:formatNumber value="${totalPrice * 1.18}" type="number" maxFractionDigits="2"/></span>
                        </div>
                        
                        <button type="button" id="payNowBtn" class="btn-pay-now mt-4">
                            <i class="fas fa-lock me-2"></i>Pay Now
                        </button>
                        
                        <div class="text-center mt-3">
                            <small class="text-muted">
                                <i class="fas fa-shield-alt me-1"></i>Secure SSL encryption
                            </small>
                        </div>
                    </div>
                </div>

                <!-- Help Card -->
                <div class="help-card fade-in" style="animation-delay: 0.4s">
                    <div class="help-content">
                        <h6>Need Help?</h6>
                        <p class="text-muted small mb-2">Contact our support team</p>
                        <div class="help-contact">
                            <a href="tel:+911234567890" class="help-link">
                                <i class="fas fa-phone-alt"></i>+91 1234567890
                            </a>
                            <a href="mailto:support@shopease.com" class="help-link">
                                <i class="fas fa-envelope"></i>support@shopease.com
                            </a>
                        </div>
                    </div>
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
    <!-- Razorpay Integration -->
    <script src="https://checkout.razorpay.com/v1/checkout.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Address selection
            const addressOptions = document.querySelectorAll('.address-option');
            addressOptions.forEach(option => {
                option.addEventListener('click', function() {
                    addressOptions.forEach(addr => addr.classList.remove('selected'));
                    this.classList.add('selected');
                    const radio = this.querySelector('input[type="radio"]');
                    if (radio) {
                        radio.checked = true;
                        document.getElementById('selectedAddressId').value = radio.value;
                    }
                });
            });

            // Payment method selection
            const paymentOptions = document.querySelectorAll('.payment-option');
            paymentOptions.forEach(option => {
                option.addEventListener('click', function() {
                    paymentOptions.forEach(pm => pm.classList.remove('selected'));
                    this.classList.add('selected');
                    const radio = this.querySelector('input[type="radio"]');
                    if (radio) {
                        radio.checked = true;
                    }
                });
            });

            // Set default selected address
            const defaultAddressRadio = document.querySelector('input[name="selectedAddress"]:checked');
            if (defaultAddressRadio) {
                document.getElementById('selectedAddressId').value = defaultAddressRadio.value;
            }

            // Show error alert
            function showError(message) {
                const errorAlert = document.getElementById('errorAlert');
                const errorMessage = document.getElementById('errorMessage');
                errorMessage.textContent = message;
                errorAlert.style.display = 'block';
                
                // Hide after 5 seconds
                setTimeout(() => {
                    errorAlert.style.display = 'none';
                }, 5000);
            }

            // Hide error alert on click
            document.getElementById('errorAlert').addEventListener('click', function() {
                this.style.display = 'none';
            });

            // Razorpay Payment Integration
            document.getElementById('payNowBtn').addEventListener('click', function() {
                const addressId = document.querySelector('input[name="selectedAddress"]:checked');
                const paymentMethod = document.querySelector('input[name="paymentMethod"]:checked');
                
                if (!addressId) {
                    showError('Please select a shipping address');
                    return false;
                }

                // Show loading overlay
                document.getElementById('loadingOverlay').style.display = 'flex';

                // Calculate total amount (including tax)
                const subtotal = ${totalPrice};
                const tax = subtotal * 0.18;
                const totalAmount = Math.round(subtotal + tax);

                // Create Razorpay order - using JSON format
                fetch('${pageContext.request.contextPath}/createOrder', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    body: JSON.stringify({
                        amount: totalAmount * 100,
                        currency: 'INR'
                    })
                })
                .then(response => {
                    if (!response.ok) {
                        // Handle 415 error specifically
                        if (response.status === 415) {
                            throw new Error('Unsupported media type. Please check server configuration.');
                        }
                        throw new Error('Server returned ' + response.status + ': ' + response.statusText);
                    }
                    return response.json();
                })
                .then(order => {
                    if (order.error) {
                        showError('Error creating order: ' + order.error);
                        document.getElementById('loadingOverlay').style.display = 'none';
                        return;
                    }

                    // Razorpay options
                    const options = {
                        key: 'rzp_test_AOkSkGp6YQkF2n', // Your Razorpay Key ID
                        amount: order.amount,
                        currency: order.currency,
                        name: 'ShopEase',
                        description: 'Order Payment',
                        order_id: order.id,
                        handler: function(response) {
                            // Verify payment on server
                            verifyPayment(response, addressId.value, paymentMethod.value);
                        },
                        prefill: {
                            name: '${user.name}',
                            email: '${user.email}',
                            contact: '${user.phone}'
                        },
                        notes: {
                            address: 'Customer address'
                        },
                        theme: {
                            color: '#2a3f54'
                        }
                    };

                    const rzp = new Razorpay(options);
                    rzp.open();
                    document.getElementById('loadingOverlay').style.display = 'none';
                })
                .catch(error => {
                    console.error('Error:', error);
                    showError(error.message);
                    document.getElementById('loadingOverlay').style.display = 'none';
                });
            });

            function verifyPayment(response, addressId, paymentMethod) {
                document.getElementById('loadingOverlay').style.display = 'flex';
                
                fetch('${pageContext.request.contextPath}/verifyPayment', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    body: JSON.stringify({
                        razorpay_order_id: response.razorpay_order_id,
                        razorpay_payment_id: response.razorpay_payment_id,
                        razorpay_signature: response.razorpay_signature
                    })
                })
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Server returned ' + response.status + ': ' + response.statusText);
                    }
                    return response.json();
                })
                .then(data => {
                    if (data.status === 'success') {
                        // Payment verified successfully, now process the order
                        processOrder(addressId, paymentMethod, response.razorpay_payment_id);
                    } else {
                        showError('Payment verification failed: ' + data.message);
                        document.getElementById('loadingOverlay').style.display = 'none';
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    showError('Error verifying payment: ' + error.message);
                    document.getElementById('loadingOverlay').style.display = 'none';
                });
            }

            function processOrder(addressId, paymentMethod, paymentId) {
                // Collect all product IDs from the cart
                const productIds = [];
                <c:forEach var="product" items="${cartItems}">
                    productIds.push(${product.id});
                </c:forEach>
                
                // Submit the form to process the order
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = '${pageContext.request.contextPath}/processPayment';
                
                const addressInput = document.createElement('input');
                addressInput.type = 'hidden';
                addressInput.name = 'addressId';
                addressInput.value = addressId;
                
                const paymentMethodInput = document.createElement('input');
                paymentMethodInput.type = 'hidden';
                paymentMethodInput.name = 'paymentMethod';
                paymentMethodInput.value = paymentMethod;
                
                const paymentIdInput = document.createElement('input');
                paymentIdInput.type = 'hidden';
                paymentIdInput.name = 'paymentId';
                paymentIdInput.value = paymentId;
                
                // Add product IDs as hidden inputs
                productIds.forEach((id, index) => {
                    const productInput = document.createElement('input');
                    productInput.type = 'hidden';
                    productInput.name = 'productIds';
                    productInput.value = id;
                    form.appendChild(productInput);
                });
                
                form.appendChild(addressInput);
                form.appendChild(paymentMethodInput);
                form.appendChild(paymentIdInput);
                
                document.body.appendChild(form);
                form.submit();
            }
            
            // Add click animation to buttons
            const buttons = document.querySelectorAll('.btn-add-address, .btn-pay-now');
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
        });
    </script>
</body>
</html>