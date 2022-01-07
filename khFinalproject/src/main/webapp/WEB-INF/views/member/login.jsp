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

 <div class="container-500 container-center">
 	<div class="row">
 		<div class="col center">
 			<h1>로그인</h1>
 		</div>
 	</div>
 <form method="post">
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