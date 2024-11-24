<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!-- 
  - Author: Md Redwanul Hoque Bhuiyan
  - Date: 19/11/2024
  - Copyright Notice:
  - @(#)
  - Description: Admin Page to view members and update selected member details such as inappropriate username, address etc and delete member
-->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Manage Members</title>
<!-- Added Bootstrap & CSS files -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="../css/style.css">
<link rel="stylesheet" href="../css/colour.css">
<link rel="stylesheet" href="../css/adminManagement.css">
<script>
    //Function to confirm member deletion
	function confirmDelete(memberId) {
	    if (confirm("Are you sure you want to delete this member?")) {
	        document.getElementById('deleteForm').memberId.value = memberId;
	        document.getElementById('deleteForm').submit();
	    }
	}

	// Function to display the update form with pre-filled data for better user experience
    function showUpdateForm(memberId, name, phone, address) {
        document.getElementById('updateForm').style.display = 'block';
        document.getElementById('memberId').value = memberId;
        document.getElementById('name').value = name;
        document.getElementById('phone').value = phone;
        document.getElementById('address').value = address;
    }
</script>

	<%
	    // Apply Session Management: Ensure the user is logged in as an admin
	    String userIdAdminValidation = (String) session.getAttribute("sessUserID");
	    String userRoleAdminValidation = (String) session.getAttribute("sessUserRole");
	
	    // Redirect to login if the user is not an admin
	    if (userIdAdminValidation == null || !"2".equals(userRoleAdminValidation)) {
	        response.sendRedirect("login.jsp");
	        return; // Prevent further execution of the page
	    }
	    
	    // Initialize variables for search and action handling
	    String searchName = request.getParameter("searchName");
	    String action = request.getParameter("action");
	    String message = null;
	
	    // Handle update operation
	    if ("update".equals(action)) {
	        int memberId = Integer.parseInt(request.getParameter("memberId"));
	        String name = request.getParameter("name");
	        String phone = request.getParameter("phone");
	        String address = request.getParameter("address");
	
	     // Update member details in the database
	        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/cleaning_service?user=root&password=henshin111&serverTimezone=UTC");
	             PreparedStatement stmt = conn.prepareStatement("UPDATE member SET name = ?, phone_number = ?, address = ? WHERE member_id = ?")) {

	            stmt.setString(1, name);
	            stmt.setString(2, phone);
	            stmt.setString(3, address);
	            stmt.setInt(4, memberId);
	            stmt.executeUpdate();
	            message = "Member updated successfully!";
	        } catch (SQLException e) {
	            message = "Error updating member: " + e.getMessage();
	        }
	    }

	    // Handle member delete operation
	    if ("delete".equals(action)) {
	        int memberId = Integer.parseInt(request.getParameter("memberId"));

	        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/cleaning_service?user=root&password=henshin111&serverTimezone=UTC")) {
	            // Check for existing bookings before deletion
	            PreparedStatement checkBookingStmt = conn.prepareStatement("SELECT COUNT(*) FROM booking WHERE member_id = ?");
	            checkBookingStmt.setInt(1, memberId);
	            ResultSet rs = checkBookingStmt.executeQuery();
	            rs.next();
	            int bookingCount = rs.getInt(1);

	            // If member has existing bookings, prevent deletion
	            if (bookingCount > 0) {
	                message = "Error deleting member: This member has existing bookings.";
	            } else {
	                // If no bookings, proceed with deletion
	                PreparedStatement deleteStmt = conn.prepareStatement("DELETE FROM member WHERE member_id = ?");
	                deleteStmt.setInt(1, memberId);
	                deleteStmt.executeUpdate();
	                message = "Member deleted successfully!";
	            }
	        } catch (SQLException e) {
	            message = "Error deleting member: " + e.getMessage();
	        }
	    }
	%>
</head>

