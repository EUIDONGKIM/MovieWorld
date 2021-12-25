<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
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
 	 
 	 <div class="row" >
	  	<ul class="snapsync-member-nav">
	  		<li><a href="#" onclick="window.open('idScan','window_name','width=600,height=500,location=no,status=no,scrollbars=yes');">아이디찾기</a></li>
	  		<li><a href="#" onclick="window.open('pwScan','window_name','width=600,height=500,location=no,status=no,scrollbars=yes');">비밀번호찾기</a></li>
	  		<li><a href="${root}/member/join">회원가입</a></li>
	  	</ul>
	 </div>
 </form>	 
 </div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>