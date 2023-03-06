package second.sosu.admin.qna.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

public interface AdminQnAService {
   
   public Map<String,Object> qnaList(Map<String,Object> map) throws Exception;
   
   public void insertQnaComment(Map<String,Object> map) throws Exception;
}