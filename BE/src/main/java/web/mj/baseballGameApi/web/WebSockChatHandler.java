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
import web.mj.baseballGameApi.domain.game.Game;
import web.mj.baseballGameApi.service.ChatService;
import web.mj.baseballGameApi.service.GameService;
import web.mj.baseballGameApi.web.dto.GameResponseDto;
import web.mj.baseballGameApi.web.dto.PitchResultDto;

import java.util.HashSet;
import java.util.Set;

@Component
public class WebSockChatHandler extends TextWebSocketHandler {
    private Logger logger = LoggerFactory.getLogger(WebSockChatHandler.class);
    private Set<WebSocketSession> sessions = new HashSet<>();

    private final ObjectMapper objectMapper;
    private final ChatService chatService;
    private final GameService gameService;

    public WebSockChatHandler(ObjectMapper objectMapper, ChatService chatService, GameService gameService){
        this.objectMapper = objectMapper;
        this.chatService = chatService;
        this.gameService = gameService;
    }

    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        String payload = message.getPayload();
        logger.info("payload: {}", payload);

        PitchResultDto pitchResult = objectMapper.readValue(payload, PitchResultDto.class);

        handleActions(session, pitchResult, gameService);
    }

    public void handleActions(WebSocketSession session, PitchResultDto pitch, GameService gameService) {
        if (pitch.getResult().equals("strike")) {
            sessions.add(session);
        }
        sendMessage("game join", gameService);
    }

    public <T> void sendMessage(T message, GameService gameService) {
        sessions.parallelStream().forEach(session -> gameService.sendMessage(session, message));
    }
}
