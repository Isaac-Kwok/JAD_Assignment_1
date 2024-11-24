<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<!-- 
  - Author: Md Redwanul Hoque Bhuiyan
  - Date: 10/11/2024
  - Copyright Notice:
  - @(#)
  - Description: Displays service details along with options to book the service and provide feedback.
-->
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
    
    <!-- Button to go back to the service categories page -->
    <div class="back-btn py-3 px-4">
        <a href="serviceCategories.jsp" class="btn btn-primary text-black">Go back to categories</a>
    </div>
    
    <!-- Title for the service details page -->
    <h1 class="text-center py-3">Service Details</h1>

    <div class="container">
        <div class="row">
            <%
                // Get the category ID from the URL parameter (service category)
                String categoryIdStr = request.getParameter("categoryId");
                if (categoryIdStr != null) {
                    try {
                        // Parse the category ID as an integer
                        int categoryId = Integer.parseInt(categoryIdStr);
                        
                        // Connect to the MySQL database
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        String connURL = "jdbc:mysql://localhost/cleaning_service?user=root&password=henshin111&serverTimezone=UTC";
                        Connection conn = DriverManager.getConnection(connURL);
                        
                        // Prepare SQL query to fetch all services in the selected category
                        String sqlStr = "SELECT * FROM service WHERE category_id = ?";
                        PreparedStatement pstmt = conn.prepareStatement(sqlStr);
                        pstmt.setInt(1, categoryId); // Set the category ID as the parameter in the query
                        ResultSet rs = pstmt.executeQuery(); // Execute the query and get the results

                        // Iterate over the result set and display each service
                        while(rs.next()) {
                            String serviceName = rs.getString("service_name");  // Get service name
                            String description = rs.getString("description");  // Get service description
                            double price = rs.getDouble("price");  // Get service price
                            String imagePath = rs.getString("image");  // Get the image path for the service
            %>
            <!-- Display the service in a Bootstrap card layout -->
            <div class="col-md-4">
                <div class="card">
                    <!-- Display the service image -->
                    <img src="../images/<%=imagePath%>" class="card-img-top" alt="<%= serviceName %>">
                    <div class="card-body">
                        <!-- Display the service name, description, and price -->
                        <h5 class="card-title"><%= serviceName %></h5>
                        <p class="card-text"><%= description %></p>
                        <p><strong>Price:</strong> $<%= price %></p>
                        <!-- Button to navigate to the booking page for the selected service -->
                        <a href="booking.jsp?serviceId=<%= rs.getInt("service_id") %>" class="btn btn-success">Book Service</a>
                        <br> 
                        <!-- Button to navigate to the feedback page for the selected service -->
                        <a href="feedback.jsp?serviceId=<%= rs.getInt("service_id") %>" class="btn btn-secondary">Feedback</a>
                    </div>
                </div>
            </div>
            <%
                        }
                        conn.close();  // Close the database connection after processing
                    } catch (NumberFormatException e) {
                        // Handle error in case of invalid category ID format
                        out.println("<p>Error: Invalid category ID.</p>");
                    }
                } else {
                    // Handle error if the category ID is missing from the URL
                    out.println("<p>Error: Category ID is missing.</p>");
                }
            %>
        </div>
    </div>
    
    <%@ include file="../includes/footer.html" %> <!-- Include Footer -->
</body>
</html>