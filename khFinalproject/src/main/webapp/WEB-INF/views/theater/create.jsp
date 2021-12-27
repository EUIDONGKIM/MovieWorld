<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>
$(function(){
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
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<h1>극장 생성</h1>

<form method="post">
	극장명 : <input type="text" name="theaterName" required>
	<br>
	
	<!-- 다음 주소 api사용 -->
	주소 : <input type="text" name="theaterAddress" required><button type="button" class="find-address-btn">주소찾기</button>
	<br>
	상세주소 : <input type="text" name="theaterDetailAddress">
	<!-- 여기도 api쓰면 자동으로 들어감 나중에 hidden으로 바꿔주기 -->	
	시도 : <input type="hidden" name="theaterSido" required>
	<br>
	
	<!-- textarea로 바꿔주기 -->
	
	설명 : <textarea name="theaterInfo"></textarea> 
	<br>
	<input type="submit" value="생성">

</form>




<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
