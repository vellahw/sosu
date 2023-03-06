package second.sosu.board.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import second.sosu.common.domain.CommandMap;

public interface FreeBoardService {
   
   //자유게시판 리스트
   List<Map<String, Object>>freeList(Map<String, Object> map, HttpSession session) throws Exception;
   
   //자유게시판 페이징 리스트
   //Map<String, Object>freeList(Map<String, Object> map, HttpSession session) throws Exception;

   //자유게시글 상세
   Map<String, Object>freeDetail(Map<String, Object> map) throws Exception; 
   
   //자유게시글 상세 이미지
   List<Map<String, Object>>freeDetailImg(Map<String, Object> map, CommandMap commandMap) throws Exception;
   
   //자유게시글 작성
   void insertFree(Map<String, Object> map, HttpSession session, HttpServletRequest request) throws Exception;
   
   //자유게시글 수정
   void updateFree(Map<String, Object> map, HttpSession session, HttpServletRequest request) throws Exception;
   
   //자유게시글 삭제
   void deleteFree(Map<String, Object> map) throws Exception;
   
   //자유게시글 이미지 삭제
   void freeImgDelete(String F_SVNAME) throws Exception;
   
   //자유게시글 프로필 리스트
   void freeMemberList(Map<String, Object> map, HttpSession session) throws Exception;
   
   //자유게시판 검색
   List<Map<String, Object>>freeSearch(Map<String, Object> map) throws Exception;
}