<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../includes/header_public.html" %> <!-- Include Header -->

<!-- 
  - Author(s): [Your Name]
  - Date: [Current Date]
  - Description: This JSP page serves as the homepage (landing page) for the Cleaning Service web app.
-->

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Home - Cleaning Service</title>
</head>
<body>
    <main>
        <h2>Welcome to Cleaning Service</h2>
        <p>Your trusted partner for professional cleaning services. We offer a variety of services to meet your home and office cleaning needs, with an easy-to-navigate booking system and customer-focused feedback.</p>
        
        <div>
            <h3>Our Services</h3>
            <p>From home cleaning to specialized services, explore our offerings designed to make your life easier and cleaner.</p>
            <a href="serviceCategories.jsp"><button>View Services</button></a>
        </div>
        
        <div>
            <h3>Become a Member</h3>
            <p>Sign up to book services, track appointments, and enjoy exclusive member benefits.</p>
            <a href="register.jsp"><button>Register Now</button></a>
        </div>
    </main>

    <br>
    <%@ include file="../includes/footer.html" %> <!-- Include Footer -->
</body>
</html>
