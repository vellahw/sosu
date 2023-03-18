$(document).ready(function(){

   $('#loginform').on('click',function(e){
      var email = $('#m_email').val();
      var password = $('#m_pw').val();
         
      if(email==null || email==''){
         alert("이메일을 입력해주세요");
         $('#m_email').focus();
         return false;
      }
         
      if(password==null || password==''){
         alert("비밀번호를 입력해주세요");
         $('#m_pw').focus();
         return false;
      }
         
      this.form.submit();
   
   
   });
      
});      
      
      