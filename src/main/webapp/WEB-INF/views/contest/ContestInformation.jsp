<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ include file="../Link.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>${cContestBean.sName}</title>
<style>
.hiddenDiv label{
	margin:0
}
.itemChoose{
	background-color:#0069d9;
}

.item{
	margin-top:10px
}

</style>
</head>
<body>
<%@ include file="../Header.jsp"%>

<div class="container">

	<h1 class="mt-4 mb-3">
<!-- 		比賽詳細資料  -->
<!-- 		<small>XXXXX</small> -->
	</h1>

	<ol class="breadcrumb">
		<li class="breadcrumb-item"><a href="<c:url value='/'/>">Home</a></li>
		<li class="breadcrumb-item active"><a href="<c:url value='/contest/Index'/>">賽事</a></li>
		<li class="breadcrumb-item active"><a href="<c:url value='/contest/Information?contestNo=${cContestBean.iNo}'/>">詳細資料</a></li>
	</ol>

		<img src="<c:url value='/contest/ImageLoading?iNo=${cContestBean.iNo}'/>" alt="" style="width:560px">
		<div >
			<label class="btn btn-primary item itemChoose">總覽</label>
			<label class="btn btn-primary item">參賽者</label>
			<label class="btn btn-primary item">賽程</label>
			<label class="btn btn-primary item">戰績</label>
			<c:set var="joinStatus" value="true"/>
			<c:forEach var="participate" items="${cContestBean.lParticipateBeans}">
				<c:if test="${participate.sPlayer == user.sAccount}">
					<c:set var="joinStatus" value="false"/>
				</c:if>
			</c:forEach>
			<jsp:useBean id="nowDate" class="java.util.Date"/>
			<fmt:formatDate var="today" pattern="yyyy-MM-dd" value="${nowDate}" />
			<c:choose>
				<c:when test="${joinStatus == 'false'}">
					<button class="btn btn-success joinItem" disabled>已報名</button>
					<c:choose>
						<c:when test="${cContestBean.dSignEnd < today}">
							<button class="btn btn-danger" disabled>退出比賽</button>
							<span style="font-size:70%;color:red">(註:報名截止後即無法退出比賽)</span>
						</c:when>
						<c:otherwise>
							<button id="quitContest" class="btn btn-danger" value="${cContestBean.iNo}">退出比賽</button>
							<span style="font-size:70%;color:red">(註:報名截止後即無法退出比賽)</span>
						</c:otherwise>
					</c:choose>
				</c:when>
				<c:otherwise>
					<c:choose>
					<c:when test="${cContestBean.dSignStart > today}">
						<button class="btn btn-success joinItem" disabled>未開始報名</button>
					</c:when>
					<c:otherwise>
						<c:choose>
							<c:when test="${cContestBean.dSignEnd < today}">
								<button class="btn btn-success joinItem" disabled>報名已截止</button>
							</c:when>
							<c:otherwise>
								<c:choose>
									<c:when
										test="${fn:length(cContestBean.lParticipateBeans) == cContestBean.iPeople}">
										<button class="btn btn-success joinItem" disabled>報名人數已滿</button>
									</c:when>
									<c:otherwise>
										<button class="btn btn-success joinItem">報名</button>
									</c:otherwise>
								</c:choose>
							</c:otherwise>
						</c:choose>
					</c:otherwise>
					</c:choose>
				</c:otherwise>
			</c:choose>
		</div>
		
		<div id="總覽" class="hiddenDiv">
			<c:if test="${cContestBean.sHost == user.sAccount }">
            	<fmt:formatDate var="dTime" value="${cContestBean.tTime}" pattern="yyyy-MM-dd"/>
				<c:choose>
					<c:when test="${dTime <= today}">
						<span style="color:gray">更改</span>
					</c:when>
					<c:otherwise>
						<a class="btn btn-primary" href="<c:url value='/contest/Update/${cContestBean.iNo}'/>">更改</a>
					</c:otherwise>
				</c:choose>
				<button class="btn btn-primary" type="submit" id="delete" value="${cContestBean.iNo}">刪除</button>
				<span style="font-size:70%;color:red">(註:至比賽當日即無法更改比賽)</span>
			</c:if>
			
			<p><label>比賽名稱: </label><label>${cContestBean.sName}</label></p>
	    	<p><label>比賽遊戲: </label><label>${cContestBean.sGame}</label></p>
	    	<p><label style="width:67.47px;text-align:right">隊伍數: </label><label>${cContestBean.iPeople}</label></p>
	    	
	    	<c:choose>
	    		<c:when test="${cContestBean.iTeamMemberCount == 1}">
	    			<p><label>隊伍組成: </label><label>個人</label></p>
	    		</c:when>
	    		<c:otherwise>
	    			<p><label>隊伍組成: </label><label>團體，每隊${cContestBean.iTeamMemberCount}人</label></p>
	    		</c:otherwise>
	    	</c:choose>
	    	<c:choose>
	    		<c:when test="${cContestBean.sPreliminary == 'none'}">
	    			<p><label style="width:67.47px;text-align:right">預賽: </label><label>無預賽</label></p>
	    		</c:when>
	    		<c:otherwise>
	    			<c:set var="sPreliminary" value="${fn:split(cContestBean.sPreliminary,'-')}"/>
    			<p><label style="width:67.47px;text-align:right">預賽: </label><label>有預賽，${sPreliminary[0]}取${sPreliminary[1]}  剩餘取${sPreliminary[2]}</label></p>
	    		</c:otherwise>
	    	</c:choose>
	    	
	    	<c:if test="${cContestBean.sRematchMode == 'knockout'}">
	    		<p><label>比賽形式: </label><label>淘汰賽</label></p>
	    	</c:if>
	    	<c:if test="${cContestBean.sRematchMode == 'ground'}">
	    		<p><label>比賽形式: </label><label>循環賽</label></p>
	    	</c:if>
	    	<c:if test="${cContestBean.sRematchMode == 'free'}">
	    		<p><label>比賽形式: </label><label>自由對戰</label></p>
	    	</c:if>
	    	
	    	<p><label>報名時間: </label><label> ${cContestBean.dSignStart}~${cContestBean.dSignEnd}</label></p>
			<fmt:formatDate var="sTime" value="${cContestBean.tTime}" pattern="yyyy-MM-dd HH:mm"/>
	    	<p><label>比賽時間: </label><label>${sTime}</label></p>
	    	<p><label>比賽地點: </label><label>${cContestBean.sLocation}</label></p>
			
			
			
