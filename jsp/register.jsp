<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../includes/header_public.html"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register</title>
</head>
<body>
    <h2>Registration Form</h2>

    <form action="${pageContext.request.contextPath}/RegisterUserServlet" method="post">
        <label for="loginid">Username:</label> 
        <input type="text" id="loginid" name="loginid" required><br><br>
        
        <label for="email">Email:</label> 
        <input type="email" id="email" name="email" required><br><br>
        
        <label for="password">Password:</label> 
        <input type="password" id="password" name="password" required><br><br>

        <input type="submit" value="Register"> 
        <input type="reset" value="Reset">
    </form>
</body>
<%@ include file="../includes/footer.html"%>
</html>
