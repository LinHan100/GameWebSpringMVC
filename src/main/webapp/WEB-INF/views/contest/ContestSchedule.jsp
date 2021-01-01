<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ include file="../Link.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>GameBar</title>
<style>
	.player{
		border: 2px solid red;
		margin: 10px;
		padding: 2px;
		cursor: default;
	}
	
	
	*{
		margin:0;
		padding:0;
	}
	
	#tree{
 	    overflow: auto; 
	    border: 1px solid red;
		position: relative;
	}
	
	.tree ul{
		padding-top:20px;
		position: relative;
	}
	.tree li{
		float:left;
		list-style: none;
		text-align: center;
		position: relative;
		padding:20px 5px 0 5px;
	}
	/*利用::before,::after作分支線*/
	.tree li::before,.tree li::after{
		content:"";
		position: absolute;
		top:0;
		right:50%;
		width:50%;
		height:20px;
		border-top:2px solid black;
	}
	.tree li:after{
		right:auto;
		left:50%;
		/* border-left:2px solid red; */
		border-left:2px solid black;
	}
	.tree li:first-child::before,.tree li:last-child::after{
		border:0 none;
	}
	.tree li:last-child::after{
		border-left:2px solid black;
		/* border-left:2px solid green; */
	}
	
	/*刪除僅只有一個分支的分支線*/
	.tree li:only-child::before,.tree li:only-child::after{
		border:none;
	}
	.tree li:only-child{
		padding-top:0;
	}
	
	/*新增僅只有一個分支的下分支線*/
	.tree ul ul::before{
		content:"";
		position: absolute;
		top:0;
		left:50%;
		border-left:2px solid black;
		/* border-left:2px solid blue; */
		width:0;
		height:20px;
	}
	
	.tree label{
		display: inline-block;
		border:2px solid black;
		/* border:2px solid #ccc; */
		text-decoration: none;
		width:96px;
		height:36px;
		margin:0;
	}

</style>

<script>

	$(function(){
		$("#delete").on("click", function(){
			return confirmDelete($(this).val());
		});
	});
	


	function confirmDelete(iNo){
	  var result = confirm("確定刪除此筆記錄?");
	  if (result) {
		  document.forms[0].putOrDelete.value = "DELETE";
	      return true;
	  }
	  return false;
	}
</script>

</head>
<body>
	<%@ include file="../Header.jsp"%>

<div class="container">

<h1 class="mt-4 mb-3">比賽詳細資料/賽程安排
      <small>XXXXX</small>
    </h1>

    <ol class="breadcrumb">
      <li class="breadcrumb-item">
        <a href="<c:url value='/'/>">Home</a>
      </li>
      <li class="breadcrumb-item active">賽事</li>
    </ol>
<form action="<c:url value='/contest/Edit/${cContestBean.iNo}'/>" method="POST" >
<input type="hidden" name="_method"  id='putOrDelete'   value="" >

		<p>比賽名稱: ${cContestBean.sName} 
<%-- 			<button type="submit" name="updateNo" value="${cContestBean.iNo}">更改</button> --%>
			<a href="<c:url value='/contest/Update/${cContestBean.iNo}'/>">更改</a>
			<button type="submit" id="delete" value="${cContestBean.iNo}">刪除</button>
<%-- 			<a href="<c:url value='/contest/Delete/${cContestBean.iNo}'/>">刪除</a> --%>
			<span style="font-size:70%;color:red">(註:至比賽當日即無法更改比賽)</span>
		</p>
</form>
		<p>比賽遊戲: ${cContestBean.sGame}</p>
		<p>主辦者: ${cContestBean.sHost}</p>
		<p>報名日期: ${cContestBean.dSignStart} ~ ${cContestBean.dSignEnd}</p>
		<fmt:formatDate var="sTime" value="${cContestBean.tTime}" pattern="yyyy-MM-dd HH:mm"/>
		<p>比賽時間: ${sTime}</p>
		<p>比賽地點: ${cContestBean.sLocation}</p>
		<p>參加人數:
			${fn:length(cContestBean.lParticipateBeans)}/${cContestBean.iPeople}</p>
		<span>比賽規則:</span> <br> <span id="rule">${cContestBean.sRule}</span>
		<hr>


	<p>本場比賽共有${fn:length(cContestBean.lParticipateBeans)}人參賽</p>
	產生賽程表:
	<form>
		<div>
			<label for="" id="team">隊伍形式: </label>
			<label>
				<input type="radio" id="individual" class="team" name="team" value="no" checked>個人賽
			</label>
			<label>
				<input type="radio" id="group" class="team" name="team" value="yes" >團體賽	
			</label><br>
			<label id="teamCountSelect"></label>
		</div>
		<div>
			<label>是否有預賽: </label>
			<label>
				<input type="radio" id="Npreliminaries" 
				class="preliminaries" name="preliminaries" value="no" checked>無預賽
			</label>
			<label>
				<input type="radio" id="Ypreliminaries" 
				class="Preliminaries" name="preliminaries" value="yes">有預賽		
			</label><br>
			<label id="preliminariesCountSelect"></label>
		</div>
		<div>
			<label>賽制: </label>
			<label>
				<input type="radio" id="knockout" 
				class="competition" name="competition" value="no" checked>淘汰賽
			</label>
			<label>
				<input type="radio" id="ground" 
				class="competition" name="competition" value="yes" >循環賽
			</label><br>
		</div>
		<input type="button" id="build" value="產生">
	</form>
	<hr>
	

	<c:forEach var="participate" items="${cContestBean.lParticipateBeans}">
		<span class="playerNone" style="display:none">${participate.sPlayer} </span>
	</c:forEach>