<%-- 			<p>比賽名稱: ${cContestBean.sName}</p> --%>
<%-- 			<p>比賽遊戲: ${cContestBean.sGame}</p> --%>
<%-- 			<p>主辦者: ${cContestBean.sHost}</p> --%>
<%-- 			<p>報名日期: ${cContestBean.dSignStart} ~ ${cContestBean.dSignEnd}</p> --%>
<%-- 			<fmt:formatDate var="sTime" value="${cContestBean.tTime}" pattern="yyyy-MM-dd HH:mm"/> --%>
<%-- 			<p>比賽時間: ${sTime}</p> --%>
<%-- 			<p>比賽地點: ${cContestBean.sLocation}</p> --%>
<!-- 			<p>參加人數: -->
<%-- 				${fn:length(cContestBean.lParticipateBeans)}/${cContestBean.iPeople}</p> --%>
			<span>比賽規則:</span> 
			<br> 
			<span id="rule">${cContestBean.sRule}</span>
		</div>
		
		<div id="參賽者" class="hiddenDiv" style="display:none">
			<c:choose>
				<c:when test="${fn:length(cContestBean.lParticipateBeans) == 0}">
					<p>目前暫無參賽者</p>
				</c:when>
				<c:otherwise>
					<p>目前參賽者: </p>
					<c:forEach varStatus="vs" var="participate" items="${cContestBean.lParticipateBeans}">
						<div><label style="width:50px;text-align:right">${vs.count}.</label><label>${participate.sPlayer}</label></div>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</div>
		
		<div id="賽程" class="hiddenDiv" style="display:none">
			<c:if test="${cContestBean.sHost == user.sAccount }">
				<c:choose>
					<c:when test="${dTime <= today}">
						<span style="color:gray">新增/更新賽程</span>
					</c:when>
					<c:otherwise>
<%-- 						<form action="<c:url value='/contest/ScheduleTest'/>" method="post"> --%>
							<a id="showOption" class="btn btn-primary" href="<c:url value='/contest/Schedule/${cContestBean.iNo}'/>">編輯賽程</a>
