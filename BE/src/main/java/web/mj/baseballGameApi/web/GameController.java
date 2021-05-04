package web.mj.baseballGameApi.web;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import web.mj.baseballGameApi.domain.game.Game;
import web.mj.baseballGameApi.domain.game.GameRepository;
import web.mj.baseballGameApi.web.dto.GameResponseDto;

import java.util.List;

@RestController
@RequestMapping("/api/games")
public class GameController {
    private final Logger logger = LoggerFactory.getLogger(GameController.class);

    public final GameRepository gameRepository;

    public GameController(GameRepository gameRepository){
        this.gameRepository = gameRepository;
    }

    @GetMapping()
    public List<Game> viewAllGames(){
        logger.info("모든 게임 요청");
        return (List<Game>) gameRepository.findAll();
    }
}
