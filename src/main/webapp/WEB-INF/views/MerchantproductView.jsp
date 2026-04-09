<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Product Collection - Merchant View</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<style>
    :root {
        --primary-color: #4361ee; --primary-dark: #3a0ca3;
        --secondary-color: #f72585; --light-color: #f8f9fa;
        --dark-color: #212529; --gray-color: #6c757d;
        --success-color: #4bb543; --danger-color: #dc3545;
        --border-radius: 8px; --box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        --transition: all 0.3s ease;
    }
    * { margin:0; padding:0; box-sizing:border-box; font-family:'Segoe UI',Tahoma,Geneva,Verdana,sans-serif; }
    body { background-color:#f5f7fa; color:var(--dark-color); line-height:1.6; display:flex; flex-direction:column; min-height:100vh; }

    /* Nav */
    .nav-bar { background:white; padding:1rem 2rem; box-shadow:var(--box-shadow); display:flex; justify-content:space-between; align-items:center; }
    .nav-title { font-size:1.5rem; font-weight:700; color:var(--primary-color); }
    .nav-buttons { display:flex; gap:1rem; align-items:center; }
    .nav-btn { padding:0.5rem 1rem; border-radius:var(--border-radius); text-decoration:none; font-weight:500; transition:var(--transition); display:flex; align-items:center; gap:0.5rem; cursor:pointer; border:none; }
    .danger-btn  { background:var(--danger-color);  color:white; border:2px solid var(--danger-color); }
    .danger-btn:hover  { background:#c82333; }
    .primary-btn { background:var(--primary-color); color:white; border:2px solid var(--primary-color); }
    .primary-btn:hover { background:var(--primary-dark); }

    /* Alerts */
    .alert { padding:0.9rem 1.2rem; border-radius:var(--border-radius); margin:1rem 2rem 0; font-weight:500; }
    .alert-success { background:rgba(75,181,67,0.12); color:#2d6a29; border:1px solid rgba(75,181,67,0.3); }
    .alert-error   { background:rgba(220,53,69,0.12); color:#842029; border:1px solid rgba(220,53,69,0.3); }

    /* Search */
    .search-container { flex:1; max-width:400px; margin:0 1rem; position:relative; }
    .search-input { width:100%; padding:0.5rem 1rem 0.5rem 2.5rem; border-radius:var(--border-radius); border:1px solid #ddd; font-size:0.95rem; transition:var(--transition); }
    .search-input:focus { outline:none; border-color:var(--primary-color); box-shadow:0 0 0 2px rgba(67,97,238,0.2); }
    .search-icon { position:absolute; left:0.9rem; top:50%; transform:translateY(-50%); color:var(--gray-color); }

    /* Main */
    .main-content { flex:1; padding:2rem; width:100%; }
    .page-header { text-align:center; margin-bottom:2rem; }
    .page-header h1 { font-size:2.2rem; color:var(--primary-dark); }

    /* Category sections */
    .category-section { margin-bottom:3rem; }
    .category-header { display:flex; align-items:center; margin-bottom:1.5rem; padding-bottom:0.5rem; border-bottom:2px solid var(--primary-color); }
    .category-title { font-size:1.5rem; color:var(--primary-dark); margin-right:1rem; }
    .product-count { background:var(--primary-color); color:white; padding:0.2rem 0.8rem; border-radius:20px; font-size:0.9rem; }

    /* Grid + Card */
    .product-grid { display:grid; grid-template-columns:repeat(auto-fill,minmax(250px,1fr)); gap:1.5rem; }
    .product-card { background:white; border-radius:var(--border-radius); overflow:hidden; box-shadow:var(--box-shadow); transition:var(--transition); }
    .product-card:hover { transform:translateY(-5px); box-shadow:0 10px 20px rgba(0,0,0,0.1); }

    /* ✅ Image container — fixed height, no scriptlets */
    .product-image-container { height:180px; overflow:hidden; background:#f0f0f0; display:flex; align-items:center; justify-content:center; }
    .product-image { width:100%; height:100%; object-fit:cover; transition:var(--transition); }
    .product-card:hover .product-image { transform:scale(1.05); }
    .no-image-placeholder { color:#bbb; font-size:3rem; }

    .product-details { padding:1.2rem; }
    .product-name { font-size:1.05rem; font-weight:600; margin-bottom:0.4rem; white-space:nowrap; overflow:hidden; text-overflow:ellipsis; }
    .product-description { color:var(--gray-color); font-size:0.88rem; margin-bottom:0.6rem; display:-webkit-box; -webkit-line-clamp:2; -webkit-box-orient:vertical; overflow:hidden; }
    .product-price { font-size:1.15rem; font-weight:700; color:var(--primary-color); margin-bottom:0.4rem; }
    .stock-badge { font-size:0.8rem; font-weight:600; padding:0.2rem 0.6rem; border-radius:12px; display:inline-block; }
    .stock-ok  { background:rgba(75,181,67,0.12);  color:#2d6a29; }
    .stock-low { background:rgba(255,193,7,0.15);  color:#856404; }
    .stock-out { background:rgba(220,53,69,0.12);  color:#842029; }

    /* Search hidden */
    .hidden { display:none !important; }
    .no-results { text-align:center; padding:2rem; grid-column:1/-1; color:var(--gray-color); }

    /* Footer */
    .footer { background:var(--dark-color); color:white; padding:1.5rem; text-align:center; }
    .footer-links { display:flex; justify-content:center; gap:1.5rem; margin-bottom:1rem; }
    .footer-link { color:#aaa; text-decoration:none; transition:var(--transition); }
    .footer-link:hover { color:white; }
    .copyright { color:#777; font-size:0.9rem; }

    @media(max-width:768px) {
        .nav-bar { flex-direction:column; gap:1rem; padding:1rem; }
        .search-container { order:-1; width:100%; max-width:none; margin:0.5rem 0; }
        .product-grid { grid-template-columns:repeat(auto-fill,minmax(200px,1fr)); }
    }
</style>
</head>
<body>

<%-- ── Navbar ── --%>
<nav class="nav-bar">
    <div class="nav-title"><i class="fas fa-store me-2"></i>Merchant Dashboard</div>

    <div class="search-container">
        <i class="fas fa-search search-icon"></i>
        <input type="text" id="searchInput" class="search-input" placeholder="Search your products...">
    </div>

    <div class="nav-buttons">
        <form action="${pageContext.request.contextPath}/AddProduct" method="get" style="display:contents;">
            <button type="submit" class="nav-btn primary-btn">
                <i class="fas fa-plus"></i> Add Product
            </button>
        </form>
        <form action="${pageContext.request.contextPath}/logoutMerchant" method="get" style="display:contents;">
            <button type="submit" class="nav-btn danger-btn">
                <i class="fas fa-sign-out-alt"></i> Logout
            </button>
        </form>
    </div>
</nav>

<%-- ── Flash messages ── --%>
<c:if test="${not empty success}">
    <div class="alert alert-success"><i class="fas fa-check-circle me-2"></i>${success}</div>
</c:if>
<c:if test="${not empty error}">
    <div class="alert alert-error"><i class="fas fa-exclamation-circle me-2"></i>${error}</div>
</c:if>

<%-- ── Main content ── --%>
<main class="main-content">
    <div class="page-header">
        <h1>Your Product Collection</h1>
        <p style="color:var(--gray-color)">Manage and track your listed products</p>
    </div>

    <div id="productsContainer">
        <c:choose>
            <c:when test="${empty products}">
                <div style="text-align:center;padding:3rem;">
                    <i class="fas fa-box-open fa-4x" style="color:#ddd;margin-bottom:1rem;display:block;"></i>
                    <p style="color:var(--gray-color);font-size:1.1rem;">No products yet. Click <strong>Add Product</strong> to get started.</p>
                </div>
            </c:when>
            <c:otherwise>
                <%-- Group products by category using JSTL --%>
                <c:forEach var="product" items="${products}">
                    <c:set var="currentCat" value="${product.category}"/>
                </c:forEach>

                <%-- Single flat grid — merchant sees all their products --%>
                <div class="category-header">
                    <h2 class="category-title">All Products</h2>
                    <span class="product-count">${products.size()} items</span>
                </div>

                <div class="product-grid" id="productGrid">
                    <c:forEach var="product" items="${products}">
                        <div class="product-card"
                             data-name="${product.productName.toLowerCase()}"
                             data-description="${product.productDescription.toLowerCase()}"
                             data-category="${product.category.toLowerCase()}">

                            <%-- ✅ Image from disk — no Base64, no scriptlets --%>
                            <div class="product-image-container">
                                <c:choose>
                                    <c:when test="${product.hasImage()}">
                                        <img src="${pageContext.request.contextPath}/uploads/products/${product.imagePath}"
                                             alt="${product.productName}"
                                             class="product-image"/>
                                    </c:when>
                                    <c:otherwise>
                                        <i class="fas fa-image no-image-placeholder"></i>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <div class="product-details">
                                <h3 class="product-name" title="${product.productName}">${product.productName}</h3>
                                <p class="product-description">${product.productDescription}</p>
                                <div class="product-price">&#8377;${product.productPrice}</div>

                                <%-- Stock indicator --%>
                                <c:choose>
                                    <c:when test="${product.stockQuantity <= 0}">
                                        <span class="stock-badge stock-out"><i class="fas fa-times-circle me-1"></i>Out of Stock</span>
                                    </c:when>
                                    <c:when test="${product.stockQuantity <= 5}">
                                        <span class="stock-badge stock-low"><i class="fas fa-exclamation-triangle me-1"></i>Low: ${product.stockQuantity} left</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="stock-badge stock-ok"><i class="fas fa-check-circle me-1"></i>In Stock: ${product.stockQuantity}</span>
                                    </c:otherwise>
                                </c:choose>

                                <div style="margin-top:0.5rem;font-size:0.82rem;color:var(--gray-color);">
                                    <i class="fas fa-tag me-1"></i>${product.category}
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>

            </c:otherwise>
        </c:choose>
    </div>
</main>

<%-- ── Footer ── --%>
<footer class="footer">
    <div class="footer-links">
        <a href="${pageContext.request.contextPath}/homePage"        class="footer-link">Home</a>
        <a href="${pageContext.request.contextPath}/merchantproductview" class="footer-link">My Products</a>
        <a href="${pageContext.request.contextPath}/AddProduct"      class="footer-link">Add Product</a>
    </div>
    <p class="copyright">&copy; 2024 ShopEase. All rights reserved.</p>
</footer>

<script>
document.addEventListener('DOMContentLoaded', function () {
    const searchInput  = document.getElementById('searchInput');
    const productCards = document.querySelectorAll('.product-card');

    searchInput.addEventListener('input', function () {
        const term = this.value.toLowerCase().trim();
        let visibleCount = 0;

        productCards.forEach(card => {
            const match = !term ||
                card.dataset.name.includes(term) ||
                card.dataset.description.includes(term) ||
                card.dataset.category.includes(term);

            card.classList.toggle('hidden', !match);
            if (match) visibleCount++;
        });

        // Update count badge
        const badge = document.querySelector('.product-count');
        if (badge) badge.textContent = visibleCount + ' items';

        // No results message
        let noResults = document.querySelector('.no-results');
        if (visibleCount === 0 && term) {
            if (!noResults) {
                noResults = document.createElement('div');
                noResults.className = 'no-results';
                noResults.innerHTML = '<i class="fas fa-search fa-2x" style="color:#ddd;margin-bottom:0.5rem;display:block;"></i><p>No products match your search.</p>';
                document.getElementById('productGrid').appendChild(noResults);
            }
        } else if (noResults) {
            noResults.remove();
        }
    });
});
</script>
</body>
</html>
