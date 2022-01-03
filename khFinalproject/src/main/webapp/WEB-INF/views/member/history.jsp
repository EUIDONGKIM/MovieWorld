<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container-1200 container-center">
	<table class="table">
		<thead>
			<tr>
				<td>일시</td>
				<td>포인트</td>
				<td>메모</td>
			</tr>
		</thead>
		<c:forEach var="historyDto" items="${list}">
			<tbody>
				<tr>
					<td>${historyDto.historyTime}</td>
					<td>${historyDto.historyAmount}</td>
					<td>${historyDto.historyMemo}</td>
				</tr>
			</tbody>
		</c:forEach>
	
	</table>

</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>