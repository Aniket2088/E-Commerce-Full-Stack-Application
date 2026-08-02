🛒 ShopEase — E-Commerce Platform for Electronics

A full-stack e-commerce web application built with Spring MVC, Hibernate, and JSP, designed for browsing, purchasing, and managing electronics products online.

Features • Tech Stack • Architecture • Getting Started • Project Structure • Roadmap

</div>
📖 About The Project

ShopEase is a Java-based e-commerce web application focused on electronics retail. It supports the full customer journey — from browsing products and managing a cart, to checkout, payment, and order tracking — along with merchant-side product management.

Built as a hands-on implementation of the Spring MVC + Hibernate (JPA) stack using classic JSP views, this project demonstrates layered architecture (Controller → Service → DAO → Entity), session-based cart handling, and cloud-based product image uploads.

✨ Features
🔐 User Authentication — registration, login, and session-based access control
🛍️ Product Catalog — browse, search, and filter electronics by category
🛒 Shopping Cart — add, update quantity, and remove items with live subtotal/tax calculation
📍 Address Management — save and manage shipping addresses
💳 Payment & Checkout — order summary with tax breakdown and checkout flow
📦 Order Management — view past orders and order history
🧑‍💼 Merchant Panel — merchants can add, update, and manage their product listings
☁️ Cloud Image Uploads — product images hosted via cloud storage integration
📱 Responsive UI — Bootstrap 5-based responsive design across devices
🛠️ Tech Stack
Layer	Technology
Language	Java 17
Framework	Spring MVC
ORM	Hibernate (JPA)
View Layer	JSP, JSTL
Database	MySQL
Build Tool	Maven
Frontend	Bootstrap 5, Font Awesome
Server	Apache Tomcat 9
Image Storage	Cloud-based image hosting
🏗️ Architecture

The project follows a classic layered MVC architecture:

Controller Layer   →  Handles HTTP requests, routes to services
Service Layer       →  Business logic
DAO Layer           →  Data access via Hibernate
Entity Layer         →  JPA-mapped domain models
JSP Views           →  Server-rendered UI with JSTL

Core Modules:

ProductController / ProductService / ProductDao — product catalog management
CartController — cart operations (add/update/remove)
UserController — authentication and user profile
AddressController — shipping address CRUD
PaymentController — checkout and payment flow
MerchanController — merchant-side product management

Core Entities: Product, User, Merchant, Address, Order

🚀 Getting Started
Prerequisites
Java 17+ (JDK)
Apache Maven 3.8+
Apache Tomcat 9
MySQL 8.x
An IDE with Maven + WTP support (Eclipse / STS / IntelliJ)
Installation
Clone the repository
bash
   git clone https://github.com/Aniket2088/E-Commerce-Full-Stack-Application.git
   cd E-Commerce-Full-Stack-Application
Configure the database Update your database connection details in the persistence configuration file (src/main/resources/META-INF/persistence.xml or equivalent):
