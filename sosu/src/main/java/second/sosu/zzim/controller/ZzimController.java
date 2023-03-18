package second.sosu.zzim.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import second.sosu.common.domain.CommandMap;
import second.sosu.zzim.service.zzimService;

@Controller
public class ZzimController {

   @Resource(name = "zzimService")
   private zzimService zzimService;

   // 모임 스크랩하기 구동
   @RequestMapping("/sosu/zzimInsert.do")
   public String zzimInsert(@RequestParam(value = "MO_IDX", required = false) String MO_IDX,
         @RequestParam(value = "RV_IDX", required = false) String RV_IDX,
         @RequestParam(value = "FR_IDX", required = false) String FR_IDX, HttpSession session,
         HttpServletRequest request, CommandMap commandMap) throws Exception {
      // ajax로 받아오기 위해 @RequestParam 사용

      commandMap.put("M_IDX", Integer.parseInt(String.valueOf(session.getAttribute("M_IDX"))));
      
      if (MO_IDX != null) {
         commandMap.put("Z_ARTICLE", MO_IDX);
         commandMap.put("Z_TABLE", "M");
         
      } else if (RV_IDX != null) {
         commandMap.put("Z_ARTICLE", RV_IDX);
         commandMap.put("Z_TABLE", "R");
         
      } else if (FR_IDX != null) {
         commandMap.put("Z_ARTICLE", FR_IDX);
         commandMap.put("Z_TABLE", "F");
      }

      zzimService.zzimInsert(commandMap.getMap(), session, commandMap);

      String referer = request.getHeader("Referer");
      return "redirect:" + referer;

   }

   // 모임 스크랩취소 구동
   @RequestMapping("/sosu/zzimDelete.do")
   public String zzimDelete(@RequestParam(value = "MO_IDX", required = false) String MO_IDX,
         @RequestParam(value = "RV_IDX", required = false) String RV_IDX,
         @RequestParam(value = "FR_IDX", required = false) String FR_IDX, HttpSession session,
         HttpServletRequest request, CommandMap commandMap) throws Exception {
      // ajax로 받아오기 위해 @RequestParam 사용

      commandMap.put("M_IDX", Integer.parseInt(String.valueOf(session.getAttribute("M_IDX"))));
      
      if (MO_IDX != null) {
         commandMap.put("Z_ARTICLE", MO_IDX);
         commandMap.put("Z_TABLE", "M");
         
      } else if (RV_IDX != null) {
         commandMap.put("Z_ARTICLE", RV_IDX);
         commandMap.put("Z_TABLE", "R");
         
      } else if (FR_IDX != null) {
         commandMap.put("Z_ARTICLE", FR_IDX);
         commandMap.put("Z_TABLE", "F");
      }

      zzimService.zzimDelete(commandMap.getMap(), session, commandMap);

      String referer = request.getHeader("Referer");
      return "redirect:" + referer;
   }

}