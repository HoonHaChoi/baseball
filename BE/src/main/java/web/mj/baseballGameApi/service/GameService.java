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
import web.mj.baseballGameApi.domain.team.Team;
import web.mj.baseballGameApi.domain.team.TeamRepository;
import web.mj.baseballGameApi.exception.EntityNotFoundException;
import web.mj.baseballGameApi.exception.ErrorMessage;
import web.mj.baseballGameApi.web.WebSockChatHandler;
import web.mj.baseballGameApi.web.dto.*;
import web.mj.baseballGameApi.exception.OccupyFailedException;
import web.mj.baseballGameApi.web.dto.GameResponseDto;
import web.mj.baseballGameApi.web.dto.TeamResponseDto;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class GameService {
    private Logger logger = LoggerFactory.getLogger(WebSockChatHandler.class);

    public final GameRepository gameRepository;
    public final TeamRepository teamRepository;
    private final ObjectMapper objectMapper;

    public GameService(GameRepository gameRepository, TeamRepository teamRepository, ObjectMapper objectMapper) {
        this.gameRepository = gameRepository;
        this.teamRepository = teamRepository;
        this.objectMapper = objectMapper;
    }

    public <T> void sendMessage(WebSocketSession session, T message) {
        try {
            session.sendMessage(new TextMessage(objectMapper.writeValueAsString(message)));
        } catch (IOException e) {
            logger.error(e.getMessage(), e);
        }
    }

    public Game createGame() {
        Game game = new Game();
        return gameRepository.save(game);
    }

    public SocketResponseDto pitch(Pitching pitching) {

        return new SocketResponseDto(pitching.result());
    }

    public List<GameResponseDto> findAllGames() {
        return gameRepository.findAll().stream()
                .map(game -> new GameResponseDto(game, getTeamResponseDtos(game.getId())))
                .collect(Collectors.toList());
    }

    public GameResponseDto findOneGame(Long id) {
        return new GameResponseDto(findGameById(id), getTeamResponseDtos(id));
    }

    public SocketResponseDto occupyTeam(SocketRequestDto requestDto) {
        Team selectedTeam = teamRepository.findById(requestDto.getTeamId()).orElseThrow(
                () -> new EntityNotFoundException(ErrorMessage.TEAM_NOT_FOUND)
        );

        Game game = gameRepository.findById(requestDto.getGameId()).orElseThrow(
                () -> new EntityNotFoundException(ErrorMessage.GAME_NOT_FOUND)
        );

        if (!selectedTeam.occupy()) {
            return new SocketResponseDto("fail");
        }

        game.selectTeam(selectedTeam.getId());

        teamRepository.save(selectedTeam);

        //TODO: Static으로 바꿀
        return new SocketResponseDto("success");
    }

    private List<TeamResponseDto> getTeamResponseDtos(Long id) {
        return teamRepository.findAllByGameId(id).stream()
                .map(TeamResponseDto::new)
                .collect(Collectors.toList());
    }

    public Game findGameById(Long id) {
        return gameRepository.findById(id).orElseThrow(
                () -> new EntityNotFoundException(ErrorMessage.GAME_NOT_FOUND)
        );
    }

    public Team findTeamById(Long id) {
        return teamRepository.findById(id).orElseThrow(
                () -> new EntityNotFoundException(ErrorMessage.TEAM_NOT_FOUND)
        );
    }
}
