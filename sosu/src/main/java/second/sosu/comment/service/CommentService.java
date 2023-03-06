package second.sosu.comment.service;

import java.util.List;
import java.util.Map;

public interface CommentService {
	
	List<Map<String, Object>> commentList(Map<String, Object> map) throws Exception;
	
	void commentInsert(Map<String, Object> map) throws Exception;
	
	void commentInsert2(Map<String, Object> map) throws Exception;
	
	void commentUpdate(Map<String, Object> map) throws Exception;
	
	void commentDelete(Map<String, Object> map) throws Exception;
}