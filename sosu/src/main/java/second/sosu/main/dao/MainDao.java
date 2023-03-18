//강승현 02/17
package second.sosu.main.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Repository;

import second.sosu.common.dao.AbstractDAO;
import second.sosu.common.domain.CommandMap;

@Repository("mainDao")
public class MainDao extends AbstractDAO {

   // 메인에서 보이는 모임, 리뷰, 자유게시판 리스트(4개씩)
   @SuppressWarnings("unchecked")
   public List<Map<String, Object>> moimList(Map<String, Object> map, CommandMap commandMap, HttpSession session) throws Exception {

      List<Map<String, Object>> moimList = (List<Map<String, Object>>) selectList("moim.moimList", map);
      
         // 스크랩 유무
         if (session.getAttribute("M_IDX") != null) {

            for (int i = 0; i < moimList.size(); i++) {

               Map<String, Object> moimZzim = new HashMap<>();
               moimZzim.put("M_IDX", session.getAttribute("M_IDX"));
               moimZzim.put("MO_IDX", moimList.get(i).get("MO_IDX"));

               Map<String, Object> zz = (Map<String, Object>) selectOne("moim.moimZzimCheck", moimZzim);

               moimList.get(i).put("MZ_CHECK", zz.get("MZ_CHECK"));
            }

         }

         // 모임 현재 멤버 수
         for (int i = 0; i < moimList.size(); i++) {
            Map<String, Object> moimMemCount = (Map<String, Object>) selectOne("moim.moimMemberCount",
                  moimList.get(i).get("MO_IDX"));
            moimList.get(i).put("MOMEM_COUNT", moimMemCount.get("MOMEM_COUNT"));
         }
         // 모임 스크랩 수
         for (int i = 0; i < moimList.size(); i++) {

            Map<String, Object> moimZzimCount = (Map<String, Object>) selectOne("moim.moimZzimCount",
                  moimList.get(i).get("MO_IDX"));
            moimList.get(i).put("MZ_COUNT", moimZzimCount.get("MZ_COUNT"));
         }
         
         //프사
         for (int i = 0; i < moimList.size(); i++) {
            Map<String, Object> memberProfile = (Map<String, Object>) selectOne("file.memberProfile",
                  moimList.get(i).get("M_IDX"));
            moimList.get(i).put("PROFILE", memberProfile.get("PROFILE"));
         }

         return moimList;

      }
   
   
   //자유게시판
   @SuppressWarnings("unchecked")
   public List<Map<String, Object>> freeList(Map<String, Object> map, HttpSession session) throws Exception {

      List<Map<String, Object>> freeList = (List<Map<String, Object>>) selectList("freeboard.freeList", map);
      
      //좋아요 유무
      if (session.getAttribute("M_IDX") != null) {

          for (int i = 0; i < freeList.size(); i++) {
             
             Map<String, Object> freeZzim = new HashMap<>();
             freeZzim.put("M_IDX", session.getAttribute("M_IDX"));
             freeZzim.put("FR_IDX", freeList.get(i).get("FR_IDX"));
             
             Map<String, Object> zz = (Map<String, Object>)selectOne("freeboard.freeZzimCheck",freeZzim);
             
             freeList.get(i).put("FZ_CHECK", zz.get("FZ_CHECK"));
          }
          
       }
      
      // 자유게시판 좋아요
      for (int i = 0; i < freeList.size(); i++) {

         Map<String, Object> zzimFreeCount = (Map<String, Object>) selectOne("freeboard.zzimFree",
               freeList.get(i).get("FR_IDX"));
         freeList.get(i).put("FRZ_COUNT", zzimFreeCount.get("FRZ_COUNT"));
      }
      //프사
      for (int i = 0; i < freeList.size(); i++) {
         Map<String, Object> memberProfile = (Map<String, Object>) selectOne("file.memberProfile",
               freeList.get(i).get("M_IDX"));
         freeList.get(i).put("PROFILE", memberProfile.get("PROFILE"));
      }

      return freeList;
   }
   
   //리뷰
   @SuppressWarnings("unchecked")
   public List<Map<String, Object>> reviewList(Map<String, Object> map, HttpSession session) throws Exception {

      List<Map<String, Object>> reviewList = (List<Map<String, Object>>) selectList("review.reviewList", map);
      
      //좋아요 유무
      if (session.getAttribute("M_IDX") != null) {

          for (int i = 0; i < reviewList.size(); i++) {
             
             Map<String, Object> reviewZzim = new HashMap<>();
             reviewZzim.put("M_IDX", session.getAttribute("M_IDX"));
             reviewZzim.put("RV_IDX", reviewList.get(i).get("RV_IDX"));
             
             Map<String, Object> zz = (Map<String, Object>)selectOne("review.reviewZzimCheck",reviewZzim);
             
             reviewList.get(i).put("RZ_CHECK", zz.get("RZ_CHECK"));
          }
          
       }
      // 리뷰 좋아요
      for (int i = 0; i < reviewList.size(); i++) {

         Map<String, Object> zzimFreeCount = (Map<String, Object>) selectOne("review.reviewZzimCount",
               reviewList.get(i).get("RV_IDX"));
         reviewList.get(i).put("RZ_COUNT", zzimFreeCount.get("RZ_COUNT"));
      }
      
      //프사
      for (int i = 0; i < reviewList.size(); i++) {
         Map<String, Object> memberProfile = (Map<String, Object>) selectOne("file.memberProfile",
               reviewList.get(i).get("M_IDX"));
         reviewList.get(i).put("PROFILE", memberProfile.get("PROFILE"));
      }

      return reviewList;
   }

}