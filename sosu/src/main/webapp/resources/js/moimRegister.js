/* 제한 없음 버튼 제어 */
/* 참가 연령 */
const ageNoLimitBtn = document.getElementById('ageNoLimitBtn');
const ageLimitCancelBtn = document.getElementById('ageLimitCancelBtn');
let age_td = document.querySelector('#age-td');

/* 제한없음 버튼 클릭 이벤트 */
ageNoLimitBtn.addEventListener('click', function () {
   document.getElementById('MO_MINAGE').remove();
   document.getElementById('MO_MAXAGE').remove();
   document.querySelector('#wave').remove();

   ageNoLimitBtn.style.display = 'none';
   ageLimitCancelBtn.style.display = 'block';

   //input 태그 만드는 함수
   function createInputElement(type, name, id, value) {
      let inputElement = document.createElement('input');
      inputElement.type = type;
      inputElement.name = name;
      inputElement.id = id;
      inputElement.value = value;
      return inputElement;
   }

   let hiddenMinAgeInput = createInputElement('hidden', 'MO_MINAGE', 'MO_MINAGE2', '0');
   let hiddenMaxAgeInput = createInputElement('hidden', 'MO_MAXAGE', 'MO_MAXAGE2', '200');

   let noLimitDiv = document.createElement('div');
   noLimitDiv.id = 'noLimitText';

   let noLimitText = document.createTextNode('제한없음');
   noLimitDiv.appendChild(noLimitText);

   age_td.appendChild(hiddenMinAgeInput);
   age_td.appendChild(hiddenMaxAgeInput);
   age_td.appendChild(noLimitDiv);
});

/* 되돌리기 버튼 클릭 이벤트 */
ageLimitCancelBtn.addEventListener('click', function() {
   document.getElementById('MO_MINAGE2').remove();
   document.getElementById('MO_MAXAGE2').remove();
   
   ageNoLimitBtn.style.display = 'block';      
   ageLimitCancelBtn.style.display = 'none';      
   
   age_td.innerHTML = '<input type="number" class="form-control" name="MO_MINAGE" id="MO_MINAGE" maxlength="2" oninput="maxLengthCheck(this)"'
                    + 'placeholder="최소 (숫자만 입력해주세요.)" style="margin-right:12px">'
                    + '<span id="wave" style = "font-weight:bold">~</span>'
                    + '<input type="number" class="form-control" name="MO_MAXAGE" id="MO_MAXAGE" maxlength="2" oninput="maxLengthCheck(this)"'
                    + 'placeholder="최대 (숫자만 입력해주세요.)" style="margin-left:12px">';

});

/* 참가 인원 */
$('#peopleNoLimit').click(function() {
   $("#MO_MAXPEOPLE").val('0');
});
 
/* 파일 추가 버튼 + 제한 없음 버튼 구동 */
var gfv_count = 1;       

$("#addFile").on("click", function(e) { //파일 추가 버튼
   e.preventDefault();
   fn_addFile();
});
 
