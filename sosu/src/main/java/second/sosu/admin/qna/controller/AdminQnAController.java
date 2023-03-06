package second.sosu.admin.qna.controller;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import second.sosu.admin.qna.service.AdminQnAService;
import second.sosu.common.domain.CommandMap;
import second.sosu.members.member.service.MemberService;

@Controller
public class AdminQnAController {
   
Logger log = Logger.getLogger(this.getClass());
   
   @Resource(name="adminQnaService")
   private AdminQnAService adminQnaService;
   
   @Resource(name = "memberService")
   private MemberService memberService;

   //qna List이동
      @RequestMapping(value = "/admin/qnalist.sosu")
      public ModelAndView qnaList(CommandMap commandMap, HttpSession session) throws Exception {
         ModelAndView mv = new ModelAndView();
         mv.setViewName("/admin/qna/adminQnaList");
         mv.addObject("myMIDX",session.getAttribute("M_IDX"));
         commandMap.put("myMIDX", session.getAttribute("M_IDX"));
         
         commandMap.put("M_EMAIL", session.getAttribute("M_EMAIL"));
         commandMap.put("M_PW", session.getAttribute("M_PW"));
         
         if(memberService.login(commandMap.getMap()).get("M_TYPE").equals("A")) {
            mv.addObject("ADMIN","ADMIN");
            commandMap.put("ADMIN", "ADMIN");
         }
         
         Map<String,Object> resultMap = adminQnaService.qnaList(commandMap.getMap());
         
          mv.addObject("paginationInfo", (PaginationInfo) resultMap.get("paginationInfo"));
         mv.addObject("qnaList", resultMap.get("result"));
         
         return mv;
      }   
      
      // 관리자 QNA 댓글 처리
      @RequestMapping(value = "/admin/insertqnacomment.sosu", method = RequestMethod.POST)
      public ModelAndView insertQnaComment(CommandMap commandMap, HttpSession session) throws Exception {
         ModelAndView mv = new ModelAndView();
         
         adminQnaService.insertQnaComment(commandMap.getMap());
         
          
         mv.setViewName("redirect:/admin/qnalist.sosu");
         return mv;
      }   

}