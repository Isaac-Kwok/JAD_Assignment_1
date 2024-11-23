<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!-- 
  - Author: Md Redwanul Hoque Bhuiyan
  - Date: 10/11/2024
  - Copyright Notice:
  - @(#)
  - Description: Categories of all the services.
-->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Service Categories</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="../css/style.css">
	<%
		String userIdValidation = (String) session.getAttribute("sessUserID");
	%>
</head>

<body>
	<%@ include file="../includes/header_public.html" %> <!-- Include Header -->
	<h1 class="text-center py-3">Service Categories</h1>
    <div class="container">
    	<div class="row">
        	<%
             // Connect to the database
             Class.forName("com.mysql.jdbc.Driver");
        	//String connURL = "jdbc:mysql://localhost:3306/jad_assignment1?user=root&password=subeteoshiete4@&serverTimezone=UTC";
             String connURL = "jdbc:mysql://localhost:3306/cleaning_service?user=root&password=henshin111&serverTimezone=UTC";
             Connection conn = DriverManager.getConnection(connURL);  		
             Statement stmt = conn.createStatement();
             String sqlStr = "SELECT * FROM service_category";
             ResultSet rs = stmt.executeQuery(sqlStr);

             while(rs.next()) {
                 String categoryName = rs.getString("category_name");
                 String description = rs.getString("description");
                 int categoryId = rs.getInt("category_id");
             %>
             <div class="col-md-4">
                 <div class="card">
                     <div class="card-body">
                         <h5 class="card-title"><%= categoryName %></h5>
                         <p class="card-text"><%= description %></p>
                         <a href="serviceDetails.jsp?categoryId=<%= categoryId %>" class="btn btn-primary">View Services</a>
                     </div>
                 </div>
             </div>
             <%
             }
             conn.close();
             %>
        </div>
    </div>  
    
    <%@ include file="../includes/footer.html" %> <!-- Include Footer -->
</body>
</html>