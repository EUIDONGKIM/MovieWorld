<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
      <!--bootstrap cdn-->
      <!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous"> -->
      <link href="https://bootswatch.com/5/cerulean/bootstrap.min.css" type="text/css" rel="stylesheet">

      <!-- bootstrap javascript cdn-->
      <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
      <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    	
    <style>
        .b{
            border:1px solid black;
        }
     </style>
</head>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<c:set var="root"   value="${pageContext.request.contextPath}"></c:set>
<c:set var="bronze" value="${memberDto.memberGrade eq '브론즈' }"></c:set>
<c:set var="silver" value="${memberDto.memberGrade eq '실버' }"></c:set>
<c:set var="gold"   value="${memberDto.memberGrade eq '골드' }"></c:set>
<c:set var="admin"  value="${memberDto.memberGrade eq '운영자' }"></c:set>

<body>
    <div class="container-fluid" style="background-color: #EEEEEE">
        <div class="row">
            <div class="col-md-12 b">
        		<div class="row">
        			<c:if test="${bronze}">
        				<div class="col-2">
        					<img src="${root}/resources/image/브론즈.png" height="200px" width="200px">
        				</div>
        			</c:if>
        			
        			<c:if test="${silver}">
        				<div class="col-2">
        					<img src="${root}/resources/image/실버.png" height="200px" width="200px">
        				</div>
        			</c:if>
        			
        			<c:if test="${gold}">
        				<div class="col-2">
        					<img src="${root}/resources/image/골드.png" height="200px" width="200px">
        				</div>
        			</c:if>
        			
        			<c:if test="${admin}">
        				<div class="col-2">
        					<img src="${root}/resources/image/플레티넘.png" height="200px" width="200px">
        				</div>
        			</c:if>
        			
        			<div class="col-6">
        				<div class="row">
        					<div class="col" style="font-size:30px">
        					${memberDto.memberName}회원님
        					</div>
        				</div>
        				<hr>
        				<div class="row">
        					<div class="col">
        					회원님의 등급은 ${memberDto.memberGrade}입니다
        					</div>
        				</div>
        				
        				<div class="row">
        					<div class="col">
        						회원님의 포인트는 ${memberDto.memberPoint}입니다
        					</div>
        				</div>
        				
        				<div class="row">
        					<div class="col">
        						회원님의 마지막 로그인은 00: 00 : 00 입니다
        					</div>
        				</div>
        			</div>
        		</div>
            </div>
        </div>
    </div>
   
   
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-2 b">

                  <div class="list-group">
                    <a href="mypage" class="list-group-item list-group-item-action active" style="text-align: center;">MY PAGE</a>
                    <a href="edit" class="list-group-item list-group-item-action ">회원정보수정하러가기</a>
                    <a href="quit" class="list-group-item list-group-item-action ">회원탈퇴하기</a>

                    <a href="${root}/board/userWriteList" class="list-group-item list-group-item-action ">내가 작성한 게시글보기</a>


                    <a href="history" class="list-group-item list-group-item-action ">포인트 적립/사용</a>
                    <a href="#" class="list-group-item list-group-item-action ">내가관람한영화</a>
                    <a href="#" class="list-group-item list-group-item-action ">의동님</a>
                    <a href="#" class="list-group-item list-group-item-action ">인태님</a>
                    <a href="#" class="list-group-item list-group-item-action ">건아님</a>
                    <a href="#" class="list-group-item list-group-item-action ">도현님</a>
                    <a href="#" class="list-group-item list-group-item-action ">죄송합니다</a>
                    <a href="#" class="list-group-item list-group-item-action ">멍청이는</a>
                    <a href="#" class="list-group-item list-group-item-action ">뭘해야할지 모르겟습니다.</a>
                    
                  </div>
            </div>
            <div class="col-md-10 b" style="height: 600px">
			
                <div id="page">
					<jsp:include page="/WEB-INF/views/member/edit.jsp">
					    <jsp:param value="${memberDto}" name="memberDto"/>
					</jsp:include>
                </div>
  			여기야잉 !
             </div>
        </div>

    </div>
</body>
 <jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
</html>