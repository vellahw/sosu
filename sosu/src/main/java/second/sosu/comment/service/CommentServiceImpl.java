package second.sosu.comment.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import second.sosu.comment.dao.CommentDAO;

@Service("commentService")
public class CommentServiceImpl implements CommentService {
	Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="commentDAO")
	private CommentDAO commentDAO;
	
	@Override
	public List<Map<String, Object>> commentList(Map<String, Object> map) throws Exception {
		return commentDAO.commentList(map);
	}
	
	@Override
	public void commentInsert(Map<String, Object> map) throws Exception {
		commentDAO.commentInsert(map);
	}
	
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
