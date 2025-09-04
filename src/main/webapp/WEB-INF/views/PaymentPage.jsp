<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Payment - Complete Your Order</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .address-card {
            border: 2px solid #e9ecef;
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 15px;
            transition: all 0.2s ease;
        }
        .address-card.selected {
            border-color: #0d6efd;
            background-color: #f8f9fa;
            border-width: 3px;
        }
        .address-card:hover {
            border-color: #0d6efd;
            cursor: pointer;
        }
        .payment-method-card {
            border: 2px solid #e9ecef;
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 15px;
            transition: all 0.2s ease;
        }
        .payment-method-card.selected {
            border-color: #0d6efd;
            background-color: #f8f9fa;
            border-width: 3px;
        }
        .payment-method-card:hover {
            border-color: #0d6efd;
            cursor: pointer;
        }
        .order-summary-card {
            border-left: 4px solid #0d6efd;
        }
        .product-img {
            max-height: 60px;
            object-fit: contain;
        }
        .loading-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.5);
            display: flex;
            justify-content: center;
            align-items: center;
            z-index: 9999;
            display: none;
        }
        .spinner-border {
            width: 3rem;
            height: 3rem;
        }
        .error-message {
            color: #dc3545;
            font-size: 0.875rem;
            margin-top: 0.25rem;
            display: none;
        }
        .alert-box {
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 10000;
            display: none;
        }
    </style>
</head>
<body class="bg-light">

<jsp:include page="NavBar.jsp" />

<!-- Loading Overlay -->
<div class="loading-overlay" id="loadingOverlay">
    <div class="spinner-border text-light" role="status">
        <span class="visually-hidden">Loading...</span>
    </div>
</div>

<!-- Error Alert -->
<div class="alert alert-danger alert-box" role="alert" id="errorAlert">
    <i class="fas fa-exclamation-circle me-2"></i>
    <span id="errorMessage"></span>
</div>

