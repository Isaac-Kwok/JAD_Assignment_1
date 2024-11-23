<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!-- 
  - Author: Md Redwanul Hoque Bhuiyan
  - Date: 21/11/2024
  - Copyright Notice:
  - @(#)
  - Description: Display and add feedback if user completed service.
-->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Feedback</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="../css/adminViewFeedback.css">
</head>
<body>
    <%@ include file="../includes/header.jsp" %> <!-- Include Header -->
    
     <div class="container">
        <h1 class="text-center py-3">Service Feedback</h1>
        
        <%
            // Fetch the service ID from the request
            String serviceIdStr = request.getParameter("serviceId");
            String memberIdStr = (String) session.getAttribute("sessUserID");

            if (serviceIdStr != null) {
                try {
                    int serviceId = Integer.parseInt(serviceIdStr);

                    // Connect to the database
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    String connURL = "jdbc:mysql://localhost/cleaning_service?user=root&password=henshin111&serverTimezone=UTC";
                    Connection conn = DriverManager.getConnection(connURL);

                    // Display all feedback for the selected service
                    String feedbackSQL = "SELECT f.rating, f.comment, m.name, f.feedback_date " +
                                         "FROM feedback f JOIN member m ON f.member_id = m.member_id " +
                                         "WHERE f.service_id = ? ORDER BY f.feedback_date DESC";
                    PreparedStatement feedbackStmt = conn.prepareStatement(feedbackSQL);
                    feedbackStmt.setInt(1, serviceId);
                    ResultSet feedbackRs = feedbackStmt.executeQuery();

                    if (feedbackRs.isBeforeFirst()) { %>
                        <h3>Feedback for this service:</h3>
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th>Username</th>
                                    <th>Rating</th>
                                    <th>Comment</th>
                                    <th>Date</th>
                                </tr>
                            </thead>
                            <tbody>
                            <% while (feedbackRs.next()) { %>
                                <tr>
                                    <td><%= feedbackRs.getString("name") %></td>
                                    <td><%= feedbackRs.getInt("rating") %></td>
                                    <td><%= feedbackRs.getString("comment") %></td>
                                    <td><%= feedbackRs.getTimestamp("feedback_date") %></td>
                                </tr>
                            <% } %>
                            </tbody>
                        </table>
                    <% } else { %>
                        <p>No feedback available for this service yet.</p>
                    <% }

                    feedbackRs.close();
                    feedbackStmt.close();

                    // Check if the user is logged in and has a completed booking
                    if (memberIdStr != null) {
                        int memberId = Integer.parseInt(memberIdStr);

                        String bookingSQL = "SELECT b.booking_id " +
                                "FROM booking b " +
                                "JOIN booking_details bd ON b.booking_id = bd.booking_id " +
                                "WHERE b.member_id = ? AND bd.service_id = ? AND b.status = 'Completed'";

                        PreparedStatement bookingStmt = conn.prepareStatement(bookingSQL);
                        bookingStmt.setInt(1, memberId);
                        bookingStmt.setInt(2, serviceId);
                        ResultSet bookingRs = bookingStmt.executeQuery();

                        if (bookingRs.next()) { %>
                            <h3>Add Your Feedback:</h3>
                            <form action="${pageContext.request.contextPath}/SubmitFeedbackServlet" method="post">
                                <input type="hidden" name="serviceId" value="<%= serviceId %>">
                                <div class="form-group">
                                    <label for="rating">Rating (1-5):</label>
                                    <input type="number" class="form-control" id="rating" name="rating" min="1" max="5" required>
                                </div>
                                <div class="form-group">
                                    <label for="comment">Comment:</label>
                                    <textarea class="form-control" id="comment" name="comment" rows="3" required></textarea>
                                </div>
                                <button type="submit" class="btn btn-warning my-2">Submit Feedback</button>
                            </form>
                        <% } else { %>
                            <p class="alert alert-warning">You must complete a booking for this service to leave feedback.</p>
                        <% }

                        bookingRs.close();
                        bookingStmt.close();
                    } else { %>
                        <p class="alert alert-info">Please <a href="login.jsp">log in</a> to add your feedback.</p>
                    <% }

                    conn.close();
                } catch (Exception e) {
                    out.println("<p class='alert alert-danger'>An error occurred: " + e.getMessage() + "</p>");
                }
            } else {
                out.println("<p class='alert alert-danger'>Service ID is missing.</p>");
            }
        %>
    </div>
    
    <%@ include file="../includes/footer.html" %> <!-- Include Footer -->
</body>
</html>
