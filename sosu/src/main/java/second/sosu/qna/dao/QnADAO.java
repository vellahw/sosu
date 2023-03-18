package second.sosu.qna.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import second.sosu.common.dao.AbstractDAO;

@Repository("qnaDAO")
public class QnADAO extends AbstractDAO {
   
//      // QNA-List
//      @SuppressWarnings("unchecked")
//      public List<Map<String,Object>> qnaList(Map<String,Object> map) throws Exception{
//         return (List<Map<String,Object>>)selectList("qna.qnaList", map);
//      }
      // QNA-List
      @SuppressWarnings("unchecked")
      public Map<String,Object> qnaList(Map<String,Object> map) throws Exception{
         return (Map<String,Object>)selectPagingList("qna.qnaList", map);
      }
   
   
       
      // insertQNA
      public void insertQna(Map<String,Object> map) throws Exception{
         insert("qna.insertQna", map);
      }
      
      //삭제
      public void deleteQna(Map<String,Object> map) throws Exception{
         update("qna.deleteQna", map);
      }

}