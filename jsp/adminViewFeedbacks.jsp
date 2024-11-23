<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!-- 
  - Author: Md Redwanul Hoque Bhuiyan
  - Date: 22/11/2024
  - Copyright Notice:
  - @(#)
  - Description: Admin Dashboard to modify services and view bookings with customer info.
-->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>View Feedback</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="../css/adminViewFeedbacks.css">
<script>
    function viewProfile(memberName) {
        window.location.href = "adminManageMembers.jsp?searchName=" + memberName;
    }
</script>
<!-- Apply Session Management -->
<%
    // Session Management Logic
    String userIdAdminValidation = (String) session.getAttribute("sessUserID");
    String userRoleAdminValidation = (String) session.getAttribute("sessUserRole");

    if (userIdAdminValidation == null || !"2".equals(userRoleAdminValidation)) {
        response.sendRedirect("login.jsp");
        return; // Prevent further execution of the page
    }
%>
</head>
	<%@ include file="../includes/header.jsp"%>
	<!-- Include Header -->
	
	<div class="container">
        <h1 class="text-center">View Feedback</h1>

        <!-- Sorting Form -->
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

            <button type="submit" class="btn btn-primary align-self-end px-2">Sort</button>
        </form>

        <!-- Feedback Table -->
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
                    String sortField = request.getParameter("sortField");
                    String order = request.getParameter("order");
                    if (sortField == null || sortField.isEmpty()) {
                        sortField = "feedback_date"; // Default sorting
                        order = "DESC"; // Default order
                    }

                    String query = "SELECT m.name AS username, sc.category_name, s.service_name, f.rating, f.comment, f.feedback_date, f.member_id " +
                            "FROM feedback f " +
                            "JOIN member m ON f.member_id = m.member_id " +
                            "JOIN service s ON f.service_id = s.service_id " +
                            "JOIN service_category sc ON s.category_id = sc.category_id ";

             // Add conditions to sort by category_id or service_id if needed
             if ("category_name".equals(sortField)) {
                 query += "ORDER BY sc.category_id " + order;  // Sorting by category_id based on category_name
             } else if ("service_name".equals(sortField)) {
                 query += "ORDER BY s.service_id " + order;  // Sorting by service_id based on service_name
             } else if ("feedback_date".equals(sortField)) {
                 query += "ORDER BY f.feedback_date " + order;  // Sorting by feedback_date
             } else {
                 query += "ORDER BY " + sortField + " " + order;  // Default sorting (if no category or service)
             }



                    try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/cleaning_service?user=root&password=henshin111&serverTimezone=UTC");
                         Statement stmt = conn.createStatement();
                         ResultSet rs = stmt.executeQuery(query)) {

                        while (rs.next()) {
                            String username = rs.getString("username");
                            String categoryName = rs.getString("category_name");
                            String serviceName = rs.getString("service_name");
                            int rating = rs.getInt("rating");
                            String comment = rs.getString("comment");
                            Timestamp feedbackDate = rs.getTimestamp("feedback_date");
                            int memberId = rs.getInt("member_id");
                %>
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
                        out.println("<tr><td colspan='7' class='text-danger'>Error: " + e.getMessage() + "</td></tr>");
                    }
                %>
            </tbody>
        </table>
    </div>
    
	<%@ include file="../includes/footer.html"%>
	<!-- Include Footer -->
<body>

</body>
</html>