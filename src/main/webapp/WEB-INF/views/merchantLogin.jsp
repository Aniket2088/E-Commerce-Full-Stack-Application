<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Merchant Login</title>
<style>
    :root {
        --primary-color: #4361ee;
        --primary-dark: #3a0ca3;
        --secondary-color: #f72585;
        --light-color: #f8f9fa;
        --dark-color: #212529;
        --gray-color: #6c757d;
        --success-color: #4bb543;
        --error-color: #ff3333;
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
        max-width: 500px;
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

    input[type="email"],
    input[type="password"] {
        width: 100%;
        padding: 12px 15px;
        border: 2px solid #e9ecef;
        border-radius: var(--border-radius);
        font-size: 1rem;
        transition: var(--transition);
    }

    input[type="email"]:focus,
    input[type="password"]:focus {
        border-color: var(--primary-color);
        outline: none;
        box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.2);
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

    .signup-link {
        text-align: center;
        margin-top: 1.5rem;
    }

    .signup-link a {
        color: var(--primary-color);
        text-decoration: none;
        font-weight: 600;
    }

    .signup-link a:hover {
        text-decoration: underline;
    }

    .alert {
        padding: 12px 15px;
        border-radius: var(--border-radius);
        margin-bottom: 1.5rem;
    }

    .alert-success {
        background-color: rgba(75, 181, 67, 0.2);
        color: var(--success-color);
        border: 1px solid var(--success-color);
    }

    .alert-error {
        background-color: rgba(255, 51, 51, 0.2);
        color: var(--error-color);
        border: 1px solid var(--error-color);
    }

    @media (max-width: 768px) {
        .container {
            padding: 1.5rem;
        }

        .form-header h1 {
            font-size: 1.8rem;
        }
    }
</style>
</head>
<body>
    <div class="container">
        <div class="form-header">
            <h1>MERCHANT LOGIN</h1>
            <p>Sign in to access your merchant dashboard</p>
        </div>

        <%-- Display error messages if any --%>
        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-error">
                <%= request.getAttribute("error") %>
            </div>
        <% } %>
        
        <%-- Display success messages if any (e.g., after registration) --%>
        <% if (request.getAttribute("success") != null) { %>
            <div class="alert alert-success">
                <%= request.getAttribute("success") %>
            </div>
        <% } %>

        <form action="${pageContext.request.contextPath}/merchantLogin" method="post">
            <div class="form-group">
                <label for="email">Email Address</label>
                <input type="email" id="email" name="email" placeholder="Enter your registered email" required>
            </div>

            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" placeholder="Enter your password" required>
            </div>

            <button type="submit" class="submit-btn">Login</button>
            
            <div class="signup-link">
                Don't have an account? <a href="./MerchantSignup">Sign up here</a>
            </div>
        </form>
    </div>
</body>
</html>