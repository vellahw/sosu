package second.sosu.admin.qna.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import second.sosu.common.dao.AbstractDAO;

@Repository("adminQnaDAO")
public class AdminQnADAO extends AbstractDAO {
   
      // QNA-List
      @SuppressWarnings("unchecked")
      public Map<String,Object> qnaList(Map<String,Object> map) throws Exception{
         return (Map<String,Object>)selectPagingList("qna.qnaList", map);
      }
       
      //QNA 답변 작성
      public void insertQnaComment(Map<String,Object> map) throws Exception{
         update("qna.insertQnaComment", map);
      }
}