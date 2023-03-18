package second.sosu.admin.notice.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import second.sosu.common.dao.AbstractDAO;

@Repository("noticeDAO")
public class NoticeDAO extends AbstractDAO {
   
   //공지사항 리스트
   @SuppressWarnings("unchecked") 
   public Map<String,Object>noticeList(Map<String, Object> map) throws Exception {
      return (Map<String,Object>)selectPagingList("notice.noticeList", map); 
   }
   
   //   작성
   public void noticeWrite(Map<String, Object> map) throws Exception {
      insert("notice.noticeWrite", map);
   }
   
   //수정
   public void noticeUpdate(Map<String, Object> map) throws Exception {
      update("notice.noticeUpdate", map);
   }
   
   //삭제
   public void noticeDelete(Map<String, Object> map) throws Exception {
      update("notice.noticeDelete", map);
   }
}