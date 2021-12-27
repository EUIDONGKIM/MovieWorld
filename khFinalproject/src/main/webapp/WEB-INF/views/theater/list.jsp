<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>
	$(function(){
		
		$(".city").click(function(){
			
			$(".result").empty();
			var cityValue = $(this).text();
			
			$.ajax({
				url:"${pageContext.request.contextPath}/data/getTheaters?city="+cityValue,
				type:"get",
				dataType:"json",
				success:function(resp){
					
					console.log("성공",resp)
					for(var i = 0 ; i < resp.length ; i++){
						//여기 고쳐야함
						var html = "<li><a href='detail?theaterNo="+resp[i].theaterNo+"'>"+resp[i].theaterName+"</a></li>" 
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

<h1>극장 목록(여기 미완성임 개판임 나중에 수정해야함)</h1>

<ul>
<c:forEach var="theaterCityVO" items="${cityList }">
<li>
	<a class="city" data-city="${theaterCityVO.theaterSido}">
		${theaterCityVO.theaterSido}
	</a>
</li>
</c:forEach>
</ul>

<hr>

<div>
	<ul class="result">
	</ul>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>