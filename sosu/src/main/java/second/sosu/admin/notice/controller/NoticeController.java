package second.sosu.admin.notice.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import second.sosu.admin.notice.service.NoticeService;
import second.sosu.admin.qna.service.AdminQnAService;
import second.sosu.common.domain.CommandMap;

@Controller
public class NoticeController {
   
Logger log = Logger.getLogger(this.getClass());
   
   @Resource(name="noticeService")
   private NoticeService noticeService;

   //관리자 공지사항 리스트
   @RequestMapping("/admin/noticeList.sosu") 
   public ModelAndView adminNoticeList(CommandMap commandMap, HttpSession session) throws Exception {
      ModelAndView mv = new ModelAndView("/admin/notice/adminNoticeList");      
      Map<String,Object> resultMap = noticeService.noticeList(commandMap.getMap());
         
        mv.addObject("paginationInfo", (PaginationInfo) resultMap.get("paginationInfo"));
       mv.addObject("noticeList", resultMap.get("result"));
      
      return mv; 
   }
   
   //공지사항 작성 폼
   @RequestMapping(value = "/admin/noticeWriteForm.sosu", method = RequestMethod.GET) 
   public String noticeWriteForm(CommandMap commandMap) throws Exception{
      return "/admin/notice/adminNoticeWrite"; 
   }
   
   //공지사항 작성 처리
   @RequestMapping(value = "/admin/noticeWrite.sosu", method = RequestMethod.POST) 
   public ModelAndView noticeWrite(CommandMap commandMap) throws Exception{
      ModelAndView mv = new ModelAndView();
    
     commandMap.put("N_CONTENT", commandMap.getMap().get("N_CONTENT").toString().replace("\r\n", "<br>")) ;
       noticeService.noticeWrite(commandMap.getMap());
      mv.setViewName("redirect:/admin/noticeList.sosu");
      return mv; 
   }
   
   
   
   //공지사항 수정 폼
   @RequestMapping(value = "/admin/noticeUpdateForm.sosu", method = RequestMethod.GET) 
   public ModelAndView noticeUpdateForm(CommandMap commandMap) throws Exception{
      ModelAndView mv = new ModelAndView();
      mv.addObject("update", commandMap.getMap());
      mv.setViewName("/admin/notice/adminNoticeUpdate");
      return mv;
   }
   
   //공지사항 수정 처리
   @RequestMapping(value = "/admin/noticeUpdate.sosu", method = RequestMethod.POST) 
   public ModelAndView noticeUpdate(CommandMap commandMap) throws Exception{
      ModelAndView mv = new ModelAndView();

      noticeService.noticeUpdate(commandMap.getMap());
      mv.setViewName("redirect:/admin/noticeList.sosu");
      return mv; 
   }
   
   
   //공지사항 삭제 처리
   @RequestMapping(value = "/admin/noticeDelete.sosu", method = RequestMethod.POST) 
   public ModelAndView noticeDelete(CommandMap commandMap) throws Exception{
      ModelAndView mv = new ModelAndView();
      noticeService.noticeDelete(commandMap.getMap());
      mv.setViewName("redirect:/admin/noticeList.sosu");
      return mv; 
   }
   
   //일반회원이 보는 공지사항
   @RequestMapping("/notice/noticeList.sosu") 
   public ModelAndView noticeList(CommandMap commandMap) throws Exception {
      ModelAndView mv = new ModelAndView("/notice/noticeList");      
      Map<String,Object> resultMap = noticeService.noticeList(commandMap.getMap());
         
        mv.addObject("paginationInfo", (PaginationInfo) resultMap.get("paginationInfo"));
       mv.addObject("noticeList", resultMap.get("result"));
      
      return mv; 
   }

}