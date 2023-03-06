package second.sosu.comment.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import second.sosu.common.dao.AbstractDAO;

@Repository("commentDAO")
public class CommentDAO extends AbstractDAO {
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> commentList(Map<String, Object> map) throws Exception {
		return(List<Map<String, Object>>)selectList("comment.commentList", map);
	}
	
	public void commentInsert(Map<String, Object> map) throws Exception {
		insert("comment.commentInsert", map);
	}
	
	public void commentInsert2(Map<String, Object> map) throws Exception {
		insert("comment.commentInsert2", map);
	}
	
	public void commentUpdate(Map<String, Object> map) throws Exception {
		update("comment.commentUpdate", map);
	}
	
	public void commentDelte(Map<String, Object> map) throws Exception {
		delete("comment.commentDelete", map);
	}
}