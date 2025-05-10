<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Merchant Signup</title>
<style>
    :root {
        --primary-color: #4361ee;
        --primary-dark: #3a0ca3;
        --secondary-color: #f72585;
        --light-color: #f8f9fa;
        --dark-color: #212529;
        --gray-color: #6c757d;
        --success-color: #4bb543;
        --border-radius: 8px;
        --box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        --transition: all 0.3s ease;
    }

    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    body {
        background-color: #f5f7fa;
        color: var(--dark-color);
        line-height: 1.6;
        padding: 20px;
    }

    .container {
        max-width: 800px;
        margin: 2rem auto;
        padding: 2rem;
        background: white;
        border-radius: var(--border-radius);
        box-shadow: var(--box-shadow);
    }

    .form-header {
        text-align: center;
        margin-bottom: 2rem;
        position: relative;
    }

    .form-header h1 {
        font-size: 2.2rem;
        color: var(--primary-dark);
        margin-bottom: 0.5rem;
        font-weight: 700;
    }

    .form-header::after {
        content: '';
        display: block;
        width: 80px;
        height: 4px;
        background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
        margin: 0 auto;
        border-radius: 2px;
    }

    .form-group {
        margin-bottom: 1.5rem;
    }

    label {
        display: block;
        margin-bottom: 0.5rem;
        font-weight: 600;
        color: var(--dark-color);
    }

    input[type="text"],
    input[type="email"],
    input[type="password"],
    input[type="tel"],
    input[type="number"],
    textarea,
    select {
        width: 100%;
        padding: 12px 15px;
        border: 2px solid #e9ecef;
        border-radius: var(--border-radius);
        font-size: 1rem;
        transition: var(--transition);
    }

    input[type="text"]:focus,
    input[type="email"]:focus,
    input[type="password"]:focus,
    input[type="tel"]:focus,
    input[type="number"]:focus,
    textarea:focus,
    select:focus {
        border-color: var(--primary-color);
        outline: none;
        box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.2);
    }

    .form-row {
        display: flex;
        gap: 1rem;
    }

    .form-row .form-group {
        flex: 1;
    }

    .submit-btn {
        display: block;
        width: 100%;
        padding: 14px;
        background: linear-gradient(to right, var(--primary-color), var(--primary-dark));
        color: white;
        border: none;
        border-radius: var(--border-radius);
        font-size: 1.1rem;
        font-weight: 600;
        cursor: pointer;
        transition: var(--transition);
        text-transform: uppercase;
        letter-spacing: 1px;
    }

    .submit-btn:hover {
        background: linear-gradient(to right, var(--primary-dark), var(--primary-color));
        transform: translateY(-2px);
        box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
    }

    .login-link {
        text-align: center;
        margin-top: 1.5rem;
    }

    .login-link a {
        color: var(--primary-color);
        text-decoration: none;
        font-weight: 600;
    }

    .login-link a:hover {
        text-decoration: underline;
    }

    @media (max-width: 768px) {
        .container {
            padding: 1.5rem;
        }

        .form-header h1 {
            font-size: 1.8rem;
        }

        .form-row {
            flex-direction: column;
            gap: 0;
        }
    }
</style>
</head>
<body>
    <div class="container">
        <div class="form-header">
            <h1>MERCHANT SIGNUP</h1>
            <p>Create your merchant account to start selling</p>
        </div>

        <form action="./registerMerchant" method="post" id="signupForm">
            <div class="form-row">
                <div class="form-group">
                    <label for="name">Full Name</label>
                    <input type="text" id="name" name="name" placeholder="Enter your full name" required>
                </div>
                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" id="email" name="email" placeholder="Enter your email" required>
                </div>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label for="phone">Phone Number</label>
                    <input type="tel" id="phone" name="phone" placeholder="Enter 10-digit phone number" pattern="[0-9]{10}" required>
                </div>
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" placeholder="Create a password" required>
                </div>
            </div>

            <div class="form-group">
                <h3 style="margin-bottom: 1rem; color: var(--primary-dark); border-bottom: 1px solid #e9ecef; padding-bottom: 0.5rem;">Bank Details</h3>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label for="accountNumber">Account Number</label>
                    <input type="text" id="accountNumber" name="accountNumber" placeholder="Enter account number" required>
                </div>
                <div class="form-group">
                    <label for="bankName">Bank Name</label>
                    <input type="text" id="bankName" name="bankName" placeholder="Enter bank name" required>
                </div>
            </div>

            <div class="form-group">
                <label for="ifscCode">IFSC Code</label>
                <input type="text" id="ifscCode" name="ifscCode" placeholder="Enter IFSC code" required>
            </div>

            <button type="submit" class="submit-btn">Create Account</button>
            
            <div class="login-link">
                Already have an account? <a href="./merchantLogin">Login here</a>
            </div>
        </form>
    </div>

    <script>
        // Form validation can be added here
        document.getElementById('signupForm').addEventListener('submit', function(e) {
            // Add any client-side validation if needed
            // e.preventDefault(); // Uncomment to prevent form submission for testing
        });
    </script>
</body>
</html>