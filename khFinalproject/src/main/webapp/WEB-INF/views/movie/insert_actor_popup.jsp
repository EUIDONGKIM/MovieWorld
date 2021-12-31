<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


   <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
    <script>

        $(function(){
			var checking = '${actorJob}';
            $(".add-btn").click(function(){
                var giveNo = $("input:checked[name=actorNo]").val();
                var giveName = $("input:checked[name=actorNo]").data("name");
                if(!giveNo||!giveName) return;
                if(checking=='director'){	
                opener.document.getElementById('directorNo').value = giveNo;
                opener.document.getElementById('director').value = giveName;
                }
                if(checking=='actor'){	
                opener.document.getElementById('actorNo').value = giveNo;
                opener.document.getElementById('actor').value = giveName;
                }
                if(checking=='staff'){	
                 opener.document.getElementById('staffNo').value = giveNo;
                 opener.document.getElementById('staff').value = giveName;
                 }
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
