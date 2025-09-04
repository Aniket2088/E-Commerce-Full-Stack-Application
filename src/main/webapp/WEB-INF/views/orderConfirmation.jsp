<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Order Confirmation - ShopEasy</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .confirmation-container {
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
        }
        .success-icon {
            font-size: 4rem;
            color: #28a745;
        }
        .error-icon {
            font-size: 4rem;
            color: #dc3545;
        }
    </style>
</head>
<body class="bg-light">

<jsp:include page="NavBar.jsp" />

<div class="container confirmation-container">
    <div class="card shadow-sm text-center">
        <div class="card-body py-5">
            <c:choose>
                <c:when test="${isSuccess}">
                    <i class="fas fa-check-circle success-icon mb-4"></i>
                    <h2 class="text-success mb-3">Order Placed Successfully!</h2>
                    <p class="text-muted mb-4">Thank you for your purchase. Your order has been confirmed.</p>
                </c:when>
                <c:otherwise>
                    <i class="fas fa-times-circle error-icon mb-4"></i>
                    <h2 class="text-danger mb-3">Order Failed</h2>
                    <p class="text-muted mb-4">${message}</p>
                </c:otherwise>
            </c:choose>
            
            <div class="d-flex justify-content-center gap-3">
                <a href="${pageContext.request.contextPath}/" class="btn btn-primary">
                    <i class="fas fa-home me-2"></i>Continue Shopping
                </a>
                <a href="${pageContext.request.contextPath}/orders" class="btn btn-outline-secondary">
                    <i class="fas fa-list me-2"></i>View Orders
                </a>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>