<body>
	<%@ include file="../includes/header.jsp"%>
	<!-- Include Header -->
	
	<div class="container">
	    <h1>Manage Members</h1>
	
	    <% if (message != null) { %>
	        <div class="alert alert-info"><%= message %></div>
	    <% } %>
	
	    <!-- Search Form for members -->
	    <form method="get" action="adminManageMembers.jsp" class="mb-4">
	        <div class="input-group">
	            <input type="text" name="searchName" placeholder="Search by name" class="form-control" value="<%= searchName != null ? searchName : "" %>">
	            <button type="submit" class="btn btn-primary">Search</button>
	        </div>
	    </form>
	
	    <!-- Table to display all members -->
	    <table class="table table-bordered">
	        <thead>
	            <tr class="table-primary">
	                <th>Name</th>
	                <th>Email</th>
	                <th>Phone Number</th>
	                <th>Address</th>
	                <th>Actions</th>
	            </tr>
	        </thead>
	        <tbody>
	            <%
	                // Query to fetch members from the database
	                String query = "SELECT * FROM member";
	                if (searchName != null && !searchName.isEmpty()) {
	                    query += " WHERE name LIKE ?";
	                }

	                boolean hasResults = false;

	                // Execute the query and display members
	                try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/cleaning_service?user=root&password=henshin111&serverTimezone=UTC");
	                     PreparedStatement stmt = conn.prepareStatement(query)) {

	                    if (searchName != null && !searchName.isEmpty()) {
	                        stmt.setString(1, "%" + searchName + "%");
	                    }

	                    ResultSet rs = stmt.executeQuery();
	                    while (rs.next()) {
	                        hasResults = true;
	                        int memberId = rs.getInt("member_id");
	                        String name = rs.getString("name");
	                        String email = rs.getString("email");
	                        String phone = rs.getString("phone_number");
	                        String address = rs.getString("address");
	            %>
	                        <tr>
	                            <td><%= name %></td>
	                            <td><%= email %></td>
	                            <td><%= phone %></td>
	                            <td><%= address %></td>
	                            <td>
	                                <button class="btn btn-warning btn-sm" onclick="showUpdateForm('<%= memberId %>', '<%= name %>', '<%= phone %>', '<%= address %>')">Update</button>
	                                <button class="btn btn-danger btn-sm" onclick="confirmDelete('<%= memberId %>')">Delete</button>
	                            </td>
	                        </tr>
	            <%
	                    }
	                } catch (SQLException e) {
	                    out.println("<tr><td colspan='5'>Error: " + e.getMessage() + "</td></tr>");
	                }

	                // Display message if no members are found
	                if (!hasResults) {
	            %>
	                <tr>
	                    <td colspan="5" class="no-results">No members found<% if (searchName != null && !searchName.isEmpty()) { %> with the name "<%= searchName %>"<% } %>.</td>
	                </tr>
	            <%
	                }
	            %>
	        </tbody>
	    </table>
	
	    <!-- Update Form to modify member details -->
	    <div id="updateForm" style="display:none;" class="card p-3">
	        <h3>Update Member</h3>
	        <form method="post" action="adminManageMembers.jsp">
	            <input type="hidden" name="action" value="update">
	            <input type="hidden" id="memberId" name="memberId">
	            <div class="mb-3">
	                <label class="form-label">Name:</label>
	                <input type="text" id="name" name="name" class="form-control" required>
	            </div>
	            <div class="mb-3">
	                <label class="form-label">Phone:</label>
	                <input type="text" id="phone" name="phone" class="form-control">
	            </div>
	            <div class="mb-3">
	                <label class="form-label">Address:</label>
	                <textarea id="address" name="address" class="form-control"></textarea>
	            </div>
	            <button type="submit" class="btn btn-success">Save Changes</button>
	        </form>
	    </div>
	
	    <!-- Hidden form to delete member -->
	    <form method="post" action="adminManageMembers.jsp" id="deleteForm">
	        <input type="hidden" name="action" value="delete">
	        <input type="hidden" name="memberId">
	    </form>
	</div>
	
	<%@ include file="../includes/footer.html"%>
	<!-- Include Footer -->
</body>
</html>