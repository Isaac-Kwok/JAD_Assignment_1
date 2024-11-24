<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!-- 
  - Author: Md Redwanul Hoque Bhuiyan
  - Date: 10/11/2024
  - Copyright Notice:
  - @(#)
  - Description: Displays a list of service categories and links to view individual services in each category.
-->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Service Categories</title>
<!-- Added Bootstrap & CSS files -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="../css/style.css">
<link rel="stylesheet" href="../css/colour.css">
	<%
	    // Retrieve the user ID from session for validation (if needed)
		String userIdValidation = (String) session.getAttribute("sessUserID");
	%>
</head>

<body>
	<%@ include file="../includes/header.jsp" %> <!-- Include Header -->
	
	<!-- Page Title -->
	<h1 class="text-center py-3">Service Categories</h1>
    <div class="container">
        <div class="row">
            <%
                // Establish a connection to the database
                Class.forName("com.mysql.jdbc.Driver");
                // Database connection URL for cleaning_service database
                String connURL = "jdbc:mysql://localhost:3306/cleaning_service?user=root&password=henshin111&serverTimezone=UTC";
                Connection conn = DriverManager.getConnection(connURL);  // Connect to the database
                Statement stmt = conn.createStatement();  // Create a statement to execute SQL queries
                // SQL query to select all service categories
                String sqlStr = "SELECT * FROM service_category";
                ResultSet rs = stmt.executeQuery(sqlStr);  // Execute the query and store the result
                
                // Iterate through the result set to display each service category
                while(rs.next()) {
                    String categoryName = rs.getString("category_name");  // Get the category name
                    String description = rs.getString("description");  // Get the category description
                    int categoryId = rs.getInt("category_id");  // Get the category ID
            %>
            
            <!-- Display the category information in a card layout -->
            <div class="col-md-4">
                <div class="card">
                    <div class="card-body">
                        <!-- Display category name and description -->
                        <h5 class="card-title"><%= categoryName %></h5>
                        <p class="card-text"><%= description %></p>
                        <!-- Link to view more details about services in this category -->
                        <a href="serviceDetails.jsp?categoryId=<%= categoryId %>" class="btn btn-primary">View Services</a>
                    </div>
                </div>
            </div>
            
            <%
                }
                conn.close();  // Close the database connection
            %>
        </div>
    </div>  
    
    <%@ include file="../includes/footer.html" %> <!-- Include Footer -->
</body>
</html>