/* 지도 */
var latitude = document.getElementById('latitude').value; //위도
var longitude = document.getElementById('longitude').value; //경도
var address = document.getElementById('address').value;
var detail_address = document.getElementById('detail-address').value;

var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
var options = { //지도를 생성할 때 필요한 기본 옵션
   center: new kakao.maps.LatLng(latitude, longitude), //지도의 중심좌표.
   level: 3 //지도의 레벨(확대, 축소 정도)
};

var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴

//지도를 클릭한 위치에 표출할 마커
var marker = new kakao.maps.Marker({ 
   // 지도 중심좌표에 마커를 생성
   position: map.getCenter() 
}); 
//지도에 마커를 표시
marker.setMap(map);

// 인포윈도우로 장소에 대한 설명을 표시
var infowindow = new kakao.maps.InfoWindow({
    content: '<div style="width:150px;text-align:center;padding:6px 0;">'+address+'<br>'+detail_address+'</div>'
});
infowindow.open(map, marker); 
 
var cate = document.getElementById("cate").value;
var idx = document.getElementById("idx").value;
var gender = document.getElementById("gender2").value; //모임성별
var presentP = document.getElementById("presentP").value; //참여한 현재인원
var maxP = document.getElementById("maxP").value; //모임에 설정된 최대인원
var minAge = document.getElementById("minAge").value;
var maxAge = document.getElementById("maxAge").value;
    
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
    let tmpAge1 = document.getElementById('sessage1').value;
    let jumin2 = document.getElementById('ssgender1').value;  

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

//참여 승인이 필요한 모임
function checkJoin2() {
  let tmpAge2 = document.getElementById('sessage2').value;
  let jumin22 = document.getElementById('ssgender2').value;  
    
  if(maxP != 0) {
    if(presentP >= maxP) {
      alert('현재 참여인원이 모두 찼습니다.');
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
    
  if(confirm("모임에 참가요청을 하시겠습니까?")) {
    alert("참가요청 되었습니다.");
  } else {
    location.href = "/moim/" + cate + "/" + idx + ".sosu";
    return false;
  }
}