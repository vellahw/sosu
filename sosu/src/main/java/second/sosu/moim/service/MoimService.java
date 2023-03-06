package second.sosu.moim.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import second.sosu.common.domain.CommandMap;

public interface MoimService {

   // 모임 리스트
   List<Map<String, Object>> moimList(Map<String, Object> map, HttpSession session) throws Exception;

   // 모임 검색 리스트
   List<Map<String, Object>> moimSearchList(Map<String, Object> map, HttpSession session, CommandMap commandMap)
         throws Exception;

   // 모임 갯수
   Map<String, Object> moimCount(Map<String, Object> map) throws Exception;

   // 페이징을 위한 모임 토탈 카운트
   int moimTotalCount(Map<String, Object> map);

   // 모임에 참가한 인원 리스트
   List<Map<String, Object>> moimMemberList(Map<String, Object> map, CommandMap commandMap) throws Exception;

   // 모임참여에 대기중인 인원 리스트
   List<Map<String, Object>> moimMemberWait(Map<String, Object> map, CommandMap commandMap) throws Exception;

   // 모임 참여승인
   void moimWaitApprove(Map<String, Object> map) throws Exception;

   // 모임 멤버 강퇴
   void moimMemberBan(Map<String, Object> map) throws Exception;

   // 모임 상세보기
   Map<String, Object> moimDetail(Map<String, Object> map, HttpSession session) throws Exception;

   // 모임 상세 이미지
   List<Map<String, Object>> selectMoimImg(Map<String, Object> map, CommandMap commandMap) throws Exception;

   // 모임 개설
   void moimRegister(Map<String, Object> map, HttpSession session, HttpServletRequest request) throws Exception;

   // 모임 참가
   void moimJoin(Map<String, Object> map, HttpSession session, CommandMap commandMap) throws Exception;

   // 모임 참가 요청
   void moimJoinPermit(Map<String, Object> map, HttpSession session, CommandMap commandMap) throws Exception;
   
   // 모임 재참여
   void moimReJoin(Map<String, Object> map, HttpSession session, CommandMap commandMap) throws Exception;
   
   // 모임 재참여 대기
   void moimRePermit(Map<String, Object> map, HttpSession session, CommandMap commandMap) throws Exception;

   // 모임 수정
   void moimModify(Map<String, Object> map, HttpServletRequest request) throws Exception;

   // 모임 이미지 삭제
   void MoimImgDelete(String F_SVNAME) throws Exception;

   // 모임 삭제
   void moimDelete(Map<String, Object> map) throws Exception; // 추후 세션추가

   // 모임 조기 마감
   void moimSelfClose(Map<String, Object> map) throws Exception;

   // 모임 자동 마감
   void moimClose() throws Exception;

   // 모임 탈퇴하기
   void moimExit(Map<String, Object> map, HttpSession session) throws Exception;

}