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
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="../css/style.css">
	<%
		String userIdValidation = (String) session.getAttribute("sessUserID");
	%>
</head>

<body>
    <%@ include file="../includes/header.jsp" %> <!-- Include Header -->
    
    <!-- Go back to categories button -->
    <div class="back-btn py-3 px-4">
        <a href="serviceCategories.jsp" class="btn btn-primary">Go back to categories</a>
    </div>
    
    <h1 class="text-center py-3">Service Details</h1>
    <div class="container">
        <div class="row">
            <%
                String categoryIdStr = request.getParameter("categoryId");
                if (categoryIdStr != null) {
                    try {
                        int categoryId = Integer.parseInt(categoryIdStr);
                        
                        // Connect to the database
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        //String connURL = "jdbc:mysql://localhost:3306/jad_assignment1?user=root&password=subeteoshiete4@&serverTimezone=UTC";
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
                    <img src="../images/<%=imagePath%>" class="card-img-top" alt="<%= serviceName %>">
                    <div class="card-body">
                        <h5 class="card-title"><%= serviceName %></h5>
                        <p class="card-text"><%= description %></p>
                        <p><strong>Price:</strong> $<%= price %></p>
                        <a href="booking.jsp?serviceId=<%= rs.getInt("service_id") %>" class="btn btn-success">Book Service</a>
                        <br> 
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