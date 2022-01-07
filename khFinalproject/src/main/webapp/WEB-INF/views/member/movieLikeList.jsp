<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<h1>내가 보고 싶은 영화 / restcotroller 더보기로 화면만 구성하면 됨</h1>
<c:forEach var="myMovieLikeVO" items="${myMovieLikeList}">
<div>
${myMovieLikeVO}
</div>
</c:forEach>