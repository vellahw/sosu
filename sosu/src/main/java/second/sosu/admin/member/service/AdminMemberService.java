package second.sosu.admin.member.service;

import java.util.List;
import java.util.Map;

public interface AdminMemberService {
   
      //관리자 - 회원 기본 리스트
      public Map<String, Object> adminMemberList(Map<String, Object> map) throws Exception;
      
      //관리자 - 회원 상세보기
      public List<Map<String,Object>> adminMemberDetail(Map<String,Object> map) throws Exception;
      
      //관리자 - 신고내역
      public List<Map<String, Object>> adminMemberReport(Map<String,Object> map) throws Exception;
      
      //관리자 - 신고 내역 삭제
      public void adminMemberReportDelete(Map<String,Object> map) throws Exception;
      
      //관리자 - 회원정지
      public void adminMemberStop(Map<String, Object> map) throws Exception;
}