<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


   <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
    <script>

        $(function(){
        	var movieNo = ${movieNo};
			var checking = '${actorJob}';
            $(".add-btn").click(function(){
            	var check = $("input[name=actorNo]").val();
            	if(!check){
                	alert("값을 선택하세요!");
                	return;
                }
            	
            	$("input[name=actorNo]").each(function(){
            		if($(this).prop("checked")){
            			var check = $(this).val();
            			addRole(movieNo,check);
        				alert("값이 들어갔습니다!"); 
            		}
            	
            	});

                opener.document.location.reload();

        		self.close();
                //window.close();
            });
			
            function addRole(movieNo,actorNo){
                $.ajax({
    			url:"${pageContext.request.contextPath}/data/addRole",
    			type:"post",
                data : {
    				movieNo:movieNo,
                    actorNo:actorNo
    			},
    			success:function(resp){
    				console.log("성공", resp);
    			},
    			error:function(e){
    				console.log("실패", e);
    			}
    		    });
            };
            
        });

    </script>


    <label>영화인 선택!</label>

	<c:forEach var="actorDto" items="${actorList}">
	     <div class="row">
       		 <label>
            	<input type="radio" name="actorNo" value="${actorDto.actorNo}">
                <span>${actorDto.actorName}</span>
            </label>
        </div>
	</c:forEach>

<button type="button" class="add-btn">추가</button>
