//mypage.jsp 카테고리 클릭 시 필요한 값 받아오기

history.replaceState({},null,location.pathname);
$(document).ready(function(){
   $('#check1').on('click', function(){
      $('.btn').removeClass("on");
      $(this).addClass("on");
      $('#category').val(1);
      console.log(1);
   });
   $('#check2').on('click', function(){
      $('#category').val(2);
      $('.btn').removeClass("on");
      $(this).addClass("on");
      console.log(2);
   });
   $('#check3').on('click', function(){
      $('#category').val(3);
   });
   $('#check4').on('click', function(){
      $('#category').val(4);
   });
   
   $('#check5').on('click', function(){
      $('#review').val(5);
   });
   $('#check6').on('click', function(){
      $('#review').val(6);
   });
   $('#check7').on('click', function(){
      $('#zzim').val(7);
   });
   $('#check8').on('click', function(){
      $('#zzim').val(8);
   });
  
  
  
   $('input:button[id^="delZzim1"]').on('click', function(){
      var DParent = $(this).parent("#parent");
      var btnDelZzim = DParent.find('#delZzim1').val();
      var btnZIDX = DParent.find('#zIDX').val();
      var zDelYN = DParent.find('#zDelYN').val();
      if(zDelYN =='Y'){
         DParent.find('#zDelYN').val("N");
         DParent.find('#delZzim1').val("❤️");
      }else if(zDelYN=='N'){
         DParent.find('#zDelYN').val("Y");
         DParent.find('#delZzim1').val("🤍");
      }
      $.ajax({
         type : "POST",
           url : "/members/deletezzim.sosu",
           contentType: "application/json",
         data : JSON.stringify({ ZZIM_YN : zDelYN, Z_IDX : btnZIDX }),
           dataType:'json',
        }); 
      console.log("버튼: " + btnDelZzim);
      console.log("번호: " + btnZIDX);
      console.log("삭제여부: " + zDelYN);
   });
   
   $('input:button[id^="delZzim2"]').on('click', function(){
      var DParent = $(this).parent("#parent");
      var btnDelZzim = DParent.find('#delZzim2').val();
      var btnZIDX = DParent.find('#zIDX').val();
      var zDelYN = DParent.find('#zDelYN').val();
      
      if(zDelYN =='Y'){
         DParent.find('#zDelYN').val("N");
         DParent.find('#delZzim2').val("❤️");
      }else if(zDelYN=='N'){
         DParent.find('#zDelYN').val("Y");
         DParent.find('#delZzim2').val("🤍");
      }
      $.ajax({
         type : "POST",
           url : "/members/deletezzim.sosu",
           contentType: "application/json",
         data : JSON.stringify({ ZZIM_YN : zDelYN, Z_IDX : btnZIDX }),
           dataType:'json',
        }); 
      console.log("버튼: " + btnDelZzim);
      console.log("번호: " + btnZIDX);
      console.log("삭제여부: " + zDelYN);
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

//리뷰 비공개 체크
function checkReview(){
   if($("input:checkbox[id='private1']").is(":checked")==true){
      $.ajax({
         type : "POST",
         url : "/members/mypageprivate.sosu",
         contentType: "application/json",
            data : JSON.stringify({
               pri1 : $("#private1").val()
            }),
            dataType:'json'
      })
   }else{
      $.ajax({
         type : "POST",
         url : "/members/mypageprivate.sosu",
         contentType: "application/json",
            data : JSON.stringify({
               pri1 : '0'
            }),
            dataType:'json'
      })
   }
}

//찜 비공개 체크
function checkZzim(){
   if($("input:checkbox[id='private2']").is(":checked")==true){
      $.ajax({
         type : "POST",
         url : "/members/mypageprivate.sosu",
         contentType: "application/json",
            data : JSON.stringify({
               pri2 : $("#private2").val()
            }),
            dataType:'json'
      })
   }else{
      $.ajax({
         type : "POST",
         url : "/members/mypageprivate.sosu",
         contentType: "application/json",
            data : JSON.stringify({
               pri2 : '0'
            }),
            dataType:'json'
      })
   }
}






