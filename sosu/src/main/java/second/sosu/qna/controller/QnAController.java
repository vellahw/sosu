package second.sosu.qna.controller;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import second.sosu.common.domain.CommandMap;
import second.sosu.members.member.service.MemberService;
import second.sosu.qna.service.QnAService;

@Controller
public class QnAController {
	
Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="qnaService")
	private QnAService qnaService;
	
	@Resource(name = "memberService")
	private MemberService memberService;
	
		
	@RequestMapping(value = "/qna/qnalist.sosu")
	   public ModelAndView qnaList(CommandMap commandMap, HttpSession session) throws Exception {
	      ModelAndView mv = new ModelAndView();
	      mv.setViewName("/qna/qnaList");
	      
	      if(session.getAttribute("M_IDX")!=null) {
	    	  mv.addObject("myMIDX",session.getAttribute("M_IDX"));
		      commandMap.put("myMIDX", session.getAttribute("M_IDX"));
		      
		      commandMap.put("M_EMAIL", session.getAttribute("M_EMAIL"));
		      commandMap.put("M_PW", session.getAttribute("M_PW"));
	      }
	      
	      
//	      if(memberService.login(commandMap.getMap()).get("M_TYPE").equals("A")) {
//	    	  mv.addObject("ADMIN","ADMIN");
//	    	  commandMap.put("ADMIN", "ADMIN");
//	      }
	      
	      Map<String,Object> resultMap = qnaService.qnaList(commandMap.getMap());
	      
	  	  mv.addObject("paginationInfo", (PaginationInfo) resultMap.get("paginationInfo"));
	      mv.addObject("qnaList", resultMap.get("result"));
	      
	      return mv;
	   }   
	   
	   //QNA 작성 폼
	   @RequestMapping(value = "/qna/qnaform.sosu", method = RequestMethod.GET)
	   public ModelAndView qnaform() throws Exception {
	      ModelAndView mv = new ModelAndView();
	      mv.setViewName("/qna/insertQna");
	      return mv;
	   }   
	   
	   // insertQna
	   @RequestMapping(value = "/qna/insertqna.sosu", method = RequestMethod.POST)
	   public ModelAndView insertQna(CommandMap commandMap, HttpSession session) throws Exception {
	      ModelAndView mv = new ModelAndView();
	      System.out.println("큐큐"+commandMap.getMap());
	      commandMap.put("M_IDX", session.getAttribute("M_IDX"));
	      
	      qnaService.insertQna(commandMap.getMap());
	       
	      mv.setViewName("redirect:/qna/qnalist.sosu");
	      return mv;
	   }   
	   
	   // deleteQna
	   @RequestMapping(value = "/qna/deleteqna.sosu", method = RequestMethod.POST)
	   public ModelAndView deleteQna(CommandMap commandMap, HttpSession session) throws Exception {
	      ModelAndView mv = new ModelAndView();
	      System.out.println("삭제"+commandMap.getMap());
	      
	      qnaService.deleteQna(commandMap.getMap());
	       
	      if(session.getAttribute("M_TYPE").toString().equals("A")) {
	    	  mv.setViewName("redirect:/admin/qnalist.sosu");
	      }else {
	    	  mv.setViewName("redirect:/qna/qnalist.sosu");
	      }
	      
	      return mv;
	   }   

}
