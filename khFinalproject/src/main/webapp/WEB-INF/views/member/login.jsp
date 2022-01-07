<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<style>
.fsize{
font-size: 20px;
}
</style>

<script>
// 	// form이 전송되면 input[type=password]가 자동 암호화되도록 설정
$(function(){
	$("form").submit(function(e){
		e.preventDefault();//form 기본 전송 이벤트 방지
	
		//this == form
		//모든 비밀번호 입력창에 SHA-1 방식 암호화 지시(32byte 단방향 암호화)
		$(this).find("input[type=password]").each(function(){
			//this == 입력창
			var origin = $(this).val();
			console.log(origin);
			var hash = CryptoJS.SHA1(origin);//암호화(SHA-1)
			var encrypt = CryptoJS.enc.Hex.stringify(hash);//암호화 값 문자열 변환
			$(this).val(encrypt);
		});
		
		this.submit();//form 전송 지시
	});
});
</script>




 <div class="container-500 container-center">
 	<div class="row">
 		<div class="col center">
 			<h1>로그인</h1>
 		</div>
 	</div>
 <form method="post" action="login">
 	 <div class="row">
 	 	<div class="col">
			<input type="text" name="memberEmail" value="${cookie.saveId.value}" placeholder="examEmail@google.com" required class="form-control fsize" id="floatingInput"> 	 	
 	 	</div>
 	 </div>
 	
 	 <div class="row">
 	 	<div class="col">
			<input type="password" name="memberPw" placeholder="pawssword" required class="form-control fsize" id="floatingInput">
 	 	</div>
 	 </div>
 	
	 <div class="row">
	 	<div class="col">
		 	<label>
		 	<c:choose>
		 		<c:when test="${cookie.saveId==null}">
			 		<input type="checkbox" name="saveId" class="form-check-input">
		 		</c:when>
		 		<c:otherwise>
			 		<input type="checkbox" name="saveId" checked class="form-check-input">
		 		</c:otherwise>
		 	</c:choose>
			 	아이디 저장
		 	</label>
	 	</div>
	 </div>

 	 
 	 <div class="row">
 			<input type="submit" value="login" class="btn btn-info fsize" width="100%">
 	 </div>
 	 
	<c:if test="${param.error != null}">
		<div class="row center">
			<div class="col">
				<h4 class="error">입력하신 정보가 일치하지 않습니다</h4>
			</div>
		</div>
	</c:if>
	
	<c:if test="${param.stop != null}">
		<div class="row center">
			<div class="col">
				<h4 class="error">계정이 정지되었습니다.</h4>
				<h4 class="error">관리자에게 문의하세요</h4>
				
			</div>
		</div>
	</c:if>
 	 
 	 <div class="row" >
	  	<div class="col center">
	  		<a href="#" onclick="window.open('idScan','window_name','width=600,height=500,location=no,status=no,scrollbars=yes');">아이디찾기</a>
	  	</div>
	  	<div class="col center">
	 		<a href="#" onclick="window.open('pwScan','window_name','width=600,height=500,location=no,status=no,scrollbars=yes');">비밀번호찾기</a>
	  	</div>
	  	<div class="col center">
	  		<a href="${root}/member/join">회원가입</a>
	  	</div>
	 </div>
 </form>	 
 </div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>