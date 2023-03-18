history.replaceState({},null,location.pathname);
$(document).ready(function(){
   //수정 버튼 클릭 시, 유효성 검사
   $('#modify').on('click',function(e){
      var m_name = $('#m_name').val();
      var m_nickname = $('#m_nickname').val();
      var m_pw = $('#m_pw').val();
      var m_pw2 = $('#m_pw2').val();
      var m_phone = $('#m_phone').val();
      var m_jumin = $('#m_jumin').val();   
      var m_que = $('#m_que').val();   
      var m_ans = $('#m_ans').val();
      var nickCheck = $('#nickCheck').val();
      var double = $('#double').val();
      var check = $('#check').val();
      var pwSameCheck = $('#pwSameCheck').val();
      
      //이름 입력하지 않았을 경우
      if(m_name==null || m_name==''){
         alert("이름을 입력해주세요");
         $('#m_name').focus();
         return false;
      }
      
      //닉네임 입력하지 않았을 경우   
      if(m_nickname==null || m_nickname==''){
         alert("닉네임을 입력해주세요");
         $('#m_nickname').focus();
         return false;
      }
     
      //비밀번호 입력하지 않았을 경우
      if(m_pw==null || m_pw==''){
         alert("비밀번호를 입력해주세요");
         $('#m_pw').focus();
         return false;
      }
      
      //비밀번호 확인 입력하지 않았을 경우
      if(m_pw2==null || m_pw2==''){
         alert("비밀번호 확인을 입력해주세요");
         $('#m_pw2').focus();
         return false;
      }
      
      //휴대전화 입력하지 않았을 경우
      if(m_phone==null || m_phone==''){
         alert("휴대전화를 입력해주세요");
         $('#m_phone').focus();
         return false;
      }
      
      //주민번호 입력하지 않았을 경우
      if(m_jumin==null || m_jumin==''){
         alert("주민등록번호를 입력해주세요");
         $('#m_jumin').focus();
         return false;
      }
      
      if(m_jumin.length < 6){
         alert("주민번호를 전부 입력해주세요");
         $('#m_jumin').focus();
         return false;
      }
      
      //질문 선택하지 않았을 경우
      if(m_que==null || m_que==''){
         alert("질문을 선택해주세요");
         $('#m_que').focus();
         return false;
      }
      
      //답변 입력하지 않았을 경우
      if(m_ans==null || m_ans==''){
         alert("답변을 입력해주세요");
         $('#m_ans').focus();
         return false;
      }
      
      //닉네임 중복 확인이 안된 경우 
      if(nickCheck == 0) {
      alert("닉네임 중복확인을 해주세요.");
      $('#m_nickname').focus();
      return false;
      }
     
      //비밀번호와 비밀번호 확인이 일치하지 않을 경우
      if(pwSameCheck==0){
         alert("비밀번호가 일치하지 않습니다. 다시 확인해주시기 바랍니다.");
         $('#m_pw2').focus();
         return false;
      }
         
      this.form.submit();
      alert("수정이 완료되었습니다.");
      
      
  }); //수정버튼 클릭시 유효성 검사 끝

  
  //닉네임 변화 시, 닉네임 중복검사 버튼 띄우기
  var m_nickname = $('#m_nickname').val(); //원래 닉네임
  $('#m_nickname').on("change keyup paste", function(){ //닉네임 변경 시 감지
    let nickCheck = $('#nickCheck'); //닉네임 체크해서value 바꾸는 것
    var m_changeNick = $(this).val();
    $("#check").attr("type", "button");
    nickCheck.val(0);
    if(m_nickname == m_changeNick){
      nickCheck.val(1);
      $("#check").attr("type", "hidden");
    }
    console.log("원래닉네임: " + m_nickname);
    console.log("바꾼 닉네임: " + m_changeNick);
    console.log(m_nickname == m_changeNick);
  });
  
  $('#check').on('click',function(e){  //아이디 중복검사 클릭시
  var m_changeNick = $('#m_nickname').val();
  if(m_changeNick != null && m_changeNick !='') { //변경한 닉네임값이 있다면
    $.ajax({
      url : "/members/checknickname.sosu",
      type : "post",
      contentType: "application/json",
      data : JSON.stringify({M_NICKNAME : m_changeNick}),
      dataType:'json',
      success : function(result, status, xhr) {
        if (result != 0) {  //중복되었다면
          $("#nickname_check_result").html('중복된 닉네임입니다.');
                  $("#nickname_check_result").css('color', 'red');
                  $('#nickCheck').val(0);
          } else{ //사용할 수 있다면
              $("#nickname_check_result").html('사용할 수 있는 닉네임입니다.');
              $("#nickname_check_result").css('color', 'green');
              $('#nickCheck').val(1);    
          }
      },
      error : function() {alert("서버요청실패");}
    }); 
  }else{
    $("#nickname_check_result").html('닉네임을 입력해 주세요.');
    $("#nickname_check_result").css('color', 'red');
    $('#nickCheck').val(-1);
  }
  }); 

      
   //비밀번호와 비밀번호 입력 체크하여 화면에 출력
   $('#m_pw, #m_pw2').focusout(function(){
         var m_pw = $("#m_pw").val();
         var m_pw2 = $("#m_pw2").val();
         
         if(checkPassword(m_pw) == false) {
            $('#pwCheck').css("color", "red");
            $('#pwCheck').css("font-size", "8px;");
            $('#pwCheck').html("영문(대소문자), 특수기호, 숫자로 구성된<br>4~20자리 비밀번호를 설정해주시기 바랍니다.");
            $('#pwSameCheck').val(0);
            return false;
         }
         $('#pwCheck').css("font-size", "16px;");
         
         if(m_pw == null || m_pw == '') {
            $('#pwCheck').css("color", "red");
            $('#pwCheck').html("비밀번호를 입력해주세요.");
         }else {
            if(m_pw != m_pw2){
               $('#pwCheck').css("color", "red");
               $('#pwCheck').html("비밀번호가 일치하지 않습니다.");
               $('#pwSameCheck').val(0);
            }else if(m_pw == m_pw2){
               $('#pwCheck').css("color", "green");
               $('#pwCheck').html("비밀번호가 일치합니다.")
               $('#pwSameCheck').val(1);
            }
         }
      });
      
         //주민등록번호 입력시 숫자 제외 모두 제거 
      $('#m_jumin').keyup(function(){
         let m_jumin = $('#m_jumin').val();
         $('#m_jumin').val(onlyNumber(m_jumin));
      });
      
         //성별 입력시 숫자 제외 모두 제거 
      $('#m_gender').keyup(function(){
         let m_gender = $('#m_gender').val();
         $('#m_gender').val(onlyGender(m_gender));
      });
      
      //탈퇴 눌렀을 때, 정말 탈퇴하는지 확인작업
      $('#deleteMem').on('click',function(e){
      var result = confirm("정말 탈퇴하시겠습니까? :( ");
      if(result){
        //yes
        alert("탈퇴를 누르셨습니다.");
        location.href='/members/mypagedelete.sosu';
      } else{
        //no
        alert("취소를 누르셨습니다.");
        return false;
      }
  });
      
});

