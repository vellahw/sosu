    var cate = $("#cate").val();
    var idx = $("#idx").val();
    var gender = $("#gender2").val(); //모임성별
    var presentP =  $('#presentP').val();//참여한 현재인원
    var maxP =  $('#maxP').val(); //모임에 설정된 최대인원
    var minAge =  $('#minAge').val();
    var maxAge =  $('#maxAge').val();
    
 $(document).ready(function(){ 
 // 모임에 참여 했다면 참여하기 버튼 없애고 탈퇴하기 버튼 띄움
 
  var M_IDX = '<%=(String)session.getAttribute("M_IDX")%>';
    
    if(pmidx == M_IDX) {
      $("#cham1").css('display', 'none');
      $("#tal1").css('display', 'block'); 
    }
    
    if(wmidx == M_IDX) {
      $("#cham2").css('display', 'none');
      $("#tal2").css('display', 'block'); 
    }
  });
    
//모임 탈퇴
 function exit() {
    
    if (confirm("모임에서 탈퇴하시겠습니까?")) {
      alert("탈퇴되었습니다.");
      location.href = "/moim/" + cate + "/" + idx + ".sosu";
      
    } else {
      location.href = "/moim/" + cate + "/" + idx + ".sosu";
      return false;
    }
 } 
 
 function exit2() {
    
    if (confirm("참가요청을 취소하시겠습니까?")) {
      alert("취소되었습니다.");
      location.href = "/moim/" + cate + "/" + idx + ".sosu";
      
    } else {
      location.href = "/moim/" + cate + "/" + idx + ".sosu";
      return false;
    }
 } 
 
 //참가 요청 승인 처리
 function approve() {
    
    if (confirm("승인 허가 하시겠습니까?")) {
      alert("승인 되었습니다.");
      location.href = "/moim/" + cate + "/" + idx + ".sosu";
      
    } else {
      location.href = "/moim/" + cate + "/" + idx + ".sosu";
      return false;
    }
 } 
 
 //참가 요청 거부 처리
 function ban() {
    
    if (confirm("참여 거부 하시겠습니까?")) {
      alert("거부 되었습니다.");
      location.href = "/moim/" + cate + "/" + idx + ".sosu";
      
    } else {
      location.href = "/moim/" + cate + "/" + idx + ".sosu";
      return false;
    }
 } 
 
  function checkJoin() {
  
    let tmpAge1 = $('#sessage1').val();  
    let jumin2 = $('#ssgender1').val(); 
    

    if(maxP != 0) { 
     if(presentP >= maxP) {
      alert('현재 참여인원이 가득 찼습니다.');
      return false;
      }
    }
    
    if(minAge > tmpAge1 || tmpAge1 > maxAge) {
      alert('회원님의 나이가 모임의 연령대에 맞지 않습니다.');
      return false;
    }

    if(gender == 'W' && jumin2 == '1' || gender == 'W' && jumin2 == '3') {
      alert('여성회원만 참여가능한 모임입니다');
      return false;
    }
    
    if(gender == 'M' && jumin2 == '2' || gender == 'M' && jumin2 == '4') {
      alert('남성회원만 참여가능한 모임입니다');
      return false;
    }
    
    
    if (confirm("모임에 참여하시겠습니까?")) {
      alert("참여 되었습니다.");
    } else {
      location.href = "/moim/" + cate + "/" + idx + ".sosu";
      return false;
    }
  }

 function checkJoin2() {
  
   let tmpAge2 = $('#sessage2').val();
   let jumin22= $('#ssgender2').val();
    
    
    if(maxP != 0) {
     
     if(presentP >= maxP) {
      alert('현재 참여인원이 꽉 찼습니다.');
      return false;
      }
    }
    
   if(minAge > tmpAge2 || tmpAge2 > maxAge) {
      alert('회원님의 나이가 모임의 연령대에 맞지 않습니다.');
      return false;
    }
    if(gender == 'W' && jumin22 == '1' || gender == 'W' && jumin22 == '3') {
      alert('여성회원만 참여가능한 모임입니다');
      return false;
    }
    
    if(gender == 'M' && jumin22 == '2' || gender == 'M' && jumin22 == '4') {
      alert('남성회원만 참여가능한 모임입니다');
      return false;
    }
    
    if (confirm("모임에 참가요청을 하시겠습니까?")) {
      alert("참가요청 되었습니다.");
      
    } else {
      location.href = "/moim/" + cate + "/" + idx + ".sosu";
      return false;
    }
  }