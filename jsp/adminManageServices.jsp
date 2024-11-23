<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Manage Service</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
</head>
<body>
	<%@ include file="../includes/header.jsp"%>
	<!-- Include Header -->
	
	<div class="container">
        <h1 class="text-center">Manage Service</h1>
		<%
		    // Session Management Logic
		    String userIdAdminValidation = (String) session.getAttribute("sessUserID");
		    String userRoleAdminValidation = (String) session.getAttribute("sessUserRole");
		
		    if (userIdAdminValidation == null || !"2".equals(userRoleAdminValidation)) {
		        response.sendRedirect("login.jsp");
		        return; // Prevent further execution of the page
		    }
		
		    String serviceId = request.getParameter("serviceId");
		    String statusMessage = null;
		
		    // Database connection
		    Connection conn = null;
		    PreparedStatement stmt = null;
		    ResultSet rs = null;
		    ResultSet categoryRs = null;
		
		    try {
		        Class.forName("com.mysql.cj.jdbc.Driver");
		        String connURL = "jdbc:mysql://localhost/cleaning_service?user=root&password=henshin111&serverTimezone=UTC";
		        conn = DriverManager.getConnection(connURL);
		
		        // Fetch the service details for updating
		        if (serviceId != null) {
		            String serviceQuery = "SELECT * FROM service WHERE service_id = ?";
		            stmt = conn.prepareStatement(serviceQuery);
		            stmt.setInt(1, Integer.parseInt(serviceId));
		            rs = stmt.executeQuery();
		
		            if (rs.next()) {
		                // Populating form fields for update (service_name, price, etc.)
		                request.setAttribute("serviceName", rs.getString("service_name"));
		                request.setAttribute("serviceDescription", rs.getString("description"));
		                request.setAttribute("servicePrice", rs.getDouble("price"));
		                
		                // Get category ID and populate category
		                int categoryId = rs.getInt("category_id");
		                String categoryQuery = "SELECT category_name FROM service_category WHERE category_id = ?";
		                stmt = conn.prepareStatement(categoryQuery);
		                stmt.setInt(1, categoryId);
		                categoryRs = stmt.executeQuery();
		                if (categoryRs.next()) {
		                    request.setAttribute("serviceCategory", categoryRs.getString("category_name"));
		                }
		            }
		        }
		
		        // Handling form submissions for adding, updating, or deleting a service
		        if ("POST".equalsIgnoreCase(request.getMethod())) {
		            String action = request.getParameter("action");
		            if ("add".equals(action)) {
		                String newServiceName = request.getParameter("service_name");
		                String newServiceDesc = request.getParameter("service_desc");
		                double newServicePrice = Double.parseDouble(request.getParameter("service_price"));
		                String categoryName = request.getParameter("category_name");

		                // Fetch the category ID from service_category table
		                String categoryQuery = "SELECT category_id FROM service_category WHERE category_name = ?";
		                stmt = conn.prepareStatement(categoryQuery);
		                stmt.setString(1, categoryName);
		                rs = stmt.executeQuery();
		                int categoryId = 0;
		                if (rs.next()) {
		                    categoryId = rs.getInt("category_id");
		                }
		
		                // Insert service into the database
		                String insertSQL = "INSERT INTO service (service_name, description, price, category_id) VALUES (?, ?, ?, ?)";
		                stmt = conn.prepareStatement(insertSQL);
		                stmt.setString(1, newServiceName);
		                stmt.setString(2, newServiceDesc);
		                stmt.setDouble(3, newServicePrice);
		                stmt.setInt(4, categoryId);
		                int rowsInserted = stmt.executeUpdate();
		                if (rowsInserted > 0) {
		                    statusMessage = "Service added successfully!";
		                } else {
		                    statusMessage = "Failed to add service.";
		                }
		            } else if ("update".equals(action) && serviceId != null) {
		                String updatedServiceName = request.getParameter("service_name");
		                String updatedServiceDesc = request.getParameter("service_desc");
		                double updatedServicePrice = Double.parseDouble(request.getParameter("service_price"));
		
		                String updateSQL = "UPDATE service SET service_name = ?, description = ?, price = ? WHERE service_id = ?";
		                stmt = conn.prepareStatement(updateSQL);
		                stmt.setString(1, updatedServiceName);
		                stmt.setString(2, updatedServiceDesc);
		                stmt.setDouble(3, updatedServicePrice);
		                stmt.setInt(4, Integer.parseInt(serviceId));
		                int rowsUpdated = stmt.executeUpdate();
		                if (rowsUpdated > 0) {
		                    statusMessage = "Service updated successfully!";
		                } else {
		                    statusMessage = "Failed to update service.";
		                }
		            } else if ("delete".equals(action) && serviceId != null) {
		                String deleteSQL = "DELETE FROM service WHERE service_id = ?";
		                stmt = conn.prepareStatement(deleteSQL);
		                stmt.setInt(1, Integer.parseInt(serviceId));
		                int rowsDeleted = stmt.executeUpdate();
		                if (rowsDeleted > 0) {
		                    statusMessage = "Service deleted successfully!";
		                } else {
		                    statusMessage = "Failed to delete service.";
		                }
		            }
		        }
		
		    } catch (SQLException e) {
		    	e.printStackTrace();
		        statusMessage = "Database error: " + e.getMessage();
		    } 
		    conn.close();
		%>
		<!-- Display status message -->
	    <%
	        if (statusMessage != null) {
	    %>
	        <div class="alert alert-info">
	            <%= statusMessage %>
	        </div>
	    <%
	        }
	    %>
	
	    <%-- Check if serviceId is present --%>
	    <% boolean hasServiceId = serviceId != null && !serviceId.trim().isEmpty(); %>
	
	    <%-- Update Form and Delete Button only visible if serviceId exists --%>
	    <% if (hasServiceId) { %>
	        <!-- Form for updating the service -->
	        <h2>Update Service</h2>
	        <form method="post" action="adminManageServices.jsp?serviceId=<%= serviceId %>">
	            <input type="hidden" name="action" value="update">
	            <div class="mb-3">
	                <label for="service_name" class="form-label">Service Name</label>
	                <input type="text" name="service_name" class="form-control" value="<%= request.getAttribute("serviceName") %>" required>
	            </div>
	            <div class="mb-3">
	                <label for="service_desc" class="form-label">Description</label>
	                <textarea name="service_desc" class="form-control" required><%= request.getAttribute("serviceDescription") %></textarea>
	            </div>
	            <div class="mb-3">
	                <label for="service_price" class="form-label">Price</label>
	                <input type="number" name="service_price" class="form-control" value="<%= request.getAttribute("servicePrice") %>" required>
	            </div>
	            <button type="submit" class="btn btn-primary">Update Service</button>
	        </form>
	
	        <hr>
	
	        <!-- Form for deleting the selected service -->
	        <h2>Delete Service: <%= request.getAttribute("serviceName") %></h2>
	        <form method="post" action="adminManageServices.jsp?serviceId=<%= serviceId %>">
	            <input type="hidden" name="action" value="delete">
	            <button type="submit" class="btn btn-danger" onclick="return confirm('Are you sure you want to delete this service?')">Delete</button>
	        </form>
	    <% } %>
	    
	    <hr>
	
	    <!-- Form for adding a new service -->
	    <h2>Add New Service</h2>
	    <form method="post" action="adminManageServices.jsp">
	        <input type="hidden" name="action" value="add">
	        <div class="mb-3">
	            <label for="service_name" class="form-label">Service Name</label>
	            <input type="text" name="service_name" class="form-control" required>
	        </div>
	        <div class="mb-3">
	            <label for="service_desc" class="form-label">Description</label>
	            <textarea name="service_desc" class="form-control" required></textarea>
	        </div>
	        <div class="mb-3">
	            <label for="service_price" class="form-label">Price</label>
	            <input type="number" name="service_price" class="form-control" required>
	        </div>
	        <div class="mb-3">
	            <label for="category_name" class="form-label">Category</label>
	            <select name="category_name" class="form-control" required>
				    <option value="Residential Cleaning">Residential Cleaning</option>
			        <option value="Commercial Cleaning">Commercial Cleaning</option>
			        <option value="Event Cleaning">Event Cleaning</option>
			        <option value="Medical Facility Cleaning">Medical Facility Cleaning</option>
			        <option value="Vehicle Cleaning">Vehicle Cleaning</option>
	            </select>
	        </div>
	        <button type="submit" class="btn btn-success">Add Service</button>
	    </form>
    </div>
    
    <%@ include file="../includes/footer.html"%>
	<!-- Include Footer -->
</body>
</html>