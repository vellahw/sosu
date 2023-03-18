package second.sosu.admin.qna.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import second.sosu.admin.qna.dao.AdminQnADAO;
import second.sosu.common.util.FileUtils;

@Service("adminQnaService")
public class AdminQnAServiceImpl implements AdminQnAService{
   
   @Resource(name = "adminQnaDAO")
      private AdminQnADAO adminQnaDAO;
      
      @Resource(name="fileUtils")
      private FileUtils fileUtils;
      
      
      @Override
      public Map<String, Object> qnaList(Map<String, Object> map) throws Exception {
         return adminQnaDAO.qnaList(map);
      }

      @Override
      public void insertQnaComment(Map<String, Object> map) throws Exception {
         adminQnaDAO.insertQnaComment(map);
      }
}