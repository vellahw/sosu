package second.sosu.members.member.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import second.sosu.admin.member.service.AdminMemberService;
import second.sosu.common.domain.CommandMap;
//import second.sosu.members.member.dao.MypageQuery;
import second.sosu.members.member.service.MemberService;

@Controller
public class MemberController {

   Logger log = Logger.getLogger(this.getClass());
   
   @Resource(name = "adminMemberService")
   private AdminMemberService adminMemberService;
   
   @Resource(name = "memberService")
   private MemberService memberService;

   // 로그인 체크(ID,PW)
   @RequestMapping(value = "/members/checklogin.sosu")
   @ResponseBody // 자바객체를 다시 HTTP 응답 바디로 변환
   public int checkLogin(@RequestBody HashMap<String, Object> param) throws Exception {
     Map<String,Object> map = memberService.checkPassword(param);
      int result;
      if(map==null) {
        result=0;            
     }else {
        if(map.get("M_PW").equals(param.get("M_PW"))) {
            result = 2;
         }else {
            result = 1;
         }
     }
      return result;
   }
   
   // 아이디 중복 검사
   @RequestMapping(value = "/members/checkid.sosu")
   @ResponseBody // 자바객체를 다시 HTTP 응답 바디로 변환
   public int checkId(@RequestBody HashMap<String, Object> param) throws Exception {

      int result = memberService.checkId(param); // 중복이면 0, 사용가능이면 1

      return result;
   }
   
   // 닉네임 중복 검사
   @RequestMapping(value = "/members/checknickname.sosu")
   @ResponseBody // 자바객체를 다시 HTTP 응답 바디로 변환
   public int checkNickname(@RequestBody HashMap<String, Object> param) throws Exception {

      int result = memberService.checkNickname(param); // 중복이면 0, 사용가능이면 1

      return result;
   }

   // 회원가입 폼
   @RequestMapping(value = "/members/joinform.sosu", method = RequestMethod.GET)
   public String joinForm(CommandMap commandMap) throws Exception {

      return "/com/join/join";
   }

   // 회원가입 처리
   @RequestMapping(value = "/members/join.sosu", method = RequestMethod.POST)
   public ModelAndView join(CommandMap commandMap, HttpServletRequest request) throws Exception {

      ModelAndView mv = new ModelAndView("main_layout");

      memberService.join(commandMap.getMap());

      Map<String, Object> map = memberService.login(commandMap.getMap());
      Map<String, Object> profileCheck = new HashMap<>();
      profileCheck.put("F_TABLE", "P");
      profileCheck.put("F_ARTICLE", map.get("M_IDX"));

      profileCheck.put("GenderCheck", map.get("M_GENDER"));
      if (memberService.profileCheck(profileCheck).isEmpty()) {
         memberService.profileRegister(profileCheck, request);
      }

      return mv;
   }

   // 로그인 폼
   @RequestMapping(value = "/members/loginform.sosu", method = RequestMethod.GET)
   public String loginForm(CommandMap commandMap) throws Exception {

      List<Map<String, Object>> list = new ArrayList<>();
      Map<String, Object> map = new HashMap<>();

      map.put("test", 123);

      list.add(map);

      return "/com/login/login";
   }

   // 로그인 처리
   @RequestMapping(value = "/members/login.sosu", method = RequestMethod.POST)
   public ModelAndView login(CommandMap commandMap, HttpSession session, HttpServletRequest request) throws Exception {

      ModelAndView mv = new ModelAndView();

      // 로그인 성공 시 세션값 저장
      if (memberService.login(commandMap.getMap()) != null) {
         Map<String, Object> map = memberService.login(commandMap.getMap());

         session.setAttribute("M_IDX", map.get("M_IDX"));
         session.setAttribute("M_NAME", map.get("M_NAME"));
         session.setAttribute("M_GENDER", map.get("M_GENDER"));
         session.setAttribute("M_NICKNAME", map.get("M_NICKNAME"));
         session.setAttribute("M_EMAIL", map.get("M_EMAIL"));
         session.setAttribute("M_PW", map.get("M_PW"));
         session.setAttribute("M_PHONE", map.get("M_PHONE"));
         session.setAttribute("M_JUMIN", map.get("M_JUMIN"));
         session.setAttribute("M_TYPE", map.get("M_TYPE"));
         session.setAttribute("M_DEL_YN", map.get("M_DEL_YN"));
         session.setAttribute("M_REGDATE", map.get("M_REGDATE"));
         session.setAttribute("M_QUE", map.get("M_QUE"));
         session.setAttribute("M_ANS", map.get("M_ANS"));
         session.setAttribute("M_PRIVATE", map.get("M_PRIVATE"));
         session.setAttribute("M_BAN_DATE", map.get("M_BAN_DATE"));
         
         session.setAttribute("MEM_INFO",map); //전체 넣어보기
         
         mv.setViewName("redirect:/main.sosu");
         
         return mv;
      }
      mv.setViewName("redirect:/members/loginform.sosu");

      return mv;
   }

