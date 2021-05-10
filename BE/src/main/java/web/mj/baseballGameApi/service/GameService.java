package web.mj.baseballGameApi.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import web.mj.baseballGameApi.domain.chat.ChatRoom;
import web.mj.baseballGameApi.domain.game.Game;
import web.mj.baseballGameApi.domain.game.GameRepository;
import web.mj.baseballGameApi.domain.team.TeamRepository;
import web.mj.baseballGameApi.web.WebSockChatHandler;
import web.mj.baseballGameApi.web.dto.GameResponseDto;
import web.mj.baseballGameApi.web.dto.PitchResultDto;
import web.mj.baseballGameApi.web.dto.TeamResponseDto;

import javax.annotation.PostConstruct;
import java.io.IOException;
import java.util.*;
import java.util.stream.Collectors;

@Service
public class GameService {

    private Logger logger = LoggerFactory.getLogger(WebSockChatHandler.class);

    private final ObjectMapper objectMapper;
    public final GameRepository gameRepository;
    public final TeamRepository teamRepository;
    private Map<Long, Game> games;

    public GameService(GameRepository gameRepository, TeamRepository teamRepository, ObjectMapper objectMapper, Map<Long, Game> games){
        this.gameRepository = gameRepository;
        this.teamRepository = teamRepository;
        this.objectMapper = objectMapper;
        this.games = games;
    }

    @PostConstruct
    private void init() {
        games = new LinkedHashMap<>();
    }

//    public List<GameResponseDto> findAllGames(){
//        return gameRepository.findAll().stream()
//                .map(game -> new GameResponseDto(game, getTeamResponseDtos(game.getId())))
//                .collect(Collectors.toList());
//    }

    public List<Game> findAllGames(){
        return new ArrayList<>(games.values());
    }

    public GameResponseDto findOneGame(Long id) {
        return new GameResponseDto(findGameById(id), getTeamResponseDtos(id));
    }

    private List<TeamResponseDto> getTeamResponseDtos(Long id){
        return teamRepository.findAllByGameId(id).stream()
                .map(TeamResponseDto::new)
                .collect(Collectors.toList());
    }

//    public Game findGameById(Long id) {
//        return gameRepository.findById(id).get();
//    }

    public Game findGameById(Long id) {
        return games.get(id);
    }

    public Game createGame() {
        Game game = new Game(5L);
        games.put(game.getId(), game);
        return game;
    }

    public PitchResultDto pitch(Long gameId, Long teamId) {

        return new PitchResultDto("strike", gameId, teamId);
    }

    public <T> void sendMessage(WebSocketSession session, T message) {
        try {
            session.sendMessage(new TextMessage(objectMapper.writeValueAsString(message)));
        } catch (IOException e) {
            logger.error(e.getMessage(), e);
        }
    }

}
