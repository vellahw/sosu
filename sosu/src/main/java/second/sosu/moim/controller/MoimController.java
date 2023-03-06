package second.sosu.moim.controller;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import second.sosu.common.domain.CommandMap;
import second.sosu.common.domain.Criteria;
import second.sosu.common.domain.PageDTO;
import second.sosu.moim.service.MoimService;

@Controller
public class MoimController {

	Logger log = Logger.getLogger(this.getClass());

	@Resource(name = "moimService")
	private MoimService moimService;

	// 모임 리스트
	@RequestMapping(value = "/moim/{MO_CATEGORY}.sosu")
	public ModelAndView moimList(@PathVariable String MO_CATEGORY, Criteria cri,
			@RequestParam(value = "MO_REGION", required = false) String MO_REGION,
			@RequestParam(value = "KEYWORD", required = false) String KEYWORD,
			@RequestParam(value = "KEYWORD2", required = false) String KEYWORD2, CommandMap commandMap,
			HttpSession session, HttpServletRequest request) throws Exception {

		HttpSession csession = request.getSession();
		csession.setAttribute("MO_CATEGORY", MO_CATEGORY);

		commandMap.getMap().put("MO_CATEGORY", MO_CATEGORY);

		int total = moimService.moimTotalCount(commandMap.getMap()); // 모임 총 갯수

		commandMap.getMap().put("amount", cri.getAmount());
		commandMap.getMap().put("pageNum", cri.getPageNum());

		int ramount = (int) commandMap.get("amount");
		int rpageNum = (int) commandMap.get("pageNum");

		cri.setAmount(ramount);
		cri.setPageNum(rpageNum);

		ModelAndView mv = new ModelAndView("/moim/moimlist");
		mv.setViewName("moim/moimlist");

		moimService.moimClose();
		Map<String, Object> map = moimService.moimCount(commandMap.getMap());

		if (MO_REGION != null) {
			commandMap.put("MO_REGION", MO_REGION);

			cri.setMO_REGION(MO_REGION);
		}

		Map<String, Object> map2 = new HashMap<>();

		map2.put("MO_CATEGORY", MO_CATEGORY);

		if (KEYWORD != null) {

			map2.put("KEYWORD", KEYWORD);
			commandMap.put("KEYWORD", KEYWORD);
			ModelAndView mv2 = new ModelAndView("/moim/moimSearchMore");
			mv2.setViewName("moim/moimSearchMore");
			mv2.addObject("list2", moimService.moimSearchList(commandMap.getMap(), session, commandMap));
			mv2.addObject("KEYWORD", KEYWORD);
			mv2.addObject("count", map.put("MO_COUNT", KEYWORD));
			mv2.addObject("sessionss", session.getAttribute("M_IDX"));

			return mv2;
		}

		if (KEYWORD2 != null) {

			map2.put("KEYWORD2", KEYWORD2);
			commandMap.put("KEYWORD2", KEYWORD2);
			ModelAndView mv3 = new ModelAndView("/moim/moimSearchMore2");
			mv3.setViewName("moim/moimSearchMore2");
			mv3.addObject("list2", moimService.moimSearchList(commandMap.getMap(), session, commandMap));
			mv3.addObject("KEYWORD2", KEYWORD2);
			mv3.addObject("count", map.put("MO_COUNT", KEYWORD2));
			mv3.addObject("sessionss", session.getAttribute("M_IDX"));

			return mv3;
		}

		mv.addObject("list", moimService.moimList(commandMap.getMap(), session));
		mv.addObject("count", map);
		mv.addObject("sessionss", session.getAttribute("M_IDX"));
		mv.addObject("pageMaker", new PageDTO(cri, total, moimService.moimList(commandMap.getMap(), session)));
		mv.addObject("MO_REGION", commandMap.get(MO_REGION));

		return mv;

	}

