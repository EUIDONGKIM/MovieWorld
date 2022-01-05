<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<c:set var="grade" value="${grade}"></c:set>
<c:set var="admin" value="${grade eq '운영자'}"></c:set>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<script>
	var grade = '${memberDto.memberGrade}';
	$(function(){
	    $(".select-grade").each(function(){
	        if(grade==$(this).val()){
	            $(this).prop("selected",true);
	        }
	    });
		$("#drop").click(function(e){
			if(window.confirm("상품 삭제")){
				return true;
			} else{
				return false;
			}

		});
	});
	

	
	
</script>
<h1>상품 수정</h1>
<p>${storeList}</p>
<form method="post">

	<table class="table">
		<tbody>
			<tr>
				<th>상품 종류</th>
				<td><input type="text" name="productType"
					value="${StoreDto.productType}"></td>
			</tr>
			<tr>
				<th>상품 이름</th>
				<td><input type="text" name="productName"
					value="${StoreDto.productName}"></td>
			</tr>
			<tr>
				<th>상품 가격</th>
				<td><input type="number" name="productPrice"
					value="${StoreDto.productPrice}"></td>
			</tr>
			<tr>
				<th>원산지</th>
				<td><input type="text" name="productOrigin"
					value="${StoreDto.productOrigin}"></td>
			</tr>
			<tr>
				<th>상품 소개</th>
				<td><input type="text" name="productIntro"
					value="${StoreDto.productIntro}"></td>
			</tr>
			<tr>
				<th>상품 내용</th>
				<td><input type="text" name="productContent"
					value="${StoreDto.productContent}"></td>
			</tr>
			
			<tr>
				<td colspan="2" align="right"><input type="submit" value="수정">
				</td>
			</tr>
			<c:if test="${admin}">
			<tr>
			 	 <td>
					<a href="${root}/store/delete?productNo=${StoreDto.productNo}" id="delete">상품 삭제</a>
			 	 </td>
			 </tr>
			</c:if>
		</tbody>
	</table>

</form>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>