   // 아이디찾기 폼
   @RequestMapping(value = "/members/findidform.sosu", method = RequestMethod.GET)
   public String findIdForm(CommandMap commandMap) throws Exception {

      return "/com/login/find_id";
   }

   // 아이디 찾기 처리
   @RequestMapping(value = "/members/findid.sosu", method = RequestMethod.POST)
   public ModelAndView findId(CommandMap commandMap) throws Exception {

      ModelAndView mv = new ModelAndView();
      mv.setViewName("/com/login/find_result");

      if (memberService.findId(commandMap.getMap()) != null) {
         mv.addObject("M_EMAIL", memberService.findId(commandMap.getMap()).get("M_EMAIL"));
         
      } else {
         mv.addObject("findId","X");
      }

      return mv;
   }

   // 비밀번호찾기 폼
   @RequestMapping(value = "/members/findpwform.sosu", method = RequestMethod.GET)
   public String findPwForm(CommandMap commandMap) throws Exception {

      return "/com/login/find_pw";
   }

   // 비밀번호 찾기 처리
   @RequestMapping(value = "/members/findpw.sosu", method = RequestMethod.POST)
   public ModelAndView findPw(CommandMap commandMap) throws Exception {

      ModelAndView mv = new ModelAndView();
      mv.setViewName("/com/login/find_result");

      if (memberService.findPw(commandMap.getMap()) != null) {
         mv.addObject("M_PW", memberService.findPw(commandMap.getMap()).get("M_PW"));
         
      } else {
         mv.addObject("findPw","X");
      }

      return mv;
   }

// 마이페이지 
   @RequestMapping(value = "/members/mypage.sosu", method = RequestMethod.GET)
   public ModelAndView mypage(CommandMap commandMap, HttpSession session) throws Exception {
      
      
      memberService.zzimRealDelete(commandMap.getMap());
      
      ModelAndView mv = new ModelAndView();
      
      commandMap.put("M_IDX", session.getAttribute("M_IDX"));
      commandMap.put("F_ARTICLE", session.getAttribute("M_IDX"));

      mv.addObject("privateCheck", session.getAttribute("M_PRIVATE"));
      mv.addObject("mypageInfo", memberService.mypage(commandMap.getMap()));
      
      mv.addObject("reCount", memberService.mypageMoimReviewCount(commandMap.getMap(), session));

      if (commandMap.get("mypageCategory") == null) {
         mv.addObject("mypageCategory", "1");
      } else {
         mv.addObject("mypageCategory", commandMap.get("mypageCategory"));
         if (commandMap.get("mypageCategory").equals("3")) {
            mv.addObject("selectReview", "5");
         } else if (commandMap.get("mypageCategory").equals("4")) {
            mv.addObject("selectZzim", "7");
         }
         if (commandMap.get("selectReview").equals("6")) {
            mv.addObject("mypageCategory", "3");
            mv.addObject("selectReview", commandMap.get("selectReview"));
         } else if (commandMap.get("selectReview").equals("5")) {
            mv.addObject("mypageCategory", "3");
            mv.addObject("selectReview", commandMap.get("selectReview"));
         }
         if (commandMap.get("selectZzim").equals("8")) {
            mv.addObject("mypageCategory", "4");
            mv.addObject("selectZzim", commandMap.get("selectZzim"));
         } else if (commandMap.get("selectZzim").equals("7")) {
            mv.addObject("mypageCategory", "4");
            mv.addObject("selectZzim", commandMap.get("selectZzim"));
         }
      }

      mv.setViewName("/members/mypage/mypage");

      return mv;
   }
   
