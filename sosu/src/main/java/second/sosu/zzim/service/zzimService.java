package second.sosu.zzim.service;

import java.util.Map;

import javax.servlet.http.HttpSession;

import second.sosu.common.domain.CommandMap;

public interface zzimService {

	// 모임 찜하기
	void zzimInsert(Map<String, Object> map, HttpSession session, CommandMap commandMap) throws Exception; 

	// 모임 찜하기
	void zzimDelete(Map<String, Object> map, HttpSession session, CommandMap commandMap) throws Exception;

}