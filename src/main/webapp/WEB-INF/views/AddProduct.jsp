<%@page import="com.aniket.ecommerce.service.MerchantService"%>
<%@page import="com.aniket.ecommerce.entity.Merchant"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Product - ShopEase</title>
<style>
    :root {
        --primary-color: #4361ee; --primary-dark: #3a0ca3;
        --secondary-color: #f72585; --light-color: #f8f9fa;
        --dark-color: #212529; --gray-color: #6c757d;
        --success-color: #4bb543; --border-radius: 8px;
        --box-shadow: 0 4px 6px rgba(0,0,0,0.1); --transition: all 0.3s ease;
    }
    * { margin:0; padding:0; box-sizing:border-box; font-family:'Segoe UI',Tahoma,Geneva,Verdana,sans-serif; }
    body { background-color:#f5f7fa; color:var(--dark-color); line-height:1.6; padding:20px; }
    .container { max-width:800px; margin:2rem auto; padding:2rem; background:white; border-radius:var(--border-radius); box-shadow:var(--box-shadow); }
    .form-header { text-align:center; margin-bottom:2rem; }
    .form-header h1 { font-size:2.2rem; color:var(--primary-dark); font-weight:700; }
    .form-header::after { content:''; display:block; width:80px; height:4px; background:linear-gradient(to right,var(--primary-color),var(--secondary-color)); margin:0.5rem auto 0; border-radius:2px; }
    .form-group { margin-bottom:1.5rem; }
    label { display:block; margin-bottom:0.5rem; font-weight:600; color:var(--dark-color); }
    input[type="text"], input[type="number"], textarea, select {
        width:100%; padding:12px 15px; border:2px solid #e9ecef; border-radius:var(--border-radius);
        font-size:1rem; transition:var(--transition);
    }
    input[type="text"]:focus, input[type="number"]:focus, textarea:focus, select:focus {
        border-color:var(--primary-color); outline:none; box-shadow:0 0 0 3px rgba(67,97,238,0.2);
    }
    textarea { min-height:120px; resize:vertical; }
    select { appearance:none; background-image:url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='currentColor' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3e%3cpolyline points='6 9 12 15 18 9'%3e%3c/polyline%3e%3c/svg%3e"); background-repeat:no-repeat; background-position:right 15px center; background-size:1em; }
    .file-input-container { position:relative; margin-bottom:1.5rem; }
    .file-input-label { display:flex; flex-direction:column; align-items:center; padding:2rem; border:2px dashed #e9ecef; border-radius:var(--border-radius); cursor:pointer; transition:var(--transition); }
    .file-input-label:hover { border-color:var(--primary-color); background-color:rgba(67,97,238,0.05); }
    .file-input-label i { font-size:2rem; color:var(--primary-color); margin-bottom:0.5rem; }
    .file-input-label span { color:var(--gray-color); }
    .file-input-label strong { color:var(--primary-color); text-decoration:underline; }
    input[type="file"] { position:absolute; width:1px; height:1px; padding:0; margin:-1px; overflow:hidden; clip:rect(0,0,0,0); border:0; }
    .submit-btn { display:block; width:100%; padding:14px; background:linear-gradient(to right,var(--primary-color),var(--primary-dark)); color:white; border:none; border-radius:var(--border-radius); font-size:1.1rem; font-weight:600; cursor:pointer; transition:var(--transition); text-transform:uppercase; letter-spacing:1px; }
    .submit-btn:hover { background:linear-gradient(to right,var(--primary-dark),var(--primary-color)); transform:translateY(-2px); box-shadow:0 6px 12px rgba(0,0,0,0.15); }
    .preview-image { max-width:200px; max-height:200px; margin-top:1rem; border-radius:var(--border-radius); display:none; }
    .hint { font-size:0.85rem; color:var(--gray-color); margin-top:0.3rem; }
</style>
</head>
<body>
<%
    MerchantService service = new MerchantService();
    Merchant merchant = (Merchant) request.getAttribute("merchant");
    if (merchant == null) {
        Integer merchantId = (Integer) session.getAttribute("merchantId");
        if (merchantId != null) {
            merchant = service.findMerchantById(merchantId);
        }
    }
    if (merchant == null) {
        response.sendRedirect(request.getContextPath() + "/merchantLogin");
        return;
    }
%>
<div class="container">
    <div class="form-header">
        <h1>ADD PRODUCT</h1>
        <p style="color:var(--gray-color);margin-top:0.5rem">Fill in the details below to add a new product to your store</p>
    </div>

    <form action="./saveProduct/<%=merchant.getId()%>" method="post" enctype="multipart/form-data" id="productForm">

        <div class="form-group">
            <label for="productName">Product Name</label>
            <input type="text" id="productName" name="productName" placeholder="e.g. Samsung Galaxy S24" required>
        </div>

        <div class="form-group">
            <label for="productDescription">Product Description</label>
            <textarea id="productDescription" name="productDescription" placeholder="Describe your product in detail..." required></textarea>
        </div>

        <div style="display:grid;grid-template-columns:1fr 1fr;gap:1.5rem;">
            <div class="form-group">
                <label for="productPrice">Product Price (₹)</label>
                <input type="number" id="productPrice" name="productPrice" step="0.01" min="0" placeholder="0.00" required>
            </div>

            <%-- ✅ NEW FIELD: stockQuantity required by new Product entity --%>
            <div class="form-group">
                <label for="stockQuantity">Stock Quantity</label>
                <input type="number" id="stockQuantity" name="stockQuantity" min="0" placeholder="e.g. 50" required>
                <p class="hint">How many units are available for sale?</p>
            </div>
        </div>

        <div class="form-group">
            <label for="category">Product Category</label>
            <select id="category" name="category" required>
                <option value="">-- Select Category --</option>
                <option value="phones">Phones</option>
                <option value="fridge">Fridge</option>
                <option value="washingmachine">Washing Machine</option>
                <option value="tv">TV</option>
                <option value="cooler">Cooler</option>
                <option value="ac">AC</option>
                <option value="computer">Computer</option>
            </select>
        </div>

        <div class="form-group">
            <label>Product Image</label>
            <div class="file-input-container">
                <label class="file-input-label" for="image">
                    <i>📷</i>
                    <span>Drag &amp; drop your image here or <strong>browse</strong></span>
                    <span style="font-size:0.85rem;color:var(--gray-color)">Supports: JPG, PNG (Max 5MB)</span>
                </label>
                <input type="file" id="image" name="image" accept="image/*" required>
                <img id="preview" class="preview-image" alt="Image preview">
            </div>
        </div>

        <button type="submit" class="submit-btn">➕ Add Product</button>
    </form>
</div>

<script>
    const imageInput = document.getElementById('image');
    const preview    = document.getElementById('preview');
    const fileLabel  = document.querySelector('.file-input-label');

    imageInput.addEventListener('change', function () {
        const file = this.files[0];
        if (file) {
            const reader = new FileReader();
            reader.addEventListener('load', function () {
                preview.style.display = 'block';
                preview.setAttribute('src', this.result);
                fileLabel.style.display = 'none';
            });
            reader.readAsDataURL(file);
        }
    });

    fileLabel.addEventListener('dragover', (e) => {
        e.preventDefault();
        fileLabel.style.borderColor = '#4361ee';
        fileLabel.style.backgroundColor = 'rgba(67,97,238,0.1)';
    });
    fileLabel.addEventListener('dragleave', () => {
        fileLabel.style.borderColor = '#e9ecef';
        fileLabel.style.backgroundColor = 'transparent';
    });
    fileLabel.addEventListener('drop', (e) => {
        e.preventDefault();
        fileLabel.style.borderColor = '#e9ecef';
        fileLabel.style.backgroundColor = 'transparent';
        if (e.dataTransfer.files.length) {
            imageInput.files = e.dataTransfer.files;
            imageInput.dispatchEvent(new Event('change'));
        }
    });
</script>
</body>
</html>
