package second.sosu.admin.member.controller;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import second.sosu.admin.member.service.AdminMemberService;
import second.sosu.common.domain.CommandMap;
import second.sosu.members.member.service.MemberService;

@Controller
public class AdminMemberController {

   Logger log = Logger.getLogger(this.getClass());

   @Resource(name = "adminMemberService")
   private AdminMemberService adminMemberService;
   
   @Resource(name = "memberService")
   private MemberService memberService;
   
   @RequestMapping(value = "/admin/memberlist.sosu")
   public ModelAndView adminMemberList(CommandMap commandMap) throws Exception {
      ModelAndView mv = new ModelAndView();      
      if(commandMap.get("listType")==null) {
         commandMap.put("listType", "adminMemberList");
         
      }else if(commandMap.get("listType").equals("adminMemberList")) {
        commandMap.put("listType", "adminMemberList");
        
      }else if(commandMap.get("listType").equals("adminReportMemberList")) {
        commandMap.put("listType", "adminReportMemberList");
        
      }else if(commandMap.get("listType").equals("adminStopMemberList")) {
         commandMap.put("listType", "adminStopMemberList");
      }
      
      Map<String,Object> resultMap = adminMemberService.adminMemberList(commandMap.getMap());
      
       mv.addObject("paginationInfo", (PaginationInfo) resultMap.get("paginationInfo"));
      mv.addObject("adminList", resultMap.get("result"));
      mv.setViewName("/admin/member/adminMemberList");
      
      return mv;    
   }
   
   //회원 상세보기
   @RequestMapping(value = "/admin/memberdetail.sosu")
   public ModelAndView adminMemberDetail(CommandMap commandMap, HttpSession session) throws Exception {
      ModelAndView mv = new ModelAndView();
      
      if(commandMap.get("M_IDX")!=null && commandMap.get("RECOUNT")!=null) {
         session.setAttribute("DETAIL_RECOUNT", commandMap.get("RECOUNT"));
         session.setAttribute("DETAIL_M_IDX", commandMap.get("M_IDX"));
      }
      
      commandMap.put("RECOUNT", session.getAttribute("DETAIL_RECOUNT"));
      commandMap.put("M_IDX", session.getAttribute("DETAIL_M_IDX"));
      
      mv.addObject("memberDetail",adminMemberService.adminMemberDetail(commandMap.getMap()));
      mv.addObject("memberReport",adminMemberService.adminMemberReport(commandMap.getMap()));
      mv.addObject("RECOUNT",commandMap.get("RECOUNT"));
      mv.setViewName("/admin/member/adminMemberDetail");
      
      return mv;
   }
   
   //신고 삭제
   @ResponseBody
   @RequestMapping(value = "/admin/reportdelete.sosu", method=RequestMethod.POST)
   public int adminMemberReportDelete(@RequestBody Map<String,Object> param) throws Exception {      
      int result;
      try {
         adminMemberService.adminMemberReportDelete(param); 
         result = 0;
      }catch(Exception e){
         e.printStackTrace(); 
         result = 1;
      }
      return result;
   }
   
   //정지버튼
   @ResponseBody
   @RequestMapping(value = "/admin/memberstop.sosu", method=RequestMethod.POST)
   public int adminMemberStop(@RequestBody Map<String,Object> param) throws Exception {
      int result;
      try {
         adminMemberService.adminMemberStop(param);
         result = 0;
      }catch(Exception e){
         e.printStackTrace(); 
         result = 1;
      }
      return result;
   }
   
   
   
   // 탈퇴
   @RequestMapping(value = "/admin/memberdelete.sosu", method = RequestMethod.GET)
   public ModelAndView mypageDelete(CommandMap commandMap) throws Exception {
      ModelAndView mv = new ModelAndView();
      commandMap.put("M_IDX", commandMap.get("M_IDX"));
      memberService.mypageDelete(commandMap.getMap());
      mv.setViewName("redirect:/admin/memberlist.sosu");
      return mv;
   }
   
  
   
   
   
   
   
   
   
   
   
   
   
   
}