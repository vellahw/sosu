package second.sosu.message.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import second.sosu.common.domain.CommandMap;
import second.sosu.members.member.service.MemberService;
import second.sosu.message.service.MessageService;

@Controller
public class MessageController {

   Logger log = Logger.getLogger(this.getClass());
   
   @Resource(name="messageService")
   private MessageService messageService;
   
   @Resource(name="memberService")
   private MemberService memberService;
   
   @SuppressWarnings("unchecked")
   @RequestMapping(value="/chat.sosu")
   public ModelAndView messageList(HttpServletRequest request, HttpSession session, CommandMap commandMap, Model model) throws Exception{
      
      Map<String, Object> member = (Map<String, Object>) session.getAttribute("MEM_INFO"); //세션에서 로그인한 회원정보 가져오기
      
      commandMap.put("F_ARTICLE", member.get("M_IDX"));
      
      model.addAttribute("FileSaveName", memberService.profileCheck(commandMap.getMap()).get(0).get("F_SVNAME"));
      
      int mem_num = Integer.parseInt(member.get("M_IDX").toString()); //로그인한 회원의 번호를 mem_num으로 저장
      
      commandMap.put("M_IDX", mem_num); //SQL로 회원번호 넣어주기
      //메세지 리스트 가져오기
      List<Map<String, Object>> unreadList = new ArrayList<>();
      List<Map<String, Object>> nicknameList = new ArrayList<>();
      
      int sender = 0;
      int reciver = 0;
      
      //새로 방을 만들었다면 값들을 구해서 만들어진 방을 삭제함
      List<Map<String, Object>> chatlist = messageService.messageList(commandMap.getMap());
      if(commandMap.get("creCheck")!=null) { //jsp에서 새로운 방을 만들었을 경우 넘어오는 값 체크
         for(int i=0 ; i<chatlist.size() ; i++) {
            if(chatlist.get(i).get("MSG_CONTENT").equals("createCheck")) { 
               commandMap.put("MSG_ROOM", chatlist.get(i).get("MSG_ROOM"));
               commandMap.put("MSG_IDX", chatlist.get(i).get("MSG_IDX"));
               commandMap.put("MSG_CONTENT", chatlist.get(i).get("MSG_CONTENT"));
               messageService.deleteRoom(commandMap.getMap()); //방을 새로 만들기 위해 넣어주었던 임의의 list를 삭제함
               model.addAttribute("cc","cc");
            }
         }
      }
      
      List<Map<String, Object>> messagelist = messageService.messageList(commandMap.getMap());

      
      if(commandMap.get("search")!=null) {
         messagelist = messageService.searchList(commandMap.getMap());
      }
      
      for(int i=0; i<messagelist.size(); i++) {
         int msgRoom = Integer.parseInt(messagelist.get(i).get("MSG_ROOM").toString());
         commandMap.put("MSG_ROOM", msgRoom);
         
         //반복문에서 상대방 닉네임을 위해 저장했던 mem_num이 계속 반복되기 때문에
         //로그인한 회원번호를 새로 넣어주기를 반복함
         commandMap.put("M_IDX", mem_num);
         
         //채팅 방에서 안읽은 메세지 개수 가져오기 
         Map<String, Object> unreadMap = (Map<String, Object>) messageService.noOpenMsg(commandMap.getMap());
         
         unreadList.add(unreadMap);
         
         
         //DB에서 받는사람, 보내는사람 번호 꺼내기
         sender = Integer.parseInt(messagelist.get(i).get("MSG_SENDER").toString());
         reciver = Integer.parseInt(messagelist.get(i).get("MSG_RECIVER").toString());

         if(sender == mem_num) { //현재 사용자가 보낸 사람이라면
            commandMap.put("M_IDX", reciver); //메세지를 받은 사람의 번호를 commandMap에 저장하기
         } else if(reciver == mem_num) { //현재 사용자가 메세지를 받은 사람이라면
            commandMap.put("M_IDX", sender); //메세지를 보낸 사람의 번호를 commandMap에 저장하기
         }
         
         //상대방 닉네임, 탈퇴(정지) 여부 가져오기 : 정상인 회원만 가능하도록 할것
         Map<String, Object> otherNickname = (Map<String, Object>) messageService.otherNickname(commandMap.getMap());
         nicknameList.add(otherNickname);
      }
      
      request.setAttribute("noOpenMSG", unreadList);
      request.setAttribute("list", messagelist);
      
      request.setAttribute("nickname", nicknameList);
      request.setAttribute("MEM_INFO", member);
      
      
      
      if(commandMap.get("check")!=null) {
         String userNickname;
         String myNickname = session.getAttribute("M_IDX").toString();
         if(session.getAttribute("USER_M_IDX")!=null) {
            userNickname= session.getAttribute("USER_M_IDX").toString();
            session.setAttribute("USER_M_IDX", null);
         }else {
            userNickname=commandMap.get("USER_M_IDX").toString();
            if(myNickname.equals(userNickname)) {
               userNickname = commandMap.get("M_NUM").toString();
            }
         }
         
        
          /*프로필 이미지 추가*/
            Map<String, Object> UserImg = new HashMap<>();
            UserImg.put("M_IDX", userNickname);
            model.addAttribute("profile", messageService.otherNickname(UserImg));
         
         commandMap.put("M_IDX", session.getAttribute("M_IDX"));
         commandMap.put("MSG_ROOM", commandMap.get("ROOM"));
        
         model.addAttribute("userId",userNickname);
         model.addAttribute("chatList", messageService.chatContent(commandMap.getMap()));
         model.addAttribute("cha",myNickname);
         
         
//         if(session.getAttribute("M_IDX").toString().equals("M_NUM")) {
//            messageService.messageRead(commandMap.getMap());
//         }
//         
         System.out.println("뭐야" + Integer.parseInt(session.getAttribute("M_IDX").toString()));
         System.out.println("뭐야2" + Integer.parseInt(commandMap.get("M_NUM").toString()));
         if(Integer.parseInt(session.getAttribute("M_IDX").toString())==Integer.parseInt(commandMap.get("M_NUM").toString())) {
            messageService.messageRead(commandMap.getMap());
         }
         
         
         
         //m_num과 msg_reciver비교해야 특정 인원에게 메시지 전송
         model.addAttribute("MSG_SENDER",myNickname);
         model.addAttribute("MSG_RECIVER",userNickname);
         model.addAttribute("MSG_ROOM",commandMap.get("MSG_ROOM"));
         model.addAttribute("check","check");
      }
      
    //채팅방에서 안읽은 메시지 가져와서 넣기
    if(session.getAttribute("M_IDX") != null) {
       commandMap.put("M_IDX", session.getAttribute("M_IDX"));
       session.setAttribute("noReadMSG", messageService.noReadMSG(commandMap.getMap()).get("UNREAD"));
    
    }
      ModelAndView mv = new ModelAndView();
      mv.setViewName("/chat");
      
      
      
      
      
      
      return mv;
   }
   
   
   //새로운 방 만드는 메소드
   @RequestMapping(value = "/message/createMessageRoom.sosu")
   public ModelAndView createMessageRoom(CommandMap commandMap, HttpSession session) throws Exception {
      
      ModelAndView mv = new ModelAndView("/chat");

      int M_IDX = Integer.parseInt(session.getAttribute("M_IDX").toString()); //로그인한 회원 번호
      int MSG_RECIVER = Integer.parseInt(commandMap.get("USER_M_IDX").toString()); //채팅하는 상대방 회원 번호
      
      int maxroom;
      
      //모든 방번호들 중에 최대값을 구하기 위함
      if(messageService.maxRoom()==null) { //아무도 대화한적 없음
         maxroom=1; //최대값을 1로 설정
      }else {
         maxroom = Integer.parseInt(messageService.maxRoom().get("MAX").toString()); //최대값 설정
      }
            
      commandMap.put("M_IDX", session.getAttribute("M_IDX")); //내 번호
      commandMap.put("MSG_RECIVER", MSG_RECIVER); //상대방 번호
      
      if(messageService.messageRoom(commandMap.getMap())==null) { //서로 대화한 적이 없다면,
         maxroom += 1; //현재 방 번호의 최대값에 +1 해주기
      }else {
         maxroom = Integer.parseInt(messageService.messageRoom(commandMap.getMap()).get("MSG_ROOM").toString());
      }
      
      mv.addObject("createCheck","createCheck"); //
      mv.addObject("check","check");
      mv.addObject("MSG_SENDER",M_IDX);
      mv.addObject("MSG_RECIVER",MSG_RECIVER);
      mv.addObject("MSG_ROOM",maxroom);
      mv.addObject("cha",M_IDX);
      
      commandMap.put("MSG_SENDER", M_IDX);
      commandMap.put("MSG_RECIVER", MSG_RECIVER);
      commandMap.put("MSG_ROOM", maxroom);
      commandMap.put("MSG_CONTENT", "createCheck");
      messageService.messageInsert(commandMap.getMap());
      
      
      //chat.jsp로 넘기기 위해 messagelist도 함께 넘겨줌
      List<Map<String, Object>> messagelist = messageService.messageList(commandMap.getMap());
      mv.addObject("list",messagelist);
      
      return mv;   
   }
   
   


   
   
}








