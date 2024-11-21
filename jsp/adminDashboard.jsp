<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!-- 
  - Author: Md Redwanul Hoque Bhuiyan
  - Date: 11/11/2024
  - Copyright Notice:
  - @(#)
  - Description: Admin Dashboard to modify services and view bookings with customer info.
-->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Dashboard</title>

<!-- Settle Session Management -->

<%
    // Session Management Logic
    String userIdAdminValidation = (String) session.getAttribute("sessUserID");
    String userRoleAdminValidation = (String) session.getAttribute("sessUserRole");

    if (userIdAdminValidation == null || !"2".equals(userRoleAdminValidation)) {
        response.sendRedirect("login.jsp");
        return; // Prevent further execution of the page
    }
%>

<style>
h2 {
	text-align: center;
}
</style>
</head>
<body>
	<%@ include file="../includes/header.jsp"%>
	<!-- Include Header -->

	<h2>Admin Dashboard</h2>

	<!-- CRUD Operations for Services -->
	<h3>Manage Services</h3>
	<form action="ServiceServlet" method="post">
		<input type="hidden" name="action" value="add"> <label>Service
			Name:</label><input type="text" name="service_name" required> <label>Category
			ID:</label><input type="number" name="category_id" required> <label>Price:</label><input
			type="number" name="price" required> <label>Description:</label><input
			type="text" name="description" required> <input type="submit"
			value="Add Service">
	</form>

	<h3>Existing Services</h3>
	<table>
		<tr>
			<th>ID</th>
			<th>Name</th>
			<th>Category</th>
			<th>Price</th>
			<th>Description</th>
			<th>Actions</th>
		</tr>
		<%
		// Connect to the database
		Class.forName("com.mysql.cj.jdbc.Driver");
		
		String connURL = "jdbc:mysql://localhost:3306/jad_assignment1?user=root&password=subeteoshiete4@&serverTimezone=UTC";
		Connection conn = DriverManager.getConnection(connURL);
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery("SELECT * FROM service");

		while (rs.next()) {
			int serviceId = rs.getInt("service_id");
			String serviceName = rs.getString("service_name");
			String category = rs.getString("category_id");
			double price = rs.getDouble("price");
			String description = rs.getString("description");
		%>
		<tr>
			<td><%=serviceId%></td>
			<td><%=serviceName%></td>
			<td><%=category%></td>
			<td><%=price%></td>
			<td><%=description%></td>
			<td><a
				href="ServiceServlet?action=edit&serviceId=<%=serviceId%>">Edit</a>
				| <a href="ServiceServlet?action=delete&serviceId=<%=serviceId%>">Delete</a>
			</td>
		</tr>
		<%
		}
		conn.close();
		%>
	</table>

	<!-- View All Bookings with Customer Info -->
	<h3>Booking Details</h3>
	<table>
		<tr>
			<th>Booking ID</th>
			<th>Customer Name</th>
			<th>Customer Email</th>
			<th>Customer Phone</th>
			<th>Customer Address</th>
			<th>Booking Date</th>
			<th>Appointment Date</th>
			<th>Status</th>
		</tr>
		<%
		// Connect to the database
		Class.forName("com.mysql.cj.jdbc.Driver");
		connURL = "jdbc:mysql://localhost:3306/jad_assignment1?user=root&password=subeteoshiete4@&serverTimezone=UTC";
		conn = DriverManager.getConnection(connURL);
		stmt = conn.createStatement();
		String sqlStr = "SELECT * FROM booking INNER JOIN member ON booking.member_id = member.member_id";
		rs = stmt.executeQuery(sqlStr);

		while (rs.next()) {
			int bookingId = rs.getInt("booking_id");
			String customerName = rs.getString("name");
			String customerEmail = rs.getString("email");
			String customerPhone = rs.getString("phone_number");
			String customerAddress = rs.getString("address");
			String bookingDate = rs.getString("booking_date");
			String appointmentDate = rs.getString("appointment_date");
			String status = rs.getString("status");
		%>
		<tr>
			<td><%=bookingId%></td>
			<td><%=customerName%></td>
			<td><%=customerEmail%></td>
			<td><%=customerPhone%></td>
			<td><%=customerAddress%></td>
			<td><%=bookingDate%></td>
			<td><%=appointmentDate%></td>
			<td><%=status%></td>
		</tr>
		<%
		}
		conn.close();
		%>
	</table>

	<%@ include file="../includes/footer.html"%>
	<!-- Include Footer -->
</body>
</html>