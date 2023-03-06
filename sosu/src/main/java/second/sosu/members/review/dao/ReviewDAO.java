package second.sosu.members.review.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Repository;

import second.sosu.common.dao.AbstractDAO;
import second.sosu.common.domain.CommandMap;

@Repository("reviewDAO")
public class ReviewDAO extends AbstractDAO {

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


//   리뷰 상세보기
   @SuppressWarnings("unchecked")
   public Map<String, Object> reviewDetail(Map<String, Object> map) throws Exception {

      return (Map<String, Object>) selectOne("review.reviewDetail", map);
   }

//   리뷰 상세보기(사진)
   @SuppressWarnings("unchecked")
   public List<Map<String, Object>> reviewPhotoList(Map<String, Object> map) throws Exception {

      return (List<Map<String, Object>>) selectList("review.reviewPhotoList", map);
   }

//   리뷰 상세보기(프로필 사진)   
   @SuppressWarnings("unchecked")
   public Map<String, Object> memberProfile(Map<String, Object> map) throws Exception {

      return (Map<String, Object>) selectOne("file.memberProfile", map);
   }

//   리뷰 작성
   public void insertReview(Map<String, Object> map) throws Exception {

      insert("review.insertReview", map);
   }
   
 @SuppressWarnings("unchecked")
 public List<Map<String, Object>> max(Map<String, Object> map) throws Exception {

    return (List<Map<String, Object>>) selectList("review.max", map);
 }

//   리뷰 사진 파일 등록
   public void imgInsert(Map<String, Object> map) throws Exception {
      insert("file.imgInsert", map);
   }

//   리뷰 수정
   public void updateReview(Map<String, Object> map) throws Exception {

      update("review.updateReview", map);
   }

//   리뷰 사진 파일 수정
   public void updatePhotoReview(Map<String, Object> map) throws Exception {
      update("review.updatePhotoReview", map);
   }

//   리뷰 사진 파일 수정
   public void deletePhotoReview(Map<String, Object> map) throws Exception {
      update("review.deletePhotoReview", map);
   }

//   리뷰 삭제
   public void deleteReview(Map<String, Object> map) throws Exception {

      update("review.deleteReview", map);
   }
   
   public void updateReviewMain(Map<String, Object> map) throws Exception {

         update("review.updateReviewMain", map);
      }
      

}