	// 모임 검색 리스트
	@RequestMapping(value = "/moim/search.sosu")
	public ModelAndView moimSearchList(@RequestParam(value = "KEYWORD", required = false) String KEYWORD,
			@RequestParam(value = "KEYWORD2", required = false) String KEYWORD2, CommandMap commandMap,
			HttpSession session, Model model) throws Exception {

		Map<String, Object> map = moimService.moimCount(commandMap.getMap());

		Map<String, Object> map2 = new HashMap<>();
		String[] category = { "culture", "sports", "game", "outdoor", "food", "etc" };

		ModelAndView mv = new ModelAndView();

		if (KEYWORD2 == null) {

			// ModelAndView mv = new ModelAndView("/moim/moimSearchlist");
			mv.setViewName("moim/moimSearchlist");

			commandMap.put("KEYWORD", KEYWORD);
			map2.put("KEYWORD", KEYWORD);

			for (int i = 0; i < category.length; i++) {
				map2.put("MO_CATEGORY", category[i]);

				mv.addObject("count" + (i + 1), moimService.moimCount(map2));
				commandMap.put("MO_CATEGORY", category[i]);
				mv.addObject("list" + (i + 1), moimService.moimSearchList(commandMap.getMap(), session, commandMap));
			}
			mv.addObject("count", map.put("MO_COUNT", KEYWORD));
			mv.addObject("KEYWORD", KEYWORD);
			mv.addObject("sessionss", session.getAttribute("M_IDX"));

		} else {

			// ModelAndView mv2 = new ModelAndView("/moim/moimSearchlist2");
			mv.setViewName("moim/moimSearchlist2");

			commandMap.put("KEYWORD2", KEYWORD2);
			map2.put("KEYWORD2", KEYWORD2);

			for (int j = 0; j < category.length; j++) {
				map2.put("MO_CATEGORY", category[j]);

				mv.addObject("count" + (j + 1), moimService.moimCount(map2));
				commandMap.put("MO_CATEGORY", category[j]);
				mv.addObject("list" + (j + 1), moimService.moimSearchList(commandMap.getMap(), session, commandMap));

			}
			mv.addObject("count", map.put("MO_COUNT", KEYWORD2));
			mv.addObject("KEYWORD2", KEYWORD2);
			mv.addObject("sessionss", session.getAttribute("M_IDX"));

		}
		return mv;
	}

	// 모임 상세보기
	@RequestMapping("/moim/{MO_CATEGORY}/{MO_IDX}.sosu")
	public ModelAndView moimDetail(@PathVariable int MO_IDX, @PathVariable String MO_CATEGORY, CommandMap commandMap,
			HttpServletRequest request, HttpSession session) throws Exception {

		commandMap.getMap().put("MO_CATEGORY", MO_CATEGORY);
		commandMap.getMap().put("MO_IDX", MO_IDX);

		Map<String, Object> map = moimService.moimDetail(commandMap.getMap(), session);

		// 모임에 참여한 인원 리스트
		List<Map<String, Object>> list = moimService.moimMemberList(commandMap.getMap(), commandMap);

		// 모임에 참여 대기중인 인원 리스트
		List<Map<String, Object>> list2 = moimService.moimMemberWait(commandMap.getMap(), commandMap);

		// 모임이미지 상세보기
		List<Map<String, Object>> Flist = moimService.selectMoimImg(commandMap.getMap(), commandMap);

		ModelAndView mv = new ModelAndView("/moim/moimDetail");
		mv.setViewName("moim/moimDetail");

		if (session.getAttribute("M_IDX") != null) {

			LocalDate today = LocalDate.now();
			int todayYear = today.getYear();

			String Jumin1 = (String) session.getAttribute("M_JUMIN");
			int Jumin2 = Integer.parseInt(String.valueOf(session.getAttribute("M_GENDER")));

			int year = Integer.parseInt(String.valueOf(Jumin1.substring(0, 2)));

			int gender = Jumin2;

			if (gender == 1 || gender == 2) {
				year = year + 1900;

			} else if (gender == 3 || gender == 4) {
				year += 2000;
			} else if (gender == 0 || gender == 9) {
				year += 1800;
			}

			int tmpAge = todayYear - year + 1;

			mv.addObject("sessage", tmpAge); // 맴버 나이
		}

		mv.addObject("list", list);
		mv.addObject("list2", list2);
		mv.addObject("Flist", Flist);
		mv.addObject("Detail", map);
		mv.addObject("sessionss", session.getAttribute("M_IDX")); // 맴버 시퀀스
		mv.addObject("sessgender", session.getAttribute("M_GENDER")); // 맴버 성별

		return mv;
	}

	// 모임 참여승인 구동
	@RequestMapping("/moim/moimWaitApprove.sosu")
	public ModelAndView moimWaitApprove(CommandMap commandMap, HttpSession session) throws Exception {
		// ajax로 받아오기 위해 @RequestParam 사용

		Map<String, Object> map = moimService.moimDetail(commandMap.getMap(), session);

		String cate = map.get("MO_CATEGORY").toString();

		String idx = map.get("MO_IDX").toString();

		ModelAndView mv = new ModelAndView("redirect:/moim/" + cate + "/" + idx + ".sosu");

		moimService.moimWaitApprove(commandMap.getMap());

		return mv;
	}

