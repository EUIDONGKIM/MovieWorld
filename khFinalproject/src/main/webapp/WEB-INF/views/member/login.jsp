<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
 <div class="container-500 container-center">
 	<div class="row">
 		<div class="col center">
 			<h1>로그인</h1>
 		</div>
 	</div>
 <form method="post">
 	 <div class="row">
 			<input type="text" name="memberEmail"  value="${cookie.saveId.value}" placeholder="examEmail@google.com" required class="form-input">
 	 </div>
 	
 	 <div class="row ">
 			<input type="password" name="memberPw" placeholder="pawssword" required class="form-input">
 	 </div>
 	
	 <div class="row">
		 	<label>
		 	<c:choose>
		 		<c:when test="${cookie.saveId==null}">
			 		<input type="checkbox" name="saveId">
		 		</c:when>
		 		<c:otherwise>
			 		<input type="checkbox" name="saveId" checked>
		 		</c:otherwise>
		 	</c:choose>
			 	아이디 저장
		 	</label>
	 </div>
 	 <div class="row">
 			<input type="submit" value="login" class="form-btn">
 	 </div>
 </form>	 
 </div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>