<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<style>
.item {
   display: flex;
   flex-direction: column;
   flex: 1 1 1 1 25%;
   flex-basis :auto;
}
a:link { 
color: black; text-decoration: none;
}
a:visited { 
color: black; text-decoration: none;
}
</style>



<h1>✿MOVIE CHART✿</h1>
<hr>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>