$("a[name='delete']").on("click", function(e) { //삭제 버튼
   e.preventDefault();
         fn_deleteFile($(this));
      });
 
      function fn_addFile() {
           var str = "<p><input type='file' id='file' name='file_"
              + (gfv_count++)
              + "' style='border:none;width: auto;padding-left: 79px;'><a href='#this' class='btn' name='delete' id='delete'>삭제</a></p>";
    
       $("#fileDiv").append(str);
         
       $("a[name='delete']").on("click", function(e) { //삭제 버튼
            e.preventDefault();
            fn_deleteFile($(this));
         });
     }
 
      function fn_deleteFile(obj) {
        obj.parent().remove();
      }
      
   function maxLengthCheck(object){
    if (object.value.length > object.maxLength){
        object.value = object.value.slice(0, object.maxLength);
    }    
}
      
 
 /* 오늘 날짜 이전 날짜는 선택 불가  */
 var now_utc = Date.now() // 지금 날짜를 밀리초로
 //getTimezoneOffset()은 현재 시간과의 차이를 분 단위로 반환
 var timeOff = new Date().getTimezoneOffset()*60000; // 분단위를 밀리초로 변환
 //new Date(now_utc-timeOff).toISOString()은 '2022-05-11T18:09:38.134Z'를 반환
 var today = new Date(now_utc-timeOff).toISOString().split("T")[0];
 document.getElementById("date").setAttribute("min", today);
    
 /* 지역 선택을 위한 스크립트 */
 function addressKindChange(e) {
     var jung = ["종로", "인사동", "동대문", "서울역", "이태원", "을지로"];
     var dong = ["잠실/송파", "왕십리", "건대", "청량리", "올림픽공원", "천호", "하남"];
     var seo = ["홍대/신촌", "연신내", "마포", "영등포/여의도", "구로", "고양"];
     var nam = ["강남/역삼/삼성", "신사", "청담", "서초/교대", "성남"];
     var book = ["강북", "노원/중계", "중랑", "의정부"];
     var target = document.getElementById("selectRDetail");
 
     if(e.value == "중부") var d = jung;
     else if(e.value == "동부") var d = dong;
     else if(e.value == "서부") var d = seo;
     else if(e.value == "남부") var d = nam;
     else if(e.value == "북부") var d = book;
 
     target.options.length = 0;
 
     for (x in d) {
         var opt = document.createElement("option");
         opt.value = d[x];
         opt.innerHTML = d[x];
         target.appendChild(opt);
     }   
 }
 
    /* 입력된 바이트(글자수) 값 제어 */
    function fn_checkByte(obj) {
       const maxByte = 1800; //최대 100바이트
       const text_val = obj.value; //입력한 문자
       const text_len = text_val.length; //입력한 문자수
 
       let totalByte = 0;
       for (let i = 0; i < text_len; i++) {
          const each_char = text_val.charAt(i);
          const uni_char = escape(each_char); //유니코드 형식으로 변환
          if (uni_char.length > 4) {
             // 한글 : 2Byte
             totalByte += 3;
          } else {
             // 영문,숫자,특수문자 : 1Byte
             totalByte += 1;
          }
       }
 
       if (totalByte > maxByte) {
          alert('최대 1800Byte까지만 입력가능합니다.');
          document.getElementById("nowByte").innerText = totalByte;
          document.getElementById("nowByte").style.color = "red";
       } else {
          document.getElementById("nowByte").innerText = totalByte;
          document.getElementById("nowByte").style.color = "green";
       }
    }

/* 지도 띄우기 */
var container = document.getElementById('map');
var options = { //지도를 생성할 때 필요한 기본 옵션
	 center: new kakao.maps.LatLng(33.450701, 126.570667), //지도의 기본 중심좌표
	level: 3 //지도의 레벨(확대, 축소 정도)
};

var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴 	

/* 다음 주소검색 및 마커 표시 */
var geocoder = new kakao.maps.services.Geocoder();

/* 주소 검색 onclick */
function kaMap() {
   var width = 500; //팝업의 너비
   var height = 600; //팝업의 높이
   new daum.Postcode({
       width: width, 
       height: height,
   
       oncomplete: function(data) {
           var addr = ''; // 주소 변수
           var extraAddr = ''; // 참고항목 변수
           //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
           if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
               addr = data.roadAddress;
           } else { // 사용자가 지번 주소를 선택했을 경우(J)
               addr = data.jibunAddress;
           }
           // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
           if(data.userSelectedType === 'R'){
               // 법정동명이 있을 경우 추가한다. (법정리는 제외)
               // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
               if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                   extraAddr += data.bname;
               }
               // 건물명이 있고, 공동주택일 경우 추가한다.
               if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
               }
               // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
               if(extraAddr !== ''){
                   extraAddr = ' (' + extraAddr + ')';
               }
               // 조합된 참고항목을 해당 필드에 넣음
           
           } else { }
           
           // 우편번호와 주소 정보를 해당 필드에 넣음
           document.getElementById("MO_MAP").value = addr;
           //상세주소 입력 폼으로 포커스 이동
           document.getElementById("detailAddress").focus();

		   // 주소 검색 후 지도에 마커 표시하기
           geocoder.addressSearch(addr, function(result, status) {
           
             // 정상적으로 검색이 완료됐으면 
             if (status === kakao.maps.services.Status.OK) {
             
              //위도, 경도 저장
              var letlng = new kakao.maps.LatLng(result[0].y, result[0].x);
			  var wii = result[0].y; //위도
			  var kyung = result[0].x; //경도
			  
			  document.getElementById('detailAddress').style.display = 'block';
			  document.getElementById('map').style.display = 'block';
				
			  //hidden input value 바꿔주기
	          var hidden_latitude = document.querySelector('input[name="WII"]'); 
	          hidden_latitude.value = wii;
	
	          var hidden_longitude = document.querySelector('input[name="KYUNG"]');
	          hidden_longitude.value = kyung;
				
              // 결과값으로 받은 위치를 마커로 표시
              var marker = new kakao.maps.Marker({
                  map: map,
                  position: letlng
              });
         
              // 인포윈도우로 장소에 대한 설명을 표시
              var infowindow = new kakao.maps.InfoWindow({
                  content: '<div style="width:150px;text-align:center;padding:6px 0;">'+addr+'</div>'
              });
              infowindow.open(map, marker);
         
              // 지도의 중심을 결과값으로 받은 위치로 이동
              map.setCenter(letlng);
            } 
         }); 
       }
   }).open({
    //팝업 가운데 정렬
    left: (window.screen.width / 2) - (width / 2),
    top: (window.screen.height / 2) - (height / 2),
    //팝업창 타이틀 지정
    popupTitle: '모임 장소 검색하기'
   });
}

