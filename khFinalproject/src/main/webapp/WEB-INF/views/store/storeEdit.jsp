<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
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
		</tbody>
	</table>

</form>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>