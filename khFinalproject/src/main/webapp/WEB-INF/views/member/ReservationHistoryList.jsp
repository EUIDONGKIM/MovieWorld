<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>

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
				url:"${pageContext.request.contextPath}/member/ReservationHistoryListMore",
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
						
						var html = 
								   "<tr>"+
							       "<td>"+resp[i].reservationNo+"</td>"+
								   "<td>"+resp[i].itemName+"</td>"+
								   "<td>"+resp[i].reservationTotalNumber+"</td>"+
								   "<td>"+resp[i].buyTime+"</td>"+
								   "<td>"+resp[i].reservationStatus+"</td>"+
								   "<td>"+"<a href="+"${root}/reservation/success_result?reservationNo="+resp[i].reservationNo+">결제내역</a></td>"
								   "<tr>"

						
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
	<div class="row">
		<div class="col">
			<h1 class="center">내가예약한영화</h1>
		</div>
	</div>
		<div class="row">
			<div class="col">
				<table class="table table-border table-hover">
					<thead>
						<tr>
							<th width="10%">예매번호</th>
							<th width="20%">예매좌석</th>
							<th width="5%">인원</th>
							<th>예약시간</th>
							<th>상태</th>
							<th>결제내역</th>
						</tr>
					</thead>
					<!-- 결과출력 -->
					<tbody id="result">
						
					</tbody>
				</table>
			</div>
		</div>
	
	<div class="row center">
		<div class="col">
			<button type="button" class="btn btn-primary more-btn">더보기</button>
		</div>
	</div>
</div>
<%-- <jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include> --%>