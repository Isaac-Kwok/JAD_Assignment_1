<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<% 
    String userId = (String) session.getAttribute("sessUserID"); 
    if (userId != null) { 
%>
    <%@ include file="../includes/header_member.html"%>
<% 
    } else { 
%>
    <%@ include file="../includes/header_public.html"%>
<% 
    } 
%>
