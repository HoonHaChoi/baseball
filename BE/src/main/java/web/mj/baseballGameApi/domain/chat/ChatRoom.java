package web.mj.baseballGameApi.domain.chat;

import org.springframework.web.socket.WebSocketSession;
import web.mj.baseballGameApi.service.ChatService;

import java.util.HashSet;
import java.util.Set;

public class ChatRoom {
    private String roomId;
    private String name;
    private Set<WebSocketSession> sessions = new HashSet<>();

    public ChatRoom() {

    }

    public ChatRoom(String roomId, String name) {
        this.roomId = roomId;
        this.name = name;
    }

    public void handleActions(WebSocketSession session, ChatMessage chatMessage, ChatService chatService) {
        if (chatMessage.getType().equals(ChatMessage.MessageType.ENTER)) {
            sessions.add(session);
            chatMessage.setMessage(chatMessage.getSender() + "님이 입장했습니다.");
        }
        sendMessage(chatMessage, chatService);
    }

    public <T> void sendMessage(T message, ChatService chatService) {
        sessions.parallelStream().forEach(session -> chatService.sendMessage(session, message));
    }

    public String getRoomId() {
        return roomId;
    }

    public String getName() {
        return name;
    }

    public Set<WebSocketSession> getSessions() {
        return sessions;
    }
}
