<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix='form' uri="http://www.springframework.org/tags/form"%>
<%@ include file="../Link.jsp"%>
<!DOCTYPE html>
<html>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=UTF-8" />
<TITLE>我要換</TITLE>
<style>
legend {
	font-size: 30px;
}

fieldset {
	padding-top: 10px;
	padding-left: 20px;
	margin: auto;
	width: 400px;
	border-color: transparent;
	border-radius: 15px;
	margin: 20px;
}

#fixedlen {
	width: 300px;
}

div {
	margin-bottom: 5px;
}
</style>
</HEAD>
<BODY>
	<%@ include file="../Header.jsp"%>

	<%--       <form action="<c:url value='/exchange/ImageUpload'/>" method="POST" enctype="multipart/form-data"> --%>
	<form:form method="post" modelAttribute="gamebean"
		enctype='multipart/form-data'>
		<fieldset>
			<legend>${update }${insert }</legend>
			<div>

				<label for="console">平台 </label>
				<form:select path="console" style="width: 260px;" class="fixedlen"
					id="console1">
					<form:option value="-1" label="請選擇平台" />
					<form:options items="${sessionScope.initOption.ConsoleList }" />
				</form:select>

				<span id="console1span"></span>
			</div>
			<div>

				<label for="gamename">遊戲名稱</label>
				<form:select path="gamename" style="width: 260px;" class="fixedlen"
					id="gamename">
					<form:option value="-1">請選擇遊戲</form:option>
					<form:options items="${sessionScope.initOption.GamenameList }" />
				</form:select>
				<span id="gamenamespan"></span>

			</div>
			<div>

				<label for="qty">數量 </label>
				<form:input class="fixedlen" id="qty" path="qty" type="text"
					onchange="value=value.replace(/[^\d]/g,'')" />
				<span id="qtyspan"></span>

			</div>
			<div>

				<label for="condition">商品狀況</label>
				<form:select path="condition" style="width: 260px;" class="fixedlen"
					id="condition">
					<form:option value="-1">請選擇商品狀況</form:option>
					<form:options items="${sessionScope.initOption.ConditionList }" />
				</form:select>
				<span id="conditionspan"></span>

			</div>
			<div>

				<label for="gamelocation">商品位置</label>
				<form:select path="gamelocation" style="width: 260px;"
					class="fixedlen" id="gamelocation">
					<form:option value="-1">請選擇地區</form:option>
					<form:options items="${sessionScope.initOption.AreaList }" />
				</form:select>

				<span id="gamelocationspan"></span>
			</div>


			<div>
				<label for="delivery">取貨方式</label>
				<form:input id="delivery" class="fixedlen" type="text"
					path="delivery" value="面交" style="background-color: grey;" />
				<span id="deliveryspan"></span>
			</div>
			<div>
				<label for="gamer">玩家名稱</label>
				<form:input id="gamer" class="fixedlen"
					style="background-color:gary" type="text" path="gamer" />
			</div>
			<div>
				<label for="dlc">含特典 </label>

				<form:radiobutton path="dlc" label="是" value="是" />
				<form:radiobutton path="dlc" label="否" value="否" />

			</div>
			<div>
				<label for="remark">備註 </label>
				<form:input class="fixedlen" type="text" path="remark" />
			</div>
			<c:if test="${insert != null }">
				<div>
					<label for="image">圖片 </label> <span id="imagespan"></span> <br>
					<input type="file" name="file" id="uploadFile" />
				</div>
			</c:if>
			<c:if test="${update != null }">
				<form:input type="hidden" path="image" />
				<form:input type="hidden" path="no" />
				<form:input type="hidden" path="status" />
				<div id="exdivin">
					<img id="eximg" width="300px"
						src="${pageContext.request.contextPath }/${gamebean.image }"
						alt="路徑失聯">
				</div>
			</c:if>
			<div style="margin-top: 20px;">
				<input type="hidden" name="decisions" value="wish">
				<c:choose>
					<c:when test="${update != null }">
						<input type="submit" value="送出" id="submit">
					</c:when>
					<c:otherwise>
						<input type="submit" value="送出" id="submit" disabled>
					</c:otherwise>
				</c:choose>
				<input type="reset" value="清除">
			</div>
		</fieldset>
	</form:form>

	<script>
		if(${insert != null}){
		let flag1 = false;
		let flag2 = false;
		let flag3 = false;
		let flag4 = false;
		let flag5 = false;
		}
		else
		{
		let flag1 = true;
		let flag2 = true;
		let flag3 = true;
		let flag4 = true;
		let flag5 = true;
		}
		
		$("#console1").on("blur", function() {
			flag1 = false
			if ($("#console1 :selected").text() == "") {
				$("#console1span").html("<span>必填</span>")
			} else if ($("#console1 :selected").text() == "請選擇平台") {
				$("#console1span").html("<span>必填</span>")
			} else {
				$("#console1span").html("")
				flag1 = true;
			}
			checkall();
		})

		$("#gamename").on("blur", function() {
			flag2 = false
			if ($("#gamename :selected").text() == "") {
				$("#gamenamespan").html("<span>必填</span>")
			} else if ($("#gamename :selected").text() == "請選擇遊戲") {
				$("#gamenamespan").html("<span>必填</span>")
			} else {
				$("#gamenamespan").html("")
				flag2 = true;
			}
			checkall();
		})

		$("#qty").on("blur", function() {
			flag3 = false
			if ($("#qty").val() == "") {
				$("#qtyspan").html("<span>必填</span>")
			} else if ($("#qty").val() == "請輸入數量") {
				$("#qtyspan").html("<span>必填</span>")
			} else {
				$("#qtyspan").html("")
				flag3 = true;
			}
			checkall();
		})

		$("#condition").on("blur", function() {
			flag4 = false
			if ($("#condition :selected").text() == "") {
				$("#conditionspan").html("<span>必填</span>")
			} else if ($("#condition :selected").text() == "請選擇商品狀況") {
				$("#conditionspan").html("<span>必填</span>")
			} else {
				$("#conditionspan").html("")
				flag4 = true;
			}
			checkall();
		})

		$("#gamelocation").on("blur", function() {
			flag5 = false
			if ($("#gamelocation :selected").text() == "") {
				$("#gamelocationspan").html("<span>必填</span>")
			} else if ($("#gamelocation :selected").text() == "請選擇地區") {
				$("#gamelocationspan").html("<span>必填</span>")
			} else {
				$("#gamelocationspan").html("")
				flag5 = true;
			}
			checkall();
		})

		function checkall() {
			if (flag1 && flag2 && flag3 && flag4 && flag5) {

				$("#submit").attr("disabled", false);
			} else {
				$("#submit").attr("disabled", true);
			}
		}
		
		
	</script>

	<%@ include file="../Foot.jsp"%>
</BODY>
</html>