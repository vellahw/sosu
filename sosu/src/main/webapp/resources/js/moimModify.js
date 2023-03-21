history.replaceState({}, null, location.pathname);

$(function() {
    var mF = $("#mImg").val();
    var mFF = $("#mfsv").val();

    if(mF == 'N' || mFF == 0) {
      $('#main').css('display', 'block');
    }

    $("#input1").change(function(){
       if($("#input1").is(":checked")){
           $('#main').css('display', 'block');               
       }else{
           $('#main').css('display', 'none');
       }
    });
    
    /*================= 지도 띄우기 =================*/
    var wii = $('#WII').val(); //위도
    var kyung = $('#KYUNG').val(); //경도
    var addr = $("#ADDRESS").val(); //주소
    var deaddr = $("#DEADDRESS").val(); //상세주소
    
    if(wii == '' || wii == undefined || wii == null) {
    	//var mapDiv = $('#map').detach();
    }
    
    if(wii != null){
        var container = document.getElementById('map');
        var options = { //지도를 생성할 때 필요한 기본 옵션
            center: new kakao.maps.LatLng(wii, kyung),
            level: 3 //지도의 레벨(확대, 축소 정도)
        };

        var map = new kakao.maps.Map(container, options); 

        var markerPosition  = new kakao.maps.LatLng(wii, kyung); 

        var marker = new kakao.maps.Marker({
            position: markerPosition
        });
        
        marker.setMap(map);
        
        /*====== undefined 공백으로 바꿔주기====== */
        function defaultCheckString (checkStr, defaultStr){
            if(checkStr == undefined || checkStr == null){
                return defaultStr;
            }
        return checkStr;
        }

        var infowindow = new kakao.maps.InfoWindow({
        content: '<div style="width:150px;text-align:center;padding:6px 0;">'+addr+'<br>'+defaultCheckString(deaddr, '')+'</div>'
        });
        infowindow.open(map, marker);
    }
});

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
           } else {}
           
           // 우편번호와 주소 정보를 해당 필드에 넣음
           document.getElementById("ADDRESS").value = addr;
           //상세주소 입력 폼으로 포커스 이동
           document.getElementById("DEADDRESS").focus();

		   // 주소 검색 후 좌표 이동 + 마커 표시
           geocoder.addressSearch(addr, function(result, status) {
           
             // 정상적으로 검색이 완료됐으면 
             if (status === kakao.maps.services.Status.OK) {
             
              //위도, 경도 저장
              var letlng = new kakao.maps.LatLng(result[0].y, result[0].x);
			  var wii = result[0].y; //위도
			  var kyung = result[0].x; //경도
			  
			  //hidden input value 바꿔주기
			  $("input[name=WII]").val(wii); 
			  $("input[name=KYUNG]").val(kyung);
			  $("#DEADDRESS").val(''); //상세주소 공란 처리
			  
   		      // 지도 중심을 부드럽게 이동 시킴
			  function panTo() {
			    var moveLatLon = new kakao.maps.LatLng(wii, kyung);
			    map.panTo(moveLatLon);            
			  }        
				
			  //지도 새로 생성하기
			  var container = document.getElementById('map'); 
			  var options = {
			     center: new kakao.maps.LatLng(wii, kyung), 
			     level: 3 
			  };
			
              var map = new kakao.maps.Map(container, options); 

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

//세부지역 선택 유지를 위한 ===========================
var jung = ["광화문", "종로", "인사동", "동대문", "서울역", "이태원", "을지로"];
var dong = ["잠실/송파", "왕십리", "건대", "청량리", "올림픽공원", "천호", "하남"];
var seo = ["홍대/신촌", "연신내", "마포", "영등포/여의도", "구로", "고양"];
var nam = ["강남/역삼/삼성", "신사", "청담", "서초/교대", "성남"];
var book = ["강북", "노원/중계", "중랑", "의정부"];
var target = document.getElementById("selectRDetail");
        
var rr = $("#selectRegion").val();
        
if(rr == "중부") {
   var d = jung;
            
    target.options.length = 0;
            
    for (x in d) {
      var opt = document.createElement("option");
        opt.value = d[x];
        opt.innerHTML = d[x];
        target.appendChild(opt);
   }
} else if (rr == "동부") {
   var d = dong;
            
   target.options.length = 0;
            
    for (x in d) {
      var opt = document.createElement("option");
        opt.value = d[x];
        opt.innerHTML = d[x];
        target.appendChild(opt);
   }
} else if(rr == "서부") {
   var d = seo;
            
    target.options.length = 0;
            
    for (x in d) {
       var opt = document.createElement("option");
        opt.value = d[x];
        opt.innerHTML = d[x];
        target.appendChild(opt);
       }
    }

if(rr == '남부') {
   var d = nam;
            
    target.options.length = 0;
            
    for (x in d) {
       var opt = document.createElement("option");
        opt.value = d[x];
        opt.innerHTML = d[x];
      target.appendChild(opt);
    }
}
        
if(rr == '북부') {
   var d = book;
           
    target.options.length = 0;
            
    for (x in d) {
       var opt = document.createElement("option");
        opt.value = d[x];
        opt.innerHTML = d[x];
        target.appendChild(opt);
   }
}
            
/*========== 참가 연령 제한 없음 버튼 클릭 이벤트 ========*/
var hiddenA = $('#MO_MAXAGE1').val(); //제한 없음일 때 mo_maxage value
var age = $('#MO_MAXAGE3').val(); //제한 없음일 때 mo_maxage value = 200
               
//-----------연령이 있을 때-------------
if(age != '200') {
$('#ageNoLimit').css('display', 'block'); 

/* 되돌리기 버튼 */
$('#cancel').click(function() {
    $('#cancel').css('display', 'none');
    $("#agetd").append(addmin);
    $("#ll2").css('display', 'none');
    $("#MO_MINAGE2").remove();
    $("#MO_MAXAGE2").remove();
    $('#ageNoLimit').css('display', 'block');
});

//---------연령이 '제한없음'일 때---------
 var m3 = '<input type="number" class="form-control" name="MO_MINAGE" id="MO_MINAGE3" maxlength="2" oninput="maxLengthCheck(this)">' +
          '<span id="wave"> ~ </span>' +
          '<input type="number" class="form-control" name="MO_MAXAGE" id="MO_MAXAGE3" maxlength="2" oninput="maxLengthCheck(this)">';
var hainput = "<input type='hidden' name='MO_MINAGE' id='MO_MINAGE2' value='0'>"
                    + "<input type='hidden' name='MO_MAXAGE' id='MO_MAXAGE2' value='200'>";

 if(hiddenA == '200') {
   $("#ageLimit").css('display', 'block');
   $("#ageNoLimit").css('display', 'none');
   
   $('#ageLimit').click(function() { //수정하기 버튼 클릭시
      $('#ageLimit').css('display', 'none');
      $('#ageNoLimit2').css('display', 'block');
      $('#ll').css('display', 'none');
      $('#MO_MINAGE1').remove();
      $('#MO_MAXAGE1').remove();
      $('#agetd').append(m3);
   });
}   
   /* 제한없음 버튼2 클릭시 */
   $('#ageNoLimit2').click(function() {
      $('#ageNoLimit2').css('display', 'none');
      $('#ll').css('display', 'block');
      $('#ll2').css('display', 'none');
      $('#MO_MINAGE3').remove();
      $('#MO_MAXAGE3').remove();
      $('#wave').remove();
      $('#cancel2').css('display', 'block');
      $('#agetd').append(hainput);
      
   }); 

    /* 되돌리기 버튼 */
   $('#cancel2').click(function() {
       $('#cancel2').css('display', 'none');
      $('#ll').css('display', 'none');
      $('#ll2').css('display', 'none');
       $("#MO_MINAGE2").remove();
       $("#MO_MAXAGE2").remove();
       $('#agetd').append(m3);
       $('#ageNoLimit').css('display', 'block');
   }); 
    
    $('#ageNoLimit').click(function() { //제한 없음 버튼
       $('#MO_MINAGE3').remove();
       $('#MO_MAXAGE3').remove();
       $('#wave').remove();
       $('#ageNoLimit').css('display', 'none');
       $('#agetd').append(hainput);
       $('#ll').css('display', 'block');        
       $('#ll2').css('display', 'block');        
       $('#cancel2').css('display', 'block');         
    });
}
    

/*============== 참가 인원 버튼 클릭 이벤트 ===============*/
var maxp = $("#MO_MAXPEOPLE").val(); //인원제한 있음
var maxp2 = $("#MO_MAXPEOPLE2").val(); //(maxpeople=0)
var str = "<input type='number' class='form-control' name='MO_MAXPEOPLE' id='MO_MAXPEOPLE'>";
var hmaxp = '<input type="hidden" name="MO_MAXPEOPLE" id="MO_MAXPEOPLE2" value="0">';
var pCancel = document.getElementById('pCancel');
var pCancel2 = document.getElementById('pCancel2');
var l3 = document.getElementById('l3');
 
//---------------참가 인원이 있다면-------------------
 if(maxp != '0') { 
   $('#peopleNoLimit').click(function() { //제한 없음 버튼 누르면
      $('#peopleNoLimit').css('display', 'none'); //제한 없음 버튼 없앰
      $("#MO_MAXPEOPLE").remove();
       
        //되돌리기 버튼 띄움
        if(pCancel.style.display == 'none') {
            pCancel.style.display = 'block'; 
        }
        
        //제한없음 텍스트 띄움
        if(l3.style.display == 'none') {
            l3.style.display = 'block'; 
        }
        
        $("#padd").append(hmaxp); //input hidden
   });
 }

//되돌리기 버튼
$(pCancel).click(function() { 
      $('#l3').css('display', 'none');
       $('#pCancel').css('display', 'none'); //되돌리기 버튼 없앰
      $('#MO_MAXPEOPLE2').remove(); //히든 인풋 
       $('#peopleNoLimit').css('display', 'block'); //제한없음 버튼 띄움
       $('#padd').append(str);
    }); 

//되돌리기 버튼2    
$(pCancel2).click(function() { 
   $('#l2').css('display', 'block');  
   $('#MO_MAXPEOPLE').remove();
   $("#padd").append(hmaxp);
   $('#pCancel2').css('display', 'none');
   $('#pepolemodi').css('display', 'block');
});

//---------------참가 인원이 '제한 없음'이라면----------------
if(maxp2 == '0') { 
   $("#pepolemodi").css('display', 'block'); //수정하기 버튼 띄움
   
    //수정하기 버튼 누르면
    $('#pepolemodi').click(function() {
        if(pCancel2.style.display == 'none') {
            pCancel2.style.display = 'block'; //되돌리기 버튼 띄움
        }
        $('#pepolemodi').css('display', 'none'); //수정하기 버튼 없앰
        $('#l2').css('display', 'none');  
        $("#padd").append(str);
        $("#MO_MAXPEOPLE2").remove();
    });
}

/*================ 파일 추가 버튼 ================*/      
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
    
/*======== 오늘 날짜 이전 날짜는 선택 불가 기능  ========*/
var now_utc = Date.now() // 지금 날짜를 밀리초로
//getTimezoneOffset()은 현재 시간과의 차이를 분 단위로 반환
var timeOff = new Date().getTimezoneOffset()*60000; // 분단위를 밀리초로 변환
//new Date(now_utc-timeOff).toISOString()은 '2022-05-11T18:09:38.134Z'를 반환
var today = new Date(now_utc-timeOff).toISOString().split("T")[0];
document.getElementById("date").setAttribute("min", today);
       
/*============ 세부 지역 선택을 위한 스크립트 ==========*/
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

function maxLengthCheck(object){
    if (object.value.length > object.maxLength){
        object.value = object.value.slice(0, object.maxLength);
    }    
}

    /* 입력된 바이트(글자수) 값 제어 */
    function fn_checkByte(obj) {
        const maxByte = 1400; //최대 100바이트
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
            alert('최대 1500Byte까지만 입력가능합니다.');
            document.getElementById("nowByte").innerText = totalByte;
            document.getElementById("nowByte").style.color = "red";
        } else {
            document.getElementById("nowByte").innerText = totalByte;
            document.getElementById("nowByte").style.color = "green";
        }
    }
    
/* ========== 폼 서브밋 전 alert 유효성 검사 =========*/
    function check() {
         
        if (document.moimR.MO_TITLE.value.trim() == "") {
           alert("제목를 입력해 주세요.");
           document.moimR.MO_TITLE.focus();
           return false;
           
        } else if (document.moimR.MO_DETAILCATEGORY.value.trim() == "") {
           alert("세부 카테고리를 입력해 주세요.");
           document.moimR.MO_DETAILCATEGORY.focus();
           return false;
           
        } else if ($("input[name=MO_MAXAGE]").val() < $("input[name=MO_MINAGE]").val()) {
            alert("참가 최소 연령이 최대 연령보다 큽니다.");
           // $('#age_check_result').css("color", "red");
          //  $('#age_check_result').html("*참가 최소 연령이 최대 연령보다 큽니다.");
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
         var mo_cate = $(".mo_cate option:selected").val();
       	 var m = $("#MO_IDX").val();
      
       var fnameList = [];        
         
       $("input[name=item0]:checked").each(function(i) {
          fnameList.push($(this).val());
       });
         
       $("input[name=item1]:checked").each(function(i) {
          fnameList.push($(this).val());
       });
          
       $.ajax({
          url : "/moim/moimModify.pro",
          type : "post",
          data : { MO_CATEGORY : mo_cate, MO_IDX : m},
          success : function(result){
          }
       }); 
      
       $.ajax({
          url : "/moim/moimImgDel.pro", 
         type : "get",
         data : { chbox : fnameList },
         dataType : 'json',
         success : function(result) {
         }
      });
   
       alert("수정 되었습니다.");
        return true;
        }
   }    