<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Product</title>
</head>
<body>
    <h1>ADD Product</h1>
   <form action="./saveProduct" method="post" enctype="multipart/form-data">

       

        <label for="productName">Product Name:</label>
        <input type="text" name="productName" required><br><br>

        <label for="productDescription">Product Description:</label><br>
        <textarea name="productDescription" rows="4" cols="50" required></textarea><br><br>

        <label for="productPrice">Product Price:</label>
        <input type="number" name="productPrice" step="0.01" required><br><br>

        <label for="image">Product Image:</label>
        <input type="file" name="image" accept="image/*" required><br><br>

        <button type="submit">Add Product</button>
    </form>
</body>
</html>
