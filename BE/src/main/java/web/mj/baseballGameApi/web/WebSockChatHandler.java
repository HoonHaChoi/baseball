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

@Component
public class WebSockChatHandler extends TextWebSocketHandler {
    private Logger logger = LoggerFactory.getLogger(WebSockChatHandler.class);

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
        // GameResponseDto는 ChatMessage와 같은 방식으로 변경
        // GameResponseDto의 형식을 통해 Json 형태로 클라이언트에게 입력 받음
        PitchResultDto pitchResult = objectMapper.readValue(payload, PitchResultDto.class);
//        ChatRoom room = chatService.findRoomById(chatMessage.getRoomId());
//        room.handleActions(session, chatMessage, chatService);
        Game game = gameService.findGameById(pitchResult.getGameId());

        game.handleActions(session, pitchResult, gameService);
    }
}
