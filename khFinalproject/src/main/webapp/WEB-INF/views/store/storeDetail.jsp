<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv= "Content-Type" content="text/html; charset="UTF-8">
<title>상품 상세정보</title>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
</head>
<body>
<h1>상품 상세정보</h1>
<table border="1">
<tr>
<tb>
<img src="${path}/image/${vo.productUrl }" width="340" height="300">
</tb>
<td>
<table border="1" style = "height:300px; width:400px;">
<tr align="center">
<td>상품명</td>
<td>${vo.productName}</td>
</tr>
<tr align="center">
<td>가격</td>
<td><fmt:formatNumber value="${vo.productPrice }" pattern="###,###,###"/></td>

</table>
</body>
</html>