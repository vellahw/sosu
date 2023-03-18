<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/resources/css/chat.css" rel="stylesheet">
<title>Insert title here</title>

</head>


<body>

<div class="container" style="display: flex;position: relative;margin: 0px auto;width: 1196px;margin-top: 60px;border: 1px solid #e6e6e6;">
   <!-- 새로 방을 만들고 나서, 전송을 눌렀을때 새로고침을 시키기 위함 -->
   <c:if test="${cc ne null}">
         <input type="hidden" id="ccc" value="c">
   </c:if>
   
   <!-- 왼쪽 사이드바 : 이미지 클릭 시 , 마이페이지로 넘어감 -->
      <nav class="sidebar">
         <a href="/members/mypage.sosu">
            <img class="sidebar-img" src="${pageContext.request.contextPath}/resources/img/upload/${FileSaveName}">
         </a>
      </nav>
      
      
      <!-- 채팅방 리스트 -->
      <div id="chat_list">
         <div id="my-nickname"><div style="font-weight:bold;font-size: 16px;line-height: 150%;">${MEM_INFO.M_NICKNAME}</div></div>
         <div id="chat-search">
         
         <form action="/chat.sosu">
            <input type="hidden" name="search" value="search">
            <input type="image" src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png" style="width: 15px;height: 15px;float: right;margin-top: 2px;margin-left: 7px;" >      
            <input type="text" id="search-keyword" name="KEYWORD" placeholder="채팅 검색" style="border: 1px solid #e6e6e6; width:160px">
         </form>   
            
   </div>
         <c:forEach var="list" items="${list}" varStatus="status">
            <div class="parenttt"
            <c:if test="${createCheck ne null and status.index eq 0}">style="display:none"</c:if>
            <c:if test="${createCheck eq null}">style="border-bottom: 1px solid #f2f2f2;"</c:if>>
               <div id="chat-one" <c:if test="${list.MSG_ROOM eq MSG_ROOM}">style="background-color:#F2F3F6;"</c:if>>
                    <div class="img-nick">
                     <img class="img-pro-chat" src="${pageContext.request.contextPath}/resources/img/upload/${nickname[status.index].F_SVNAME}">
                  </div>
                  <div class="text-nick" style="flex: 1 0 0%; width: 0px;">
                     <div style="display: flex;-webkit-box-align: center;align-items: center; padding-left: 37px;">
                     <span  class="list-nick">${nickname[status.index].M_NICKNAME}</span>
                     <span style="font-size: 14px;margin-left: 20px;color: #8D929A;">${list.MSG_SEND_TIME }</span>
                     </div>
                     <div style="display: flex;-webkit-box-align: center;align-items: center;height: 20px;">
                     <span class="New-MSG">${list.MSG_CONTENT}</span>
                     </div>
                     </div>
                     <c:if test="${noOpenMSG[status.index].UNREAD ne 0}">
                        <div style="display: flex;-webkit-box-align: center;align-items: flex-end;height: 20px;">
                        <span class="unread-MSG">${noOpenMSG[status.index].UNREAD }</span>
                        </div>
                     </c:if>
               </div>
            
            
            <form action="/chat.sosu" id="goChat">
            <input type="hidden" name="check" value="check">
            <input type="hidden" name="USER_M_IDX" value="${list.MSG_SENDER}">
            <input type="hidden" name="MSG_ROOM" value="${list.MSG_ROOM}">
            <input type="hidden" name="ROOM" value="${list.MSG_ROOM }">
            <input type="hidden" name="M_NUM" value="${list.MSG_RECIVER}">
            <input type="submit" value="대화 참여" id="participate" style="display:none; visibility:hidden;">
            </form>
            </div>
          
          <!-- 새로 방을 만들었다면 돌아가는 form  -->
             <c:if test="${createCheck ne null}">
                  <form action="/chat.sosu">
                  <input type="hidden" name="creCheck" value="creChck" id="creChck">
                  <input type="hidden" name="check" value="check" >
                  <input type="hidden" name="USER_M_IDX" value="${MSG_SENDER}">
                  <input type="hidden" name="MSG_CONTENT" value="${MSG_CONTENT}">
                  <input type="hidden" name="MSG_ROOM" value="${MSG_ROOM}">
                  <input type="hidden" name="ROOM" value="${MSG_ROOM }">
                  <input type="hidden" name="M_NUM" value="${MSG_RECIVER}">
                  <input type="hidden" name="checkMidx" value="${MSG_ROOM}">
                  <input type="submit" value="대화 참여" id="gogo" style="display:none; visibility:hidden;">
                  </form>
               </c:if>
         </c:forEach>
      </div>
      
      
