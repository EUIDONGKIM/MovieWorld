<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/designcode.jsp"></jsp:include>
<c:set var ="root" value="${pageContext.request.contextPath}"></c:set>
<c:set var="searchList" value="${boardSearchVO.list}"></c:set>
     <script>
     $(function(){
    	 //기본 전송 이벤트 방지
    	$(".atag").on("click",function(e){
    		e.preventDefault();
    		
    		var url = $(this).attr("href");
    		
    		
    		$.ajax({
    			url:url,
    			success:function(resp){
    				$("#page1").html(resp);
    			}
    		});
    	});
     });
 </script>
<div class="container-fulid">
	<div class="row center">
		<h2>내가 작성한 게시글</h2>
		<hr>
	</div>

	<div class="row">
		<table class="table table-hover">
			<thead>
				<tr>
					<th>번호</th>
					<th width="40%">제목</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>조회수</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="boardDto" items="${searchList}">
				<tr>
					<td>${boardDto.boardNo}</td>
					
					<td class="left" style="text-align: left;">
						<c:if test="${boardDto.hasDepth()}">
							<c:forEach var="i" begin="1" end="${boardDto.boardDepth}" step="1">
										&nbsp;&nbsp;&nbsp;&nbsp;
							</c:forEach>
							<img src="${root}/resources/image/reply.png" width="15" height="15">
						</c:if>
			
						<a href="${root}/board/detail?boardNo=${boardDto.boardNo}&boardTypeName=1">
							${boardDto.boardTitle}
						</a>
					</td>
					
					<td>${boardDto.memberEmail}</td>
					<td>${boardDto.boardDate}</td>
					<td>${boardDto.boardViews}</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
		<!-- 게시판 아래부분  -->
		<div class="row" >
		<div class="col">
		</div>
		<div class="col" >
		<!-- 이전 버튼 -->
			<ul class="pagination pagination-lg center">
			<c:choose>
				<c:when test="${boardSearchVO.isPreviousAvailable()}">
					<c:choose>
						<c:when test="${boardSearchVO.isSearch()}">
							<li class="page-item">
							<!-- 검색용 링크 -->
							<a href="${root}/board/userWriteList?column=${boardSearchVO.column}&keyword=${boardSearchVO.keyword}&p=${boardSearchVO.getPreviousBlock()}}" class="atag page-link">&lt;</a>
							</li>
						</c:when>
						<c:otherwise>
							<!-- 목록용 링크 -->
							<li class="page-item">
								<a href="${root}/board/userWriteList?&p=${boardSearchVO.getPreviousBlock()}}" class="atag page-link">&lt;</a>
							</li>
						</c:otherwise>
					</c:choose>
				</c:when>
				<c:otherwise>
					<a>&laquo;</a>
				</c:otherwise>
			</c:choose>
		
			<!-- 페이지 네비게이터 -->
			<c:forEach var="i" begin="${boardSearchVO.getStartBlock()}" end="${boardSearchVO.getRealLastBlock()}" step="1" >
				
				<c:choose>
					<c:when test="${boardSearchVO.isSearch()}">
						<li class="page-item">
							<!-- 검색용 링크 -->
							<a href="${root}/board/userWriteList?column=${boardSearchVO.column}&keyword=${boardSearchVO.keyword}&p=${i}" class="atag page-link">${i}</a>
						</li>
					</c:when>
					<c:otherwise>
						<li class="page-item">
							<!-- 목록용 링크 -->
							<a href="${root}/board/userWriteList?p=${i}" class="atag page-link">${i}</a>
						</li>
					</c:otherwise>
				</c:choose>
			
			</c:forEach>
	
			
			<!-- 다음 -->
			<c:choose>
				<c:when test="${boardSearchVO.isNextAvailable()}">
					<c:choose>
						<c:when test="${boardSearchVO.isSearch()}">
							<!-- 검색용 링크 -->
							<li class="page-item">
								<a href="${root}/board/userWriteList?column=${boardSearchVO.column}&keyword=${boardSearchVO.keyword}&p=${boardSearchVO.getNextBlock()}}" class="atag page-link">&gt;</a>
							<li>
						</c:when>
						<c:otherwise>
							<!-- 목록용 링크 -->
							<li class="page-item">
								<a href="${root}/board/userWriteList?p=${boardSearchVO.getNextBlock()}" class="atag page-link">&gt;</a>
							</li>					
						</c:otherwise>
					</c:choose>
				</c:when>
				<c:otherwise>
					<a>&raquo;</a>
				</c:otherwise>
			</c:choose>
			</ul>
		</div>
		
		<div class="col">
		</div>

</div>	
</div>
<!-- 	<!-- 검색창 --> 
<!-- 	<div class="row"> -->
<!-- 		<div class="col-3"> -->
<!-- 		</div> -->
<!-- 		<div class="col-6 right"> -->
<!-- 			<form method="get" class="d-flex"> -->
<!-- 					히든으로 보드타입을 보내준다. -->
<%-- 					<input type="hidden" name="boardTypeName" value="${param.boardTypeName}"> --%>
				
<!-- 				<select name="column" class="form-input form-inline"> -->
<%-- 					<c:choose> --%>
<%-- 						<c:when test="${boardSearchVO.columnIs('board_title')}"> --%>
<!-- 							<option value="board_title" selected>제목</option> -->
<!-- 							<option value="board_content">내용</option> -->
<!-- 							<option value="member_email">작성자</option> -->
<%-- 						</c:when> --%>
						
<%-- 						<c:when test="${boardSearchVO.columnIs('board_content')}"> --%>
<!-- 							<option value="board_title">제목</option> -->
<!-- 							<option value="board_content" selected>내용</option> -->
<!-- 							<option value="member_email">작성자</option> -->
<%-- 						</c:when> --%>
						
<%-- 						<c:otherwise> --%>
<!-- 							<option value="board_title">제목</option> -->
<!-- 							<option value="board_content">내용</option> -->
<!-- 							<option value="member_email" selected>작성자</option> -->
<%-- 						</c:otherwise> --%>
<%-- 					</c:choose> --%>
<!-- 				</select> -->
				
<!-- 				<input type="search" name="keyword" placeholder="검색어 입력" required  -->
<%-- 						value="${boardSearchVO.keyword}" class="form-control me-sm-2"> --%>
				
<!-- 				<input type="submit" value="검색" class="btn btn-info my-2 my-sm-0"> -->
				
<!-- 			</form> -->
<!-- 		</div> -->
<!-- 		<div class="col-3"> -->
<!-- 		</div> -->
<!-- 	</div> -->
<!-- </div> -->
