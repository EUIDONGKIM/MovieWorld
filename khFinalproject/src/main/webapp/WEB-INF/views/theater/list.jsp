<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>
	$(function(){
		
		var deleteResult = "${deleteResult}";
		if(deleteResult){
			alert("삭제가 완료되었습니다.");
		}
		
		$(".city").click(function(){
			
			var cityValue = $(this).text();
			
			$.ajax({
				url:"${pageContext.request.contextPath}/data/getTheaters?city="+cityValue,
				type:"get",
				dataType:"json",
				success:function(resp){
					console.log("성공",resp)
					//$(".result").remove();
					$(".result").empty();
					
					for(var i = 0 ; i < resp.length ; i++){
						//여기 고쳐야함
						var html = "<div><a href='detail?theaterNo="+resp[i].theaterNo+"'>"+resp[i].theaterName+"</a></div>" 
						$(".result").append(html);
					}
					
				},
				error:function(e){
					console.log(" 실패",e);
				}
			});
		});
	});
</script>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<h1>극장 목록(레이아웃 생각해보기...내가 선호하는 or 자주가는 극장도 ?)</h1>

<div>
	<c:forEach var="theaterCityVO" items="${cityList }">
		<div>
			<a class="city" data-city="${theaterCityVO.theaterSido}">${theaterCityVO.theaterSido}</a>
		</div>
	</c:forEach>

<hr>

	<div class="result"></div>

</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>