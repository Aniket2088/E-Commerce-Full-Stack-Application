<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Orders - ShopEasy</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .order-card {
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            margin-bottom: 20px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }
        .order-header {
            background-color: #f8f9fa;
            padding: 15px 20px;
            border-bottom: 1px solid #e0e0e0;
            border-radius: 8px 8px 0 0;
        }
        .product-img {
            max-height: 80px;
            object-fit: contain;
        }
        .empty-state {
            text-align: center;
            padding: 60px 20px;
        }
        .empty-state i {
            font-size: 4rem;
            color: #dee2e6;
            margin-bottom: 20px;
        }
    </style>
</head>
<body class="bg-light">

<jsp:include page="NavBar.jsp" />

<div class="container py-5">
    <div class="row">
        <div class="col-12">
            <h2 class="mb-4">My Orders</h2>

            <c:choose>
                <c:when test="${not empty purchasedProducts}">
                    <c:forEach var="product" items="${purchasedProducts}">
                        <div class="card order-card mb-4">
                            <div class="order-header">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <h6 class="mb-1">Order #${product.id}</h6>
                                        <small class="text-muted">Purchased product</small>
                                    </div>
                                    <span class="badge bg-success">Paid</span>
                                </div>
                            </div>
                            <div class="card-body">
                                <div class="row align-items-center">
                                    <div class="col-md-2">
                                        <c:choose>
                                            <c:when test="${product.hasImage()}">
                                                <img src="data:image/jpeg;base64,${product.getBase64Image()}" 
                                                     alt="${product.productName}" 
                                                     class="img-fluid product-img">
                                            </c:when>
                                            <c:otherwise>
                                                <div class="bg-light p-2 rounded">
                                                    <i class="fas fa-box-open fa-2x text-secondary"></i>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="col-md-6">
                                        <h5 class="mb-1">${product.productName}</h5>
                                        <p class="text-muted mb-0">${product.productDescription}</p>
                                    </div>
                                    <div class="col-md-2 text-center">
                                        <span class="text-muted">Qty: 1</span>
                                    </div>
                                    <div class="col-md-2 text-end">
                                        <h5 class="mb-0">₹<fmt:formatNumber value="${product.productPrice}" type="number" maxFractionDigits="2"/></h5>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="card">
                        <div class="card-body empty-state">
                            <i class="fas fa-shopping-bag"></i>
                            <h4 class="text-muted">No orders yet</h4>
                            <p class="text-muted mb-4">You haven't placed any orders with us yet.</p>
                            <a href="${pageContext.request.contextPath}/" class="btn btn-primary">
                                <i class="fas fa-shopping-cart me-2"></i>Start Shopping
                            </a>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>