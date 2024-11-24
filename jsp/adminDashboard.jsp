<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!-- 
  - Author: Md Redwanul Hoque Bhuiyan
  - Date: 17/11/2024
  - Copyright Notice:
  - @(#)
  - Description: Admin Dashboard to view/modify services and view bookings with customer info.
-->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Dashboard</title>
<!-- Added Bootstrap & CSS files -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="../css/style.css">
<link rel="stylesheet" href="../css/colour.css">
<link rel="stylesheet" href="../css/adminDashboard.css">

<!-- Session Management to ensure only admins can access this page -->
<%
    // Checking if the user is logged in and is an admin
    String userIdAdminValidation = (String) session.getAttribute("sessUserID");
    String userRoleAdminValidation = (String) session.getAttribute("sessUserRole");

    // If the user is not an admin, redirect to the login page
    if (userIdAdminValidation == null || !"2".equals(userRoleAdminValidation)) {
        response.sendRedirect("login.jsp");
        return; // Prevent further execution of the page
    }
%>
</head>

<body>
	<%@ include file="../includes/header.jsp"%>
	<!-- Include Header -->

	<div class="container">
	
	<!-- Processing the Update Request -->
        <%
            String statusMessage = null;

            // Check if the form is submitted via POST method
            if (request.getMethod().equalsIgnoreCase("POST")) {
                // Retrieve booking ID and new status from the form
                String bookingId = request.getParameter("bookingId");
                String newStatus = request.getParameter("status");

                try {
                    // Connect to the database
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    String connURL = "jdbc:mysql://localhost/cleaning_service?user=root&password=henshin111&serverTimezone=UTC";
                    Connection conn = DriverManager.getConnection(connURL);

                    // Prepare and execute the SQL query to update booking status
                    String updateSQL = "UPDATE booking SET status = ? WHERE booking_id = ?";
                    PreparedStatement stmt = conn.prepareStatement(updateSQL);
                    stmt.setString(1, newStatus);
                    stmt.setInt(2, Integer.parseInt(bookingId));
                    int rowsUpdated = stmt.executeUpdate();

                    // Set success or failure message based on result
                    if (rowsUpdated > 0) {
                        statusMessage = "Booking ID " + bookingId + " updated successfully!";
                    } else {
                        statusMessage = "Failed to update Booking ID " + bookingId;
                    }

                    stmt.close();
                    conn.close();
                } catch (Exception e) {
                    statusMessage = "Error: " + e.getMessage(); // Display error message if any exception occurs
                }
            }
        %>

        <!-- Display the status message if there is any -->
        <%
            if (statusMessage != null) {
        %>
            <div class="alert alert-info mt-3">
                <%= statusMessage %>
            </div>
        <%
            }
        %>
	
	    <!-- Display List of All Bookings -->
	    <h3 class="mt-5">All Bookings</h3>
	    <table class="table table-striped table-bordered">
            <thead class="thead-dark">
                <tr>
                    <th>User Name</th>
                    <th>Service Name</th>
                    <th>Quantity</th>
                    <th>Special Request</th>
                    <th>Appointment Date</th>
                    <th>Time Slot</th>
                    <th>Booking Date</th>
                    <th>Phone number</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <%
                    try {
                        // Database connection to fetch booking details
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        String connURL = "jdbc:mysql://localhost/cleaning_service?user=root&password=henshin111&serverTimezone=UTC";
                        Connection conn = DriverManager.getConnection(connURL);

                        // SQL query to fetch all bookings and related details
                        String bookingsSQL = "SELECT b.booking_id, m.phone_number, b.timeslot, m.name AS user_name, s.service_name, bd.quantity, bd.special_request, b.appointment_date, b.booking_date, b.status " +
                                             "FROM booking b " +
                                             "JOIN member m ON b.member_id = m.member_id " +
                                             "JOIN booking_details bd ON b.booking_id = bd.booking_id " +
                                             "JOIN service s ON bd.service_id = s.service_id";
                        PreparedStatement bookingsStmt = conn.prepareStatement(bookingsSQL);
                        ResultSet bookingsRS = bookingsStmt.executeQuery();

                        // Loop through each booking and display it in the table
                        while (bookingsRS.next()) {
                %>
                <tr>
                    <td><%= bookingsRS.getString("user_name") %></td>
                    <td><%= bookingsRS.getString("service_name") %></td>
                    <td><%= bookingsRS.getInt("quantity") %></td>
                    <td><%= bookingsRS.getString("special_request") %></td>
                    <td><%= bookingsRS.getDate("appointment_date") %></td>
                    <td>
					    <%
					        // Fetch and format the timeslot value
					        Time timeSlot = bookingsRS.getTime("timeslot");
					        String formattedTime = timeSlot != null ? timeSlot.toString() : "N/A";
					    %>
					    <%= formattedTime %>
					</td>
                    <td><%= bookingsRS.getDate("booking_date") %></td>
                    <td><%= bookingsRS.getInt("phone_number") %></td>
                    <td><%= bookingsRS.getString("status") %></td>
                    <td>
                        <!-- Form to update the booking status -->
                        <form method="post" action="adminDashboard.jsp">
                            <input type="hidden" name="bookingId" value="<%= bookingsRS.getInt("booking_id") %>">
                            <select name="status" class="form-control form-control-sm">
                                <option value="Pending" <%= bookingsRS.getString("status").equals("Pending") ? "selected" : "" %>>Pending</option>
                                <option value="Confirmed" <%= bookingsRS.getString("status").equals("Confirmed") ? "selected" : "" %>>Confirmed</option>
                                <option value="Cancelled" <%= bookingsRS.getString("status").equals("Cancelled") ? "selected" : "" %>>Cancelled</option>
                                <option value="Completed" <%= bookingsRS.getString("status").equals("Completed") ? "selected" : "" %>>Completed</option>
                            </select>
                            <button type="submit" class="btn btn-success btn-sm mt-2">Update</button>
                        </form>
                    </td>
                </tr>
                <%
                        }
                        bookingsStmt.close();
                        conn.close();
                    } catch (Exception e) {
                        out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
                    }
                %>
            </tbody>
        </table>
        
        <!-- Display List of All Services -->
	    <h3 class="mt-4">All Services</h3>
	    <table class="table table-striped table-bordered">
	        <thead class="thead-dark">
	            <tr>
	                <th>Service ID</th>
	                <th>Service Name</th>
	                <th>Category</th>
	                <th>Price</th>
	                <th>Description</th>
	                <th>Action</th>
	            </tr>
	        </thead>
	        <tbody>
	            <%
	                try {
	                    Class.forName("com.mysql.cj.jdbc.Driver");
	                    String connURL = "jdbc:mysql://localhost/cleaning_service?user=root&password=henshin111&serverTimezone=UTC";
	                    Connection conn = DriverManager.getConnection(connURL);
	
	                    // Fetch all services and display them
	                    String servicesSQL = "SELECT s.service_id, s.service_name, s.description, s.price, c.category_name FROM service s JOIN service_category c ON s.category_id = c.category_id ORDER BY 1";
	                    PreparedStatement servicesStmt = conn.prepareStatement(servicesSQL);
	                    ResultSet servicesRS = servicesStmt.executeQuery();
	
	                    // Loop through each service and display it in the table
	                    while (servicesRS.next()) {
	            %>
	            <tr>
	                <td><%= servicesRS.getInt("service_id") %></td>
	                <td><%= servicesRS.getString("service_name") %></td>
	                <td><%= servicesRS.getString("category_name") %></td>
	                <td>$<%= servicesRS.getDouble("price") %></td>
	                <td><%= servicesRS.getString("description") %></td>
	                <td>
	                    <!-- Button to manage the service -->
	                    <a href="adminManageServices.jsp?serviceId=<%= servicesRS.getInt("service_id") %>" class="btn btn-primary btn-sm">Manage</a>
	                </td>
	            </tr>
	            
	            <%
	                    }
	                    servicesStmt.close();
	                    conn.close(); // Close database connection
                    } catch (Exception e) {
                        out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
                    }
	            %>
	        </tbody>
	    </table>
	</div>

	<%@ include file="../includes/footer.html"%>
	<!-- Include Footer -->
</body>
</html>