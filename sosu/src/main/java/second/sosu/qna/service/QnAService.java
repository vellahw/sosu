package second.sosu.qna.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

public interface QnAService {
   
//   public List<Map<String,Object>> qnaList(Map<String,Object> map) throws Exception;
   public Map<String,Object> qnaList(Map<String,Object> map) throws Exception;   
   
   public void insertQna(Map<String,Object> map) throws Exception;
   
   public void deleteQna(Map<String,Object> map) throws Exception;
   
}