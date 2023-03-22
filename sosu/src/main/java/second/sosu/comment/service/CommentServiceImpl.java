package second.sosu.comment.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import second.sosu.comment.dao.CommentDAO;

@Service("commentService")
@Log4j
@AllArgsConstructor
public class CommentServiceImpl implements CommentService {
	Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="commentDAO")
	private CommentDAO commentDAO;
	
	@Override
	public List<Map<String, Object>> commentList(Map<String, Object> map) throws Exception {
		return commentDAO.commentList(map);
	}
	
	@Override
	public int commentInsert(Map<String, Object> map) throws Exception {
		log.info("오예ㅖㅖ.." + map);
		return	commentDAO.commentInsert(map);
	}

//	@Override
//	public void commentInsert(Map<String, Object> map) throws Exception {
//		log.info("오예ㅖㅖ.." + map);
//		commentDAO.commentInsert(map);
//	}
	
	@Override
	public void commentInsert2(Map<String, Object> map) throws Exception {
		commentDAO.commentInsert2(map);
	}
	
	@Override
	public void commentUpdate(Map<String, Object> map) throws Exception {
		commentDAO.commentUpdate(map);
	}
	
	@Override
	public void commentDelete(Map<String, Object> map) throws Exception {
		commentDAO.commentDelte(map);
	}
}
