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
import web.mj.baseballGameApi.domain.game.Pitching;
import web.mj.baseballGameApi.service.ChatService;
import web.mj.baseballGameApi.service.GameService;
import web.mj.baseballGameApi.web.dto.GameResponseDto;
import web.mj.baseballGameApi.web.dto.PitchRequestDto;
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

    public WebSockChatHandler(ObjectMapper objectMapper, ChatService chatService, GameService gameService) {
        this.objectMapper = objectMapper;
        this.chatService = chatService;
        this.gameService = gameService;
    }

    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        String payload = message.getPayload();
        logger.info("payload: {}", payload);

        // TODO: Request에서 받아온 teamId, gameId로 pitching data DB에 저장
        PitchRequestDto pitchRequestDto = objectMapper.readValue(payload, PitchRequestDto.class);

        PitchResultDto resultDto = new PitchResultDto(new Pitching().result());

        handleActions(session, resultDto, gameService);
    }

    public void handleActions(WebSocketSession session, PitchResultDto pitch, GameService gameService) {

//        if (pitch.getResult().equals("join")) {
//            // TODO: 추후 전달하는 매개변수는 pitch가 아닌 다른 것
//            handleJoining(session, pitch);
//        } else {
//            handlePitching(pitch);
//        }

            handleJoining(session, pitch);
            handlePitching(pitch);
    }

    public <T> void sendMessage(T message, GameService gameService) {
        sessions.parallelStream().forEach(session -> gameService.sendMessage(session, message));
    }

    public void handleJoining(WebSocketSession session, PitchResultDto pitch) {
        // TODO: join에 대한 객체는 pitchResultDto가 아니라 다른 객체로 처리
        sessions.add(session);
//        sendMessage(pitch, gameService);
    }

    public void handlePitching(PitchResultDto pitch) {
        if (pitch.getResult().equals("strike")) {
            sendMessage(pitch, gameService);
        }

        if (pitch.getResult().equals("hit")) {
            sendMessage(pitch, gameService);
        }

        if (pitch.getResult().equals("ball")) {
            sendMessage(pitch, gameService);
        }
    }


}
