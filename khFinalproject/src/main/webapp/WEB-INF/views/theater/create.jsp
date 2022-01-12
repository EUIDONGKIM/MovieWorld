<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>
$(function(){
	
	// Fetch all the forms we want to apply custom Bootstrap validation styles to
	var forms = document.querySelectorAll('.needs-validation')
	
	// Loop over them and prevent submission
	Array.prototype.slice.call(forms).forEach(function (form) {
	    form.addEventListener('submit', function (event) {
	      if (!form.checkValidity()) {
	        event.preventDefault()
	        event.stopPropagation()
	      }
	
	      form.classList.add('was-validated')
	    }, false)
    })
	
	
	
	
	
    $(".find-address-btn").click(function(){
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

<div class="container-600 container-center"> 

<h1>극장 생성</h1>

<form method="post" class="needs-validation" novalidate>

    <div class="row">
	    <div class="col">
	      	<label class="form-label">극장명</label>
	      	<input type="text" class="form-control" name="theaterName" required>
          	<div class="invalid-feedback">
        		극장명을 입력해 주세요!
			</div>
	    </div>
    </div>

	<div class="row">
		<label class="form-label">주소</label>
		<div class="col">
			<input type="text" class="form-control" name="theaterAddress" required>
          	<div class="invalid-feedback">
        		주소를 입력해 주세요!
			</div>
		</div>
		<div class="col-auto">
			<button type="button" class="btn btn-primary find-address-btn">주소찾기</button>
		</div>
	</div>
	
	<input type="hidden" name="theaterSido" required>
	
	<div class="row">
		<div class="col">
			<label class="form-label">상세주소</label>
			<input type="text" class="form-control" name="theaterDetailAddress" required>
          	<div class="invalid-feedback">
        		상세주소를 입력해 주세요!
			</div>
		</div>
	</div>	
	
   	<div class="row">
   		<div class="col">
      		<label class="form-label">설명</label>
      		<textarea class="form-control" name="theaterInfo" rows="10" required></textarea>
          	<div class="invalid-feedback">
        		설명을 입력해 주세요!
			</div>
   		</div>
    </div>
	
	<input type="submit" class="btn btn-primary" value="생성">

</form>

</div>



<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
