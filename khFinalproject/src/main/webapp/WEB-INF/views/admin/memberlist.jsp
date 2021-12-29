<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>


<h1> 회원 목록  </h1>

<div class="container-1200 contianer-center">
 <table class="table">
 	<thead>
	 	<tr>
	 		<th>회원번호</th>
	 		<th>이메일</th>
	 		<th>닉네임</th>
	 		<th>회원등급</th>
	 		<th>회원포인트</th>
	 		<td>상세보기</td>
 			<td>수정</td>
 			<td>탈퇴</td>
	 	</tr>
 	</thead>
 	<tbody>
 		<c:forEach var="memberDto" items="${list}">
	 		<tr>
	 			<td>${memberDto.memberNo}</td>
	 			<td>${memberDto.memberEmail}</td>
	 			<td>${memberDto.memberNick}</td>
	 			<td>${memberDto.memberGrade}</td>
	 			<td>${memberDto.memberPoint}</td>
	 			<td><a href="#">상세</a></td>
	 			<td><a href="${root}/member/eidt?memberNo="${memberDto.memberNo}>수정</a></td>
	 			<td><a href="memberDrop">탈퇴</a></td>
	 		</tr>
 		</c:forEach>
 	</tbody>
 	
 	
 
 </table>
</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>