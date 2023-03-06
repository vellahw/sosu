$(document).ready(function(){

   //회원가입 버튼 클릭 시, 유효성 검사
   $('#join').on('click',function(e){
      var m_name = $('#m_name').val();
      var m_nickname = $('#m_nickname').val();
      var m_email = $('#m_email').val();
      var m_pw = $('#m_pw').val();
      var m_pw2 = $('#m_pw2').val();
      var m_phone = $('#m_phone').val();
      var m_jumin = $('#m_jumin').val();   
      var m_gender = $('#m_gender').val();   
      var m_que = $('#m_que').val();   
      var m_ans = $('#m_ans').val();
      var doubleCheck = $('#doubleCheck').val();
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
      
      //이메일 입력하지 않았을 경우
      if(m_email==null || m_email==''){
         alert("이메일을 입력해주세요");
         $('#m_email').focus();
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
      
      //성별 입력하지 않았을 경우
      if(m_gender==null || m_gender==''){
         alert("성별을 입력해주세요");
         $('#m_gender').focus();
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
      
      //아이디 중복 확인이 안된 경우 
      if(doubleCheck == 0) {
      alert("아이디 중복확인을 해주세요.");
      $('#m_email').focus();
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
      alert("회원가입에 성공하셨습니다.");
   });
   
   
   //아이디 중복검사 ajax
      $('#double').on('click',function(e){
         let email = $('#m_email').val(); // input_id에 입력되는 값
         let doubleCheck = $('#doubleCheck');

         //이메일 형식이 틀린 경우 
         if(checkEmail(email) == false) {
            $('#double_check_result').css("color", "red");
            $('#double_check_result').html("정확한 이메일을 입력해주시기 바랍니다.");
            $('#doubleCheck').val(0);
            return false;
         }
         
         //이메일이 온전한 경우 ajax로 중복검사 실시
         //0 경우 : 중복된 아이디
         //1일 경우 : 사용 가능한 아이디
         if(email != null && email !='') {
            
            $.ajax({
               url : "/members/checkid.sosu",
               type : "post",
               contentType: "application/json",
               data : JSON.stringify({
                        M_EMAIL : email
               }),
               dataType:'json',
               success : function(result, status, xhr) {
                  if (result != 0) { 
                     $("#double_check_result").html('중복된 아이디입니다.');
                     $("#double_check_result").css('color', 'red');
                     $('#doubleCheck').val(0);
                  } else {
                     $("#double_check_result").html('사용할 수 있는 아이디입니다.');
                     $("#double_check_result").css('color', 'green');
                     $('#doubleCheck').val(1);
                  }
               },
               error : function() {
                  alert("서버요청실패");
               }
            })
         }else {
            $("#double_check_result").html('아이디를 입력해 주세요.');
            $("#double_check_result").css('color', 'red');
            $('#doubleCheck').val(-1);
         }
      });   
      
      
      //--------------------
      //닉네임 중복검사 ajax
      $('#check').on('click',function(e){
         let nickname = $('#m_nickname').val(); // input_id에 입력되는 값
         let nickCheck = $('#nickCheck');
      
         if(nickname != null && nickname !='') {
            $.ajax({
               url : "/members/checknickname.sosu",
               type : "post",
               contentType: "application/json",
               data : JSON.stringify({
                        M_NICKNAME : nickname
               }),
               dataType:'json',
               success : function(result, status, xhr) {
                  if (result != 0) { 
                     $("#nickname_check_result").html('중복된 닉네임입니다.');
                     $("#nickname_check_result").css('color', 'red');
                     $('#nickCheck').val(0);
                  } else {
                     $("#nickname_check_result").html('사용할 수 있는 닉네임입니다.');
                     $("#nickname_check_result").css('color', 'green');
                     $('#nickCheck').val(1);
                  }
               },
               error : function() {
                  alert("서버요청실패");
               }
            })
         }else {
            $("#nickname_check_result").html('닉네임을 입력해 주세요.');
            $("#nickname_check_result").css('color', 'red');
            $('#nickCheck').val(-1);
         }
      });   
      
      //------------------
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
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
      
      
});



//비밀번호 유효성검사 4~20자 입력, 숫자, 영문, 특수기호만 입력 가능
function checkPassword(pw) {
   var regexPw = /^[A-Za-z0-9`~!@#\$%\^&\*\(\)\{\}\[\]\-_=\+\\|;:'"<>,\./\?]{4,20}$/;
   if(!regexPw.test(pw)) {
      return false;
   }
     return true;
}

//이메일 유효성검사
function checkEmail(email) {
   var pattern = /^[0-9a-zA-Z가-힣]([-_.]?[0-9a-zA-Z가-힣])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
   if(!pattern.test(email)) {
      return false;
   }
   return true;
}


function checkNickname(nickname) {
   var pattern = /^[0-9a-zA-Z가-힣]([-_.]?[0-9a-zA-Z가-힣])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
   if(!pattern.test(nickname)) {
      return false;
   }
   return true;
}


//숫자만 입력 가능하도록 만들기 (0부터 9까지)
function onlyNumber(data){
   data = data.replace(/[^0-9]/g, '');
   return data;
}

//성별 입력 (1부터 4까지만 가능)
function onlyGender(data){
   data = data.replace(/[^1-4]/g, '');
   return data;
}