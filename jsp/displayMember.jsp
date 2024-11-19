<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% 
    String userId = (String) session.getAttribute("sessUserID"); 
    if (userId != null) { 
%>
<%@ include file="../includes/header_admin.html"%>
<% 
    } else { 
%>
<%@ include file="../includes/header_public.html"%>
<% 
    } 
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Welcome</title>
</head>
<body>
    <h2>Welcome, <%= request.getParameter("userName") %>!</h2>

</body>
<%@ include file="../includes/footer.html"%>
</html>
