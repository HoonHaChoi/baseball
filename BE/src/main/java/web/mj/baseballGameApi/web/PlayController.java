package web.mj.baseballGameApi.web;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.*;
import web.mj.baseballGameApi.service.GameService;
import web.mj.baseballGameApi.service.PitchService;
import web.mj.baseballGameApi.web.dto.OccupyTeamRequestDto;
import web.mj.baseballGameApi.web.dto.ResultResponseDto;

@RestController
@RequestMapping("/api")
public class PlayController {

    private final Logger logger = LoggerFactory.getLogger(PlayController.class);

    public final GameService gameService;
    private final PitchService pitchService;

    public PlayController(GameService gameService, PitchService pitchService) {
        this.gameService = gameService;
        this.pitchService = pitchService;
    }
    @PatchMapping("/occupy")
    public ResultResponseDto occupyTeam(@RequestBody OccupyTeamRequestDto requestDto){
        logger.info("특정 팀 선정 요청");

        return gameService.occupyTeamForHttp(requestDto);
    }

    @GetMapping("/pitch")
    public ResultResponseDto viewGameStatus(@RequestParam Long gameId, @RequestParam Long teamId){
        logger.info("투구 결과 요청");

        return pitchService.pitchingResultToHttp(gameId, teamId);
    }
}