   // 다른 사람 마이페이지 
   @RequestMapping(value = "/members/usermypage.sosu", method = RequestMethod.GET)
   public ModelAndView usermypage(CommandMap commandMap, HttpSession session) throws Exception {
      ModelAndView mv = new ModelAndView();
      
      if(commandMap.get("M_NICKNAME")!=null) {
         session.setAttribute("USER_M_NICKNAME", commandMap.get("M_NICKNAME"));
      }
      
      String nickname = (String)session.getAttribute("M_NICKNAME");
      String mnickname = (String)session.getAttribute("USER_M_NICKNAME");
      
      if(mnickname.equals(nickname)) {
         mv.setViewName("redirect:/members/mypage.sosu");
         return mv;
      }
      
      mv.addObject("M_NICKNAME", session.getAttribute("USER_M_NICKNAME"));
      commandMap.put("M_NICKNAME", session.getAttribute("USER_M_NICKNAME"));
      List<Map<String,Object>> list = memberService.userMypage(commandMap.getMap());
            
      commandMap.put("M_IDX", list.get(0).get("M_IDX"));
      commandMap.put("F_ARTICLE", list.get(0).get("M_IDX"));
      
      mv.addObject("privateCheck", list.get(0).get("M_PRIVATE"));
      mv.addObject("M_IDX", list.get(0).get("M_IDX"));
      session.setAttribute("USER_M_IDX", list.get(0).get("M_IDX"));
      
      
      mv.addObject("mypageInfo", memberService.mypage(commandMap.getMap()));

      if (commandMap.get("mypageCategory") == null) {
         mv.addObject("mypageCategory", "1");
      } else {
         mv.addObject("mypageCategory", commandMap.get("mypageCategory"));
         if (commandMap.get("mypageCategory").equals("3")) {
            mv.addObject("selectReview", "5");
         } else if (commandMap.get("mypageCategory").equals("4")) {
            mv.addObject("selectZzim", "7");
         }
         if (commandMap.get("selectReview").equals("6")) {
            mv.addObject("mypageCategory", "3");
            mv.addObject("selectReview", commandMap.get("selectReview"));
         } else if (commandMap.get("selectReview").equals("5")) {
            mv.addObject("mypageCategory", "3");
            mv.addObject("selectReview", commandMap.get("selectReview"));
         }
         if (commandMap.get("selectZzim").equals("8")) {
            mv.addObject("mypageCategory", "4");
            mv.addObject("selectZzim", commandMap.get("selectZzim"));
         } else if (commandMap.get("selectZzim").equals("7")) {
            mv.addObject("mypageCategory", "4");
            mv.addObject("selectZzim", commandMap.get("selectZzim"));
         }
      }
      

      mv.setViewName("/members/mypage/userMypage");

      return mv;
   }

   // 수정하기 폼
   @RequestMapping(value = "/members/mypagemodifyform.sosu", method = RequestMethod.GET)
   public ModelAndView mypageModifyForm(CommandMap commandMap, HttpSession session) throws Exception {

      ModelAndView mv = new ModelAndView();

      commandMap.put("M_EMAIL", session.getAttribute("M_EMAIL"));
      commandMap.put("M_PW", session.getAttribute("M_PW"));
      commandMap.put("F_ARTICLE", session.getAttribute("M_IDX"));

      mv.addObject("modify", memberService.login(commandMap.getMap()));
      mv.addObject("profileGet", memberService.profileCheck(commandMap.getMap()).get(0));
      mv.setViewName("/members/mypage/mypageModify");

      return mv;
   }

   // 수정하기 처리
   @RequestMapping(value = "/members/mypagemodify.sosu", method = RequestMethod.POST)
   public ModelAndView mypageModify(CommandMap commandMap, HttpSession session, HttpServletRequest request)
         throws Exception {

      ModelAndView mv = new ModelAndView();

      memberService.mypageModify(commandMap.getMap(), request, session);
      commandMap.put("M_EMAIL", session.getAttribute("M_EMAIL"));

      Map<String, Object> map = memberService.login(commandMap.getMap());

      session.setAttribute("M_NAME", map.get("M_NAME"));
      session.setAttribute("M_EMAIL", map.get("M_EMAIL"));
      session.setAttribute("M_NICKNAME", map.get("M_NICKNAME"));
      session.setAttribute("M_PW", map.get("M_PW"));
      session.setAttribute("M_PHONE", map.get("M_PHONE"));
      session.setAttribute("M_QUE", map.get("M_QUE"));
      session.setAttribute("M_ANS", map.get("M_ANS"));

      mv.setViewName("redirect:/members/mypage.sosu");

      return mv;
   }

   // 로그아웃
   @RequestMapping(value = "/members/logout.sosu", method = RequestMethod.GET)
   public ModelAndView logout(HttpSession session) throws Exception {

      ModelAndView mv = new ModelAndView();

      session.invalidate();
      mv.setViewName("main_layout");

      return mv;
   }

