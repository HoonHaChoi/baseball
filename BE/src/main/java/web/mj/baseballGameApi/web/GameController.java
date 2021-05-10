package web.mj.baseballGameApi.web;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.*;
import web.mj.baseballGameApi.domain.game.Game;
import web.mj.baseballGameApi.service.GameService;

import java.util.List;

@RestController
public class GameController {
    private final Logger logger = LoggerFactory.getLogger(GameController.class);

    public final GameService gameService;

    public GameController(GameService gameService){
        this.gameService = gameService;
    }

    @GetMapping("/api/games")
    public List<Game> viewAllGames(){
        logger.info("모든 게임 요청");

        return gameService.findAllGames();
    }

    @PostMapping("/api/games")
    public Game createGame() {
        return gameService.createGame();
    }

//    @GetMapping("/pitch")
//    public PitchResultDto viewPitchResult(@RequestParam Long gameId, @RequestParam Long teamId){
//        logger.info("pitch");
//
//        return gameService.pitch();
//    }


}
