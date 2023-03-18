package second.sosu.members.review.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import second.sosu.common.domain.CommandMap;
import second.sosu.members.review.service.ReviewService;

@Controller
public class ReviewController {

   Logger log = Logger.getLogger(this.getClass());

   @Resource(name = "reviewService")
   private ReviewService reviewService;

   @GetMapping("/review/{MO_CATEGORY}/{RV_IDX}.sosu")
   public ModelAndView reviewDetail(@PathVariable int RV_IDX, @PathVariable String MO_CATEGORY, CommandMap commandMap,
         HttpSession session) throws Exception {

      commandMap.put("RV_IDX", RV_IDX);

      commandMap.put("MO_CATEGORY", MO_CATEGORY);

      ModelAndView mv = new ModelAndView("/members/review/reviewDetail");

      mv.setViewName("members/review/reviewDetail");

      Map<String, Object> map = reviewService.reviewDetail(commandMap.getMap());

      List<Map<String, Object>> list = reviewService.reviewPhotoList(commandMap.getMap());

      mv.addObject("sessionss", session.getAttribute("M_IDX"));
      mv.addObject("map", map);
      mv.addObject("list", list);

      return mv;
   }

   @GetMapping("/review/{MO_CATEGORY}.sosu")
   public ModelAndView reviewList(@PathVariable String MO_CATEGORY, HttpSession session, CommandMap commandMap)
         throws Exception {

      commandMap.put("MO_CATEGORY", MO_CATEGORY);

      ModelAndView mv = new ModelAndView("/members/review/reviewList");

      mv.setViewName("members/review/reviewList");

      List<Map<String, Object>> list = reviewService.reviewList(commandMap.getMap(), session);

      mv.addObject("list", list);
      mv.addObject("sessionss", session.getAttribute("M_IDX"));

      return mv;
   }

   /**
    * 리뷰 작성 폼
    * 
    * @category review
    * @param commandMap
    * @throws Exception
    * @author seungju han
    */
   @GetMapping("/members/reviewForm.sosu")
   public ModelAndView reviewForm(CommandMap commandMap, HttpSession session, HttpServletRequest request) throws Exception {

      ModelAndView mv = new ModelAndView("/members/review/reviewForm");

      mv.setViewName("members/review/reviewForm");

      mv.addObject("MO_IDX", commandMap.get("MO_IDX"));
      mv.addObject("MO_TITLE", commandMap.get("MO_TITLE"));
      mv.addObject("M_IDX", session.getAttribute("M_IDX"));

      return mv;
   }

   /**
    * 리뷰 작성
    * 
    * @param commandMap
    * @param session
    * @throws Exception
    * @return insert, update, delete 쿼리문은 int값으로 반환하므로 리턴타입을 map으로 받으면 안된다. (dao,
    *         service, serviceimpl 수정 완료)
    * @author seungju han
    */
      @PostMapping("/members/reviewForm.sosu")
      public ModelAndView reviewForm_insert(CommandMap commandMap, HttpServletRequest request, HttpSession session,  RedirectAttributes rttr) throws Exception {

         commandMap.put("M_IDX", Integer.parseInt(String.valueOf(session.getAttribute("M_IDX"))));

         String CONTENT = (String) (commandMap.get("RV_CONTENT"));
         CONTENT = CONTENT.replaceAll("(\r\n|\r|\n|\n\r)", "<br/>");
         
         commandMap.put("RV_CONTENT", CONTENT);
         
         rttr.addFlashAttribute("result", (commandMap.get("RV_IDX")));

         ModelAndView mv = new ModelAndView("redirect:/members/mypage.sosu");

         reviewService.insertReview(commandMap.getMap(), request);

         return mv;
      }

   /**
    * 리뷰 수정 폼
    * 
    * @param commandMap
    * @return
    * @throws Exception
    */

   @GetMapping("/reviewModify/{MO_CATEGORY}/{RV_IDX}.sosu")
   public ModelAndView reviewModify(@PathVariable int RV_IDX, @PathVariable String MO_CATEGORY, CommandMap commandMap) throws Exception {

      commandMap.put("RV_IDX", RV_IDX);

      Map<String, Object> map = reviewService.reviewDetail(commandMap.getMap());

      ModelAndView mv = new ModelAndView("/members/review/reviewModify");

      mv.setViewName("members/review/reviewModify");

      List<Map<String, Object>> list = reviewService.reviewPhotoList(commandMap.getMap());

      mv.addObject("map", map);

      mv.addObject("list", list);

      return mv;
   }

   /**
    * 리뷰 수정
    * 
    * @param commandMap
    * @return
    * @throws Exception
    */

   
    @PostMapping("/review/reviewModify.sosu") 
    public ModelAndView reviewModify_(@RequestParam(value="MO_CATEGORY", required=false) String MO_CATEGORY, CommandMap commandMap, HttpServletRequest request) throws Exception {
       
       try {
          commandMap.put("rMax", commandMap.get("RV_IDX"));
          reviewService.updateReviewMain(commandMap.getMap(), request);
       }catch(Exception e) {}
       
       
       Map<String, Object> map = reviewService.reviewDetail(commandMap.getMap());
       
       String idx = map.get("RV_IDX").toString();
       
       commandMap.put("MO_CATEGORY", MO_CATEGORY);
       
       ModelAndView mv = new ModelAndView("redirect:/review/"+ MO_CATEGORY +"/"+ idx
       +".sosu");
       
       reviewService.updateReview(commandMap.getMap());
       
       mv.addObject("RV_IDX", commandMap.get("RV_IDX"));
       
       return mv; 
   }
    

   /**
    * 리뷰 삭제
    * 
    * @param commandMap
    * @return
    * @throws Exception
    */

   @PostMapping("/review/delete.sosu")
   public ModelAndView reviewDelete(CommandMap commandMap) throws Exception {

      ModelAndView mv = new ModelAndView("redirect:/members/mypage.sosu");

      reviewService.deleteReview(commandMap.getMap());

      return mv;
   }
}