package web.mj.baseballGameApi.web;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import web.mj.baseballGameApi.domain.chat.ChatRoom;
import web.mj.baseballGameApi.domain.game.Game;
import web.mj.baseballGameApi.domain.game.GameRepository;
import web.mj.baseballGameApi.domain.team.TeamRepository;
import web.mj.baseballGameApi.service.GameService;
import web.mj.baseballGameApi.web.dto.GameResponseDto;
import web.mj.baseballGameApi.web.dto.PitchResultDto;
import web.mj.baseballGameApi.web.dto.TeamResponseDto;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

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
