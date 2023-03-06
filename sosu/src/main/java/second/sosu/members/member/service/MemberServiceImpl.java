package second.sosu.members.member.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

import second.sosu.common.util.FileUtils;
import second.sosu.members.member.dao.MemberDAO;

@Service("memberService")
public class MemberServiceImpl implements MemberService{
   
   @Resource(name = "memberDAO")
   private MemberDAO memberDAO;
   
   @Resource(name="fileUtils")
   private FileUtils fileUtils;
   
   //비밀번호 체크
   @Override
   public Map<String, Object> checkPassword(Map<String, Object> map) throws Exception {
      return memberDAO.checkPassword(map);
   }

   //아이디 중복 체크
   @Override
   public int checkId(Map<String, Object> map) throws Exception {
      return memberDAO.checkId(map);
   }
   
   //닉네임 중복 체크
   @Override
   public int checkNickname(Map<String, Object> map) throws Exception {
         return memberDAO.checkNickname(map);
   }

   //회원가입
   @Override
   public void join(Map<String, Object> map) throws Exception {
      memberDAO.join(map);   
   }
   
   //로그인
   @Override
   public Map<String, Object> login(Map<String, Object> map) throws Exception {
      return memberDAO.login(map);
   }
   
   //아이디찾기
   @Override
   public Map<String, Object> findId(Map<String, Object> map) throws Exception {
      return memberDAO.findId(map);
   }
   
   //비밀번호찾기
   @Override
   public Map<String, Object> findPw(Map<String, Object> map) throws Exception {
      return memberDAO.findPw(map);
   }
   
   //마이페이지
   @Override
   public List<List<Map<String,Object>>> mypage(Map<String, Object> map) throws Exception {
      return memberDAO.mypage(map);
   }
   
   // 다른 사람 마이페이지
   @Override
   public List<Map<String,Object>> userMypage(Map<String, Object> map) throws Exception {
      return memberDAO.userMypage(map);
   }
   
   //마이페이지 수정
   @Override
   public void mypageModify(Map<String, Object> map, HttpServletRequest request, HttpSession session) throws Exception {
      if(map.get("GenderCheck").toString().equals("0")==false) {
         memberDAO.profileUpdate(fileUtils.profileInsert(map, request));
      }else {
         if(request!=null) {
            List<Map<String,Object>> list = fileUtils.profileUpdate(map, request);
            for(int i=0,size=list.size() ; i<size ; i++) {
               memberDAO.profileUpdate(list.get(i));
            }
         }
      }
      memberDAO.mypageModify(map);
   }

   //탈퇴하기
   @Override
   public void mypageDelete(Map<String, Object> map) throws Exception {
      memberDAO.mypageDelete(map);
   }
   
   //프로필 사진 여부 확인
   @Override
   public List<Map<String, Object>> profileCheck(Map<String, Object> map) throws Exception {
      return memberDAO.profileCheck(map);
   }
   
   //프로필 기본 사진 등록
   @Override
   public void profileRegister(Map<String, Object> map, HttpServletRequest request) throws Exception {
      memberDAO.profileRegister(fileUtils.profileInsert(map, request));
   }
   
   //프로필 비공개
   @Override
   public void mypagePrivate(Map<String, Object> map) throws Exception {
      memberDAO.mypagePrivate(map);
   }
   
   //신고하기
   @Override
   public void insertReport(Map<String, Object> map) throws Exception {
      memberDAO.insertReport(map);
   }
   
   //찜 삭제
   @Override
   public void deleteZzim(Map<String, Object> map) throws Exception {
      memberDAO.deleteZzim(map);
   }
   
   @Override
   public void zzimRealDelete(Map<String, Object> map) throws Exception {
      memberDAO.zzimRealDelete(map);
   }
   
// 마이페이지 내가 참여한 모임 리뷰 유무
   @Override
   public List<Map<String,Object>> mypageMoimReviewCount(Map<String, Object> map, HttpSession session) throws Exception {
      return memberDAO.mypageMoimReviewCount(map, session);
   }
}   