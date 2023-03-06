package second.sosu.main.sevice;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import second.sosu.common.domain.CommandMap;

public interface MainService {

	List<Map<String, Object>> moimList(Map<String, Object> map, HttpSession session, CommandMap commandMap) throws Exception;
	
	List<Map<String, Object>> freeList(Map<String, Object> map, HttpSession session) throws Exception;
	
	List<Map<String, Object>> reviewList(Map<String, Object> map, HttpSession session) throws Exception;
	
	//Map<String, Object> memberProfile(Map<String, Object> map) throws Exception;
	
	
}
