package second.sosu.chat;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import second.sosu.message.service.MessageService;

@Component
public class ChatHandler extends TextWebSocketHandler {
   
   private static List<WebSocketSession> list = new ArrayList<WebSocketSession>();
   
   @Resource(name="messageService")
   private MessageService messageService;
   
   
   //클라이언트 접속
   @Override
   public void afterConnectionEstablished(WebSocketSession webSession) throws Exception {
      System.out.println("입장 세션 : "+webSession);
      list.add(webSession);
    
   }

   //@Override
   protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
   // 전송된 메시지를 List의 모든 세션에 전송
      String msg = message.getPayload();
      
      String[] msgcut = msg.split(",");
      
      Map<String,Object> messageMap = new HashMap<>();
      messageMap.put("MSG_CONTENT", msgcut[0]);
      messageMap.put("MSG_SENDER", msgcut[1]);
      messageMap.put("MSG_RECIVER", msgcut[2]);
      messageMap.put("MSG_ROOM", msgcut[3]);
      
      messageService.messageInsert(messageMap);
      
      for (WebSocketSession s : list) {
         System.out.println("전송할 때 웹소켓 세션 뭐냐" + s);
         if(s.getUri().equals(session.getUri())) {
              s.sendMessage(new TextMessage(msgcut[0] + "," +(msgcut[1])));
         }else {
            if(s.getId().equals(session.getId())) {
                    s.sendMessage(new TextMessage(msgcut[0] + "," +(msgcut[1])));
            }
         }
//         if(s.getId().equals(session.getId())) {
//             s.sendMessage(new TextMessage(msgcut[0] + "," +(msgcut[1])));
//         }
      }
   }
   
   // 클라이언트의 접속이 해제 호출 메소드
   @Override
   public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
      System.out.println("클라이언트와 연결 해제됨");
      System.out.println("리스트는?"+session);
      list.remove(session);
   }
}