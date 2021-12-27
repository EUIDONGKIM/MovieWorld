<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
    <script>

        $(function(){

            actorList();

            $(".add-btn").click(function(){
                var giveNo = $("input[name=actorNo]").val();
                var giveName = $("input[name=actorNo]").data("name");
                if(!giveNo||!giveName) return;
                opener.document.getElementById('actorNo').value = giveNo;
                opener.document.getElementById('actorName').value = giveName;
                window.close();
            });

            
        function actorList(){
            $.ajax({
			url:"${pageContext.request.contextPath}/data/actorList",
			type:"post",
            dataType : "json",    
			success:function(resp){
				console.log("성공", resp);
                for(var i = 0 ; i<resp.length ; i++){
                    var template = $("#actor-list-template").html();
                    template = template.replace("{{actorNo}}",resp[i].actorNo);
                    template = template.replace("{{actorName}}",resp[i].actorName);
                    template = template.replace("{{actorName}}",resp[i].actorName);

                    $("#actor-result").append(template);
                }
			},
			error:function(e){
				console.log("실패", e);
			}
		    });
        };
            
        });

    </script>



<template id="actor-list-template">
        <div class="row">
        <label>
            <input type="radio" name="actorNo" value="{{actorNo}}" data-name="{{actorName}}">
                <span>{{actorName}}</span>
            </label>
        </div>    
    </template>

    <label>actor 값 전달..</label>

    <div id="actor-result"></div>

<button type="button" class="add-btn">추가</button>

