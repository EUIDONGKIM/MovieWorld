<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>
$(function(){
	
	var scheduleList = "${scheduleList.size()}";
	if(scheduleList > 0){
		$("input[name=theaterName]").attr("disabled",true);
		$("input[name=theaterAddress]").attr("disabled",true);
		$("input[name=theaterDetailAddress]").attr("disabled",true);
		$("input[name=theaterSido]").attr("disabled",true);
		$(".find-address-btn").attr("disabled",true);
		
		$(".delete-btn").attr("disabled",true);
	}
	
	
	
    $("button[type=submit]").on("click",function(e){
		e.preventDefault();

    	var operation = $(this).data("oper");
    	
    	if(operation == "delete"){
    		$("form").attr("action","${root}/theater/admin/delete");
    	}
    	else if(operation == "cancel"){
    		self.location = "${root}/theater/detail?theaterNo=${theaterDto.theaterNo}";
    		return;
    	}
    	$("form").submit();

    	
    	
    });
	
    $(".find-address-btn").click(function(e){
        findAddress();
    });

    function findAddress(){
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ""; // 주소 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                document.querySelector("input[name=theaterAddress]").value = addr;
                //$("input[name=address]").val(addr);
                
                //시도
                document.querySelector("input[name=theaterSido]").value = data.sido.substring(0,2);

                //원래 써있던 값지우기
                document.querySelector("input[name=theaterDetailAddress]").value = null;
                // 커서를 상세주소 필드로 이동한다.
                document.querySelector("input[name=theaterDetailAddress]").focus();
                //$("input[name=detailAddress]").focus();

            }
        }).open();
    };
});
</script>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container-600 mx-auto">
<h1>${theaterDto.theaterName}점 정보 수정</h1>

<form action="${root}/theater/admin/edit" method="post">

	<input type="hidden" name="theaterNo" value="${theaterDto.theaterNo }">
	<div class="row">
	    <div class="col">
	      	<label class="form-label">극장명</label>
	      	<input type="text" class="form-control" value="${theaterDto.theaterName}" name="theaterName" required>
	    </div>
    </div>
	
	<div class="row">
		<label class="form-label">주소</label>
		<div class="col">
			<input type="text" class="form-control" value="${theaterDto.theaterAddress}" name="theaterAddress" required>
		</div>
		<div class="col-auto">
			<button type="button" class="btn btn-primary find-address-btn">주소찾기</button>
		</div>
	</div>
	
	<input type="hidden" value="${theaterDto.theaterSido}" name="theaterSido" required>
	
	<div class="row">
		<div class="col">
			<label class="form-label">상세주소</label>
			<input type="text" class="form-control" value="${theaterDto.theaterDetailAddress}" name="theaterDetailAddress" required>
		</div>
	</div>
	
   	<div class="row">
   		<div class="col">
      		<label class="form-label">설명</label>
      		<textarea class="form-control" name="theaterInfo" rows="10" required>${theaterDto.theaterInfo }</textarea>
   		</div>
    </div>	
	<button type="submit" class="btn btn-primary" data-oper="edit">수정</button>
	<button type="submit" class="delete-btn btn btn-outline-primary" data-oper="delete" class="delete-btn">폐점</button>
	<button type="submit" class="btn btn-outline-primary" data-oper="cancel">취소</button>
</form>

<c:if test="${scheduleList.size() > 0}">
<div class="row">
	현재 상영중인 영화가 있으면 폐점이 불가능합니다.
</div>
</c:if>
</div> 



<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>