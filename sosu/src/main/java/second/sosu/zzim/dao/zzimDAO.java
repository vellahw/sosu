package second.sosu.zzim.dao;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Repository;

import second.sosu.common.dao.AbstractDAO;
import second.sosu.common.domain.CommandMap;

@Repository("zzimDAO")
public class zzimDAO extends AbstractDAO {

	// 모임 찜 insert
	public void zzimInsert(Map<String, Object> map, HttpSession seesion, CommandMap commandMap) throws Exception {
		insert("common.zzimInsert", map);
	}

	// 모임 찜 삭제
	public void zzimDelete(Map<String, Object> map, HttpSession seesion, CommandMap commandMap) throws Exception {
		delete("common.zzimDelete", map);
	}
}