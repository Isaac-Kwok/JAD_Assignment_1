<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Book a Service</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container">
        <h2>Book a Cleaning Service</h2>
        <form action="confirmBooking.jsp" method="post">
            <!-- Service Selection -->
            <label for="service">Select Service:</label>
            <select name="service_id" id="service" required>
                <% 
                // Declare the connection and statement outside the try block
                Connection conn = null;
                Statement stmt = null;
                try {
                    // Load JDBC Driver
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    
                    // Define Connection URL
                    String connURL = "jdbc:mysql://localhost:3306/cleaning_service?user=root&password=henshin111&serverTimezone=UTC";
                    
                    // Establish connection to URL
                    conn = DriverManager.getConnection(connURL);
                    
                    // Create statement and execute query
                    stmt = conn.createStatement();
                    ResultSet rs = stmt.executeQuery("SELECT service_id, service_name FROM service");

                    // Populate dropdown with service options
                    while (rs.next()) {
                %>
                        <option value="<%= rs.getInt("service_id") %>"><%= rs.getString("service_name") %></option>
                <% 
                    }
                    rs.close();
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    // Close resources in the finally block to ensure they are closed
                    if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
                %>
            </select>

            <!-- Appointment Date -->
            <label for="appointment_date">Appointment Date:</label>
            <input type="datetime-local" id="appointment_date" name="appointment_date" required>

            <!-- Special Request -->
            <label for="special_request">Special Requests:</label>
            <textarea id="special_request" name="special_request" rows="4"></textarea>

            <button type="submit" class="btn">Confirm Booking</button>
        </form>
    </div>
</body>
</html>
