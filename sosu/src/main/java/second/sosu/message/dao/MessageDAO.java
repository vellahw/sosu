package second.sosu.message.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import second.sosu.common.dao.AbstractDAO;

@Repository("messageDAO")
public class MessageDAO extends AbstractDAO{

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> messageList(Map<String, Object> map) throws Exception{
		System.out.println("messageList 쿼리로 전달한 내용 : " + map);
		return (List<Map<String, Object>>) selectList("message.messageList", map); 
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> noOpenMsg(Map<String, Object> map) throws Exception{
		System.out.println("noOpenMsg 쿼리로 전달한 내용 : " + map);
		return (Map<String, Object>) selectOne("message.noOpenMsg", map);
	}


	@SuppressWarnings("unchecked")
	public Map<String, Object> otherNickname(Map<String, Object> map) throws Exception{
		System.out.println("otherNickname쿼리로 전달한 내용 : " + map);
		return (Map<String, Object>) selectOne("message.otherNickname", map);
	}
	
	public void messageInsert(Map<String, Object> map) throws Exception{
	      System.out.println("messageInsert쿼리로 전달한 내용 : " + map);
	      insert("message.messageInsert", map);
	   }
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> chatContent(Map<String, Object> map) throws Exception{
		System.out.println("chatContent 쿼리로 전달한 내용 : " + map);
		return (List<Map<String, Object>>) selectList("message.chatContent", map); 
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> messageRecord(Map<String, Object> map) throws Exception{
		System.out.println("messageRecord쿼리로 전달한 내용 : " + map);
		return (Map<String, Object>) selectOne("message.messageRecord", map);
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> messageRoom(Map<String, Object> map) throws Exception{
		System.out.println("messageRoom쿼리로 전달한 내용 : " + map);
		return (Map<String, Object>) selectOne("message.messageRoom", map);
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> maxRoom() throws Exception{
		System.out.println("maxRoom쿼리로 전달한 내용 :" );
		return (Map<String, Object>) selectOne("message.maxRoom");
	}
	
	//채팅방 번호 받아서 메세지 읽음 처리
	public void messageRead(Map<String, Object> map) throws Exception{
		System.out.println("messageRead 쿼리로 전달한 내용: " + map);
		update("message.messageRead", map);
	}
	
	//방 삭제
	public void deleteRoom(Map<String,Object> map) throws Exception{
	      delete("message.deleteRoom",map);
	}
	
	//메인에서 안읽은 메시지 개수 구해오기
	@SuppressWarnings("unchecked")
	public Map<String, Object> noReadMSG(Map<String, Object> map) throws Exception{
		System.out.println("noReadMSG 쿼리로 전달한 내용 : " + map);
		return (Map<String, Object>) selectOne("message.noReadMSG", map);
	}
	
	//검색
	   @SuppressWarnings("unchecked")
	   public List<Map<String,Object>> searchList(Map<String,Object> map) throws Exception{ 
	      return  (List<Map<String,Object>>)selectList("message.searchList",map);
	   }
	   
}