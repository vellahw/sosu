
package second.sosu.main.sevice;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import second.sosu.common.domain.CommandMap;
import second.sosu.main.dao.MainDao;

@Service("mainService")
public class MainServiceImpl implements MainService {

	Logger log = Logger.getLogger(this.getClass());

	@Resource(name = "mainDao")
	private MainDao mainDao;

	@Override
	public List<Map<String, Object>> moimList(Map<String, Object> map, HttpSession session, CommandMap commandMap) throws Exception {
		// TODO Auto-generated method stub
		return mainDao.moimList(map, commandMap, session);

	}

	@Override
	public List<Map<String, Object>> freeList(Map<String, Object> map, HttpSession session) throws Exception {
		// TODO Auto-generated method stub
		return mainDao.freeList(map, session);

	}

	@Override
	public List<Map<String, Object>> reviewList(Map<String, Object> map,  HttpSession session) throws Exception {
		// TODO Auto-generated method stub
		return mainDao.reviewList(map, session);

	}

}
