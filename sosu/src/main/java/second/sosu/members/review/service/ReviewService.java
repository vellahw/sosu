package second.sosu.members.review.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import second.sosu.common.domain.CommandMap;

public interface ReviewService {

//   리뷰 전체 페이지
   List<Map<String, Object>> reviewList(Map<String, Object> map, HttpSession session) throws Exception;
//   리뷰 상세보기
   Map<String, Object> reviewDetail(Map<String, Object> map) throws Exception;
//   리뷰 상세보기(사진)
   List<Map<String, Object>> reviewPhotoList(Map<String, Object> map) throws Exception;
//   리뷰 상세보기(프로필사진)
   Map<String, Object> memberProfile(Map<String, Object> map) throws Exception;
//   리뷰 작성(+이미지)
   void insertReview(Map<String, Object> map, HttpServletRequest request) throws Exception;
//   리뷰 수정(+이미지)
  // void updateReview(Map<String, Object> map, HttpServletRequest request) throws Exception;
//   리뷰 삭제   
   void deleteReview(Map<String, Object> map) throws Exception;
   
   void updateReview(Map<String, Object> map) throws Exception;
   
   public void updateReviewMain(Map<String, Object> map, HttpServletRequest request) throws Exception;
}