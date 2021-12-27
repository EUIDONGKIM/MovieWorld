<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
   <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
    <script>

        $(function(){

            $(".add-btn").click(function(){
                var giveNo = $("input:checked[name=actorNo]").val();
                var giveName = $("input:checked[name=actorNo]").data("name");
                if(!giveNo||!giveName) return;
                opener.document.getElementById('actorNo').value = giveNo;
                opener.document.getElementById('actorName').value = giveName;
                
                window.close();
            });

        });

    </script>


    <label>영화인 선택!</label>

	<c:forEach var="actorDto" items="${actorList}">
	     <div class="row">
       		 <label>
            	<input type="radio" name="actorNo" value="${actorDto.actorNo}" data-name="${actorDto.actorName}" class="actor-item">
                <span>${actorDto.actorName}</span>
            </label>
        </div>
	</c:forEach>

<button type="button" class="add-btn">추가</button>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>