	// 모임 강퇴 구동
	@RequestMapping("/moim/moimMemberBan.sosu")
	public ModelAndView moimMemberBan(CommandMap commandMap, HttpSession session) throws Exception {
		// ajax로 받아오기 위해 @RequestParam 사용

		Map<String, Object> map = moimService.moimDetail(commandMap.getMap(), session);

		String cate = map.get("MO_CATEGORY").toString();

		String idx = map.get("MO_IDX").toString();

		ModelAndView mv = new ModelAndView("redirect:/moim/" + cate + "/" + idx + ".sosu");

		moimService.moimMemberBan(commandMap.getMap());

		return mv;
	}

	// 모임 조기 마감
	@RequestMapping("/moim/moimSelfClose.sosu")
	public ModelAndView moimSelfClose(CommandMap commandMap, HttpSession session) throws Exception {

		Map<String, Object> map = moimService.moimDetail(commandMap.getMap(), session);

		String cate = map.get("MO_CATEGORY").toString();

		String idx = map.get("MO_IDX").toString();

		ModelAndView mv = new ModelAndView("redirect:/moim/" + cate + "/" + idx + ".sosu");

		moimService.moimSelfClose(commandMap.getMap());

		return mv;
	}

	// 모임작성 폼
	@RequestMapping(value = "/moim/moimRegister.sosu")
	public ModelAndView insertForm(CommandMap commandMap, HttpSession session) throws Exception {

		ModelAndView mv = new ModelAndView("/moim/moimRegister");
		mv.setViewName("moim/moimRegister");

		mv.addObject("M_IDX", session.getAttribute("M_IDX"));
		mv.addObject("MO_CATE", session.getAttribute("MO_CATEGORY"));

		return mv;
	}

	// 모임작성 구동
	@RequestMapping("/moim/moimRegister.pro")
	public ModelAndView moimRegister(@RequestParam("MO_CATEGORY") String MO_CATEGORY, CommandMap commandMap,
			HttpSession session, HttpServletRequest request) throws Exception {
		// ajax로 받아오기 위해 @RequestParam 사용

		commandMap.put("M_IDX", Integer.parseInt(String.valueOf(session.getAttribute("M_IDX"))));

		String MO_DETAIL = (String) (commandMap.get("MO_DETAIL"));
		MO_DETAIL = MO_DETAIL.replaceAll("(\r\n|\r|\n|\n\r)", "<br/>");
		commandMap.put("MO_DETAIL", MO_DETAIL);

		ModelAndView mv = new ModelAndView("redirect:/moim/" + MO_CATEGORY + ".sosu");

		moimService.moimRegister(commandMap.getMap(), session, request);

		return mv;
	}

	// 모임 수정 폼
	@RequestMapping("/moimModify/{MO_IDX}.sosu")
	public ModelAndView modifyForm(@PathVariable int MO_IDX, CommandMap commandMap, HttpSession session)
			throws Exception {

		ModelAndView mv = new ModelAndView("/moim/moimModify");
		mv.setViewName("moim/moimModify");

		commandMap.put("MO_IDX", MO_IDX);

		// 모임이미지 상세보기
		List<Map<String, Object>> Flist = moimService.selectMoimImg(commandMap.getMap(), commandMap);

		Map<String, Object> map = moimService.moimDetail(commandMap.getMap(), session);

		String MO_DETAIL = map.get("MO_DETAIL").toString();
		MO_DETAIL = MO_DETAIL.replaceAll("<br/>", "\r\n");
		map.put("MO_DETAIL", MO_DETAIL);

		mv.addObject("modify", map);
		mv.addObject("flist", Flist);

		return mv;
	}

	// 모임 수정 구동
	@RequestMapping("/moim/moimModify.pro")
	public ModelAndView moimModify(@RequestParam("MO_CATEGORY") String MO_CATEGORY,
			@RequestParam("MO_IDX") String MO_IDX, CommandMap commandMap, HttpServletRequest request) throws Exception {
		// ajax로 받아오기 위해 @RequestParam 사용

		ModelAndView mv = new ModelAndView("redirect:/moim/" + MO_CATEGORY + "/" + MO_IDX + ".sosu");

		String MO_DETAIL = (String) (commandMap.get("MO_DETAIL"));
		MO_DETAIL = MO_DETAIL.replaceAll("(\r\n|\r|\n|\n\r)", "<br/>");
		commandMap.put("MO_DETAIL", MO_DETAIL);

		moimService.moimModify(commandMap.getMap(), request);

		return mv;
	}

	// 모임 이미지 삭제
	@RequestMapping("/moim/moimImgDel.pro")
	public String MoimImgDelete(@RequestParam(value = "chbox[]", required = false) String[] chArr) throws Exception {

		if (chArr != null) {
			String F_SVNAME = null;

			if (F_SVNAME == null) {
				for (int i = 0; i < chArr.length; i++) {
					F_SVNAME = chArr[i];

					moimService.MoimImgDelete(F_SVNAME);
				}
			}
		}
		return "/moim/moimModify.pro";
	}

