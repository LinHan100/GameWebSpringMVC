<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../Link.jsp"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>交換版首頁</title>
</head>
<body>
	<%@ include file="../Header.jsp"%>
	<form method='get' action='<c:url value="/exchange/preparehomepage"/>'>


		<div id="portfolio" class="section md-padding bg-grey">
			<div class="container">


				<h1 class="mt-4 mb-3">許願池
    </h1>

    <ol class="breadcrumb">
      <li class="breadcrumb-item">
        <a href="<c:url value='/'/>">Home</a>
      </li>
      <li class="breadcrumb-item active">交換</li>
    </ol>

				<label>依名稱搜尋: </label>
				<div class="input-group">
				<input type="text" class="form-control" name="searchparams" value="${ searchparams}">
				<input type="submit">
				</div>


<%-- 				<c:choose> --%>
<%-- 					<c:when test="${search =='area'}"> --%>
<!-- 						<label><input type="radio" name="search" value="gamename">遊戲名稱</label> -->
<!-- 						<label><input type="radio" name="search" value="area" -->
<!-- 							checked>地區</label> -->
<%-- 					</c:when> --%>
<%-- 					<c:otherwise> --%>
<!-- 						<label><input type="radio" name="search" value="gamename" -->
<!-- 							checked>遊戲名稱</label> -->
<!-- 						<label><input type="radio" name="search" value="area">地區</label> -->
<%-- 					</c:otherwise> --%>
<%-- 				</c:choose> --%>

				<input type="hidden" id="search" value="${search}">
				<!-- 藏參數 -->


				<div class="row" id="bigdiv">


					<c:forEach var='g' items='${list }'>

						<!-- Work -->
						<div class="col-md-4 col-xs-6 work">
							<img class="img-responsive" style="width: 345px; height: 345px"
								src="${pageContext.request.contextPath }/images/$${g.gamename}" alt="">
							<div class="overlay"></div>
							<div class="work-content">
								<span>遊戲名稱:${g.gamename}</span><span>玩家名稱:${g.gamer}</span>
								<div class="work-link" style="margin: auto;">
									<a class="applyFor" style="border-radius: 30px"
										href="<c:url value="/exchange/applyFor?gamer=${g.gamer }&no=${g.no }"/>"><i
										class="fa fa-exchange"></i></a>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
					<div>
						<c:if test="${p > 1}">
							<c:forEach var="num" begin="1" end="${p }" step="1">
								<a class="page"><i >${num}</i></a>
							</c:forEach>
						</c:if>
					</div>
			</div>


		</div>

	</form>
	<%@ include file="../Foot.jsp"%>
	<script>
		window.onload = function() {
			var pages = document.querySelectorAll(".page");
			var divout = document.getElementById("bigdiv")
			var search = document.getElementById("search").value
			var searchDOM = document.getElementById("search")
			var xhr = new XMLHttpRequest();

			for (i = 0; i < pages.length; i++) {
				pages[i].onclick = changepage
			}
			for (i = 0; i < applyFors.length; i++) {
				applyFors[i].onclick = checkMemberCheck
			}

			function changepage() {
				let i = (this.innerText)
				console.log(i)
				xhr.open('GET', '<c:url value="/exchange/changepage" />'
						+ '?page=' + i + '&search=' + search, true);
				xhr.send();
				xhr.onreadystatechange = function() {
					console.log("xhr.readyState" + xhr.readyState)
					if (xhr.readyState === 4 && xhr.status === 200) {
						var g = JSON.parse(xhr.responseText)
						console.log("!")
						divout.innerHTML = "";

						for (var i = 0; i < g.list.length; i++) {
							console.log("!!")
							divout.innerHTML += "<div class='col-md-4 col-xs-6 work'><img class='img-responsive' style='width:345px; height:345px' src='${pageContext.request.contextPath }/"+g.list[i].image+"' alt=''>"
									+ "<div class='overlay'></div><div class='work-content'><span>遊戲名稱:"
									+ g.list[i].gamename
									+ "</span>"
									+ "<span>遊戲數量:"
									+ g.list[i].qty
									+ "</span>"
									+ "<span>遊戲所在地:"
									+ g.list[i].gamelocation
									+ "</span>"
									+ "<span>運送方式:"
									+ g.list[i].delivery
									+ "</span>"
									+ "<span>主機平台:"
									+ g.list[i].console
									+ "</span>"
									+ "<span>玩家名稱:"
									+ g.list[i].gamer
									+ "</span>"
									+ "<span>是否含特點:"
									+ g.list[i].dlc
									+ "</span>"
									+ "<span>備註:"
									+ g.list[i].remark
									+ "</span>"
									+ "<div class='work-link' style='margin: auto;'><a class='applyFor' style='border-radius:30px' href=''<c:url value='/exchange/applyFor?gamer="
									+ g.list[i].gamer
									+ "&no="
									+ g.list[i].no
									+ "'/>'><i class='fa fa-exchange'></i></a>"
									+ "</div></div></div>"
						}
						divout.innerHTML += "<input type='hidden' id='search' value='"+g.searchparams+"'> "
					}
				}
			}

		}
	</script>
</body>
</html>