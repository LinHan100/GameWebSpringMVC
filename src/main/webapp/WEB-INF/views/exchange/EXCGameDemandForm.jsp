<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix='form' uri="http://www.springframework.org/tags/form"%>
<%@ include file="../Link.jsp"%>
<%
	response.setContentType("text/html;charset=UTF-8");
request.setCharacterEncoding("UTF-8");
%>

<!DOCTYPE html>
<html>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=UTF-8" />
<TITLE>許願池</TITLE>
<style>
.com{
    max-width:1000px; 
}
legend {
	font-size: 30px;
}

fieldset {
	padding-top: 10px;
	padding-left: 20px;
	margin: auto;
	width: 800px;
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
<br>
	<form:form method="post" modelAttribute="DemandGameBean" class="dark-matter com">
		<div class="container">
		<fieldset>
			<legend>許願池</legend>
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

				<label for="gamelocation">商品位置</label>
				<form:select path="area" style="width: 260px;"
					class="fixedlen" id="gamelocation">
					<form:option value="-1">請選擇地區</form:option>
					<form:options items="${sessionScope.initOption.AreaList }" />
				</form:select>

				<span id="gamelocationspan"></span>
			</div>
			<div>
				<label for="gamer">玩家名稱</label>
				<form:input id="gamer" class="fixedlen"
					style="background-color:gary" type="text" path="gamer" />
			</div>
			<div>
				<label for="remark">備註 </label>
				<form:input class="fixedlen" type="text" path="remark" id="remark"/>
			</div>
			<div style="margin-top: 20px;">
				<button type="button"   id="submitButton" onclick="checkSubmit();" class="button" disabled>送出</button>
				<button type="reset" class="button">清除</button>
				<button type="button" class="button"  onclick="oneClick();">一鍵輸入:馬力歐賽車</button>
			</div>
		</fieldset>
		</div>
	</form:form>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10.13.0/dist/sweetalert2.all.min.js"></script>
	<script>
	
	function oneClick(){
		$("#console1").val("Switch")
		$("#gamename").val("馬力歐賽車")
		$("#gamelocation").val("新北市")
		$("#remark").val("下班後可面交")
		$("#submitButton").attr("disabled",false)
	}
	
	function checkSubmit(){
		swal.fire("${action}成功",
				  "",
				  "success")
				  .then(function(){
					 $('form').submit()
					  console.log("success")
				  })
	}
	
	
	
	
	$("#gamer").attr("readonly", true);
	
	
	$("#console1").mouseout(function() {
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

	$("#gamename").mouseout(function() {
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
	
	$("#gamelocation").mouseout(function() {
			flag3 = false
			if ($("#gamelocation :selected").text() == "") {
				$("#gamelocationspan").html("<span>必填</span>")
			} else if ($("#gamelocation :selected").text() == "請選擇地區") {
				$("#gamelocationspan").html("<span>必填</span>")
			} else {
				$("#gamelocationspan").html("")
				flag3 = true;
			}
			checkall();
		})

		function checkall() {
			if (flag1 && flag2 && flag3) {

				$("#submitButton").attr("disabled", false);
			} else {
				$("#submitButton").attr("disabled", true);
			}
		}
	</script>

	<%@ include file="../Foot.jsp"%>
</BODY>
</html>