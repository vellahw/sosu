package second.sosu.message.service;

import java.util.List;
import java.util.Map;

public interface MessageService {
	
	List<Map<String, Object>> messageList(Map<String, Object> map) throws Exception;
	
	Map<String, Object> noOpenMsg(Map<String, Object> map) throws Exception;
	
	Map<String, Object> otherNickname(Map<String, Object> map) throws Exception;
	
	void messageInsert(Map<String,Object> map) throws Exception;
	
	List<Map<String, Object>> chatContent(Map<String, Object> map) throws Exception;
	
	   
	Map<String, Object> messageRecord(Map<String, Object> map) throws Exception;
	
	Map<String, Object> messageRoom(Map<String, Object> map) throws Exception;
	
	Map<String, Object> maxRoom() throws Exception;

	void messageRead(Map<String, Object> map) throws Exception;
	
	public void deleteRoom(Map<String,Object> map) throws Exception;
	
	Map<String, Object> noReadMSG(Map<String, Object> map) throws Exception;
	
	public List<Map<String,Object>> searchList(Map<String,Object> map) throws Exception;
}


