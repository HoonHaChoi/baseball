package web.mj.baseballGameApi.domain.game;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.annotation.Id;
import org.springframework.data.annotation.Transient;
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

    @Id
    private Long id;

    public Game() {
    }
    public Game(Long id) {
        this.id = id;
    }

    public Long getId() {
        return id;
    }
}