   // 탈퇴
   @RequestMapping(value = "/members/mypagedelete.sosu", method = RequestMethod.GET)
   public ModelAndView mypageDelete(CommandMap commandMap, HttpSession session) throws Exception {

      ModelAndView mv = new ModelAndView();

      commandMap.put("M_IDX", session.getAttribute("M_IDX"));
      memberService.mypageDelete(commandMap.getMap());
      session.invalidate();

      mv.setViewName("main_layout");

      return mv;
   }

   // 프로필 비공개
   @RequestMapping(value = "/members/mypageprivate.sosu")
   @ResponseBody
   public void mypagePrivate(@RequestBody HashMap<String, Object> param, HttpSession session) throws Exception {

      Map<String, Object> map = new HashMap<>();

      map.put("M_IDX", session.getAttribute("M_IDX"));
      map.put("M_PW", session.getAttribute("M_PW"));
      map.put("M_EMAIL", session.getAttribute("M_EMAIL"));
      
      String M_PRIVATE = session.getAttribute("M_PRIVATE").toString();

      if (param.get("pri1") != null) {
         if (param.get("pri1").equals("1")) {
            if (M_PRIVATE.equals("0")) {
               map.put("M_PRIVATE", "2");
               memberService.mypagePrivate(map);
            } else if (M_PRIVATE.equals("3")) {
               map.put("M_PRIVATE", "1");
               memberService.mypagePrivate(map);
            }
         } else if (param.get("pri1").equals("0")) {
            if (M_PRIVATE.equals("1")) {
               map.put("M_PRIVATE", "3");
               memberService.mypagePrivate(map);
            } else if (M_PRIVATE.equals("2")) {
               map.put("M_PRIVATE", "0");
               memberService.mypagePrivate(map);
            }
         }
      }

      if (param.get("pri2") != null) {
         if (param.get("pri2").equals("1")) {
            if (M_PRIVATE.equals("0")) {
               map.put("M_PRIVATE", "3");
               memberService.mypagePrivate(map);
            } else if (M_PRIVATE.equals("2")) {
               map.put("M_PRIVATE", "1");
               memberService.mypagePrivate(map);
            }
         } else if (param.get("pri2").equals("0")) {
            if (M_PRIVATE.equals("1")) {
               map.put("M_PRIVATE", "2");
               memberService.mypagePrivate(map);
            } else if (M_PRIVATE.equals("3")) {
               map.put("M_PRIVATE", "0");
               memberService.mypagePrivate(map);
            }
         }
      }

      session.setAttribute("M_PRIVATE", memberService.login(map).get("M_PRIVATE"));
   }
   
   //신고하기 폼
   @RequestMapping(value = "/members/insertreport.sosu", method = RequestMethod.GET)
   public ModelAndView insertReport(CommandMap commandMap, HttpSession session) throws Exception {
      ModelAndView mv = new ModelAndView();
      
      commandMap.put("M_IDX", session.getAttribute("USER_M_IDX"));
      List<Map<String,Object>> check = adminMemberService.adminMemberReport(commandMap.getMap());
      for(int i=0 ; i<check.size() ; i++) {
         if(check.get(i).get("R_MEM").toString().equals(session.getAttribute("M_IDX").toString())) {
            mv.addObject("impossible","impossible");
         }
      }
      
      mv.addObject("M_IDX", session.getAttribute("USER_M_IDX"));
      mv.setViewName("/members/report/insertReport");
      return mv;
   }   
   
   //신고하기 처리
   @RequestMapping(value = "/members/report.sosu", method = RequestMethod.POST)
   @ResponseBody
   public ModelAndView report(CommandMap commandMap, HttpSession session) throws Exception {
      
      commandMap.put("R_MEM", session.getAttribute("M_IDX"));
      commandMap.put("R_REPORTEDMEM", commandMap.get("M_IDX"));
      
      memberService.insertReport(commandMap.getMap());
      ModelAndView mv = new ModelAndView();
      mv.addObject("close","close");
      mv.setViewName("/members/report/insertReport");
      return mv;
   }
   
 //찜 삭제
   @RequestMapping(value = "/members/deletezzim.sosu", method = RequestMethod.POST)
   @ResponseBody
   public void deleteZzim(@RequestBody HashMap<String, Object> param, HttpSession session) throws Exception {
      try {memberService.deleteZzim(param);
      }catch(Exception e) {
         e.printStackTrace();
      }
   }
       
}
   