<!-- 							<button class="btn btn-primary" id="showOption">新增/更新賽程</button> -->
<!-- 						</form> -->
					</c:otherwise>
				</c:choose>
				<span id="spanHidden" style="font-size:70%;color:red">(註:至比賽當日即無法更改賽程)</span>
			</c:if>
				
				<c:choose>
					<c:when test="${empty cContestBean.bRematchImage}">
						<p>目前暫無賽程表</p>
					</c:when>
					<c:otherwise>
						<p>複賽: </p>
						<div data-toggle="modal" data-target="#RematchImage">
							<a href="#">
							<img
								src="<c:url value='/contest/RematchImageLoading/${cContestBean.iNo}'/>"
								style="width: 560px; border: 2px solid black; border-radius: 10px" />
							</a>
							<div class="modal fade bs-example-modal-xl" id="RematchImage"
								tabindex="-1" role="dialog"
								aria-labelledby="exampleModalLongTitle" aria-hidden="true">
								<div class="modal-dialog modal-xl" role="document">
									<div class="modal-content">
										<div class="modal-header">
											<h5 class="modal-title" id="exampleModalLabel">賽程表</h5>
											<button type="button" class="close" data-dismiss="modal"
												aria-label="Close">
												<span aria-hidden="true">&times;</span>
											</button>
										</div>
										<div class="modal-body">
											<div class="container-fluid">
												<div class="row" style="overflow: auto">
													<img
														src="<c:url value='/contest/RematchImageLoading/${cContestBean.iNo}'/>"
														style="width: 1000px; border: 2px solid black; border-radius: 10px" />
												</div>
											</div>
										</div>
										<div class="modal-footer">
											<button type="button" class="btn btn-secondary"
												data-dismiss="modal">Close</button>
										</div>
									</div>
								</div>
							</div>
						</div>
						<c:choose>
							<c:when test="${empty cContestBean.bPreliminariesImage}">
								<br>
								<p>預賽: 本場賽事並無預賽</p>
							</c:when>						
							<c:otherwise>
								<br>
								<p>預賽: </p>
								<div data-toggle="modal" data-target="#PreliminariesImage">
									<a href="#">
									<img
										src="<c:url value='/contest/PreliminariesImageLoading/${cContestBean.iNo}'/>"
										style="width: 560px; border: 2px solid black; border-radius: 10px" />
									</a>
									<div class="modal fade bs-example-modal-xl" id="PreliminariesImage"
										tabindex="-1" role="dialog"
										aria-labelledby="exampleModalLongTitle" aria-hidden="true">
										<div class="modal-dialog modal-xl" role="document">
											<div class="modal-content">
												<div class="modal-header">
													<h5 class="modal-title" id="exampleModalLabel">賽程表</h5>
													<button type="button" class="close" data-dismiss="modal"
														aria-label="Close">
														<span aria-hidden="true">&times;</span>
													</button>
												</div>
												<div class="modal-body">
													<div class="container-fluid">
														<div class="row" style="overflow: auto">
															<img
																src="<c:url value='/contest/PreliminariesImageLoading/${cContestBean.iNo}'/>"
																style="width: 1000px; border: 2px solid black; border-radius: 10px" />
														</div>
													</div>
												</div>
												<div class="modal-footer">
													<button type="button" class="btn btn-secondary"
														data-dismiss="modal">Close</button>
												</div>
											</div>
										</div>
									</div>
								</div>							
							</c:otherwise>
						</c:choose>
					</c:otherwise>
				</c:choose>
		</div>

		<div id="戰績" class="hiddenDiv" style="display:none">
<!-- 			<p>比賽未開始,暫無戰績內容</p> -->
			<p>冠軍:</p>
			<p>亞軍:</p>
			<p>季軍:</p>
			<p>殿軍:</p>
			<hr>

			<p>round(n)</p>
			<hr>
			
			<p>預賽圖</p>
			<hr>
			
			<p>預賽戰績</p>


		</div>
		
		
		
</div>
<%@ include file="../Foot.jsp"%>

