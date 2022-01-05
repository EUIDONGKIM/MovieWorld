<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<c:set var="list" value="${storeSearchVO.list}"></c:set>


<h1> 상품 목록  </h1>

<div class="container-1200 contianer-center">
 <table class="table">
 	<thead>
	 	<tr>
	 		<th>상품 번호</th>
	 		<th>상품 종류</th>
	 		<th>상품 이름</th>
	 		<th>상품 가격</th>
	 		<th>원산지</th>
	 		<th>상품 소개</th>
	 		<th>상품 내용</th>
	 		<td>상세보기</td>
<!--  			<td>수정</td> -->
<!--  			<td>탈퇴</td> -->
	 	</tr>
 	</thead>
 	<tbody>
 		<c:forEach var="storeDto" items="${list}">
	 		<tr>
	 			<td>${storeDto.productNo}</td>
	 			<td>${storeDto.productType}</td>
	 			<td>${storeDto.productName}</td>
	 			<td>${storeDto.productPrice}</td>
	 			<td>${storeDto.productOrigin}</td>
	 			<td>${storeDto.productIntro}</td>
	 			<td>${storeDto.productContent}</td>
	 			<td><a href="${root}/store/storeEdit?productNo=${storeDto.productNo}">상세</a></td>
	 		</tr>
 		</c:forEach>
 	</tbody>
 </table>
 <!-- 페이지 네이션 및 검색 -->
 	<div class="row pagination">
		<!-- 이전 버튼 -->
		<c:choose>
			<c:when test="${storeSearchVO.isPreviousAvailable()}">
				<c:choose>
					<c:when test="${storeSearchVO.isSearch()}">
						<!-- 검색용 링크 -->
						<a href="storelist?column=${storeSearchVO.column}&keyword=${storeSearchVO.keyword}&p=${storeSearchVO.getPreviousBlock()}">&lt;</a>
					</c:when>
					<c:otherwise>
						<!-- 목록용 링크 -->
						<a href="storelistp=${storeSearchVO.getPreviousBlock()}">&lt;</a>
					</c:otherwise>
				</c:choose>
			</c:when>
			<c:otherwise>
				<a>&lt;</a>
			</c:otherwise>
		</c:choose>
	
		<!-- 페이지 네비게이터 -->
		<c:forEach var="i" begin="${storeSearchVO.getStartBlock()}" end="${storeSearchVO.getRealLastBlock()}" step="1">
			<c:choose>
				<c:when test="${storeSearchVO.isSearch()}">
					<!-- 검색용 링크 -->
					<a href="storelist?column=${storeSearchVO.column}&keyword=${storeSearchVO.keyword}&p=${i}">${i}</a>
				</c:when>
				<c:otherwise>
					<!-- 목록용 링크 -->
					<a href="storelist?p=${i}">${i}</a>
				</c:otherwise>
			</c:choose>
		</c:forEach>

		
		<!-- 다음 -->
		<c:choose>
			<c:when test="${storeSearchVO.isNextAvailable()}">
				<c:choose>
					<c:when test="${storeSearchVO.isSearch()}">
						<!-- 검색용 링크 -->
						<a href="storelistcolumn=${storeSearchVO.column}&keyword=${storeSearchVO.keyword}&p=${storeSearchVO.getNextBlock()}">&gt;</a>
					</c:when>
					<c:otherwise>
						<!-- 목록용 링크 -->
						<a href="storelist?p=${storeSearchVO.getNextBlock()}">&gt;</a>
					</c:otherwise>
				</c:choose>
			</c:when>
			<c:otherwise>
				<a>&gt;</a>
			</c:otherwise>
		</c:choose>
	</div>
	
	<!-- 검색창 -->
	<div class="row center">
		<form method="get">
	
			<select name="column" class="form-input form-inline">
				<c:choose>
					<c:when test="${StoreSearchVO.columnIs('product_no')}">
						<option value="product_no" selected>상품 번호</option>
						<option value="product_type">상품 종류</option>
						<option value="product_name">상품 이름</option>
					</c:when>
					
					<c:when test="${StoreSearchVO.columnIs('product_type')}">
						<option value="product_no" >상품 번호</option>
						<option value="product_type" selected>상품 종류</option>
						<option value="product_name">상품 이름</option>
					</c:when>
					
					<c:otherwise>
						<option value="product_no" >상품 번호</option>
						<option value="product_type" >상품 종류</option>
						<option value="product_name" selected>상품 이름</option>
					</c:otherwise>
				</c:choose>
			</select>
			
			<input type="search" name="keyword" placeholder="검색어 입력" required 
					value="${MemberSearchVO.keyword}" class="form-input form-inline">
			
			<input type="submit" value="검색" class="form-btn form-inline">
			
		</form>
	</div>
</div>



<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>