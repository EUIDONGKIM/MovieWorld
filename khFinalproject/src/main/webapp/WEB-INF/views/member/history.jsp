<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- <jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include> --%>
<script>
	$(function(){
		var page = 1;
		var size = 5;
		
		$(".more-btn").click(function(){
			loadData(page, size);
			page++;
		});
		
		//더보기 버튼을 강제 1회 클릭(트리거)
		$(".more-btn").click();
		
		//내부적으로 사용할 함수 (외부에서는 호출 불가)
		function loadData(pageValue, sizeValue){
			$.ajax({
				url:"${pageContext.request.contextPath}/member/historyMore",
				type:"get",
				data:{
					page : pageValue,
					size : sizeValue
				},
				dataType:"json",
				success:function(resp){
					console.log("성공", resp);
					
					//데이터가 sizeValue보다 적은 개수가 왔다면 더보기 버튼을 삭제
					if(resp.length < sizeValue){
						$(".more-btn").remove();
					}
					
				
					//데이터 출력
					
					for(var i=0; i < resp.length; i++){
						console.log("변환 전",resp[i].historyTime);
						//Date d = new Date(resp[i].historyTime);
						var date = new Date(resp[i].historyTime);
						
						var html = 
						"<tr>"+
						"<th>"+date.getFullYear()+"년　"+date.getMonth()+1+"월　"+date.getDate()+"일　"+date.getHours()+"시　"+date.getMinutes()+"분　"+"</th>"+
						"<th>"+resp[i].historyAmount+"</th>"+
						"<th>"+resp[i].historyMemo+"</th>"+
						"</tr>"
							
							
// 						"<h2>"+"[시간:"+date.getFullYear()+"년 "+date.getMonth()+1+"월 "+date.getDate()+"일"
// 						+date.getHours()+"시 "+date.getMinutes()+"분 "+date.getSeconds()+"초]"
// 						+"-[적립금]"+resp[i].historyAmount+"-[내역]"+resp[i].historyMemo+"</h2>";
						
						$("#result").append(html);
					}
				},
				error:function(e){
					console.log("실패", e);
				}
			});
		}
	});
	
	
</script>
<div class="container-1200 container-center">
	<div class="row center">
	 	<div class="col ">
	 		<h1>사용가능하신 포인트는  ["${point}"] 포인트 입니다</h1>
	 	</div>
	</div>
	<table class="table table-border table-hover">
		<thead>
			<tr>
				<td width="30%">일시</td>
				<td>포인트</td>
				<td>사용내역</td>
			</tr>
		</thead>
			<tbody id="result">
			</tbody>
	</table>

	<div class="row center">
		<div class="col">
			<button type="button" class="btn btn-primary more-btn">더보기</button>
		</div>
	</div>

</div>
<%-- <jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include> --%>