//mypagemodify.jsp 사진 삭제 클릭 시, 기본 이미지 넣기
$(document).ready(function(){
      $('#delete').on('click', function(){
      changeImg();
      var deleteResult = $('#delete_result').val();
      var m_gender = $('#m_gender').val();
      if(m_gender == 1){
         $('#delete_result').val(1);
      }else if(m_gender == 2){
         $('#delete_result').val(2);
      }else if(m_gender == 3){
         $('#delete_result').val(3);
      }else{
         $('#delete_result').val(4);
      }
      var file = document.getElementById("file");
      file.setAttribute("type","hidden");
   });

});



//마이페이지 수정 시, 기본 프로필 이미지로 src 변경 함수
function changeImg(){
   var img1 = document.getElementById("img1");
   var m_gender = document.getElementById("m_gender").value;
   if(m_gender == '1' || m_gender == '3'){
      img1.src="/resources/img/profile/base_m.png";
   }else{
      img1.src="/resources/img/profile/base_w.png";
   }
}



//비밀번호 유효성검사 4~20자 입력, 숫자, 영문, 특수기호만 입력 가능
function checkPassword(pw) {
   var regexPw = /^[A-Za-z0-9`~!@#\$%\^&\*\(\)\{\}\[\]\-_=\+\\|;:'"<>,\./\?]{4,20}$/;
   if(!regexPw.test(pw)) {
      return false;
   }
     return true;
}

//숫자만 입력 가능하도록 만들기 (0부터 9까지)
function onlyNumber(data){
   data = data.replace(/[^0-9]/g, '');
   return data;
}