/* 유효성 검사 + 등록 완료 */
function check() {
   if (document.moimR.MO_TITLE.value.trim() == "") {
      alert("제목를 입력해 주세요.");
      document.moimR.MO_TITLE.focus();
      return false;
      
   } else if (document.moimR.MO_DETAILCATEGORY.value.trim() == "") {
      alert("세부 카테고리를 입력해 주세요.");
      document.moimR.MO_DETAILCATEGORY.focus();
      return false;
      
   } else if ($("#selectRegion option:selected").text() == '지역을 선택해주세요.') {
      alert("지역을 선택해 주세요.");
      document.moimR.selectRegion.focus();
      return false;

   } else if ($("input[name=MO_PERMIT]:radio:checked").length < 1) {
      alert("승인 허가 여부를 선택해 주세요.");
      document.getElementById("MO_PERMIT").focus();
      return false;
      
   } else if ($("input[name=MO_GENDER]:radio:checked").length < 1) {
      alert("참가 성별을 선택해 주세요.");
      document.getElementById("MO_GENDER").focus();
      return false;
      
   } else if ($("input[name=MO_MAXAGE]").val() == "") {
      alert("참가 연령을 입력해 주세요.");
      $("#MO_MAXAGE").focus();
      return false; 

   } else if ($("input[name=MO_MAXAGE]").val() < $("input[name=MO_MINAGE]").val()) {
      alert("참가 최소 연령이 최대 연령보다 큽니다.");
      $("#MO_MAXAGE").focus();
      return false; 
      
    } else if ($("input[name=MO_MINAGE]").val() == "") {
      alert("참가 연령을 입력해 주세요.");
      $("#MO_MINAGE").focus();
      return false; 
      
   } else if ($("input[name=MO_MAXPEOPLE]").val() == "") {
      alert("참가 인원을 입력해 주세요.");
      $("#MO_MAXPEOPLE").focus();
      return false; 
      
   } else if ($("input[name=MO_DEADLINE]").val() == "") {
      alert("모임 날짜를 선택해 주세요.");
      $("#MO_MAXPEOPLE").focus();
      return false; 
      
   } else if ($("input[name=MO_DEADTIME]").val() == "") {
      alert("모임 시간을 선택해 주세요.");
      $("#MO_MAXPEOPLE").focus();
      return false; 
      
   } else if (document.moimR.MO_DETAIL.value.trim() == "") {
      alert("내용을 입력해 주세요.");
      document.moimR.MO_DETAIL.focus();
      return false;
      
   } else {
   
   //카테고리 값 넘기기
    var mo_cate = $(".mo_cate option:selected").val();
 
    $.ajax({
       url : "moim/moimRegister.pro",
       type : "post",
       data : { MO_CATEGORY : mo_cate },
       success : function(data){
          }
       }); 
   
      alert("게시글이 등록되었습니다.")
      return true;
   }
}