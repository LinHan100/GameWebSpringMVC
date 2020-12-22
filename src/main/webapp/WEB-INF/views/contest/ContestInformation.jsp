<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ include file="../Link.jsp"%>
<%
	request.setCharacterEncoding("UTF-8");
response.setContentType("text/html;charset=UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ContestInformation</title>
</head>
<body>
	<%@ include file="../Header.jsp"%>

	<p>比賽詳細資料</p>

	<form action="<c:url value='/contest/Join'/>" method="post">
		<p>比賽名稱: ${cContestBean.sName}</p>
		<p>比賽遊戲: ${cContestBean.sGame}</p>
		<p>報名日期: ${cContestBean.dSignStart} ~ ${cContestBean.dSignEnd}</p>
		<p>比賽時間: ${cContestBean.tTime}</p>
		<p>比賽地點: ${cContestBean.sLocation}</p>
		<p>參加人數:
			${fn:length(cContestBean.lParticipateBeans)}/${cContestBean.iPeople}</p>
		<c:set var="rule" value="${cContestBean.sRule}" />
		<%
			request.setAttribute("vEnter", "\n");
		%>
		<span>比賽規則:</span> <br> <span>${fn:replace(rule,vEnter,"<br>")}</span>
		<hr>
		<c:set var="now" value="<%=new java.util.Date()%>" />
		<fmt:formatDate var="today" pattern="yyyy-MM-dd" value="${now}" />

		<c:choose>
			<c:when test="${cContestBean.dSignStart > today}">
				<input type="text" name="gameID" disabled value="未開始報名">
				<br>
				<input type="checkbox" name="checkBox" required disabled>
				<label>我同意遵守比賽規則</label>
				<br>
				<button type="submit" name="join" value="join" disabled>報名比賽</button>
			</c:when>
			<c:otherwise>
				<c:choose>
					<c:when test="${cContestBean.dSignEnd < today}">
						<input type="text" name="gameID" disabled value="已截止報名">
						<br>
						<input type="checkbox" name="checkBox" required disabled>
						<label>我同意遵守比賽規則</label>
						<br>
						<button type="submit" name="join" value="join" disabled>報名比賽</button>
					</c:when>
					<c:otherwise>
						<c:choose>
							<c:when
								test="${fn:length(cContestBean.lParticipateBeans) == cContestBean.iPeople}">
								<input type="text" name="gameID" disabled value="參加人數已額滿">
								<br>
								<input type="checkbox" name="checkBox" required disabled>
								<label>我同意遵守比賽規則</label>
								<br>
								<button type="submit" name="join" value="join" disabled>報名比賽</button>
							</c:when>
							<c:otherwise>
								<input type="text" name="sGameId" required>
								<br>
								<input type="checkbox" id="checkBox" name="checkBox" required>
								<label for="checkBox">我同意遵守比賽規則</label>
								<br>
								<button type="submit" name="join" value="join">報名比賽</button>
							</c:otherwise>
						</c:choose>
					</c:otherwise>
				</c:choose>
			</c:otherwise>
		</c:choose>

	</form>

	<%@ include file="../Foot.jsp"%>
</body>
</html>