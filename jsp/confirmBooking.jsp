<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Booking Confirmation</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container">
        <h2>Booking Confirmation</h2>
        <%
            // Retrieve parameters from the booking form
            int serviceId = Integer.parseInt(request.getParameter("service_id"));
            String appointmentDate = request.getParameter("appointment_date");
            String specialRequest = request.getParameter("special_request");

            // Retrieve member_id from session
            Integer memberId = (Integer) session.getAttribute("member_id");
            if (memberId == null) {
                out.println("<p>Error: Member is not logged in.</p>");
            } else {
                // Database connection to insert booking
                try {
                	String course = request.getParameter("course");
                	
                    // Step1: Load JDBC Driver
                    Class.forName("com.mysql.jdbc.Driver");
                    // Step 2: Define Connection URL
                    String connURL =("jdbc:mysql://localhost/cleaning_service?user=root&password=henshin111&serverTimezone=UTC");
                    // Step 3: Establish connection to URL
                    Connection conn =   DriverManager.getConnection(connURL);
                    
                    PreparedStatement stmt = conn.prepareStatement(
                        "INSERT INTO booking (member_id, booking_date, appointment_date, status) VALUES (?, NOW(), ?, 'Pending')", Statement.RETURN_GENERATED_KEYS);

                    stmt.setInt(1, memberId);  // Use memberId instead of serviceId
                    stmt.setString(2, appointmentDate);
                    stmt.executeUpdate();

                    ResultSet generatedKeys = stmt.getGeneratedKeys();
                    if (generatedKeys.next()) {
                        int bookingId = generatedKeys.getInt(1);

                        // Insert into booking_details
                        PreparedStatement detailStmt = conn.prepareStatement(
                            "INSERT INTO booking_details (booking_id, service_id, quantity, price, special_request) VALUES (?, ?, 1, (SELECT price FROM service WHERE service_id = ?), ?)");
                        detailStmt.setInt(1, bookingId);
                        detailStmt.setInt(2, serviceId);
                        detailStmt.setInt(3, serviceId);
                        detailStmt.setString(4, specialRequest);
                        detailStmt.executeUpdate();

                        detailStmt.close();
                    }

                    stmt.close();
                    conn.close();
        %>
            <p>Your booking has been confirmed! Here are the details:</p>
            <ul>
                <li>Service ID: <%= serviceId %></li>
                <li>Appointment Date: <%= appointmentDate %></li>
                <li>Special Requests: <%= specialRequest %></li>
            </ul>
        <%
                } catch (Exception e) { 
                    out.println("Error: " + e.getMessage());
                }
            }
        %>
    </div>
</body>
</html>
