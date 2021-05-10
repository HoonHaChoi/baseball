package web.mj.baseballGameApi.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import web.mj.baseballGameApi.domain.chat.ChatRoom;
import web.mj.baseballGameApi.web.WebSockChatHandler;

import javax.annotation.PostConstruct;
import java.io.IOException;
import java.util.*;

@Service
public class ChatService {

    private Logger logger = LoggerFactory.getLogger(WebSockChatHandler.class);

    private final ObjectMapper objectMapper;
    private Map<String, ChatRoom> chatRooms;

    public ChatService(ObjectMapper objectMapper, Map<String, ChatRoom> chatRooms){
        this.objectMapper = objectMapper;
        this.chatRooms = chatRooms;
    }

    @PostConstruct
    private void init() {
        chatRooms = new LinkedHashMap<>();
    }

    public List<ChatRoom> findAllRoom() {
        return new ArrayList<>(chatRooms.values());
    }

    public ChatRoom findRoomById(String roomId) {
        return chatRooms.get(roomId);
    }

    public ChatRoom createRoom(String name) {
        String randomId = UUID.randomUUID().toString();
        ChatRoom chatRoom = new ChatRoom(randomId, name);
        chatRooms.put(randomId, chatRoom);
        return chatRoom;
    }

    public <T> void sendMessage(WebSocketSession session, T message) {
        try {
            session.sendMessage(new TextMessage(objectMapper.writeValueAsString(message)));
        } catch (IOException e) {
            logger.error(e.getMessage(), e);
        }
    }
}
