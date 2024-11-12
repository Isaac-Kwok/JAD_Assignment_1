<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Booking Confirmation</title>
<!-- Custom CSS -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<link href="../css/style.css" rel="stylesheet">
<link href="../css/colour.css" rel="stylesheet">
</head>
<body>
	<h1>Booking Confirmation</h1>
	<%
	String memberId = session.getAttribute("member_id").toString(); // Ensure member is logged in
	String serviceId = request.getParameter("service_id");
	String quantity = request.getParameter("quantity");
	String appointmentDate = request.getParameter("appointment_date");
	String specialRequest = request.getParameter("special_request");

	// Step 1: Insert booking into booking table
	String insertBookingSQL = "INSERT INTO booking (member_id, appointment_date, status) VALUES (?, ?, 'Pending')";
	PreparedStatement pstBooking = conn.prepareStatement(insertBookingSQL, Statement.RETURN_GENERATED_KEYS);
	pstBooking.setString(1, memberId);
	pstBooking.setString(2, appointmentDate);
	int affectedRows = pstBooking.executeUpdate();
	ResultSet generatedKeys = pstBooking.getGeneratedKeys();

	if (generatedKeys.next()) {
		int bookingId = generatedKeys.getInt(1);

		// Step 2: Insert booking details into booking_details table
		String insertBookingDetailsSQL = "INSERT INTO booking_details (booking_id, service_id, quantity, price, special_request) VALUES (?, ?, ?, ?, ?)";
		PreparedStatement pstBookingDetails = conn.prepareStatement(insertBookingDetailsSQL);
		pstBookingDetails.setInt(1, bookingId);
		pstBookingDetails.setString(2, serviceId);
		pstBookingDetails.setString(3, quantity);
		pstBookingDetails.setString(4, servicePrice); // Assume you fetch this price from service
		pstBookingDetails.setString(5, specialRequest);
		pstBookingDetails.executeUpdate();
	}
	%>
	<p>Your booking has been confirmed!</p>
	<a href="home.jsp">Go back to Home</a>
</body>
</html>
