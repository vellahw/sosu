package second.sosu.message.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import second.sosu.message.dao.MessageDAO;

@Service("messageService")
public class MessageServiceImpl implements MessageService{
	
	Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="messageDAO")
	private MessageDAO messageDAO;
	
	
	
	@Override
	public List<Map<String, Object>> messageList(Map<String, Object> map) throws Exception {
		return messageDAO.messageList(map);
	}



	@Override
	public Map<String, Object> noOpenMsg(Map<String, Object> map) throws Exception {
		return messageDAO.noOpenMsg(map);
	}



	@Override
	public Map<String, Object> otherNickname(Map<String, Object> map) throws Exception {
		return messageDAO.otherNickname(map);
	}

	
	@Override
	public void messageInsert(Map<String, Object> map) throws Exception {
		messageDAO.messageInsert(map);
	   }

	@Override
	public List<Map<String, Object>> chatContent(Map<String, Object> map) throws Exception {
		return messageDAO.chatContent(map);
	}


	@Override
	public Map<String, Object> messageRecord(Map<String, Object> map) throws Exception {
		return messageDAO.messageRecord(map);
	}


	@Override
	public Map<String, Object> messageRoom(Map<String, Object> map) throws Exception {
		return messageDAO.messageRoom(map);
	}

	@Override
	public Map<String, Object> maxRoom() throws Exception {
		return messageDAO.maxRoom();
	}


	@Override
	public void messageRead(Map<String, Object> map) throws Exception {
		messageDAO.messageRead(map);
	}
	
	@Override
	   public void deleteRoom(Map<String, Object> map) throws Exception {
	      messageDAO.deleteRoom(map);
	}

	@Override
	public Map<String, Object> noReadMSG(Map<String, Object> map) throws Exception {
		return messageDAO.noReadMSG(map);
	}
	
	@Override
	   public List<Map<String, Object>> searchList(Map<String, Object> map) throws Exception {
	      return messageDAO.searchList(map);
	   }
	
	
}
