<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.util.Base64" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Product Details</title>
<style>
    .card {
        width: 300px;
        border: 1px solid #ccc;
        border-radius: 10px;
        padding: 16px;
        margin: 20px auto;
        text-align: center;
        box-shadow: 2px 2px 10px rgba(0,0,0,0.1);
    }
    .product-image {
        max-width: 100%;
        height: auto;
        border-radius: 8px;
    }
</style>
</head>
<body>

<% 
    com.aniket.ecommerce.entity.Product product = (com.aniket.ecommerce.entity.Product) request.getAttribute("product");
    if (product != null) {
        byte[] imageBytes = product.getImage();
        String base64Image = Base64.getEncoder().encodeToString(imageBytes);
%>

<div class="card">
    <img src="data:image/jpeg;base64,<%= base64Image %>" alt="Product Image" class="product-image"/>
    <h2><%= product.getProductName() %></h2>
    <p><strong>ID:</strong> <%= product.getId() %></p>
    <p><strong>Description:</strong> <%= product.getProductDescription() %></p>
    <p><strong>Price:</strong> ₹<%= product.getProductPrice() %></p>
</div>

<%
    } else {
%>
    <h2 style="text-align:center;">Product Not Found</h2>
<%
    }
%>

</body>
</html>
