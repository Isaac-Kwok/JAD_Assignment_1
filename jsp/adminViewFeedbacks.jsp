<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!-- 
  - Author: Md Redwanul Hoque Bhuiyan
  - Date: 22/11/2024
  - Copyright Notice:
  - @(#)
  - Description: Admin Page to view feedback and url to retrieve feedback giver's profile.
-->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>View Feedback</title>
<!-- Added Bootstrap & CSS files -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="../css/style.css">
<link rel="stylesheet" href="../css/colour.css">
<link rel="stylesheet" href="../css/feedbacks.css">
<script>
    // JavaScript function to redirect to member profile page based on the member's username
    function viewProfile(memberName) {
        window.location.href = "adminManageMembers.jsp?searchName=" + memberName;
    }
</script>

<!-- Session Management: Ensuring that only admin users can access this page -->
<%
    // Session Validation for Admin Role
    String userIdAdminValidation = (String) session.getAttribute("sessUserID");
    String userRoleAdminValidation = (String) session.getAttribute("sessUserRole");

    // Redirect to login page if session is not valid or user is not an admin
    if (userIdAdminValidation == null || !"2".equals(userRoleAdminValidation)) {
        response.sendRedirect("login.jsp");
        return; // Stop further page execution
    }
%>
</head>

<body>
	<%@ include file="../includes/header.jsp"%> 
	<!-- Include header -->
	
	<!-- Page Content -->
	<div class="container">
	    <h1 class="text-center">View Feedback</h1>
	
	    <!-- Sorting Form: Allows the admin to sort feedback by various fields -->
	    <form method="get" action="adminViewFeedbacks.jsp" class="sorting-form d-flex justify-content-center mb-4">
	        <div class="form-group px-2">
	            <label for="sortField">Sort By</label>
	            <select name="sortField" class="form-select">
	                <option value="category_name">Category</option>
	                <option value="service_name">Service</option>
	                <option value="rating">Rating</option>
	                <option value="feedback_date">Date</option>
	            </select>
	        </div>
	        <br>
	        <div class="form-group px-2">
	            <label for="order">Order</label>
	            <select name="order" class="form-select">
	                <option value="ASC">Ascending</option>
	                <option value="DESC">Descending</option>
	            </select>
	        </div>
	
	        <!-- Submit button for sorting feedback -->
	        <button type="submit" class="btn btn-primary align-self-end px-2">Sort</button>
	    </form>
	
	    <!-- Feedback Table: Displays all feedback details fetched from the database -->
	    <table class="table table-bordered table-striped">
	        <thead>
	            <tr>
	                <th>Username</th>
	                <th>Category Name</th>
	                <th>Service Name</th>
	                <th>Rating</th>
	                <th>Comment</th>
	                <th>Feedback Date</th>
	                <th>Actions</th>
	            </tr>
	        </thead>
	        <tbody>
	            <%
	                // Get sorting parameters from request (if available)
	                String sortField = request.getParameter("sortField");
	                String order = request.getParameter("order");
	
	                // Set default values if no sorting parameters are provided
	                if (sortField == null || sortField.isEmpty()) {
	                    sortField = "feedback_date"; // Default sorting by feedback date
	                    order = "DESC"; // Default order (Descending)
	                }
	
	                // Sql query to fetch feedback data from the database
	                String query = "SELECT m.name AS username, sc.category_name, s.service_name, f.rating, f.comment, f.feedback_date, f.member_id " +
	                        "FROM feedback f " +
	                        "JOIN member m ON f.member_id = m.member_id " +
	                        "JOIN service s ON f.service_id = s.service_id " +
	                        "JOIN service_category sc ON s.category_id = sc.category_id ";
	
	                // Dynamically add ORDER BY clause based on the selected sorting option
	                if ("category_name".equals(sortField)) {
	                    query += "ORDER BY sc.category_id " + order; // Sort by category name
	                } else if ("service_name".equals(sortField)) {
	                    query += "ORDER BY s.service_id " + order; // Sort by service name
	                } else if ("feedback_date".equals(sortField)) {
	                    query += "ORDER BY f.feedback_date " + order; // Sort by feedback date
	                } else {
	                    query += "ORDER BY " + sortField + " " + order; // Default sorting
	                }
	
	                // Execute the query and display results in the table
	                try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/cleaning_service?user=root&password=henshin111&serverTimezone=UTC");
	                     Statement stmt = conn.createStatement();
	                     ResultSet rs = stmt.executeQuery(query)) {
	
	                    // Loop through the result set and display feedback details
	                    while (rs.next()) {
	                        String username = rs.getString("username");
	                        String categoryName = rs.getString("category_name");
	                        String serviceName = rs.getString("service_name");
	                        int rating = rs.getInt("rating");
	                        String comment = rs.getString("comment");
	                        Timestamp feedbackDate = rs.getTimestamp("feedback_date");
	                        int memberId = rs.getInt("member_id");
	            %>
	                    <!-- Display feedback details in each row -->
	                    <tr>
	                        <td><%= username %></td>
	                        <td><%= categoryName %></td>
	                        <td><%= serviceName %></td>
	                        <td><%= rating %></td>
	                        <td><%= comment %></td>
	                        <td><%= feedbackDate %></td>
	                        <td><button onclick="viewProfile('<%= username %>')" class="btn btn-warning action-btn">View Profile</button></td>
	                    </tr>
	            <%
	                    }
	                } catch (SQLException e) {
	                    // Handle any SQL errors and display them in the table
	                    out.println("<tr><td colspan='7' class='text-danger'>Error: " + e.getMessage() + "</td></tr>");
	                }
	            %>
	        </tbody>
	    </table>
	</div>
	
	<%@ include file="../includes/footer.html"%> <!-- Include footer for consistent page layout -->
</body>
</html>