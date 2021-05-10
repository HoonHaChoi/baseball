package web.mj.baseballGameApi.web;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;
import web.mj.baseballGameApi.domain.chat.ChatMessage;
import web.mj.baseballGameApi.domain.chat.ChatRoom;
import web.mj.baseballGameApi.service.ChatService;

@Component
public class WebSockChatHandler extends TextWebSocketHandler {
    private Logger logger = LoggerFactory.getLogger(WebSockChatHandler.class);

    private final ObjectMapper objectMapper;
    private final ChatService chatService;

    public WebSockChatHandler(ObjectMapper objectMapper, ChatService chatService){
        this.objectMapper = objectMapper;
        this.chatService = chatService;
    }

    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        String payload = message.getPayload();
        logger.info("payload: {}", payload);
// 삭제        TextMessage textMessage = new TextMessage("Welcome chatting sever~^^ ");
// 삭제       session.sendMessage(textMessage);
        ChatMessage chatMessage = objectMapper.readValue(payload, ChatMessage.class);
        ChatRoom room = chatService.findRoomById(chatMessage.getRoomId());
        room.handleActions(session, chatMessage, chatService);
    }
}
