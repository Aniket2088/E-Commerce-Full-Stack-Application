<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Your Shopping Cart</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .cart-item-card {
            transition: all 0.3s ease;
            border-left: 4px solid #0d6efd;
        }
        .cart-item-card:hover {
            box-shadow: 0 0.5rem 1rem rgba(0,0,0,0.1);
        }
        .product-img {
            max-height: 120px;
            object-fit: contain;
        }
        .quantity-input {
            width: 60px;
            text-align: center;
        }
        .empty-cart-icon {
            font-size: 5rem;
            opacity: 0.2;
        }
    </style>
</head>
<body class="bg-light">

<jsp:include page="NavBar.jsp" />

<div class="container py-5">
    <!-- Flash messages -->
    <c:if test="${not empty success}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            ${success}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    <c:if test="${not empty info}">
        <div class="alert alert-info alert-dismissible fade show" role="alert">
            ${info}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    
    <div class="row">
        <div class="col-lg-8">
            <div class="card shadow-sm mb-4">
                <div class="card-header bg-white border-bottom-0">
                    <h3 class="mb-0">
                        <i class="fas fa-shopping-cart me-2"></i>Your Cart
                        <span class="badge bg-primary rounded-pill ms-2">${not empty cartItems ? cartItems.size() : 0}</span>
                    </h3>
                </div>
                
                <c:choose>
                    <c:when test="${empty cartItems}">
                        <div class="card-body text-center py-5">
                            <div class="empty-cart-icon mb-3">
                                <i class="fas fa-cart-arrow-down"></i>
                            </div>
                            <h4 class="text-muted">Your cart is empty</h4>
                            <p class="text-muted">Start shopping to add items to your cart</p>
                            <a href="${pageContext.request.contextPath}/products" class="btn btn-primary mt-3">
                                <i class="fas fa-shopping-bag me-2"></i>Browse Products
                            </a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="card-body p-0">
                            <div class="list-group list-group-flush">
                                <c:set var="totalPrice" value="0" />
                                <c:forEach var="product" items="${cartItems}">
                                    <c:set var="subtotal" value="${product.productPrice}" />
                                    <c:set var="totalPrice" value="${totalPrice + subtotal}" />
                                    <div class="list-group-item p-3 cart-item-card">
                                        <div class="row align-items-center">
                                            <div class="col-md-2 text-center">
                                                <c:choose>
                                                    <c:when test="${product.hasImage()}">
                                                        <img src="data:image/jpeg;base64,${product.getBase64Image()}" 
                                                             alt="${product.productName}" 
                                                             class="img-fluid product-img">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div class="bg-light p-3 rounded">
                                                            <i class="fas fa-box-open fa-3x text-secondary"></i>
                                                        </div>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                            <div class="col-md-5">
                                                <h5 class="mb-1">${product.productName}</h5>
                                                <p class="text-muted small mb-2">${product.productDescription}</p>
                                                <span class="badge bg-info">${product.category}</span>
                                            </div>
                                            <div class="col-md-2">
                                                <div class="h5 mb-0">
                                                    ₹<fmt:formatNumber value="${product.productPrice}" type="number" maxFractionDigits="2"/>
                                                </div>
                                            </div>
                                            <div class="col-md-2">
                                                <form action="${pageContext.request.contextPath}/updateCartQuantity" method="post" class="d-flex align-items-center">
                                                    <input type="hidden" name="productId" value="${product.id}" />
                                                    <input type="number" name="quantity" value="1" 
                                                           class="form-control form-control-sm quantity-input" min="1"/>
                                                    <button class="btn btn-sm btn-outline-primary ms-2">
                                                        <i class="fas fa-sync-alt"></i>
                                                    </button>
                                                </form>
                                            </div>
                                            <div class="col-md-1 text-end">
                                                <a href="${pageContext.request.contextPath}/removeFromCart/${product.id}" 
                                                   class="btn btn-sm btn-outline-danger"
                                                   onclick="return confirm('Remove this item from your cart?')">
                                                    <i class="fas fa-trash-alt"></i>
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
            
            <div class="d-flex justify-content-between mb-4">
                <a href="${pageContext.request.contextPath}/products" class="btn btn-outline-secondary">
                    <i class="fas fa-chevron-left me-2"></i>Continue Shopping
                </a>
                <c:if test="${not empty cartItems}">
                    <a href="${pageContext.request.contextPath}/clearCart" class="btn btn-outline-danger">
                        <i class="fas fa-trash-alt me-2"></i>Clear Cart
                    </a>
                </c:if>
            </div>
        </div>
        
        <c:if test="${not empty cartItems}">
            <div class="col-lg-4">
                <div class="card shadow-sm">
                    <div class="card-header bg-white">
                        <h5 class="mb-0">Order Summary</h5>
                    </div>
                    <div class="card-body">
                        <div class="d-flex justify-content-between mb-2">
                            <span>Subtotal:</span>
                            <span>₹<fmt:formatNumber value="${totalPrice}" type="number" maxFractionDigits="2"/></span>
                        </div>
                        <div class="d-flex justify-content-between mb-2">
                            <span>Shipping:</span>
                            <span>FREE</span>
                        </div>
                        <hr>
                        <div class="d-flex justify-content-between mb-3">
                            <strong>Total:</strong>
                            <strong>₹<fmt:formatNumber value="${totalPrice}" type="number" maxFractionDigits="2"/></strong>
                        </div>
                        <a href="${pageContext.request.contextPath}/checkout" class="btn btn-primary w-100 py-2">
                            <i class="fas fa-credit-card me-2"></i>Proceed to Checkout
                        </a>
                    </div>
                </div>
            </div>
        </c:if>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Quantity input validation
    document.querySelectorAll('.quantity-input').forEach(input => {
        input.addEventListener('change', function() {
            if (this.value < 1) this.value = 1;
        });
    });
    
    // Auto-dismiss alerts after 5 seconds
    setTimeout(() => {
        const alerts = document.querySelectorAll('.alert');
        alerts.forEach(alert => {
            new bootstrap.Alert(alert).close();
        });
    }, 5000);
</script>

</body>
</html>