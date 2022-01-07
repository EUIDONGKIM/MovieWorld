<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<c:set var="list" value="${memberSearchVO.list}"></c:set>


<div class="container-1200 container-center">
	<div class="row center">
		<h1> 회원 목록  </h1>
	</div>

 <table class="table">
 	<thead>
	 	<tr>
	 		<th>회원번호</th>
	 		<th>이메일</th>
	 		<th>닉네임</th>
	 		<th>회원등급</th>
	 		<th>회원포인트</th>
	 		<td>상세보기</td>
<!--  			<td>수정</td> -->
<!--  			<td>탈퇴</td> -->
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
	 			<td><a href="${root}/admin/member/edit2?memberNo=${memberDto.memberNo}">상세</a></td>
<%-- 	 			<td><a href="${root}/member/eidt?memberNo="${memberDto.memberNo}>수정</a></td> --%>
<!-- 	 			<td><a href="memberDrop">탈퇴</a></td> -->
	 		</tr>
 		</c:forEach>
 	</tbody>
 </table>
 <!-- 페이지 네이션 및 검색 -->
 	<div class="row center">
		<div class="col">
		</div>
		<div class="col center" >
		<!-- 이전 버튼 -->
			<ul class="pagination pagination-lg center" style="justify-content: center;">
			<c:choose>
				<c:when test="${memberSearchVO.isPreviousAvailable()}">
					<c:choose>
						<c:when test="${memberSearchVO.isSearch()}">
							<li class="page-item">
							<!-- 검색용 링크 -->
							<a href="memberlist?column=${memberSearchVO.column}&keyword=${memberSearchVO.keyword}&p=${memberSearchVO.getPreviousBlock()}" class="page-link">&lt;</a>
							</li>
						</c:when>
						<c:otherwise>
							<!-- 목록용 링크 -->
	<%-- 						<a href="main?p=${boardSearchVO.getPreviousBlock()}">&lt;</a> --%>
							<li class="page-item">
							<a href="memberlist?p=${memberSearchVO.getPreviousBlock()}" class="page-link">&lt;</a>
							</li>
						</c:otherwise>
					</c:choose>
				</c:when>
				<c:otherwise>
					<li class="page-item"><a class="page-link">&laquo;</a></li>
				</c:otherwise>
			</c:choose>
		
			<!-- 페이지 네비게이터 -->
			<c:forEach var="i" begin="${memberSearchVO.getStartBlock()}" end="${memberSearchVO.getRealLastBlock()}" step="1">
				
				<c:choose>
					<c:when test="${memberSearchVO.isSearch()}">
						<li class="page-item">
						<!-- 검색용 링크 -->
						<a href="memberlist?column=${memberSearchVO.column}&keyword=${memberSearchVO.keyword}&p=${i}" class="page-link">${i}</a>
						</li>
					</c:when>
					<c:otherwise>
						<li class="page-item">
						<!-- 목록용 링크 -->
						<a href="memberlist?p=${i}" class="page-link">${i}</a>
						</li>
					</c:otherwise>
				</c:choose>
			
			</c:forEach>
	
			
			<!-- 다음 -->
			<c:choose>
				<c:when test="${memberSearchVO.isNextAvailable()}">
					<c:choose>
						<c:when test="${memberSearchVO.isSearch()}">
							<!-- 검색용 링크 -->
							<li class="page-item">
								<a href="memberlist?column=${memberSearchVO.column}&keyword=${memberSearchVO.keyword}&p=${memberSearchVO.getNextBlock()}" class="page-link">&gt;</a>
						</c:when>
						<c:otherwise>
							<!-- 목록용 링크 -->
							<li class="page-item">
								<a href="memberlist?p=${memberSearchVO.getNextBlock()}" class="page-link">&gt;</a>
							</li>					
						</c:otherwise>
					</c:choose>
				</c:when>
				<c:otherwise>
					<li class="page-item"><a class="page-link">&raquo;</a></li>
				</c:otherwise>
			</c:choose>
			</ul>
		</div>
		<div class="col">
		</div>
	</div>
	
	<!-- 검색창 -->
	<div class="row">
		<div class="col-4">
		</div>
		<div class="col-4">
			<form method="get" class="d-flex">
			
				<select name="column" class="form-input form-inline">
					<c:choose>
						<c:when test="${MemberSearchVO.columnIs('member_no')}">
						<option value="member_no" selected>회원번호</option>
						<option value="member_email">이메일</option>
						<option value="member_nick">닉네임</option>
					</c:when>
					
					<c:when test="${MemberSearchVO.columnIs('member_email')}">
						<option value="member_no">회원번호</option>
						<option value="member_email" selected>이메일</option>
						<option value="member_nick">닉네임</option>
					</c:when>
					
					<c:otherwise>
						<option value="member_no">회원번호</option>
						<option value="member_email">이메일</option>
						<option value="member_nick" selected>닉네임</option>
					</c:otherwise>
					</c:choose>
				</select>
				
				<input type="search" name="keyword" placeholder="검색어 입력" required 
						value="${MemberSearchVO.keyword}" class="form-input form-inline">
				
				<input type="submit" value="검색" class="btn btn-info my-2 my-sm-0">
				
			</form>
		</div>
		<div class="col-4">
		</div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>