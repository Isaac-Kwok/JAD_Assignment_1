<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<!-- 
  - Author: Md Redwanul Hoque Bhuiyan
  - Date: 10/11/2024
  - Copyright Notice:
  - @(#)
  - Description: Service details with booking and feedback feature.
-->
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	h2 {
		text-align: center;
	}
</style>
</head>

<body>
    <%@ include file="../includes/header_public.html" %> <!-- Include Header -->
    
    <h2>Service Details</h2>
    <div class="container">
        <div class="row">
            <%
                String categoryIdStr = request.getParameter("categoryId");
                if (categoryIdStr != null) {
                    try {
                        int categoryId = Integer.parseInt(categoryIdStr);
                        
                        // Connect to the database
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        String connURL = "jdbc:mysql://localhost/cleaning_service?user=root&password=henshin111&serverTimezone=UTC";
                        Connection conn = DriverManager.getConnection(connURL);
                        String sqlStr = "SELECT * FROM service WHERE category_id = ?";
                        PreparedStatement pstmt = conn.prepareStatement(sqlStr);
                        pstmt.setInt(1, categoryId);
                        ResultSet rs = pstmt.executeQuery();

                        while(rs.next()) {
                            String serviceName = rs.getString("service_name");
                            String description = rs.getString("description");
                            double price = rs.getDouble("price");
                            String imagePath = rs.getString("image");
            %>
            <div class="col-md-4">
                <div class="card">
                    <img src="<%= imagePath != null ? imagePath : "../images/default.png" %>" class="card-img-top" alt="<%= serviceName %>">
                    <div class="card-body">
                        <h5 class="card-title"><%= serviceName %></h5>
                        <p class="card-text"><%= description %></p>
                        <p><strong>Price:</strong> $<%= price %></p>
                        <a href="booking.jsp?serviceId=<%= rs.getInt("service_id") %>" class="btn btn-success">Book Service</a> 
                        <a href="feedback.jsp?serviceId=<%= rs.getInt("service_id") %>" class="btn btn-secondary">Feedback</a>
                    </div>
                </div>
            </div>
            <%
                        }
                        conn.close();
                    } catch (NumberFormatException e) {
                        out.println("<p>Error: Invalid category ID.</p>");
                    }
                } else {
                    out.println("<p>Error: Category ID is missing.</p>");
                }
            %>
        </div>
    </div>
    
    <%@ include file="../includes/footer.html" %> <!-- Include Footer -->
</body>
</html>