<div class="container py-5">
    <div class="row">
        <div class="col-lg-8">
            <!-- Shipping Address Section -->
            <div class="card shadow-sm mb-4">
                <div class="card-header bg-white">
                    <h4 class="mb-0">
                        <i class="fas fa-map-marker-alt me-2 text-primary"></i>Shipping Address
                    </h4>
                </div>
                <div class="card-body">
                    <c:if test="${not empty savedAddresses}">
                        <div class="row">
                            <input type="hidden" id="selectedAddressId" name="selectedAddressId" value="">
                            <c:forEach var="address" items="${savedAddresses}">
                                <div class="col-md-6 mb-3">
                                    <div class="address-card" data-address-id="${address.id}">
                                        <div class="form-check">
                                            <input class="form-check-input" type="radio" name="selectedAddress" 
                                                   id="address${address.id}" value="${address.id}" 
                                                  
                                                   style="position: absolute; opacity: 0;">
                                            <label class="form-check-label fw-bold" for="address${address.id}">
                                                ${address.addressType} Address
                                            </label>
                                        </div>
                                        <p class="mb-1">${address.firstName} ${address.lastName}</p>
                                        <p class="mb-1">${address.addressLine1}</p>
                                        <c:if test="${not empty address.addressLine2}">
                                            <p class="mb-1">${address.addressLine2}</p>
                                        </c:if>
                                        <p class="mb-1">${address.city}, ${address.state} ${address.postalCode}</p>
                                        <p class="mb-1">${address.country}</p>
                                        <p class="mb-0">Phone: ${address.phone}</p>
                                        <p class="mb-0">Email: ${address.email}</p>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:if>
                    
                    <div class="text-center mt-3">
                        <a href="${pageContext.request.contextPath}/addressPage" class="btn btn-outline-primary">
                            <i class="fas fa-plus-circle me-2"></i>Add New Address
                        </a>
                    </div>
                </div>
            </div>

            <!-- Payment Method Section -->
            <div class="card shadow-sm mb-4">
                <div class="card-header bg-white">
                    <h4 class="mb-0">
                        <i class="fas fa-credit-card me-2 text-primary"></i>Payment Method
                    </h4>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <div class="payment-method-card selected" data-method="credit-card">
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="paymentMethod" 
                                           id="creditCard" value="credit-card" checked>
                                    <label class="form-check-label fw-bold" for="creditCard">
                                        <i class="fas fa-credit-card me-2"></i>Credit/Debit Card
                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 mb-3">
                            <div class="payment-method-card" data-method="paypal">
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="paymentMethod" 
                                           id="paypal" value="paypal">
                                    <label class="form-check-label fw-bold" for="paypal">
                                        <i class="fab fa-paypal me-2"></i>PayPal
                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 mb-3">
                            <div class="payment-method-card" data-method="cod">
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="paymentMethod" 
                                           id="cod" value="cod">
                                    <label class="form-check-label fw-bold" for="cod">
                                        <i class="fas fa-money-bill-wave me-2"></i>Cash on Delivery
                                    </label>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Order Items Section -->
            <div class="card shadow-sm">
                <div class="card-header bg-white">
                    <h4 class="mb-0">
                        <i class="fas fa-shopping-bag me-2 text-primary"></i>Order Items
                    </h4>
                </div>
                <div class="card-body">
                    <c:if test="${not empty cartItems}">
                        <div class="list-group list-group-flush">
                            <c:set var="processedProductIds" value="" />
                            <c:forEach var="product" items="${cartItems}">
                                <c:set var="alreadyProcessed" value="false" />
                                <c:if test="${not empty processedProductIds}">
                                    <c:forTokens items="${processedProductIds}" delims="," var="processedId">
                                        <c:if test="${processedId eq product.id}">
                                            <c:set var="alreadyProcessed" value="true" />
                                        </c:if>
                                    </c:forTokens>
                                </c:if>
                                
                                <c:if test="${not alreadyProcessed}">
                                    <c:set var="quantity" value="0" />
                                    <c:forEach var="item" items="${cartItems}">
                                        <c:if test="${item.id == product.id}">
                                            <c:set var="quantity" value="${quantity + 1}" />
                                        </c:if>
                                    </c:forEach>
                                    
                                    <div class="list-group-item border-0 px-0">
                                        <div class="row align-items-center">
                                            <div class="col-2">
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
                                            <div class="col-6">
                                                <h6 class="mb-1">${product.productName}</h6>
                                                <small class="text-muted">Quantity: ${quantity}</small>
                                            </div>
                                            <div class="col-4 text-end">
                                                <div class="h6 mb-0">
                                                    ₹<fmt:formatNumber value="${product.productPrice * quantity}" 
                                                                      type="number" maxFractionDigits="2"/>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <c:set var="processedProductIds" value="${processedProductIds},${product.id}" />
                                </c:if>
                            </c:forEach>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>

        <!-- Order Summary Sidebar -->
        <div class="col-lg-4">
            <div class="card shadow-sm order-summary-card">
                <div class="card-header bg-white">
                    <h5 class="mb-0">Order Summary</h5>
                </div>
                <div class="card-body">
                    <c:set var="totalPrice" value="0" />
                    <c:if test="${not empty cartItems}">
                        <c:set var="processedProductIds" value="" />
                        <c:forEach var="product" items="${cartItems}">
                            <c:set var="alreadyProcessed" value="false" />
                            <c:if test="${not empty processedProductIds}">
                                <c:forTokens items="${processedProductIds}" delims="," var="processedId">
                                    <c:if test="${processedId eq product.id}">
                                        <c:set var="alreadyProcessed" value="true" />
                                    </c:if>
                                </c:forTokens>
                            </c:if>
                            
                            <c:if test="${not alreadyProcessed}">
                                <c:set var="quantity" value="0" />
                                <c:forEach var="item" items="${cartItems}">
                                    <c:if test="${item.id == product.id}">
                                        <c:set var="quantity" value="${quantity + 1}" />
                                    </c:if>
                                </c:forEach>
                                <c:set var="totalPrice" value="${totalPrice + (product.productPrice * quantity)}" />
                                <c:set var="processedProductIds" value="${processedProductIds},${product.id}" />
                            </c:if>
                        </c:forEach>
                    </c:if>

                    <div class="d-flex justify-content-between mb-2">
                        <span>Subtotal:</span>
                        <span>₹<fmt:formatNumber value="${totalPrice}" type="number" maxFractionDigits="2"/></span>
                    </div>
                    <div class="d-flex justify-content-between mb-2">
                        <span>Shipping:</span>
                        <span class="text-success">FREE</span>
                    </div>
                    <div class="d-flex justify-content-between mb-2">
                        <span>Tax (18%):</span>
                        <span>₹<fmt:formatNumber value="${totalPrice * 0.18}" type="number" maxFractionDigits="2"/></span>
                    </div>
                    <hr>
                    <div class="d-flex justify-content-between mb-3">
                        <strong>Total:</strong>
                        <strong>₹<fmt:formatNumber value="${totalPrice * 1.18}" type="number" maxFractionDigits="2"/></strong>
                    </div>

                    <button type="button" id="payNowBtn" class="btn btn-success w-100 py-3 fs-5">
                        <i class="fas fa-lock me-2"></i>Pay Now
                    </button>
                    
                    <div id="paymentError" class="error-message mt-2 text-center"></div>

                    <div class="text-center mt-3">
                        <small class="text-muted">
                            <i class="fas fa-lock me-1"></i>Your payment information is secure and encrypted
                        </small>
                    </div>
                </div>
            </div>

            <div class="card shadow-sm mt-3">
                <div class="card-body text-center">
                    <h6>Need Help?</h6>
                    <p class="text-muted small mb-2">Contact our support team</p>
                    <div class="d-flex justify-content-center gap-3">
                        <a href="#" class="text-decoration-none">
                            <i class="fas fa-phone-alt me-1"></i>+91 1234567890
                        </a>
                        <a href="#" class="text-decoration-none">
                            <i class="fas fa-envelope me-1"></i>support@shopeasy.com
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<!-- Razorpay Integration -->
<script src="https://checkout.razorpay.com/v1/checkout.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Address selection
        const addressCards = document.querySelectorAll('.address-card');
        addressCards.forEach(card => {
            card.addEventListener('click', function() {
                addressCards.forEach(addr => addr.classList.remove('selected'));
                this.classList.add('selected');
                const radio = this.querySelector('input[type="radio"]');
                if (radio) {
                    radio.checked = true;
                    document.getElementById('selectedAddressId').value = radio.value;
                }
            });
        });

        // Payment method selection
        const paymentCards = document.querySelectorAll('.payment-method-card');
        paymentCards.forEach(card => {
            card.addEventListener('click', function() {
                paymentCards.forEach(pm => pm.classList.remove('selected'));
                this.classList.add('selected');
                const radio = this.querySelector('input[type="radio"]');
                if (radio) {
                    radio.checked = true;
                }
            });
        });

        // Set default selected address
        const defaultAddressRadio = document.querySelector('input[name="selectedAddress"]:checked');
        if (defaultAddressRadio) {
            document.getElementById('selectedAddressId').value = defaultAddressRadio.value;
            defaultAddressRadio.closest('.address-card').classList.add('selected');
        }

        // Show error alert
        function showError(message) {
            const errorAlert = document.getElementById('errorAlert');
            const errorMessage = document.getElementById('errorMessage');
            errorMessage.textContent = message;
            errorAlert.style.display = 'block';
            
            // Hide after 5 seconds
            setTimeout(() => {
                errorAlert.style.display = 'none';
            }, 5000);
        }

        // Razorpay Payment Integration
        document.getElementById('payNowBtn').addEventListener('click', function() {
            const addressId = document.querySelector('input[name="selectedAddress"]:checked');
            const paymentMethod = document.querySelector('input[name="paymentMethod"]:checked');
            
            if (!addressId) {
                showError('Please select a shipping address');
                return false;
            }

            // Show loading overlay
            document.getElementById('loadingOverlay').style.display = 'flex';

            // Calculate total amount (including tax)
            const subtotal = ${totalPrice};
            const tax = subtotal * 0.18;
            const totalAmount = Math.round(subtotal + tax);

            // Create Razorpay order - using JSON format
            fetch('${pageContext.request.contextPath}/createOrder', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({
                    amount: totalAmount * 100,
                    currency: 'INR'
                })
            })
            .then(response => {
                if (!response.ok) {
                    // Handle 415 error specifically
                    if (response.status === 415) {
                        throw new Error('Unsupported media type. Please check server configuration.');
                    }
                    throw new Error('Server returned ' + response.status + ': ' + response.statusText);
                }
                return response.json();
            })
            .then(order => {
                if (order.error) {
                    showError('Error creating order: ' + order.error);
                    document.getElementById('loadingOverlay').style.display = 'none';
                    return;
                }

                // Razorpay options
                const options = {
                    key: 'rzp_test_AOkSkGp6YQkF2n', // Your Razorpay Key ID
                    amount: order.amount,
                    currency: order.currency,
                    name: 'ShopEasy',
                    description: 'Order Payment',
                    order_id: order.id,
                    handler: function(response) {
                        // Verify payment on server
                        verifyPayment(response, addressId.value, paymentMethod.value);
                    },
                    prefill: {
                        name: '${user.name}',
                        email: '${user.email}',
                        contact: '${user.phone}'
                    },
                    notes: {
                        address: 'Customer address'
                    },
                    theme: {
                        color: '#0d6efd'
                    }
                };

                const rzp = new Razorpay(options);
                rzp.open();
                document.getElementById('loadingOverlay').style.display = 'none';
            })
            .catch(error => {
                console.error('Error:', error);
                showError(error.message);
                document.getElementById('loadingOverlay').style.display = 'none';
            });
        });

        function verifyPayment(response, addressId, paymentMethod) {
            document.getElementById('loadingOverlay').style.display = 'flex';
            
            fetch('${pageContext.request.contextPath}/verifyPayment', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({
                    razorpay_order_id: response.razorpay_order_id,
                    razorpay_payment_id: response.razorpay_payment_id,
                    razorpay_signature: response.razorpay_signature
                })
            })
            .then(response => {
                if (!response.ok) {
                    throw new Error('Server returned ' + response.status + ': ' + response.statusText);
                }
                return response.json();
            })
            .then(data => {
                if (data.status === 'success') {
                    // Payment verified successfully, now process the order
                    processOrder(addressId, paymentMethod, response.razorpay_payment_id);
                } else {
                    showError('Payment verification failed: ' + data.message);
                    document.getElementById('loadingOverlay').style.display = 'none';
                }
            })
            .catch(error => {
                console.error('Error:', error);
                showError('Error verifying payment: ' + error.message);
                document.getElementById('loadingOverlay').style.display = 'none';
            });
        }

        function processOrder(addressId, paymentMethod, paymentId) {
            // Submit the form to process the order
            const form = document.createElement('form');
            form.method = 'POST';
            form.action = '${pageContext.request.contextPath}/processPayment';
            
            const addressInput = document.createElement('input');
            addressInput.type = 'hidden';
            addressInput.name = 'addressId';
            addressInput.value = addressId;
            
            const paymentMethodInput = document.createElement('input');
            paymentMethodInput.type = 'hidden';
            paymentMethodInput.name = 'paymentMethod';
            paymentMethodInput.value = paymentMethod;
            
            const paymentIdInput = document.createElement('input');
            paymentIdInput.type = 'hidden';
            paymentIdInput.name = 'paymentId';
            paymentIdInput.value = paymentId;
            
            form.appendChild(addressInput);
            form.appendChild(paymentMethodInput);
            form.appendChild(paymentIdInput);
            
            document.body.appendChild(form);
            form.submit();
        }
    });
</script>

</body>
</html>