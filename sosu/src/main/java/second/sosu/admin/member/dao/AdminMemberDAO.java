package second.sosu.admin.member.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import second.sosu.common.dao.AbstractDAO;

@Repository("adminMemberDAO")
public class AdminMemberDAO extends AbstractDAO {
   //관리자 - 회원 기본 리스트
      @SuppressWarnings("unchecked")
      public Map<String, Object> adminMemberList(Map<String, Object> map) throws Exception{
         
         if(map.get("listType").equals("adminMemberList")) {
         return (Map<String, Object>)selectPagingList("members.adminMemberList",map);
      }else if(map.get("listType").equals("adminReportMemberList")) {
         return (Map<String, Object>)selectPagingList("members.adminReportMemberList",map);
      }else {
         return (Map<String, Object>)selectPagingList("members.adminStopMemberList",map);
      }
      }
      
      //관리자 - 정지처리
      public void adminMemberStop(Map<String, Object> map) throws Exception{
         if(map.get("STOP_YN").equals("Y")) {
            update("members.adminMemberStop", map);
         }else {
            update("members.adminMemberStopCancle", map);
         }      
      }
      
      // 관리자 - 회원 상세보기
      @SuppressWarnings("unchecked")
      public List<Map<String,Object>> adminMemberDetail(Map<String,Object> map) throws Exception{
         return (List<Map<String,Object>>)selectList("members.adminMemberDetail", map);
      }
      
      // 관리자 - 회원 신고 내역
      @SuppressWarnings("unchecked")
      public List<Map<String,Object>> adminMemberReport(Map<String,Object> map) throws Exception{

         List<Map<String,Object>> reportMap = (List<Map<String,Object>>)selectList("members.adminMemberReport", map);
         
         for(int i=0 ; i<reportMap.size() ; i++) {
            Map<String,Object> m = new HashMap<>();
            m.put("M_IDX", reportMap.get(i).get("R_MEM"));
            List<Map<String,Object>> list = (List<Map<String,Object>>)selectList("members.adminMemberDetail", m.get("M_IDX"));
            reportMap.get(i).put("M_NICKNAME",list.get(0).get("M_NICKNAME"));
         }
         return reportMap;
      }
      
      // 관리자 - 신고 내역 삭제
      public void adminMemberReportDelete(Map<String,Object> map) throws Exception{
         update("members.adminMemberReportDelete",map);
      }
}