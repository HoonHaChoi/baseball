package web.mj.baseballGameApi.web;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;
import web.mj.baseballGameApi.domain.game.Game;
import web.mj.baseballGameApi.domain.game.Pitching;
import web.mj.baseballGameApi.domain.team.Team;
import web.mj.baseballGameApi.service.GameService;
import web.mj.baseballGameApi.web.dto.SocketRequestDto;
import web.mj.baseballGameApi.web.dto.SocketResponseDto;

import java.util.HashSet;
import java.util.Set;

@Component
public class WebSockChatHandler extends TextWebSocketHandler {
    private Logger logger = LoggerFactory.getLogger(WebSockChatHandler.class);
    private Set<WebSocketSession> sessions = new HashSet<>();

    private final ObjectMapper objectMapper;
    private final GameService gameService;

    public WebSockChatHandler(ObjectMapper objectMapper, GameService gameService) {
        this.objectMapper = objectMapper;
        this.gameService = gameService;
    }

    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        String payload = message.getPayload();
        logger.info("payload: {}", payload);

        // TODO: Request에서 받아온 teamId, gameId로 pitching data DB에 저장
        SocketRequestDto socketRequestDto = objectMapper.readValue(payload, SocketRequestDto.class);


        handleActions(session, socketRequestDto, gameService);
    }

    public void handleActions(WebSocketSession session, SocketRequestDto requestDto, GameService gameService) {

        if (requestDto.getType().equals("join")) {
            handleJoining(session);
        }

        if (requestDto.getType().equals("out")) {
            handleOut();
        }

        if (requestDto.getType().equals("pitch")) {

            SocketResponseDto pitchingResult = gameService.pitch(requestDto.getGameId(), requestDto.getTeamId());

            handlePitching(pitchingResult);
        }

        if (requestDto.getType().equals("occupy")) {

            SocketResponseDto responseDto = gameService.occupyTeam(requestDto);

            handleOccupying(responseDto);
        }
    }

    public <T> void sendMessage(T message, GameService gameService) {
        sessions.parallelStream().forEach(session -> gameService.sendMessage(session, message));
    }

    public void handleJoining(WebSocketSession session) {
        // TODO: join은 occpy 대체하는 것, occupy 응답형태로 구현할 것
        sessions.add(session);
        sendMessage("join", gameService);
    }

    public void handleOut() {
        sendMessage("out", gameService);
        sessions.clear();
    }

    public void handlePitching(SocketResponseDto pitch) {

        if (pitch.getResult().equals("strike")) {
            sendMessage("strike", gameService);
        }

        if (pitch.getResult().equals("hit")) {
            sendMessage("hit", gameService);
        }

        if (pitch.getResult().equals("ball")) {
            sendMessage("ball", gameService);
        }
    }

    public void handleOccupying(SocketResponseDto response) {

        if (response.getResult().equals("success")) {
            sendMessage("success", gameService);
        }

        if (response.getResult().equals("fail")) {
            sendMessage("fail", gameService);
        }
    }


}
