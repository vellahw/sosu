package second.sosu.main.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import second.sosu.common.domain.CommandMap;
import second.sosu.main.sevice.MainService;
import second.sosu.message.service.MessageService;

@Controller
public class MainController {
   

   @Resource(name="mainService")
   private MainService mainService;
   
   @Resource(name="messageService")
   private MessageService messageService;
   

   @RequestMapping(value = "/main.sosu")
   public String main(HttpSession session, CommandMap commandMap, Model model) throws Exception {
      if(session.getAttribute("M_TYPE") != null) {
         if(session.getAttribute("M_TYPE").equals("A")) {
            return "admin_main_layout";
         }
      }
      
      if(session.getAttribute("M_IDX") != null) {
          commandMap.put("M_IDX", session.getAttribute("M_IDX"));
          session.setAttribute("noReadMSG", messageService.noReadMSG(commandMap.getMap()).get("UNREAD"));
          model.addAttribute("noReadMSG",messageService.noReadMSG(commandMap.getMap()).get("UNREAD"));
          }
      
       return "main_layout";
   }
   
   @RequestMapping( "/{MO_CATEGORY}.sosu")
   public ModelAndView mainList(@PathVariable String MO_CATEGORY, CommandMap commandMap, HttpSession session, HttpServletRequest request) throws Exception {
      
      commandMap.getMap().put("MO_CATEGORY", MO_CATEGORY);
      
      HttpSession csession = request.getSession();
      csession.setAttribute("MO_CATEGORY", MO_CATEGORY);
      
      ModelAndView mv = new ModelAndView("/mainlist");
      mv.setViewName("mainlist");
      
      List<Map<String, Object>> molist  = mainService.moimList(commandMap.getMap(), session, commandMap);
      
      List<Map<String, Object>> frlist  = mainService.freeList(commandMap.getMap(), session);
      List<Map<String, Object>> relist  = mainService.reviewList(commandMap.getMap(), session);
      mv.addObject("molist", molist);
      mv.addObject("frlist", frlist);
      mv.addObject("relist", relist);
      mv.addObject("sessionss",session.getAttribute("M_IDX"));
      
      return mv;
   }

//   @RequestMapping( "/{MO_CATEGORY}.sosu")
//   public String mainList(@PathVariable String MO_CATEGORY, ModelMap model, CommandMap commandMap) throws Exception {
//      
//      commandMap.getMap().put("MO_CATEGORY", MO_CATEGORY);
//      
//      model.addAttribute("molist",mainService.moimList(commandMap.getMap()));
//      model.addAttribute("frlist",mainService.freeList(commandMap.getMap()));
//      model.addAttribute("relist",mainService.reviewList(commandMap.getMap()));
//      
//      return "mainlist";
//   }
}