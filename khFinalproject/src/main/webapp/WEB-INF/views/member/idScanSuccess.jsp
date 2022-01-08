<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:include page="/WEB-INF/views/template/designcode.jsp"></jsp:include>

<br><br>
<div class="container-fluid">
	<div class="card border-dark mb-3 align-items-center" style="width: auto; height: auto" >
	  <div class="card-header">가입하신 아이디는</div>
	  <div class="card-body">
	    <h4 class="card-title">[${memberEmail}]입니다</h4>
	  </div>
		<div class="row">
		<input type="button" value="창닫기" onClick="window.close()" class="btn btn-info">
		</div>
	</div>
</div>

