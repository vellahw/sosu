package second.sosu.admin.member.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import second.sosu.admin.member.dao.AdminMemberDAO;

@Service("adminMemberService")
public class AdminMemberServiceImpl implements AdminMemberService {
   
   @Resource(name = "adminMemberDAO")
   private AdminMemberDAO adminMemberDAO;
   
   //관리자 - 회원 기본 리스트: 페이징 이후
      @Override
      public Map<String, Object> adminMemberList(Map<String, Object> map) throws Exception {
         return adminMemberDAO.adminMemberList(map);
      }
      
      //관리자 - 회원 상세보기, 신고내역
      @Override
      public List<Map<String, Object>> adminMemberDetail(Map<String,Object> map) throws Exception {
         return adminMemberDAO.adminMemberDetail(map);
      }
      
      //관리자 - 회원 상세보기, 신고내역
      @Override
      public List<Map<String, Object>> adminMemberReport(Map<String,Object> map) throws Exception {
         return adminMemberDAO.adminMemberReport(map);
      }
      
      //관리자 - 신고 내역 삭제
      @Override
      public void adminMemberReportDelete(Map<String, Object> map) throws Exception {
         adminMemberDAO.adminMemberReportDelete(map);
      }
      
      //관리자 - 회원 정지
      @Override
      public void adminMemberStop(Map<String, Object> map) throws Exception {
         adminMemberDAO.adminMemberStop(map);
      }
}