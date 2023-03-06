package second.sosu.qna.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import second.sosu.common.util.FileUtils;
import second.sosu.qna.dao.QnADAO;

@Service("qnaService")
public class QnAServiceImpl implements QnAService{
   
   @Resource(name = "qnaDAO")
      private QnADAO qnaDAO;
      
      @Resource(name="fileUtils")
      private FileUtils fileUtils;

      @Override
      public Map<String, Object> qnaList(Map<String, Object> map) throws Exception {
         return qnaDAO.qnaList(map);
      }

      @Override
      public void insertQna(Map<String, Object> map) throws Exception {
         qnaDAO.insertQna(map);
      }

      @Override
      public void deleteQna(Map<String, Object> map) throws Exception {
         qnaDAO.deleteQna(map);
         
      }

}