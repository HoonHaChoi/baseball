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
import web.mj.baseballGameApi.service.GameService;
import web.mj.baseballGameApi.web.dto.GameResponseDto;
import web.mj.baseballGameApi.web.dto.TeamResponseDto;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/games")
public class GameController {
    private final Logger logger = LoggerFactory.getLogger(GameController.class);

    public final GameService gameService;

    public GameController(GameService gameService){
        this.gameService = gameService;
    }

    @GetMapping
    public List<GameResponseDto> viewAllGames(){
        logger.info("모든 게임 요청");

        return gameService.findAllGames();
    }
}
