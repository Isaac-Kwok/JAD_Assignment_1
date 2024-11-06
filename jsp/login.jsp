<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../includes/header_public.html"%>
<!-- Include Header -->

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Form</title>
</head>
<body>
    <h2>Login Form</h2>

    <%
    String errCode = request.getParameter("errCode");
    if ("duplicateEmail".equals(errCode)) {
        out.println("<p style='color:red;'>The email you entered is already registered.</p>");
    }
    if ("invalidLogin".equals(errCode)) {
        out.println("<p style='color:red;'>You have entered an invalid ID/Password</p>");
    }
    %>

    <form action="${pageContext.request.contextPath}/VerifyUserServletAssignment" method="post">
        <label for="email">Email:</label>
        <input type="text" id="email" name="email" required><br><br>

        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required><br><br>

        <input type="submit" value="Login">
        <input type="reset" value="Reset">
    </form>
</body>
<%@ include file="../includes/footer.html"%>
<!-- Include Footer -->
</html>
