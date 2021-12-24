<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
 <div class="container-500 container-center">
 	<div class="row">
 		<div class="col center">
 			<h1>로그인</h1>
 		</div>
 	</div>
 <form method="post">
 	 <div class="row">
 			<input type="text" name="memberEmail" placeholder="examEmail@google.com" required class="form-input">
 	 </div>
 	
 	 <div class="row ">
 			<input type="password" name="memberPw" placeholder="pawssword" required class="form-input">
 	 </div>
 	
 	 <div class="row">
 			<input type="submit" value="login" class="form-btn">
 	 </div>
 </form>	 
 </div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>