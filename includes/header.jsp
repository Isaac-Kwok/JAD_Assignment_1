<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
String userId = (String) session.getAttribute("sessUserID");
String userRole = (String) session.getAttribute("sessUserRole");

if (userId != null) {
	// User is logged in
	if ("2".equals(userRole)) {
		// Admin user
%>
<%@ include file="../includes/header_admin.html"%>
<%
} else {
// Regular member
%>
<%@ include file="../includes/header_member.html"%>
<%
}
} else {
// Public (unauthenticated) user
%>
<%@ include file="../includes/header_public.html"%>
<%
}
%>

<script>
	//Get the current URL path
	var currentPath = window.location.pathname.split('/').pop(); // Extract only the filename

	// Select all nav links
	var navLinks = document.querySelectorAll('.navbar-nav .nav-link');

	// Loop through links and add 'active' class if the link's href matches the current filename
	console.log("Current Path:", currentPath);
	navLinks.forEach(function(link) {
		console.log("Checking Link:", link.getAttribute('href'));
		if (link.getAttribute('href').includes(currentPath)) {
			console.log("Matched:", link);
			link.classList.add('active');
		}
	});
</script>