<section id="sec_chatting">
   <c:if test="${check eq null }">
      <div id="none">
         <img src="/resources/img/icons/noneChat.png" style="display: block;max-width: 100%;width: 96px;height: 81px;fill: none;">
         <div style="margin-top: 34px;font-size: 14px;line-height: 150%;letter-spacing: -0.02em;">채팅할 상대를 선택해주세요.</div>
      </div>
   </c:if>
<c:if test="${check ne null }">
   <div id="notNone">
   
   <div id="one">
   <form action="/members/usermypage.sosu">
         <input type="hidden" name="M_NICKNAME" value="${profile.M_NICKNAME}">
         <input type="image" class="img-pro-chat-room" src="${pageContext.request.contextPath}/resources/img/upload/${profile.F_SVNAME}">
         <input type="submit" class="other-nick-name" value="${profile.M_NICKNAME}" >
      </form>
      <input type="hidden" id="nickname" value="${cha}"/><!-- 채팅방에 접속한 내 닉네임 -->
       <input type="button" id="enter" value="입장" style="display:none; visibility:hidden;"/>
       <input type="button" id="exit" value="나가기" style="display:none; visibility:hidden;"/>
   </div>
   
   <!-- 보낸 사람 -->
   <input type="hidden" name="MSG_SENDER" value="${MSG_SENDER}" id="msg_sender">
   <!-- 받는 사람 -->
   <input type="hidden" name="MSG_RECIVER" value="${MSG_RECIVER}" id="msg_reciver"> 
   <!-- 방 번호 -->
   <input type="hidden" name="MSG_ROOM" value="${MSG_ROOM}" id="msg_room">
   
   
<!-- <div id="two"> -->
   <div id="chatarea" >
      <c:forEach var="list" items="${chatList }" varStatus="status">
      
      <!-- 내가 보낸거 -->
      <c:if test="${list.MSG_SENDER eq MSG_SENDER}">
         <div id="my-Div">
            <p id="msg-send-time-my">${list.MSG_SEND_TIME}<span id="mymessage">${list.MSG_CONTENT }</span>
          </div>
      </c:if>
      
      <!-- 상대방이 보낸거 -->
      <c:if test="${list.MSG_SENDER ne MSG_SENDER}">
         <input type="hidden" id="otherNick" value="${list.MSG_SENDER}" >
         <div id="your-Div">
            <p id="msg-send-time-you">${list.MSG_SEND_TIME}<span id="yourmessage">${list.MSG_CONTENT} </span>
         </div>
      </c:if>
      </c:forEach>
      </div>
      
      <div id="sendarea">
         <div>
         <textarea placeholder="메시지를 입력해주세요" id="message"></textarea>
         <input type="button" id="send" value="전송" />
         </div>
      </div>
</div>
<!-- </div> -->
</c:if>
</section>
</div>

</body>





<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script>
/* history.replaceState({},null,location.pathname); */
$(document).ready(function(){
   
   $("#enter").trigger('click');
   
   $("div[id='chat-one']").on('click', function(){
      var parent = $(this).parent(".parenttt");
      var divId = parent.find("#participate");
      divId.trigger('click');
   });
   
   $("#gogo").trigger('click');
   
   
   
   

});
</script>


<script type="text/javascript">
   one = document.getElementById("one");
   document.getElementById("enter").addEventListener("click", function() {   
      connect(); //웹 소켓 연결해주는 함수 호출
   });
   document.getElementById("exit").addEventListener("click", function() {
      disconnect(); //연결을 해제해주는 함수 호출
   });
   document.getElementById("send").addEventListener("click", function() {
      send(); //전송해주는 함수 호출
   });
   document.getElementById("message").addEventListener("keydown", function(event) {
      var keycode = (event.keyCode ? event.keyCode : event.which);
      if (keycode == '13' && !event.shiftKey) {
         event.preventDefault();
          send();
      }
      event.stopPropagation();
   });
   var websocket;
   