<script>
	$(function(){
		$("#rule").on("click","a",function(){
			this.target = "_blank";
		});
		
		$('#largeImage').on('shown.bs.modal', function() {
//				$('#myInput').trigger('focus')
			console.log("大圖");
			
		})
		
		$(".item").on("click",function(){
			$(".item").removeClass("itemChoose");
			$(this).addClass("itemChoose");
			$(".joinItem").css("background", "#28a745");
			$(".hiddenDiv").css("display","none");
			$("#" + $(this).text()).css("display","block");
		});
		
		$(".joinItem").on("click",function(){
			$(".item").removeClass("itemChoose");
			$(this).css("background", "#218838");
			
			(async () => {
				const { value: accept } = await Swal.fire({
				  title: "報名比賽",
				  input: "checkbox",
				  inputValue: 1,
				  inputPlaceholder: "我同意遵守比賽規則",
				  confirmButtonText: "報名&nbsp;<i class=\"fa fa-arrow-right\"></i>",
				  inputValidator: (result) => {
				    return !result && "您必須勾選才能報名"
				  },
				  showClass: {
					    popup: 'animate__animated animate__fadeInDown'
				  }
				})

				if (accept) {
					$.ajax({
						type: "post",
						url: "<c:url value='/contest/Join'/>",
						dataType: "json",
						data:{},
						success: function(result){
							if(result.status == "success"){
								Swal.fire({
									  title: "報名完成",
				 					  icon: "success",
				 					  hideClass: {
				 						    popup: 'animate__animated animate__fadeOutUp'
				 					  }
							  	})
							}else if(result.status == "sqlError"){
								Swal.fire({
									  title: '資料庫發生錯誤!',
									  text: '請聯繫管理員',
									  icon: 'error',
									  hideClass: {
										    popup: 'animate__animated animate__fadeOutUp'
										  }
								})
							}
						},
						error: function(err){
							Swal.fire({
								  title: '網頁發生錯誤!',
								  text: '請聯繫管理員',
								  icon: 'error',
								  hideClass: {
									    popup: 'animate__animated animate__fadeOutUp'
									  }
						})
						}
					});
					
					
				  
				}
				})()
		});
		
		$("#quitContest").on("click", function(){
			console.log($(this).val());
			Swal.fire({
				showClass: {
				    popup: 'animate__animated animate__fadeInDown'
				  },
				  title: '確定退出比賽?',
				  icon: 'warning',
				  showCancelButton: true,
				  confirmButtonColor: '#d33',
				  cancelButtonColor: '#3085d6',
				  confirmButtonText: '退出比賽',
			      cancelButtonText: '取消',
					hideClass: {
					    popup: 'animate__animated animate__fadeOutUp'
					  }
				}).then((result) => {
				  if (result.isConfirmed) {
					  $.ajax({
							type: "delete",
							url: "<c:url value='/contest/Quit/" + $(this).val() + "'/>",
							dataType: "json",
							data: {},
							success: function(result){
								if(result.status == "success"){
									Swal.fire({
											      title:"退出成功!",
												  icon:"success",
												  hideClass: {
												    popup: 'animate__animated animate__fadeOutUp'
												  }
											  }).then(function(){
												window.setTimeout(function(){$(location).attr("href", "<c:url value='/contest/Index'/>");},500);
												
											})
								}else if(result.status == "sqlError"){
									Swal.fire(
											  '資料庫發生錯誤!',
											  '請聯繫管理員',
											  'error'
											)
								}
							},
							error: function(err){
								Swal.fire(
										  '網頁發生錯誤!',
										  '請聯繫管理員',
										  'error'
										)
							}
							
						});		
				  }
				})

		});
		
		
		
		
		$("#delete").on("click", function(){
			Swal.fire({
				showClass: {
				    popup: 'animate__animated animate__fadeInDown'
				  },
				  title: '確定刪除此筆紀錄?',
				  text: "刪除之後將不能復原",
				  icon: 'warning',
				  showCancelButton: true,
				  confirmButtonColor: '#d33',
				  cancelButtonColor: '#3085d6',
				  confirmButtonText: '刪除',
			      cancelButtonText: '取消',
					hideClass: {
					    popup: 'animate__animated animate__fadeOutUp'
					  }
				}).then((result) => {
				  if (result.isConfirmed) {
					  $.ajax({
							type: "delete",
							url: "<c:url value='/contest/Edit/" + $(this).val() + "'/>",
							dataType: "json",
							data: {},
							success: function(result){
								if(result.status == "success"){
									Swal.fire({
											      title:"刪除成功!",
												  icon:"success",
												  hideClass: {
												    popup: 'animate__animated animate__fadeOutUp'
												  }
											  }).then(function(){
												window.setTimeout(function(){$(location).attr("href", "<c:url value='/contest/Index'/>");},500);
												
											})
								}else if(result.status == "sqlError"){
									Swal.fire(
											  '資料庫發生錯誤!',
											  '請聯繫管理員',
											  'error'
											)
								}
							},
							error: function(err){
								Swal.fire(
										  '網頁發生錯誤!',
										  '請聯繫管理員',
										  'error'
										)
							}
							
						});		
				  }
				})

		});
		
		
		$("#showOption").on("click", function(){
			this.target = "_blank";
		});
	
	});
</script>

</body>
</html>