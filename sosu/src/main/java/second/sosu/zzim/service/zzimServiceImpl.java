package second.sosu.zzim.service;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

import second.sosu.common.domain.CommandMap;
import second.sosu.moim.dao.MoimDao;
import second.sosu.zzim.dao.zzimDAO;

@Service("zzimService")
public class zzimServiceImpl implements zzimService{
	
	 @Resource(name = "zzimDAO")
	   private zzimDAO zzimDAO;

	@Override
	public void zzimInsert(Map<String, Object> map, HttpSession session, CommandMap commandMap) throws Exception {
		 zzimDAO.zzimInsert(map, session, commandMap);
		
	}

	@Override
	public void zzimDelete(Map<String, Object> map, HttpSession session, CommandMap commandMap) throws Exception {
		 zzimDAO.zzimDelete(map, session, commandMap);
		
	}

}
