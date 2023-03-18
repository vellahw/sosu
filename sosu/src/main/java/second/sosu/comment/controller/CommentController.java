package second.sosu.comment.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import second.sosu.comment.service.CommentService;
import second.sosu.common.domain.CommandMap;

@Controller
public class CommentController {
	Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="commentService")
	private CommentService commentService;
	
	@RequestMapping(value="/sample/commentInsert/{FR_IDX}")
	public ModelAndView commentInsert(CommandMap commandMap, HttpSession session) throws Exception {
		ModelAndView mv = new ModelAndView("redirect:/freeboard/Detail");
		
		commentService.commentInsert(commandMap.getMap());
		mv.addObject("B_IDX", commandMap.get("B_IDX"));
		
		return mv;
	}
	
	@RequestMapping(value="/sample/commentInsert2/{FR_IDX}")
	public ModelAndView commentInsert2(CommandMap commandMap, HttpSession session) throws Exception {
		ModelAndView mv = new ModelAndView("redirect:/freeboard/Detail");
		
		commentService.commentInsert2(commandMap.getMap());
		mv.addObject("B_IDX", commandMap.get("B_IDX"));
		
		return mv;
	}
	
	@RequestMapping(value="/sample/commentUpdate/{FR_IDX}")
	public ModelAndView commentUpdate(CommandMap commandMap, HttpSession session) throws Exception {
		ModelAndView mv = new ModelAndView("redirect:/freeboard/Detail");
		
		commentService.commentUpdate(commandMap.getMap());
		mv.addObject("B_IDX", commandMap.get("B_IDX"));
		
		return mv;
	}
	
	@RequestMapping(value="/sample/commentDelete/{FR_IDX}")
	public ModelAndView commandDelete(CommandMap commandMap, HttpSession session) throws Exception {
		ModelAndView mv = new ModelAndView("redirect:/freeboard/Detail");
		
		commentService.commentDelete(commandMap.getMap());
		mv.addObject("B_IDX", commandMap.get("B_IDX"));
		
		return mv;
	}
}
