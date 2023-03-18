package second.sosu.admin.notice.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

public interface NoticeService {
   
   //공지사항 리스트
   Map<String,Object>noticeList(Map<String, Object> map) throws Exception; 
   
   //공지사항 작성
   void noticeWrite(Map<String, Object> map) throws Exception;
   
   //공지사항 수정
   void noticeUpdate(Map<String, Object> map) throws Exception;
      
   //공지사항 삭제
   void noticeDelete(Map<String, Object> map) throws Exception;

}