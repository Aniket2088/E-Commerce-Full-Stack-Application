<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Your Shopping Cart - ShopEase</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #2a3f54; --secondary: #e74c3c; --accent: #3498db;
            --success: #2ecc71; --warning: #f39c12;
        }
        body { font-family: 'Segoe UI', sans-serif; background-color: #f8f9fa; }
        .navbar { background-color: white; box-shadow: 0 4px 12px rgba(0,0,0,0.08); padding: 1rem 0; }
        .navbar-brand { font-weight: 800; font-size: 2rem; background: linear-gradient(135deg,var(--primary),var(--accent)); -webkit-background-clip: text; -webkit-text-fill-color: transparent; }
        .nav-link { font-weight: 600; padding: 0.5rem 1.5rem !important; border-radius: 20px; transition: all 0.3s ease; }
        .nav-link:hover, .nav-link.active { background-color: rgba(42,63,84,0.1); color: var(--primary) !important; }
        .page-header { background: linear-gradient(135deg,rgba(42,63,84,0.9),rgba(52,152,219,0.9)); color: white; padding: 3rem 0; margin-bottom: 2rem; position: relative; overflow: hidden; }
        .page-title { font-size: 2.5rem; font-weight: 800; }
        .cart-card { border: none; border-radius: 15px; box-shadow: 0 5px 20px rgba(0,0,0,0.08); background: white; margin-bottom: 2rem; overflow: hidden; }
        .cart-header { background: linear-gradient(135deg,var(--primary),var(--accent)); color: white; padding: 1.5rem; }
        .cart-badge { background: rgba(255,255,255,0.2); color: white; font-size: 0.9rem; padding: 0.4rem 0.8rem; border-radius: 20px; }
        .cart-item { padding: 1.5rem; border-bottom: 1px solid rgba(0,0,0,0.05); transition: all 0.3s ease; position: relative; }
        .cart-item:last-child { border-bottom: none; }
        .cart-item:hover { background-color: rgba(52,152,219,0.03); }
        .cart-item::before { content:''; position: absolute; left: 0; top: 0; bottom: 0; width: 4px; background: linear-gradient(to bottom,var(--secondary),var(--accent)); opacity: 0; transition: opacity 0.3s; }
        .cart-item:hover::before { opacity: 1; }
        .product-img-container { width: 120px; height: 120px; border-radius: 10px; overflow: hidden; background: #f8f9fa; display: flex; align-items: center; justify-content: center; }
        .product-img { width: 100%; height: 100%; object-fit: cover; transition: transform 0.3s; }
        .cart-item:hover .product-img { transform: scale(1.05); }
        .product-name { font-weight: 700; color: var(--primary); margin-bottom: 0.5rem; font-size: 1.1rem; }
        .product-description { color: #666; font-size: 0.9rem; margin-bottom: 0.5rem; }
        .product-category { background: linear-gradient(135deg,var(--accent),rgba(52,152,219,0.1)); color: var(--accent); padding: 0.3rem 0.8rem; border-radius: 20px; font-size: 0.8rem; font-weight: 600; display: inline-block; }
        .price-main { font-size: 1.3rem; font-weight: 700; color: var(--secondary); }
        .price-label { color: #888; font-size: 0.8rem; }
        .quantity-form { display: flex; align-items: center; gap: 0.5rem; }
        .quantity-input { width: 80px; padding: 0.5rem; border: 2px solid #e1e5e9; border-radius: 8px; text-align: center; font-weight: 600; transition: all 0.3s; background: #f8f9fa; }
        .quantity-input:focus { border-color: var(--accent); box-shadow: 0 0 0 0.25rem rgba(52,152,219,0.15); background: white; }
        .quantity-btn { background: linear-gradient(135deg,var(--primary),var(--accent)); color: white; border: none; width: 40px; height: 40px; border-radius: 8px; display: flex; align-items: center; justify-content: center; cursor: pointer; transition: all 0.3s; }
        .quantity-btn:hover { background: linear-gradient(135deg,var(--accent),var(--primary)); transform: translateY(-2px); }
        .subtotal { font-weight: 600; color: var(--primary); font-size: 1rem; margin-top: 0.5rem; }
        .remove-btn { background: rgba(231,76,60,0.1); color: var(--secondary); border: none; width: 40px; height: 40px; border-radius: 8px; display: flex; align-items: center; justify-content: center; cursor: pointer; transition: all 0.3s; text-decoration: none; }
        .remove-btn:hover { background: var(--secondary); color: white; transform: translateY(-2px); }
        .empty-cart { padding: 4rem 2rem; text-align: center; }
        .empty-cart-icon { font-size: 5rem; color: rgba(42,63,84,0.2); margin-bottom: 1.5rem; }
        .summary-card { border: none; border-radius: 15px; box-shadow: 0 5px 20px rgba(0,0,0,0.08); background: white; overflow: hidden; }
        .summary-header { background: linear-gradient(135deg,var(--primary),var(--accent)); color: white; padding: 1.5rem; }
        .summary-body { padding: 1.5rem; }
        .summary-row { display: flex; justify-content: space-between; padding: 0.8rem 0; border-bottom: 1px solid rgba(0,0,0,0.05); }
        .summary-row:last-child { border-bottom: none; }
        .summary-total { font-size: 1.2rem; font-weight: 700; color: var(--primary); }
        .summary-value { font-weight: 600; color: var(--primary); }
        .btn-continue { background: linear-gradient(135deg,var(--primary),var(--accent)); color: white; border: none; padding: 1rem 2rem; border-radius: 10px; font-weight: 600; text-decoration: none; display: inline-flex; align-items: center; gap: 0.5rem; transition: all 0.3s; }
        .btn-continue:hover { background: linear-gradient(135deg,var(--accent),var(--primary)); color: white; transform: translateY(-2px); box-shadow: 0 8px 20px rgba(52,152,219,0.3); }
        .btn-clear { background: rgba(231,76,60,0.1); color: var(--secondary); border: 2px solid rgba(231,76,60,0.2); padding: 1rem 2rem; border-radius: 10px; font-weight: 600; text-decoration: none; display: inline-flex; align-items: center; gap: 0.5rem; transition: all 0.3s; }
        .btn-clear:hover { background: var(--secondary); color: white; border-color: var(--secondary); transform: translateY(-2px); }
        .btn-checkout { background: linear-gradient(135deg,var(--secondary),#ff6b6b); color: white; border: none; padding: 1rem; border-radius: 10px; font-weight: 600; width: 100%; display: flex; align-items: center; justify-content: center; gap: 0.5rem; transition: all 0.3s; }
        .btn-checkout:hover { background: linear-gradient(135deg,#ff6b6b,var(--secondary)); transform: translateY(-2px); box-shadow: 0 8px 20px rgba(231,76,60,0.3); }
        .alert-success { background: rgba(46,204,113,0.1); border: 1px solid rgba(46,204,113,0.2); color: #27ae60; border-radius: 10px; border-left: 4px solid var(--success); }
        .alert-danger { background: rgba(231,76,60,0.1); border: 1px solid rgba(231,76,60,0.2); color: var(--secondary); border-radius: 10px; border-left: 4px solid var(--secondary); }
        .footer { background: linear-gradient(135deg,var(--primary),#1a2530); color: white; margin-top: 4rem; }
        @keyframes fadeIn { from { opacity:0; transform:translateY(20px); } to { opacity:1; transform:translateY(0); } }
        .fade-in { animation: fadeIn 0.6s ease-out; }
        @media (max-width: 768px) { .page-title { font-size: 2rem; } .product-img-container { width: 80px; height: 80px; } .btn-continue, .btn-clear { width: 100%; justify-content: center; margin-bottom: 0.5rem; } }
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
                <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/cartView"><i class="fas fa-shopping-cart me-1"></i>Cart</a></li>
            </ul>
            <div class="d-flex align-items-center">
                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <div class="dropdown">
                            <button class="btn btn-outline-primary dropdown-toggle d-flex align-items-center" type="button" id="userDropdown" data-bs-toggle="dropdown">
                                <i class="fas fa-user-circle me-2 fs-5"></i><span>${sessionScope.user.name}</span>
                            </button>
                            <ul class="dropdown-menu dropdown-menu-end">
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/orders"><i class="fas fa-box me-2"></i>Orders</a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt me-2"></i>Logout</a></li>
                            </ul>
                        </div>
                        <a href="${pageContext.request.contextPath}/cartView" class="btn btn-primary ms-3 position-relative">
                            <i class="fas fa-shopping-cart"></i>
                            <c:if test="${not empty cartItems}">
                                <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">${cartItems.size()}</span>
                            </c:if>
                        </a>
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
        <h1 class="page-title fade-in"><i class="fas fa-shopping-cart me-2"></i>Your Shopping Cart</h1>
        <p class="lead mb-0 fade-in">Review and manage your items</p>
    </div>
</div>

<div class="container py-4">
    <c:if test="${not empty success}"><div class="alert alert-success alert-dismissible fade show mb-4"><i class="fas fa-check-circle me-2"></i>${success}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div></c:if>
    <c:if test="${not empty error}"><div class="alert alert-danger alert-dismissible fade show mb-4"><i class="fas fa-exclamation-circle me-2"></i>${error}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div></c:if>

    <div class="row">
        <div class="col-lg-8 mb-4">
            <div class="cart-card fade-in">
                <div class="cart-header">
                    <div class="d-flex justify-content-between align-items-center">
                        <h3 class="mb-0">Your Cart</h3>
                        <span class="cart-badge"><i class="fas fa-box me-1"></i>${not empty cartItems ? cartItems.size() : 0} items</span>
                    </div>
                </div>

                <c:choose>
                    <c:when test="${empty cartItems}">
                        <div class="empty-cart">
                            <div class="empty-cart-icon"><i class="fas fa-cart-arrow-down"></i></div>
                            <h4 class="mb-2" style="color:var(--primary)">Your cart is empty</h4>
                            <p class="text-muted mb-4">Start shopping to add items to your cart</p>
                            <a href="${pageContext.request.contextPath}/products" class="btn-continue"><i class="fas fa-shopping-bag me-2"></i>Browse Products</a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <%-- ✅ cartItems is now List<CartItem> — each item has .quantity and .product --%>
                        <c:set var="totalPrice" value="0"/>
                        <c:forEach var="item" items="${cartItems}">
                            <c:set var="subtotal" value="${item.product.productPrice * item.quantity}"/>
                            <c:set var="totalPrice" value="${totalPrice + subtotal}"/>
                            <div class="cart-item">
                                <div class="row align-items-center">
                                    <div class="col-md-2 col-3">
                                        <div class="product-img-container">
                                            <c:choose>
                                                <c:when test="${item.product.hasImage()}">
                                                    <img src="${pageContext.request.contextPath}/uploads/products/${item.product.imagePath}" alt="${item.product.productName}" class="product-img">
                                                </c:when>
                                                <c:otherwise><i class="fas fa-box-open fa-3x text-secondary"></i></c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                    <div class="col-md-4 col-9">
                                        <h5 class="product-name">${item.product.productName}</h5>
                                        <p class="product-description">${item.product.productDescription}</p>
                                        <span class="product-category">${item.product.category}</span>
                                    </div>
                                    <div class="col-md-2 col-6 mt-3 mt-md-0 text-center">
                                        <div class="price-main">₹<fmt:formatNumber value="${item.product.productPrice}" type="number" maxFractionDigits="2"/></div>
                                        <div class="price-label">each</div>
                                    </div>
                                    <div class="col-md-3 col-6 mt-3 mt-md-0">
                                        <form action="${pageContext.request.contextPath}/updateCartQuantity" method="post" class="quantity-form">
                                            <input type="hidden" name="productId" value="${item.product.id}"/>
                                            <%-- ✅ quantity now comes directly from CartItem.quantity --%>
                                            <input type="number" name="quantity" value="${item.quantity}" class="quantity-input" min="1" onchange="this.form.submit()"/>
                                            <button type="submit" class="quantity-btn" title="Update"><i class="fas fa-sync-alt"></i></button>
                                        </form>
                                        <div class="subtotal">Subtotal: ₹<fmt:formatNumber value="${subtotal}" type="number" maxFractionDigits="2"/></div>
                                    </div>
                                    <div class="col-md-1 col-12 mt-3 mt-md-0 text-end">
                                        <a href="${pageContext.request.contextPath}/removeFromCart/${item.product.id}"
                                           class="remove-btn"
                                           onclick="return confirm('Remove this item from your cart?')"
                                           title="Remove">
                                            <i class="fas fa-trash-alt"></i>
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="d-flex flex-wrap gap-3 mb-4 fade-in">
                <a href="${pageContext.request.contextPath}/products" class="btn-continue"><i class="fas fa-chevron-left me-2"></i>Continue Shopping</a>
                <c:if test="${not empty cartItems}">
                    <a href="${pageContext.request.contextPath}/clear" class="btn-clear" onclick="return confirm('Clear entire cart?')"><i class="fas fa-trash-alt me-2"></i>Clear Cart</a>
                </c:if>
            </div>
        </div>

        <c:if test="${not empty cartItems}">
            <div class="col-lg-4">
                <div class="summary-card fade-in">
                    <div class="summary-header"><h5 class="mb-0">Order Summary</h5></div>
                    <div class="summary-body">
                        <div class="summary-row"><span>Subtotal:</span><span class="summary-value">₹<fmt:formatNumber value="${totalPrice}" type="number" maxFractionDigits="2"/></span></div>
                        <div class="summary-row"><span>Shipping:</span><span class="text-success"><i class="fas fa-check-circle me-1"></i>FREE</span></div>
                        <div class="summary-row"><span>Tax (18%):</span><span class="summary-value">₹<fmt:formatNumber value="${totalPrice * 0.18}" type="number" maxFractionDigits="2"/></span></div>
                        <hr>
                        <div class="summary-row summary-total"><span>Total:</span><span>₹<fmt:formatNumber value="${totalPrice * 1.18}" type="number" maxFractionDigits="2"/></span></div>
                        <a href="${pageContext.request.contextPath}/paymentPage" class="btn-checkout mt-4"><i class="fas fa-credit-card me-2"></i>Proceed to Checkout</a>
                        <div class="text-center mt-3"><small class="text-muted"><i class="fas fa-lock me-1"></i>Secure checkout</small></div>
                    </div>
                </div>
            </div>
        </c:if>
    </div>
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
<script>
    document.querySelectorAll('.quantity-input').forEach(input => {
        input.addEventListener('change', function() { if (this.value < 1) this.value = 1; });
    });
    setTimeout(() => {
        document.querySelectorAll('.alert').forEach(alert => { try { new bootstrap.Alert(alert).close(); } catch(e){} });
    }, 5000);
</script>
</body>
</html>
