<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Confirmation</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link href="../css/style.css" rel="stylesheet">
    <link href="../css/colour.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h1 class="text-center mb-4">Booking Confirmation</h1>
        <%
            Connection conn = null;
            PreparedStatement pstBooking = null;
            PreparedStatement pstBookingDetails = null;
            ResultSet generatedKeys = null;
            String memberId = "1";

            /*
            String memberId = (String) session.getAttribute("member_id");
            if (memberId == null) {
                response.sendRedirect("login.jsp?errCode=notLoggedIn");
                return;
            }
			*/
            
            String serviceId = request.getParameter("service_id");
            String quantity = request.getParameter("quantity");
            String appointmentDate = request.getParameter("appointment_date");
            String specialRequest = request.getParameter("special_request");

            try {
                // Step 1: Load JDBC Driver
                Class.forName("com.mysql.jdbc.Driver");
                // Step 2: Establish connection
                //String connURL = "jdbc:mysql://localhost:3306/jad_assignment1?user=root&password=subeteoshiete4@&serverTimezone=UTC";
                String connURL = "jdbc:mysql://localhost:3306/cleaning_service?user=root&password=henshin111&serverTimezone=UTC";
                conn = DriverManager.getConnection(connURL);

                // Step 3: Insert booking into booking table
                String insertBookingSQL = "INSERT INTO booking (member_id, appointment_date, status) VALUES (?, ?, 'Pending')";
                pstBooking = conn.prepareStatement(insertBookingSQL, Statement.RETURN_GENERATED_KEYS);
                pstBooking.setString(1, memberId);
                pstBooking.setString(2, appointmentDate);
                int affectedRows = pstBooking.executeUpdate();

                if (affectedRows > 0) {
                    generatedKeys = pstBooking.getGeneratedKeys();
                    if (generatedKeys.next()) {
                        int bookingId = generatedKeys.getInt(1);

                        // Step 4: Insert booking details into booking_details table
                        String insertBookingDetailsSQL = "INSERT INTO booking_details (booking_id, service_id, quantity, price, special_request) VALUES (?, ?, ?, (SELECT price FROM service WHERE service_id = ?), ?)";
                        pstBookingDetails = conn.prepareStatement(insertBookingDetailsSQL);
                        pstBookingDetails.setInt(1, bookingId);
                        pstBookingDetails.setString(2, serviceId);
                        pstBookingDetails.setString(3, quantity);
                        pstBookingDetails.setString(4, serviceId);
                        pstBookingDetails.setString(5, specialRequest);
                        pstBookingDetails.executeUpdate();

                        out.println("<div class='alert alert-success'>Booking successful! Your booking ID is: " + bookingId + "</div>");
                    }
                } else {
                    out.println("<div class='alert alert-danger'>Booking failed. Please try again.</div>");
                }
            } catch (Exception e) {
                out.println("<div class='alert alert-danger'>Error: " + e.getMessage() + "</div>");
            } finally {
                // Close resources
                if (generatedKeys != null) generatedKeys.close();
                if (pstBookingDetails != null) pstBookingDetails.close();
                if (pstBooking != null) pstBooking.close();
                if (conn != null) conn.close();
            }
        %>
        <a href="service_category.jsp" class="btn btn-primary mt-4">Back to Services</a>
    </div>
</body>
</html>
