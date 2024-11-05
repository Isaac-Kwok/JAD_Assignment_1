<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../includes/header_public.html" %> <!-- Include Header -->
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Display Member</title>
</head>
<body>
    <!-- 
      - Author(s): Isaac Kwok
      - Date: 28/10/2024
      - Description: This JSP page displays the member’s name if logged in.
    -->
    
    <%
        // Retrieve session attributes and cast them
        String sessUserID = (String) session.getAttribute("sessUserID");
        String sessUserRole = (String) session.getAttribute("sessUserRole");

        // Check if sessUserID is null
        if (sessUserID == null) {
            // Redirect to login page with error code if not logged in
            response.sendRedirect("login.jsp?errCode=invalidLogin");
            return; // Stop further execution
        }

        // Retrieve the userName from the request parameter
        String userName = request.getParameter("userName");

        // Display welcome message if userName is available
        if (userName != null) {
    %>
        <h2>pract5-part4-displayMember.jsp</h2>
        <p>Welcome, <%= userName %>!</p>
        <p>Your role is <%= sessUserRole %>!</p>
    <%
        } else {
            out.println("<p>Missing user information. Please login again.</p>");
        }
    %>

    <form action="login.jsp" method="get">
        <input type="submit" value="Home">
    </form>
</body>
    <%@ include file="../includes/footer.html" %> <!-- Include Footer -->
</html>