	// 모임 삭제
	@RequestMapping("/moim/moimDelete.sosu")
	public ModelAndView moimDelete(CommandMap commandMap, HttpSession session) throws Exception {

		Map<String, Object> map = moimService.moimDetail(commandMap.getMap(), session);

		String cate = map.get("MO_CATEGORY").toString();

		ModelAndView mv = new ModelAndView("redirect:/moim/" + cate + ".sosu");

		moimService.moimDelete(commandMap.getMap());

		return mv;
	}

	// 모임 참가(승인요청이 필요 없는 경우)
	@RequestMapping("/moim/moimJoin.sosu")
	public ModelAndView moimJoin(CommandMap commandMap, HttpSession session) throws Exception {

		Map<String, Object> map = moimService.moimDetail(commandMap.getMap(), session);

		commandMap.put("M_IDX", Integer.parseInt(String.valueOf(session.getAttribute("M_IDX"))));

		commandMap.put("MO_IDX", commandMap.get("MO_IDX"));

		String cate = map.get("MO_CATEGORY").toString();
		String idx = map.get("MO_IDX").toString();

		ModelAndView mv = new ModelAndView("redirect:/moim/" + cate + "/" + idx + ".sosu");

		moimService.moimJoin(commandMap.getMap(), session, commandMap);

		return mv;
	}

	// 모임 재참여
	@RequestMapping("/moim/moimReJoin.sosu")
	public ModelAndView moimReJoin(CommandMap commandMap, HttpSession session) throws Exception {

		Map<String, Object> map = moimService.moimDetail(commandMap.getMap(), session);

		commandMap.put("M_IDX", Integer.parseInt(String.valueOf(session.getAttribute("M_IDX"))));

		commandMap.put("MO_IDX", commandMap.get("MO_IDX"));

		String cate = map.get("MO_CATEGORY").toString();
		String idx = map.get("MO_IDX").toString();

		ModelAndView mv = new ModelAndView("redirect:/moim/" + cate + "/" + idx + ".sosu");

		moimService.moimReJoin(commandMap.getMap(), session, commandMap);

		return mv;
	}

	// 모임 재참여
	@RequestMapping("/moim/moimRePermit.sosu")
	public ModelAndView moimRePermit(CommandMap commandMap, HttpSession session) throws Exception {

		Map<String, Object> map = moimService.moimDetail(commandMap.getMap(), session);

		commandMap.put("M_IDX", Integer.parseInt(String.valueOf(session.getAttribute("M_IDX"))));

		commandMap.put("MO_IDX", commandMap.get("MO_IDX"));

		String cate = map.get("MO_CATEGORY").toString();
		String idx = map.get("MO_IDX").toString();

		ModelAndView mv = new ModelAndView("redirect:/moim/" + cate + "/" + idx + ".sosu");

		moimService.moimRePermit(commandMap.getMap(), session, commandMap);

		return mv;
	}

	// 모임 참가(승인요청이 필요한 경우)
	@RequestMapping("/moim/moimJoinPermit.sosu")
	public ModelAndView moimJoinPermit(CommandMap commandMap, HttpSession session) throws Exception {

		Map<String, Object> map = moimService.moimDetail(commandMap.getMap(), session);

		commandMap.put("M_IDX", Integer.parseInt(String.valueOf(session.getAttribute("M_IDX"))));

		commandMap.put("MO_IDX", commandMap.get("MO_IDX"));

		String cate = map.get("MO_CATEGORY").toString();
		String idx = map.get("MO_IDX").toString();

		ModelAndView mv = new ModelAndView("redirect:/moim/" + cate + "/" + idx + ".sosu");

		moimService.moimJoinPermit(commandMap.getMap(), session, commandMap);

		return mv;
	}

	// 모임 탈퇴하기
	@RequestMapping("/moim/moimExit.sosu")
	public ModelAndView moimExit(CommandMap commandMap, HttpSession session) throws Exception {

		Map<String, Object> map = moimService.moimDetail(commandMap.getMap(), session);

		commandMap.put("M_IDX", Integer.parseInt(String.valueOf(session.getAttribute("M_IDX"))));
		commandMap.put("MO_IDX", commandMap.get("MO_IDX"));

		String cate = map.get("MO_CATEGORY").toString();
		String idx = map.get("MO_IDX").toString();

		ModelAndView mv = new ModelAndView("redirect:/moim/" + cate + "/" + idx + ".sosu");

		moimService.moimExit(commandMap.getMap(), session);

		return mv;
	}

}