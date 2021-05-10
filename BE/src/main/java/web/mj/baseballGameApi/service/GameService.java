package web.mj.baseballGameApi.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import web.mj.baseballGameApi.domain.game.Game;
import web.mj.baseballGameApi.domain.game.GameRepository;
import web.mj.baseballGameApi.domain.game.Pitching;
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

    public GameService(GameRepository gameRepository, TeamRepository teamRepository, ObjectMapper objectMapper, Map<Long, Game> games){
        this.gameRepository = gameRepository;
        this.teamRepository = teamRepository;
        this.objectMapper = objectMapper;
    }

//    public List<GameResponseDto> findAllGames(){
//        return gameRepository.findAll().stream()
//                .map(game -> new GameResponseDto(game, getTeamResponseDtos(game.getId())))
//                .collect(Collectors.toList());
//    }

    public List<Game> findAllGames(){
        return gameRepository.findAll();
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
        return gameRepository.findById(id).orElseThrow(
                () -> new NoSuchElementException()
        );
    }

    public Game createGame() {
        Game game = new Game();
        return gameRepository.save(game);
    }

    public PitchResultDto pitch(Pitching pitching) {

        return new PitchResultDto(pitching.result());
    }

    public <T> void sendMessage(WebSocketSession session, T message) {
        try {
            session.sendMessage(new TextMessage(objectMapper.writeValueAsString(message)));
        } catch (IOException e) {
            logger.error(e.getMessage(), e);
        }
    }

}
