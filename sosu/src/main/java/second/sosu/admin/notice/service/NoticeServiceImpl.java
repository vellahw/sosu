package second.sosu.admin.notice.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import second.sosu.admin.notice.dao.NoticeDAO;

@Service("noticeService")
public class NoticeServiceImpl implements NoticeService{
   
   Logger log = Logger.getLogger(this.getClass());
   
   @Resource(name = "noticeDAO")
   private NoticeDAO noticeDAO;
   
   //공지사항 리스트
   @Override 
   public Map<String,Object>noticeList(Map<String, Object> map) throws Exception {
      return noticeDAO.noticeList(map);
     }
   
   //공지사항 작성
   @Override
   public void noticeWrite(Map<String, Object> map) throws Exception {
      noticeDAO.noticeWrite(map);
   }
   
   //공지사항 수정
   @Override
   public void noticeUpdate(Map<String, Object> map) throws Exception {
      noticeDAO.noticeUpdate(map);
   }
   
   //공지사항 삭제
   @Override
   public void noticeDelete(Map<String, Object> map) throws Exception {
      noticeDAO.noticeDelete(map);
   }
}