//입장 버튼을 눌렀을 때 호출되는 함수
function connect(){
   MSG_ROOM = document.getElementById("msg_room").value;
   websocket = new WebSocket("ws://localhost:9000/chat-ws?MSG_ROOM="+MSG_ROOM);
   //웹 소켓에 이벤트가 발생했을 때 호출될 함수 등록
   websocket.onopen = onOpen;
   websocket.onmessage = onMessage;
   websocket.onclose = onClose;
}

//퇴장 버튼을 눌렀을 때 호출되는 함수
function disconnect(){
   msg = document.getElementById("nickname").value;
   websocket.send(msg+"님이 퇴장하셨습니다");
   websocket.close();
}

//전송 버튼을 눌렀을 때 호출될 함수
function send(){
   msg = document.getElementById("message").value;
   MSG_SENDER = document.getElementById("msg_sender").value;
   MSG_RECIVER = document.getElementById("msg_reciver").value;
   MSG_ROOM = document.getElementById("msg_room").value;
   
      websocket.send(msg+","+MSG_SENDER+","+MSG_RECIVER+","+MSG_ROOM);
   console.log("전송버튼 눌렀을때 호출되는 함수 : " + "/보내는 사람"+MSG_SENDER + "/받는사람"+MSG_RECIVER );
   document.getElementById("message").value = "";
    
    //처음 만든 방임을 알려줌
   if(document.getElementById("ccc").value != null){
           location.reload();
    }
}

//웹 소켓에 연결되었을 때 호출될 함수
function onOpen(){
   nickname = document.getElementById("nickname").value;
   chatarea = document.getElementById("chatarea");   
   chatarea.scrollTop = chatarea.scrollHeight;
}


function onClose(){
   let send_msg = "";
   msg = document.getElementById("nickname").value;
   send_msg +=  msg
   send_msg += "님이 퇴장하셨습니다"
   chatarea = document.getElementById("chatarea");
   chatarea.innerHTML = chatarea.innerHTML+ "<br/>"+ send_msg;
   chatarea.scrollTop = chatarea.scrollHeight;
}

//웹 소켓에서 메시지를 받아서 돌아가는 함수
function onMessage(evt){
   var data= evt.data;
    var otherNick = document.getElementById("otherNick");
    if(otherNick != null){
       otherNickVal = otherNick.value;
    } else{
       otherNickVal = null;
       location.reload();
    }
      var arr = data.split(",");
      for(var  i=0; i<arr.length; i++){
         console.log('arr[' + i + ']' + arr[i]);
      }
      var message = arr[0];
      
      //시간 구하기
      var today = new Date();
      var year = today.getFullYear();
      var month = ('0' + (today.getMonth() + 1)).slice(-2);
      var day = ('0' + today.getDate()).slice(-2);
      var hours = ('0' + today.getHours()).slice(-2); 
      var minutes = ('0' + today.getMinutes()).slice(-2);
      var dateString = year + '.' + month  + '.' + day + ' ' + hours + ":" + minutes;
      
    let send_msg = "";
         if(sendId != otherNickVal){ //메시지를 보낸 사용자가 대화하고 있는 사용자가 아니라면 즉, 내가 보낸 메세지라면
            send_msg += "<div id='my-Div'>"
            send_msg += "<p id='msg-send-time-my'>"
            send_msg += dateString
            send_msg += "<span id=mymessage>"
            send_msg += message
            send_msg += "</span></p></div>"
            
         } else if(otherNickVal == null){
            send_msg += "<div id='your-Div'>"
            send_msg += "<p id='msg-send-time-my'>"
            send_msg += dateString
            send_msg += "<span id='yourmessage'>"
            send_msg += message + "hihi"
            send_msg += "</span></p></div>"
            location.reload();
         }else if(sendId == otherNickVal) { //메시지를 보낸 사용자가 대화하고 있는 사용자라면 즉, 상대방이 보낸 메시지라면
             send_msg += "<div id='your-Div'>"
                 send_msg += "<p id='msg-send-time-you'>"
                 send_msg += dateString
                 send_msg += "<span id='yourmessage'>"
                 send_msg += message
                 send_msg += "</span></p></div>"
         } 
         
         chatarea = document.getElementById("chatarea");
         chatarea.innerHTML = chatarea.innerHTML+ "<br/>"+ send_msg;
           chatarea.scrollTop = chatarea.scrollHeight;
}    

</script>


</html>