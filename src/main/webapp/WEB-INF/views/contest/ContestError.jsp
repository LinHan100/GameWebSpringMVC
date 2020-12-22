<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../Link.jsp" %>
<%
request.setCharacterEncoding("UTF-8");
response.setContentType("text/html;charset=UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ContestError</title>
</head>
<body>
<%@ include file="../Header.jsp" %>

<p>發生錯誤,請重新操作!</p>
<p>${updateMessage}</p>

<a href="<c:url value='/contest/Index'/>">回首頁</a>



<%@ include file="../Foot.jsp" %>
</body>
</html>