<div id="show" style="display:none">
	<span>賽程:</span>
	<form>
		<input type="button" value="自動安排">
		<input type="button" value="產生圖檔">
	</form>
	<div style="overflow:auto">
		<div id="tree" class="tree"></div>
	</div>
	<div style="overflow:auto">
		<div id="drow" class="drow"></div>
	</div>
	<p>參賽人員:</p>
	<label id="playerCount"></label>
	<hr>	

</div>


</div>
	<%@ include file="../Foot.jsp"%>

	<script src="<c:url value='/js/jquery-ui.js'/>"></script>
	<script>
	
		$("#rule").on("click","a",function(){
			this.target = "_blank";
		});
		
		$(function() {

			$("#group").on("focus",function(){    
				if($("#group:checked").length == 0){	
			        let showSelect = false;
			        $("#teamCountSelect").append("分<select id=\"teamCount\"></select>組");
			        for(let i=2; i<$(".playerNone").length; i++){
			        	if($(".playerNone").length % i == 0) {
			        		$("#teamCount").append("<option value=" + i + ">" + i + "</option>");
							showSelect = true;
						}
			        }
			        if(!showSelect) {
			        	$("#teamCountSelect").text("目前人數無法分組");
					}
				}
				if($("#Ypreliminaries:checked").length > 0){
					$("#preliminariesCountSelect").empty();
					preliminariesCount();
				}
			});
			
			$("#individual").on("focus",function(){
				$("#teamCountSelect").empty();
				if($("#Ypreliminaries:checked").length > 0){
					$("#preliminariesCountSelect").empty();
					preliminariesCount();
				}
			});
			
			$(document).on("change", "#teamCount", function(){
                if($("#Ypreliminaries:checked").length > 0){
                	$("#preliminariesCountSelect").empty();
                	preliminariesCount();
				}
            });
			
			$("#Ypreliminaries").on("focus", function(){
				if($("#Ypreliminaries:checked").length == 0){
					preliminariesCount();
				}
			});
			
			$("#Npreliminaries").on("focus",function(){
				$("#preliminariesCountSelect").empty();
			});
			
			$(document).on("change", "#preliminariesCount1", function(){
				$("#preliminariesCount2").empty();
				for(let i=2; i<=$(this).val(); i++){
					$("#preliminariesCount2").append("<option value=" + i + ">" + i + "</option>")
				}
            });
			 
			function preliminariesCount(){
			    let iPlayer = $(".playerNone").length;
		        $("#preliminariesCountSelect").append("<select id=\"preliminariesCount1\"></select>");
		        if($("#teamCount").val() != null) {
		        	iPlayer = $("#teamCount").val();
				}
				for(let i=2; i<=iPlayer; i++) {
					$("#preliminariesCount1").append("<option value=" + i + ">" + i + "</option>");
				}
				$("#preliminariesCountSelect").append("取<select id=\"preliminariesCount2\"><option value=\"2\">2</option></select>");
			}
			
			$("#build").on("click",function(){
				$(this).val("產生/重新整理");
				let iPlayer = $(".playerNone").length;
				$("#show").attr("style","display:block;");
				
				$("#playerCount").empty();
				$("#tree").empty();
				$("#drow").empty();
				$(".playerNone").each(function(){
					$("#playerCount").append("<label class=\"player\">" + $(this).text() + "</label>");
				});			
				
				if($("#group:checked").length > 0) {
		        	iPlayer = $("#teamCount").val();
				}
				
//--------------產生賽程表-----------------------------------------------------
// 				let a = iPlayer;
// // 		        $("#tree").width((a*96+(2*a-1)*10) + "px");
// 		        $("#tree").width("1000vw");
// // 		        console.log("寬度: " + (a*100+(2*a-1)*10));
// 		        let pow = a.toString(2).length;
// 		        let max = Math.pow(2,pow);
// 		        if((max-a) == a){
// 		            pow = a.toString(2).length - 1;
// 		            max = Math.pow(2,pow);
// 		        }
// // 		        console.log("次方: " + pow);
// // 		        console.log("補滿2的次方: " + max);
// // 		        console.log("不要的場數: " + (max-a));

// 		        $("#tree").append("<ul class=\"layer1\">");
// 		        $(".layer1").append("<li class=\"text1\"><label>&nbsp;</label>");
		        
// 		        for(let i=1; i<=pow; i++){
// 		            let j = i + 1;
// 		            let className;
// 		            if(i != a.toString(2).length){
// 		                className = "class=\"text" + j + "\"";
// 		            }else{
// 		                className = "class=\"buttom\"";
// 		            }
// 		            $(".text" + i).append("<ul class=\"layer" + j + "\">");
// 		            $(".layer" + j).append("<li " + className + "><label>&nbsp;</label>");
// 		            $(".layer" + j).append("<li " + className + "><label>&nbsp;</label>");
// 		        }
// 		        for(let i=0; i<max; i++){
// 		            $(".buttom").eq(i).children().attr("id", "編號"+i).attr("class", "drop");
// 		        } 
		     
// 		        for(let i=0; i<(max-a); i++){
// 		            let str = i.toString(2);
// 		            while(str.length < pow-1){
// 		                str = "0" + str;
// 		            }
// // 		            console.log("i= " + i);
// // 		            console.log("換成2進位: " + str);
// 		            // str = str.split("").reverse().join("");
// 		            // console.log("2進位反轉: " + str);
// // 		            console.log("拆開: " + str.split(""));
// 		            let eqNumber = 0;
// 		            for(let j=0; j<pow-1; j++){
// 		                eqNumber += str.split("")[j]*Math.pow(2,j+1);
// 		            }
// // 		            console.log("eq的值: " + eqNumber);
// 		            $("#編號" + eqNumber).parent().parent().prev().before("<ul>").before("<ul>").before("<ul>").before("<ul>").attr("class","drop");
// 		            $("#編號" + eqNumber).parent().parent().remove();
// 		        }
		        
// 		        $(".drop").css("position","absolute").css("left", "100px");
//--------------產生賽程表-----------------------------------------------------				
		        
//--------------產生預賽(循環)-------------------------------------------------

// 				var gCount = 2; //組數
		        var mW = 400;
		        var mH = 400;
		        let drow = document.getElementById("drow");
		        drow.style = "width:" + (mW*Math.ceil(iPlayer/$("#preliminariesCount1").val())+5) + "px;position:relative;border: 2px solid red";
		        var mCount; //邊數
		        var mCenter = mW / 2; //中心點
		        var mRadius = mCenter - 100; //半徑(減去的值用於給繪製的文字留空間)
		        var mAngle; //角度
		        var mColorPolygon = '#FF0000'; //多邊形顏色
		        var mColorText = '#000000';
		        console.log("iPlayer: " + iPlayer);
		        console.log("$(\"#preliminariesCount1\").val(): " + $("#preliminariesCount1").val());

		        for(let i=0; i<Math.ceil(iPlayer/$("#preliminariesCount1").val()); i++){
		        	if(i == Math.ceil(iPlayer/$("#preliminariesCount1").val())-1){
			        	mCount = iPlayer - $("#preliminariesCount1").val() * i;
		        	}else{
			        	mCount = $("#preliminariesCount1").val();
		        	}
		        	mAngle = Math.PI * 2 / mCount;
		            createGroup(i);
		        }

		        function createGroup(i){
		            var canvas = document.createElement("canvas");
		            document.getElementById("drow").appendChild(canvas);
		            // document.body.appendChild(canvas);
		            canvas.height = mH;
		            canvas.width = mW;
		            canvas.style = "display:inline;";
		            var ctx = canvas.getContext('2d');
		            drowLine(ctx);
		            let coordinate = setTextCoordinate(ctx);
		            createDiv(coordinate, (mH*i));
		        }
		        
		        function drowLine(ctx){
		            //畫6條邊
		            ctx.strokeStyle = mColorPolygon;
		            ctx.beginPath(); //開始路徑
		            for(let i=0; i<mCount; i++){
		                let x1 = mCenter + mRadius * Math.cos(mAngle * i);
		                let y1 = mCenter + mRadius * Math.sin(mAngle * i);    
		                for (let j = 0; j < mCount; j++) {
		                    let x = mCenter + mRadius * Math.cos(mAngle * j);
		                    let y = mCenter + mRadius * Math.sin(mAngle * j);
		                    // console.log('x:' +  x, 'y:' +  y);
		                    ctx.moveTo(x1, y1);
		                    ctx.lineTo(x, y);
		                }
		            }
		            ctx.stroke();
		        }   

		        function setTextCoordinate(ctx){
		            //文字座標
		            var fontSize = mCenter / 12;
		            ctx.font = fontSize +  'px Microsoft Yahei';
		            ctx.fillStyle = mColorText;
		            ctx.strokeStyle = mColorText;//換個顏色
		            let coordinate = [];//儲存各方框座標
		            let size = [];//儲存各方框寬高
		            for (var i = 0; i < mCount; i++) {
		                var x = mCenter +  mRadius * Math.cos(mAngle * i);
		                var y = mCenter +  mRadius * Math.sin(mAngle * i);
		                if (mAngle * i >= 0 && mAngle * i <= Math.PI / 2) {
		                    //******點在左上******
		                    // ctx.fillText("文字" + i, x+10, y+5 +  fontSize);
		                    // ctx.strokeRect(x, y, ctx.measureText("文字" + i).width, fontSize);
		                    // ctx.strokeRect(x+10, y, 80, 30);
		                    // console.log('x:' +  (x+10), 'y:' +  y);
		                    coordinate.push([x+10,y]);
		                    // size.push([,]);
		                } else if (mAngle * i > Math.PI / 2 && mAngle * i <= Math.PI) {
		                    //******點在右上******
		                    // ctx.fillText("文字" + i, x-10 - ctx.measureText("文字" + i).width, y+5 +  fontSize);
		                    // ctx.strokeRect(x-10 -80, y, 80, 30);
		                    // console.log('x:' +  (x-10), 'y:' +  y);
		                    coordinate.push([x-100,y]);
		                } else if (mAngle * i > Math.PI && mAngle * i <= Math.PI * 3 / 2) {
		                    //******點在右下******
		                    // ctx.fillText("文字" + i, x-10 - ctx.measureText("文字" + i).width, y-5);
		                    // ctx.strokeRect(x-10 -80, y-30, 80, 30);
		                    // console.log('x:' +  (x-10), 'y:' +  y);
		                    coordinate.push([x-100,y-30]);
		                } else {
		                    //******點在左下******
		                    // ctx.fillText("文字" + i, x+10, y-5);
		                    // ctx.strokeRect(x+10, y-30, 80, 30);
		                    // console.log('x:' +  (x+10), 'y:' +  y);
		                    coordinate.push([x+10,y-30]);
		                }
		            }
		            console.log(coordinate);
		            return coordinate;
		        }
		        // console.log("各方框座標: " + coordinate);
		        // console.log("文字1的y座標: " + coordinate[1][1]);
		        // ctx.clearRect(coordinate[3][0]-1,coordinate[3][1]+1,-78,28);//+1+1-2-2 看位置調整

		        function createDiv(coordinate, groupLeft){
		            //做div
		            for(let i=0; i<mCount; i++){
		                let div = document.createElement("div");
		                div.style = "left:" + (coordinate[i][0]+groupLeft) + "px;top:" + coordinate[i][1] + "px;width:80px;height:30px;border:2px solid green;position:absolute";
		                div.className = "drop";
		                document.getElementById("drow").appendChild(div);
		                // document.body.appendChild(div);
		            }
		        }




//--------------產生預賽(循環)-------------------------------------------------


		        
				drag($(".player"));
				drop($(".drop"));
				
			});

			function drag(object){
				object.draggable();
			}

			function drop(object){
				object.droppable({
				    accept:"*",
				    drop: function(ev,ui) {
						console.log("drop" + $(this).text() + ui.draggable.text());
						$(this).text(ui.draggable.text());
// 						$(this).append("<label class=\"player\">" + ui.draggable.text() + "</label>");
						ui.draggable.css("visibility","hidden").removeClass("player");
						
					//	let 綠框內的個數 = $(".playerNone").length)/$(".drop").length;
						if($(this).children(".player").length == ($(".playerNone").length/$(".drop").length)){
							$(this).css("border-color","red").droppable("destroy");			
						}
				    },
				    out: function() {
				    	console.log("out");
				    }
				}); 
				
			}
			

		});
	</script>




</body>
</html>