<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
			if(window.confirm("정말 탈퇴 시킬껍니까? 후회할퇸데...마음속으로만하라했는뒈......")){
				return true;
			} else{
				return false;
			}

		});
	});
	
</script>
<div class="container">
	
		<h2 class="center">회원 정보 수정</h2>
			<form action="edit" method="post">
			
				<table class="table">
					<tbody>
						<tr>
							<th>이메일</th>
							<td><input type="email" name="memberEmail"
								value="${memberDto.memberEmail}" readonly class="form-control fsize" id="floatingInput"></td>
						</tr>
						<tr>
							<th>이름</th>
							<td><input type="text" name="memberName"
								value="${memberDto.memberName}" readonly class="form-control fsize" id="floatingInput"></td>
						</tr>
						<c:if test="${!admin}">
							<tr>
								<th>비밀번호</th>
								<td><input type="password" name="memberPw" required class="form-control fsize" id="floatingInput"></td>
							</tr>
						</c:if>
						<tr>
							<th>닉네임</th>
							<td><input type="text" name="memberNick" required
								value="${memberDto.memberNick}" class="form-control fsize" id="floatingInput"></td>
						</tr>
						<tr>
							<th>생년월일</th>
							<td><input type="date" name="memberBirth" required
								value="${memberDto.getMemberBirthDay()}" class="form-control fsize" id="floatingInput"></td>
						</tr>
						<tr>
							<th>전화번호</th>
							<td><input type="tel" name="memberPhone"
								value="${memberDto.memberPhone}" class="form-control fsize" id="floatingInput"></td>
						</tr>
						<%--관리자 등급만 수정가능 구역  --%>
						<c:if test="${admin}">
							<tr>
								<th>회원등급</th>
								 <td>
									<select name="memberGrade" class="form-select" id="exampleSelect1" >
			                                    <option class="select-grade" value="브론즈" >브론즈</option>
			                                    <option class="select-grade" value="실버">실버</option>
			                                    <option class="select-grade" value="다이아">다이아</option>
			                                    <option class="select-grade" value="운영자">운영자</option>
			                                    <option class="select-grade" value="정지">정지</option>
			                        </select>
								 <td>
							</tr>
							
							<tr>
								<th>포인트</th>
								<td><input type="number" name="memberPoint" value="${memberDto.memberPoint}" class="form-control fsize" id="floatingInput"></td>
							</tr>
								
							<tr>
								<th>가입일</th>
								<td><input type="date" name="memberJoin" value="${memberDto.getMemberJoinDay()}" readonly class="form-control fsize" id="floatingInput"></td>
							</tr>
							
								
						</c:if>
				
						<tr>
							<td colspan="2" align="right">
								<input type="submit" value="수정" class="btn btn-info">
							</td>
						</tr>
						<c:if test="${admin}">
						 <tr>
						 	 <td>
								<a href="${root}/admin/memberDrop?memberNo=${memberDto.memberNo}" id="drop" class="btn btn-primary">회원탈퇴</a>
						 	 </td>
						 </tr>
						</c:if>
					</tbody>
				</table>
			
			</form>
</div>

<c:if test="${param.error != null}">
<h4><font color="red">비밀번호가 일치하지 않습니다</font></h4>
</c:if>


