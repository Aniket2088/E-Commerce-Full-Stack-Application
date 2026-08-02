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
        :root{--primary:#2a3f54;--secondary:#e74c3c;--accent:#3498db;--success:#2ecc71;--warning:#f39c12;}
        body{font-family:'Segoe UI',sans-serif;background-color:#f8f9fa;}
        .navbar{background-color:white;box-shadow:0 4px 12px rgba(0,0,0,0.08);padding:1rem 0;}
        .navbar-brand{font-weight:800;font-size:2rem;background:linear-gradient(135deg,var(--primary),var(--accent));-webkit-background-clip:text;-webkit-text-fill-color:transparent;}
        .nav-link{font-weight:600;padding:0.5rem 1.5rem !important;border-radius:20px;transition:all 0.3s;}
        .nav-link:hover,.nav-link.active{background-color:rgba(42,63,84,0.1);color:var(--primary)!important;}
        .page-header{background:linear-gradient(135deg,rgba(42,63,84,0.9),rgba(52,152,219,0.9));color:white;padding:3rem 0;margin-bottom:2rem;position:relative;overflow:hidden;}
        .page-title{font-size:2.5rem;font-weight:800;}
        .payment-card{border:none;border-radius:15px;box-shadow:0 5px 20px rgba(0,0,0,0.08);background:white;margin-bottom:2rem;overflow:hidden;}
        .payment-header{background:linear-gradient(135deg,var(--primary),var(--accent));color:white;padding:1.5rem;}
        .payment-header h4{margin:0;font-weight:700;font-size:1.3rem;}
        .card-body{padding:1.5rem;}
        .address-option{border:2px solid #e1e5e9;border-radius:10px;padding:1.5rem;margin-bottom:1rem;cursor:pointer;transition:all 0.3s;position:relative;overflow:hidden;}
        .address-option:hover{border-color:var(--accent);transform:translateY(-3px);box-shadow:0 5px 15px rgba(52,152,219,0.1);}
        .address-option.selected{border-color:var(--success);background:linear-gradient(to right,rgba(46,204,113,0.05),rgba(46,204,113,0.02));border-width:3px;}
        .address-option.selected::before{content:'';position:absolute;left:0;top:0;bottom:0;width:4px;background:var(--success);}
        .address-type{background:rgba(52,152,219,0.1);color:var(--accent);padding:0.3rem 0.8rem;border-radius:20px;font-size:0.8rem;font-weight:600;display:inline-block;margin-bottom:0.5rem;}
        .address-details h6{font-weight:700;color:var(--primary);margin-bottom:0.25rem;}
        .address-details p{color:#666;margin-bottom:0.4rem;font-size:0.9rem;}
        .payment-option{border:2px solid #e1e5e9;border-radius:10px;padding:1.5rem;margin-bottom:1rem;cursor:pointer;transition:all 0.3s;position:relative;overflow:hidden;}
        .payment-option:hover{border-color:var(--accent);transform:translateY(-3px);}
        .payment-option.selected{border-color:var(--secondary);background:linear-gradient(to right,rgba(231,76,60,0.05),rgba(231,76,60,0.02));border-width:3px;}
        .payment-option.selected::before{content:'';position:absolute;left:0;top:0;bottom:0;width:4px;background:var(--secondary);}
        .payment-icon{width:50px;height:50px;background:linear-gradient(135deg,var(--primary),rgba(42,63,84,0.1));border-radius:10px;display:flex;align-items:center;justify-content:center;margin-bottom:0.75rem;color:var(--primary);font-size:1.2rem;}
        .payment-method h6{font-weight:700;color:var(--primary);margin-bottom:0.25rem;}
        .payment-method p{color:#666;font-size:0.85rem;margin:0;}

        /* ✅ Order Items - uses CartItem */
        .order-item{padding:1rem 0;border-bottom:1px solid rgba(0,0,0,0.05);transition:all 0.3s;}
        .order-item:last-child{border-bottom:none;}
        .order-item:hover{background-color:rgba(52,152,219,0.03);}
        .product-image{width:70px;height:70px;border-radius:8px;overflow:hidden;background:#f8f9fa;display:flex;align-items:center;justify-content:center;flex-shrink:0;}
        .product-img{width:100%;height:100%;object-fit:cover;}
        .product-name{font-weight:600;color:var(--primary);margin-bottom:0.25rem;font-size:0.95rem;}
        .product-quantity{color:#666;font-size:0.85rem;}
        .product-price{font-weight:700;color:var(--secondary);font-size:1rem;text-align:right;}

        .summary-card{border:none;border-radius:15px;box-shadow:0 5px 20px rgba(0,0,0,0.08);background:white;position:sticky;top:20px;overflow:hidden;}
        .summary-header{background:linear-gradient(135deg,var(--primary),var(--accent));color:white;padding:1.5rem;}
        .summary-body{padding:1.5rem;}
        .summary-row{display:flex;justify-content:space-between;padding:0.8rem 0;border-bottom:1px solid rgba(0,0,0,0.05);}
        .summary-row:last-child{border-bottom:none;}
        .summary-total{font-size:1.2rem;font-weight:700;color:var(--primary);}
        .summary-value{font-weight:600;color:var(--primary);}
        .btn-add-address{background:rgba(42,63,84,0.1);color:var(--primary);border:2px solid rgba(42,63,84,0.2);padding:0.875rem 2rem;border-radius:10px;font-weight:600;text-decoration:none;display:inline-flex;align-items:center;gap:0.5rem;transition:all 0.3s;}
        .btn-add-address:hover{background:var(--primary);color:white;border-color:var(--primary);transform:translateY(-2px);}
        .btn-pay-now{background:linear-gradient(135deg,var(--success),#27ae60);color:white;border:none;padding:1rem;border-radius:10px;font-weight:600;width:100%;display:flex;align-items:center;justify-content:center;gap:0.5rem;font-size:1.1rem;transition:all 0.3s;}
        .btn-pay-now:hover{background:linear-gradient(135deg,#27ae60,var(--success));transform:translateY(-2px);box-shadow:0 8px 20px rgba(46,204,113,0.3);}
        .loading-overlay{position:fixed;top:0;left:0;width:100%;height:100%;background-color:rgba(0,0,0,0.7);display:none;flex-direction:column;justify-content:center;align-items:center;z-index:9999;color:white;}
        .loading-spinner{width:60px;height:60px;border:4px solid rgba(255,255,255,0.3);border-top:4px solid white;border-radius:50%;animation:spin 1s linear infinite;margin-bottom:1rem;}
        @keyframes spin{0%{transform:rotate(0deg);}100%{transform:rotate(360deg);}}
        .error-alert{position:fixed;top:20px;right:20px;z-index:10000;min-width:300px;border-radius:10px;padding:1rem;display:none;}
        .footer{background:linear-gradient(135deg,var(--primary),#1a2530);color:white;margin-top:4rem;}
        @keyframes fadeIn{from{opacity:0;transform:translateY(20px);}to{opacity:1;transform:translateY(0);}}
        .fade-in{animation:fadeIn 0.6s ease-out;}
        @media(max-width:768px){.page-title{font-size:2rem;}}
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
                <li class="nav-item"><a class="nav-link active" href="#"><i class="fas fa-credit-card me-1"></i>Payment</a></li>
            </ul>
            <div class="d-flex align-items-center">
                <c:if test="${not empty sessionScope.user}">
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
                </c:if>
            </div>
        </div>
    </div>
</nav>

<div class="page-header">
    <div class="container">
        <h1 class="page-title fade-in"><i class="fas fa-credit-card me-2"></i>Complete Your Order</h1>
        <p class="lead mb-0 fade-in">Review your order and proceed to payment</p>
    </div>
</div>

<div class="loading-overlay" id="loadingOverlay">
    <div class="loading-spinner"></div><p>Processing your payment...</p>
</div>
<div class="error-alert alert alert-danger" role="alert" id="errorAlert">
    <i class="fas fa-exclamation-circle me-2"></i><span id="errorMessage"></span>
</div>

<div class="container py-4">
    <div class="row">
        <!-- LEFT -->
        <div class="col-lg-8">

            <!-- Shipping Address -->
            <div class="payment-card fade-in">
                <div class="payment-header"><h4><i class="fas fa-map-marker-alt me-2"></i>Shipping Address</h4></div>
                <div class="card-body">
                    <input type="hidden" id="selectedAddressId" value="">
                    <c:choose>
                        <c:when test="${not empty savedAddresses}">
                            <div class="row">
                                <c:forEach var="address" items="${savedAddresses}" varStatus="s">
                                    <div class="col-md-6 mb-3">
                                        <div class="address-option ${s.first ? 'selected' : ''}" data-address-id="${address.id}">
                                            <div class="address-type">${address.addressType} Address</div>
                                            <div class="address-details">
                                                <h6>${address.firstName} ${address.lastName}</h6>
                                                <p class="mb-1">${address.addressLine1}</p>
                                                <c:if test="${not empty address.addressLine2}"><p class="mb-1">${address.addressLine2}</p></c:if>
                                                <p class="mb-1">${address.city}, ${address.state} ${address.postalCode}</p>
                                                <p class="mb-1">${address.country}</p>
                                                <p class="mb-0"><i class="fas fa-phone me-1"></i>${address.phone}</p>
                                            </div>
                                            <input type="radio" name="selectedAddress" id="addr${address.id}" value="${address.id}" ${s.first ? 'checked' : ''} style="position:absolute;opacity:0;">
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:when>
                        <c:otherwise><p class="text-muted">No saved addresses. Please add one.</p></c:otherwise>
                    </c:choose>
                    <div class="text-center mt-3">
                        <a href="${pageContext.request.contextPath}/addressPage" class="btn-add-address"><i class="fas fa-plus-circle me-2"></i>Add New Address</a>
                    </div>
                </div>
            </div>

            <!-- Payment Method -->
            <div class="payment-card fade-in" style="animation-delay:0.1s">
                <div class="payment-header"><h4><i class="fas fa-credit-card me-2"></i>Payment Method</h4></div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-4 mb-3">
                            <div class="payment-option selected" data-method="credit-card">
                                <div class="payment-icon"><i class="fas fa-credit-card"></i></div>
                                <div class="payment-method"><h6>Credit/Debit Card</h6><p>Pay securely with Razorpay</p></div>
                                <input type="radio" name="paymentMethod" value="credit-card" checked style="position:absolute;opacity:0;">
                            </div>
                        </div>
                        <div class="col-md-4 mb-3">
                            <div class="payment-option" data-method="upi">
                                <div class="payment-icon"><i class="fas fa-mobile-alt"></i></div>
                                <div class="payment-method"><h6>UPI</h6><p>Pay via UPI / GPay / PhonePe</p></div>
                                <input type="radio" name="paymentMethod" value="upi" style="position:absolute;opacity:0;">
                            </div>
                        </div>
                        <div class="col-md-4 mb-3">
                            <div class="payment-option" data-method="cod">
                                <div class="payment-icon"><i class="fas fa-money-bill-wave"></i></div>
                                <div class="payment-method"><h6>Cash on Delivery</h6><p>Pay when you receive</p></div>
                                <input type="radio" name="paymentMethod" value="cod" style="position:absolute;opacity:0;">
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- ✅ Order Items — now uses List<CartItem> -->
            <div class="payment-card fade-in" style="animation-delay:0.2s">
                <div class="payment-header"><h4><i class="fas fa-shopping-bag me-2"></i>Order Items</h4></div>
                <div class="card-body">
                    <c:forEach var="item" items="${cartItems}">
                        <div class="order-item">
                            <div class="d-flex align-items-center gap-3">
                                <div class="product-image">
                                    <c:choose>
                                        <c:when test="${item.product.hasImage()}">
                                            <img src="${pageContext.request.contextPath}/uploads/products/${item.product.imagePath}" alt="${item.product.productName}" class="product-img">
                                        </c:when>
                                        <c:otherwise><i class="fas fa-box-open fa-2x text-secondary"></i></c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="flex-grow-1">
                                    <div class="d-flex justify-content-between align-items-start">
                                        <div>
                                            <h6 class="product-name">${item.product.productName}</h6>
                                            <%-- ✅ quantity from CartItem.quantity --%>
                                            <span class="product-quantity"><i class="fas fa-box me-1"></i>Qty: ${item.quantity}</span>
                                        </div>
                                        <div class="product-price">
                                            ₹<fmt:formatNumber value="${item.product.productPrice * item.quantity}" type="number" maxFractionDigits="2"/>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>

        <!-- RIGHT: Summary -->
        <div class="col-lg-4">
            <div class="summary-card fade-in" style="animation-delay:0.3s">
                <div class="summary-header"><h5 class="mb-0">Order Summary</h5></div>
                <div class="summary-body">

                    <%-- ✅ Total from cartTotal attribute set by controller --%>
                    <c:set var="subtotal" value="${cartTotal}"/>

                    <div class="summary-row"><span>Subtotal:</span><span class="summary-value">₹<fmt:formatNumber value="${subtotal}" type="number" maxFractionDigits="2"/></span></div>
                    <div class="summary-row"><span>Shipping:</span><span class="text-success"><i class="fas fa-check-circle me-1"></i>FREE</span></div>
                    <div class="summary-row"><span>Tax (18%):</span><span class="summary-value">₹<fmt:formatNumber value="${subtotal * 0.18}" type="number" maxFractionDigits="2"/></span></div>
                    <hr>
                    <div class="summary-row summary-total"><span>Total:</span><span>₹<fmt:formatNumber value="${subtotal * 1.18}" type="number" maxFractionDigits="2"/></span></div>

                    <button type="button" id="payNowBtn" class="btn-pay-now mt-4"><i class="fas fa-lock me-2"></i>Pay Now</button>
                    <div class="text-center mt-3"><small class="text-muted"><i class="fas fa-shield-alt me-1"></i>Secure SSL encryption</small></div>
                </div>
            </div>
        </div>
    </div>
</div>

<footer class="footer py-5">
    <div class="container">
        <div class="row">
            <div class="col-md-6"><p class="text-light mb-0">&copy; 2024 ShopEase. All rights reserved.</p></div>
            <div class="col-md-6 text-md-end"><a href="#" class="text-light me-3 text-decoration-none">Privacy Policy</a><a href="#" class="text-light text-decoration-none">Terms of Service</a></div>
        </div>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://checkout.razorpay.com/v1/checkout.js"></script>
<script>
    const subtotal = ${cartTotal};

    document.addEventListener('DOMContentLoaded', function () {

        // Address selection
        document.querySelectorAll('.address-option').forEach(opt => {
            opt.addEventListener('click', function () {
                document.querySelectorAll('.address-option').forEach(a => a.classList.remove('selected'));
                this.classList.add('selected');
                const radio = this.querySelector('input[type="radio"]');
                if (radio) { radio.checked = true; document.getElementById('selectedAddressId').value = radio.value; }
            });
        });

        // Payment method selection
        document.querySelectorAll('.payment-option').forEach(opt => {
            opt.addEventListener('click', function () {
                document.querySelectorAll('.payment-option').forEach(p => p.classList.remove('selected'));
                this.classList.add('selected');
                const radio = this.querySelector('input[type="radio"]'); if (radio) radio.checked = true;
            });
        });

        // Set default address id
        const defaultAddr = document.querySelector('input[name="selectedAddress"]:checked');
        if (defaultAddr) document.getElementById('selectedAddressId').value = defaultAddr.value;

        function showError(msg) {
            const el = document.getElementById('errorAlert');
            document.getElementById('errorMessage').textContent = msg;
            el.style.display = 'block';
            setTimeout(() => { el.style.display = 'none'; }, 5000);
        }

        document.getElementById('payNowBtn').addEventListener('click', function () {
            const addrRadio = document.querySelector('input[name="selectedAddress"]:checked');
            const pmRadio   = document.querySelector('input[name="paymentMethod"]:checked');
            if (!addrRadio) { showError('Please select a shipping address'); return; }

            document.getElementById('loadingOverlay').style.display = 'flex';
            const totalAmount = Math.round(subtotal * 1.18);

            fetch('${pageContext.request.contextPath}/createOrder', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ amount: totalAmount * 100, currency: 'INR' })
            })
            .then(r => { if (!r.ok) throw new Error('Server error ' + r.status); return r.json(); })
            .then(order => {
                if (order.error) { showError(order.error); document.getElementById('loadingOverlay').style.display = 'none'; return; }
                const options = {
                    key: 'rzp_test_AOkSkGp6YQkF2n',
                    amount: order.amount, currency: order.currency, order_id: order.id,
                    name: 'ShopEase', description: 'Order Payment',
                    handler: function (response) { verifyAndProcess(response, addrRadio.value, pmRadio ? pmRadio.value : 'credit-card'); },
                    prefill: { name: '${sessionScope.user.name}', email: '${sessionScope.user.email}' },
                    theme: { color: '#2a3f54' }
                };
                new Razorpay(options).open();
                document.getElementById('loadingOverlay').style.display = 'none';
            })
            .catch(err => { showError(err.message); document.getElementById('loadingOverlay').style.display = 'none'; });
        });

        function verifyAndProcess(response, addressId, paymentMethod) {
            document.getElementById('loadingOverlay').style.display = 'flex';
            fetch('${pageContext.request.contextPath}/verifyPayment', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ razorpay_order_id: response.razorpay_order_id, razorpay_payment_id: response.razorpay_payment_id, razorpay_signature: response.razorpay_signature })
            })
            .then(r => r.json())
            .then(data => {
                if (data.status === 'success') { submitOrder(addressId, paymentMethod, response.razorpay_payment_id); }
                else { showError('Payment verification failed: ' + data.message); document.getElementById('loadingOverlay').style.display = 'none'; }
            })
            .catch(err => { showError(err.message); document.getElementById('loadingOverlay').style.display = 'none'; });
        }

        function submitOrder(addressId, paymentMethod, paymentId) {
            const form = document.createElement('form');
            form.method = 'POST';
            form.action = '${pageContext.request.contextPath}/processPayment';
            const add = (name, value) => { const i = document.createElement('input'); i.type='hidden'; i.name=name; i.value=value; form.appendChild(i); };
            add('addressId', addressId);
            add('paymentMethod', paymentMethod);
            add('paymentId', paymentId);
            // ✅ Send one productId per CartItem (not duplicates)
            <%-- cartItems is List<CartItem>, so item.product.id gives each unique product id --%>
            <c:forEach var="item" items="${cartItems}">
            add('productIds', '${item.product.id}');
            </c:forEach>
            document.body.appendChild(form);
            form.submit();
        }
    });
</script>
</body>
</html>
