package web.mj.baseballGameApi.web;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.*;
import web.mj.baseballGameApi.domain.game.Game;
import web.mj.baseballGameApi.service.GameService;
import web.mj.baseballGameApi.web.dto.GameDetailResponseDto;
import web.mj.baseballGameApi.web.dto.GameResponseDto;
import web.mj.baseballGameApi.web.dto.GameStatusResponseDto;

import java.util.List;

@RestController
@RequestMapping("/api/games")
public class GameController {
    private final Logger logger = LoggerFactory.getLogger(GameController.class);

    public final GameService gameService;

    public GameController(GameService gameService) {
        this.gameService = gameService;
    }

    @GetMapping
    public List<GameResponseDto> viewAllGames() {
        logger.info("모든 게임 요청");

        return gameService.findAllGames();
    }

    @GetMapping("/{gameId}")
    public GameResponseDto viewOneGame(@PathVariable Long gameId) {
        logger.info("gameId: {} 게임 요청", gameId);

        return gameService.findOneGame(gameId);
    }

    @GetMapping("/status")
    public GameStatusResponseDto viewGameStatus(@RequestParam Long gameId) {
        logger.info("특정 게임 현황 조회");

        return gameService.findGameStatus(gameId);
    }

    @GetMapping("/{gameId}/detail")
    public GameDetailResponseDto viewGameDetail(@PathVariable Long gameId) {
        logger.info("특정 게임 상세 조회");

        return gameService.findGameDetail(gameId);
    }
}
