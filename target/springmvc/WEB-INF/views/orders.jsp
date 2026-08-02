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
        :root { --primary:#2a3f54; --secondary:#e74c3c; --accent:#3498db; --success:#2ecc71; --warning:#f39c12; }
        body { font-family:'Segoe UI',sans-serif; background-color:#f8f9fa; }
        .navbar { background-color:white; box-shadow:0 4px 12px rgba(0,0,0,0.08); padding:1rem 0; }
        .navbar-brand { font-weight:800; font-size:2rem; background:linear-gradient(135deg,var(--primary),var(--accent)); -webkit-background-clip:text; -webkit-text-fill-color:transparent; }
        .nav-link { font-weight:600; padding:0.5rem 1.5rem !important; border-radius:20px; transition:all 0.3s ease; }
        .nav-link:hover,.nav-link.active { background-color:rgba(42,63,84,0.1); color:var(--primary) !important; }
        .page-header { background:linear-gradient(135deg,rgba(42,63,84,0.9),rgba(52,152,219,0.9)); color:white; padding:3rem 0; margin-bottom:2rem; position:relative; overflow:hidden; }
        .page-title { font-size:2.5rem; font-weight:800; }

        /* Order card */
        .order-card { border:none; border-radius:15px; box-shadow:0 5px 20px rgba(0,0,0,0.08); background:white; margin-bottom:1.5rem; position:relative; overflow:hidden; transition:all 0.3s; }
        .order-card:hover { transform:translateY(-5px); box-shadow:0 15px 30px rgba(0,0,0,0.15); }
        .order-card::before { content:''; position:absolute; left:0; top:0; bottom:0; width:4px; background:linear-gradient(to bottom,var(--accent),var(--primary)); border-radius:2px 0 0 2px; }
        .order-header { background:linear-gradient(135deg,rgba(42,63,84,0.05),rgba(52,152,219,0.05)); padding:1.2rem 1.5rem; border-bottom:1px solid rgba(0,0,0,0.05); display:flex; justify-content:space-between; align-items:center; flex-wrap:wrap; gap:1rem; }
        .order-header h5 { font-weight:700; color:var(--primary); margin:0; }
        .order-header p { color:#666; margin:0; font-size:0.9rem; }
        .order-total-badge { font-weight:700; color:var(--secondary); font-size:1.1rem; }

        /* Status badges */
        .status-badge { padding:0.4rem 1rem; border-radius:20px; font-weight:600; font-size:0.82rem; display:inline-flex; align-items:center; gap:0.4rem; }
        .status-paid { background:rgba(46,204,113,0.12); color:var(--success); border:1px solid rgba(46,204,113,0.3); }
        .status-pending { background:rgba(243,156,18,0.12); color:var(--warning); border:1px solid rgba(243,156,18,0.3); }
        .status-failed { background:rgba(231,76,60,0.12); color:var(--secondary); border:1px solid rgba(231,76,60,0.3); }

        /* Product item row inside an order */
        .product-item { padding:1.2rem 1.5rem; border-bottom:1px solid rgba(0,0,0,0.05); transition:all 0.3s; }
        .product-item:last-child { border-bottom:none; }
        .product-item:hover { background-color:rgba(52,152,219,0.03); }
        .product-thumb { width:80px; height:80px; border-radius:8px; overflow:hidden; background:#f8f9fa; display:flex; align-items:center; justify-content:center; flex-shrink:0; }
        .product-thumb img { width:100%; height:100%; object-fit:cover; }
        .product-details h6 { font-weight:600; color:var(--primary); margin-bottom:0.2rem; }
        .product-category-badge { background:rgba(52,152,219,0.1); color:var(--accent); padding:0.2rem 0.6rem; border-radius:12px; font-size:0.75rem; font-weight:600; display:inline-block; }
        .item-qty { color:#666; font-size:0.9rem; }
        .item-price { font-weight:700; color:var(--secondary); font-size:1rem; }
        .item-subtotal { font-size:0.85rem; color:#888; }

        /* Empty state */
        .empty-state { padding:4rem 2rem; text-align:center; background:white; border-radius:15px; box-shadow:0 5px 20px rgba(0,0,0,0.08); }
        .empty-icon { font-size:5rem; color:rgba(42,63,84,0.2); margin-bottom:1.5rem; }
        .btn-start-shopping { background:linear-gradient(135deg,var(--primary),var(--accent)); color:white; border:none; padding:0.875rem 2rem; border-radius:10px; font-weight:600; display:inline-flex; align-items:center; gap:0.5rem; transition:all 0.3s; text-decoration:none; }
        .btn-start-shopping:hover { background:linear-gradient(135deg,var(--accent),var(--primary)); transform:translateY(-2px); color:white; }

        .footer { background:linear-gradient(135deg,var(--primary),#1a2530); color:white; margin-top:4rem; }
        @keyframes fadeIn { from{opacity:0;transform:translateY(20px);}to{opacity:1;transform:translateY(0);} }
        .fade-in { animation:fadeIn 0.6s ease-out; }
        @media(max-width:768px){ .page-title{font-size:2rem;} .order-header{flex-direction:column;align-items:flex-start;} }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-light sticky-top">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/homePage"><i class="fas fa-shopping-bag me-2"></i>ShopEase</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"><span class="navbar-toggler-icon"></span></button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/homePage"><i class="fas fa-home me-1"></i>Home</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/products"><i class="fas fa-store me-1"></i>All Products</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/cartView"><i class="fas fa-shopping-cart me-1"></i>Cart</a></li>
                <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/orders"><i class="fas fa-box me-1"></i>Orders</a></li>
            </ul>
            <div class="d-flex align-items-center">
                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <div class="dropdown">
                            <button class="btn btn-outline-primary dropdown-toggle d-flex align-items-center" type="button" data-bs-toggle="dropdown">
                                <i class="fas fa-user-circle me-2 fs-5"></i><span>${sessionScope.user.name}</span>
                            </button>
                            <ul class="dropdown-menu dropdown-menu-end">
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/orders"><i class="fas fa-box me-2"></i>Orders</a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt me-2"></i>Logout</a></li>
                            </ul>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/userLogin" class="btn btn-outline-primary me-2"><i class="fas fa-sign-in-alt me-1"></i>Login</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</nav>

<div class="page-header">
    <div class="container">
        <h1 class="page-title fade-in"><i class="fas fa-box me-2"></i>My Orders</h1>
        <p class="lead mb-0 fade-in">Track and manage your purchases</p>
    </div>
</div>

<div class="container py-4">
    <c:choose>
        <%-- ✅ NEW: model sends List<Order> named "orders" --%>
        <c:when test="${not empty orders}">
            <c:forEach var="order" items="${orders}" varStatus="orderStatus">

                <%-- Compute order total from its items --%>
                <c:set var="orderTotal" value="0"/>
                <c:forEach var="item" items="${order.orderItems}">
                    <c:set var="orderTotal" value="${orderTotal + (item.priceAtTime * item.quantity)}"/>
                </c:forEach>

                <div class="order-card fade-in" style="animation-delay:${orderStatus.index * 0.08}s">
                    <div class="order-header">
                        <div>
                            <h5>Order #${order.id}</h5>
                            <p>
                                <i class="fas fa-calendar-alt me-1"></i>
                                <fmt:formatDate value="${order.orderDate}" pattern="dd MMM yyyy, hh:mm a" type="both"/>
                                &nbsp;|&nbsp;
                                <strong>${order.orderItems.size()}</strong> item(s)
                            </p>
                        </div>
                        <div class="d-flex align-items-center gap-3">
                            <span class="order-total-badge">
                                ₹<fmt:formatNumber value="${orderTotal}" type="number" maxFractionDigits="2"/>
                            </span>
                            <c:choose>
                                <c:when test="${order.paymentStatus == 'PAID'}">
                                    <span class="status-badge status-paid"><i class="fas fa-check-circle"></i>Paid</span>
                                </c:when>
                                <c:when test="${order.paymentStatus == 'PENDING'}">
                                    <span class="status-badge status-pending"><i class="fas fa-clock"></i>Pending</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="status-badge status-failed"><i class="fas fa-times-circle"></i>${order.paymentStatus}</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                    <%-- ✅ Loop over OrderItems — each has .product, .quantity, .priceAtTime --%>
                    <c:forEach var="item" items="${order.orderItems}">
                        <div class="product-item">
                            <div class="d-flex gap-3 align-items-center">
                                <div class="product-thumb">
                                    <c:choose>
                                        <c:when test="${item.product.hasImage()}">
                                            <img src="${pageContext.request.contextPath}/uploads/products/${item.product.imagePath}" alt="${item.product.productName}">
                                        </c:when>
                                        <c:otherwise><i class="fas fa-box-open fa-2x text-secondary"></i></c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="flex-grow-1">
                                    <div class="d-flex justify-content-between align-items-start flex-wrap gap-2">
                                        <div>
                                            <h6 class="mb-1">${item.product.productName}</h6>
                                            <span class="product-category-badge">${item.product.category}</span>
                                            <p class="text-muted small mt-1 mb-0" style="max-width:400px">${item.product.productDescription}</p>
                                        </div>
                                        <div class="text-end">
                                            <%-- ✅ quantity directly from OrderItem.quantity --%>
                                            <div class="item-qty mb-1"><i class="fas fa-box me-1"></i>Qty: <strong>${item.quantity}</strong></div>
                                            <div class="item-price">₹<fmt:formatNumber value="${item.priceAtTime}" type="number" maxFractionDigits="2"/><span class="text-muted small ms-1">each</span></div>
                                            <div class="item-subtotal">Subtotal: ₹<fmt:formatNumber value="${item.priceAtTime * item.quantity}" type="number" maxFractionDigits="2"/></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>

            </c:forEach>
        </c:when>
        <c:otherwise>
            <div class="empty-state fade-in">
                <div class="empty-icon"><i class="fas fa-box-open"></i></div>
                <h4 class="mb-2" style="color:var(--primary)">No orders yet</h4>
                <p class="text-muted mb-4">You haven't placed any orders. Start shopping!</p>
                <a href="${pageContext.request.contextPath}/products" class="btn-start-shopping">
                    <i class="fas fa-shopping-bag me-2"></i>Browse Products
                </a>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<footer class="footer py-5">
    <div class="container">
        <div class="row">
            <div class="col-md-6"><p class="text-light mb-0">&copy; 2024 ShopEase. All rights reserved.</p></div>
            <div class="col-md-6 text-md-end">
                <a href="#" class="text-light me-3 text-decoration-none">Privacy Policy</a>
                <a href="#" class="text-light text-decoration-none">Terms of Service</a>
            </div>
        </div>
    </div>
</footer>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
