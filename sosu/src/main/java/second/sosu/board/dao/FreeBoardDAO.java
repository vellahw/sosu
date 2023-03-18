package second.sosu.board.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Repository;

import second.sosu.common.dao.AbstractDAO;
import second.sosu.common.domain.CommandMap;

@Repository("freeboardDAO")
public class FreeBoardDAO extends AbstractDAO {

	// 자유게시판 리스트
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> freeList(Map<String, Object> map, HttpSession session) throws Exception {
		List<Map<String, Object>> freeList = (List<Map<String, Object>>) selectList("freeboard.freeList", map);

		// 좋아요 유무
		if (session.getAttribute("M_IDX") != null) {

			for (int i = 0; i < freeList.size(); i++) {

				Map<String, Object> freeZzim = new HashMap<>();
				freeZzim.put("M_IDX", session.getAttribute("M_IDX"));
				freeZzim.put("FR_IDX", freeList.get(i).get("FR_IDX"));

				Map<String, Object> zz = (Map<String, Object>) selectOne("freeboard.freeZzimCheck", freeZzim);

				freeList.get(i).put("FZ_CHECK", zz.get("FZ_CHECK"));
			}
		}

		// 프사
		for (int i = 0; i < freeList.size(); i++) {
			Map<String, Object> freemember = (Map<String, Object>) selectOne("freeboard.freeMemberList",
					freeList.get(i).get("M_IDX"));
			freeList.get(i).put("PROFILE", freemember.get("PROFILE"));
		}
		// 찜
		for (int i = 0; i < freeList.size(); i++) {
			Map<String, Object> zzimFree = (Map<String, Object>) selectOne("freeboard.zzimFree",
					freeList.get(i).get("FR_IDX"));
			freeList.get(i).put("FRZ_COUNT", zzimFree.get("FRZ_COUNT"));
		}
		return freeList;
	}

//   //자유게시판 페이징 리스트
//   @SuppressWarnings("unchecked")
//   public Map<String, Object>freeList(Map<String, Object> map, HttpSession session) throws Exception {
//      //Map<String, Object> freeList = (Map<String, Object>)selectPagingList("freeboard.freeList", map);
//      
//   }

	// 자유게시판 리스트 이미지
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> freeListImg(Map<String, Object> map, CommandMap commandMap) throws Exception {
		return selectList("freeboard.freeListImg", map);
	}

	// 자유게시글 상세
	@SuppressWarnings("unchecked")
	public Map<String, Object> freeDetail(Map<String, Object> map) throws Exception {
		return (Map<String, Object>) selectOne("freeboard.freeDetail", map);
	}

	// 자유게시글 상세 이미지
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> freeDetailImg(Map<String, Object> map, CommandMap commandMap) throws Exception {
		return selectList("freeboard.freeDetailImg", map);
	}

	// 자유게시글 작성
	public void insertFree(Map<String, Object> map, HttpSession session) throws Exception {
		insert("freeboard.insertFree", map);
	}

	// 자유게시판 이미지 등록
	public void freeImg(Map<String, Object> map) throws Exception {
		insert("file.imgInsert", map);
	}

	// 자유게시글 수정
	public void updateFree(Map<String, Object> map) throws Exception {
		update("freeboard.updateFree", map);
	}

	// 자유게시글 삭제
	public void deleteFree(Map<String, Object> map) throws Exception {
		update("freeboard.deleteFree", map);
	}

	// 자유게시판 이미지 삭제
	public void freeImgDelete(String F_SVNAME) throws Exception {
		update("file.FileDelete", F_SVNAME);
	}

	// 자유게시글 프로필 리스트
	public void freeMemberList(Map<String, Object> map, HttpSession session) throws Exception {
		insert("freeboard.freeMemberList", map);
	}

	// 자유게시판 검색
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> freeSearch(Map<String, Object> map) throws Exception {
		return (List<Map<String, Object>>) selectList("freeboard.freeSearch", map);
	}
}