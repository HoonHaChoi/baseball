package web.mj.baseballGameApi.domain.game;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.annotation.Id;
import org.springframework.web.socket.WebSocketSession;
import web.mj.baseballGameApi.domain.chat.ChatMessage;
import web.mj.baseballGameApi.domain.team.Team;
import web.mj.baseballGameApi.service.GameService;
import web.mj.baseballGameApi.web.WebSockChatHandler;
import web.mj.baseballGameApi.web.dto.PitchResultDto;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class Game {


    private Logger logger = LoggerFactory.getLogger(WebSockChatHandler.class);

    private Long id;
    private Set<WebSocketSession> sessions = new HashSet<>();

    public Game() {
    }
    public Game(Long id) {
        this.id = id;
    }

    public Long getId() {
        return id;
    }

    public void handleActions(WebSocketSession session, PitchResultDto pitch, GameService gameService) {
        if (pitch.getResult().equals("strike")) {
            sessions.add(session);
            logger.info("game join !! pitchresult: {}", pitch.getResult());
        }
        sendMessage("game join", gameService);
    }

    public <T> void sendMessage(T message, GameService gameService) {
        sessions.parallelStream().forEach(session -> gameService.sendMessage(session, message));
    }

}

