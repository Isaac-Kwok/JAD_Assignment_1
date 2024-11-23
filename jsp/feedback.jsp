<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!-- 
  - Author: Md Redwanul Hoque Bhuiyan
  - Date: 12/11/2024
  - Copyright Notice:
  - @(#)
  - Description: Display and add feedback if user completed service.
-->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Feedback</title>
</head>
<body>
	<%@ include file="../includes/header_public.html" %> <!-- Include Header -->
	
    <h2>Feedback for Service</h2>
    <div class="container">
        <%
            // Get service ID from request
            String serviceIdStr = request.getParameter("serviceId");
            int memberId = (Integer) session.getAttribute("member_id"); // Using pre-defined session object
            
            if (serviceIdStr != null && memberId > 0) {
                try {
                    int serviceId = Integer.parseInt(serviceIdStr);

                    // Connect to the database
                    Class.forName("com.mysql.jdbc.Driver");
                  //String connURL = "jdbc:mysql://localhost:3306/jad_assignment1?user=root&password=subeteoshiete4@&serverTimezone=UTC";
                    String connURL = "jdbc:mysql://localhost/cleaning_service?user=root&password=henshin111&serverTimezone=UTC";
                    Connection conn = DriverManager.getConnection(connURL);

                    // Check if the user has a completed booking for this service
                    String checkBookingSQL = "SELECT * FROM booking b "
                                           + "JOIN booking_details bd ON b.booking_id = bd.booking_id "
                                           + "WHERE b.member_id = ? AND bd.service_id = ? AND b.status = 'Completed'";
                    PreparedStatement checkBookingStmt = conn.prepareStatement(checkBookingSQL);
                    checkBookingStmt.setInt(1, memberId);
                    checkBookingStmt.setInt(2, serviceId);
                    ResultSet bookingResult = checkBookingStmt.executeQuery();

                    boolean canAddFeedback = bookingResult.next();

                    // Display existing feedback
                    String feedbackSQL = "SELECT f.rating, f.comment, f.feedback_date, m.name AS member_name "
                                       + "FROM feedback f "
                                       + "JOIN member m ON f.member_id = m.member_id "
                                       + "WHERE f.service_id = ? "
                                       + "ORDER BY f.feedback_date DESC";
                    PreparedStatement feedbackStmt = conn.prepareStatement(feedbackSQL);
                    feedbackStmt.setInt(1, serviceId);
                    ResultSet feedbackResult = feedbackStmt.executeQuery();
        %>

        <h3>All Feedback</h3>
        <div>
            <%
                while (feedbackResult.next()) {
                    String memberName = feedbackResult.getString("member_name");
                    int rating = feedbackResult.getInt("rating");
                    String comment = feedbackResult.getString("comment");
                    String feedbackDate = feedbackResult.getString("feedback_date");
            %>
                <div class="feedback-entry">
                    <p><strong><%= memberName %></strong> (Rating: <%= rating %> stars)</p>
                    <p><%= comment %></p>
                    <p><em>Submitted on <%= feedbackDate %></em></p>
                </div>
                <hr>
            <%
                }
            %>
        </div>

        <% 
            if (canAddFeedback) { 
        %>
        <!-- Add Feedback Form -->
        <h3>Add Your Feedback</h3>
        <form action="SubmitFeedbackServlet" method="post">
            <input type="hidden" name="serviceId" value="<%= serviceId %>">
            <label for="rating">Rating (1 to 5):</label>
            <input type="number" id="rating" name="rating" min="1" max="5" required><br><br>

            <label for="comment">Comment:</label><br>
            <textarea id="comment" name="comment" rows="4" cols="50" required></textarea><br><br>

            <input type="submit" value="Submit Feedback">
        </form>
        <% 
            } else {
                out.println("<p style='color:red;'>You can only add feedback if you have completed a booking for this service.</p>");
            }
            conn.close();
        } catch (Exception e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
        }
        } else {
            out.println("<p>Error: Invalid or missing service ID.</p>");
        }
        %>
    </div>
	
	<%@ include file="../includes/footer.html" %> <!-- Include Footer -->
</body>
</html>