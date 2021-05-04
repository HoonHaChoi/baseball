package web.mj.baseballGameApi.web;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import web.mj.baseballGameApi.domain.game.Game;
import web.mj.baseballGameApi.domain.game.GameRepository;
import web.mj.baseballGameApi.domain.team.TeamRepository;
import web.mj.baseballGameApi.web.dto.GameResponseDto;
import web.mj.baseballGameApi.web.dto.TeamResponseDto;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/games")
public class GameController {
    private final Logger logger = LoggerFactory.getLogger(GameController.class);

    public final GameRepository gameRepository;
    public final TeamRepository teamRepository;

    public GameController(GameRepository gameRepository, TeamRepository teamRepository){
        this.gameRepository = gameRepository;
        this.teamRepository = teamRepository;
    }

    @GetMapping
    public List<GameResponseDto> viewAllGames(){
        logger.info("모든 게임 요청");
        return gameRepository.findAll().stream()
                    .map(game -> new GameResponseDto(game, getTeamResponseDtos(game.getId())))
                    .collect(Collectors.toList());
    }

    private List<TeamResponseDto> getTeamResponseDtos(Long id){
        return teamRepository.findAllByGameId(id).stream()
                .map(TeamResponseDto::new)
                .collect(Collectors.toList());
    }
}
