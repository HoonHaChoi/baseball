package web.mj.baseballGameApi.web;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.*;
import web.mj.baseballGameApi.service.GameService;
import web.mj.baseballGameApi.service.OccupyService;
import web.mj.baseballGameApi.service.PitchService;
import web.mj.baseballGameApi.web.dto.OccupyTeamRequestDto;
import web.mj.baseballGameApi.web.dto.ResultResponseDto;

@RestController
@RequestMapping("/api")
public class PlayController {

    private final Logger logger = LoggerFactory.getLogger(PlayController.class);

    public final GameService gameService;
    private final PitchService pitchService;
    private final OccupyService occupyService;

    public PlayController(GameService gameService, PitchService pitchService, OccupyService occupyService) {
        this.gameService = gameService;
        this.pitchService = pitchService;
        this.occupyService = occupyService;
    }

    @PatchMapping("/occupy")
    public ResultResponseDto occupyTeam(@RequestBody OccupyTeamRequestDto requestDto){
        logger.info("특정 팀 선점 요청");

        return occupyService.occupyTeamToHttp(requestDto);
    }

    @PatchMapping("/leave")
    public ResultResponseDto leaveTeam(@RequestBody OccupyTeamRequestDto requestDto){
        logger.info("특정 팀 선점 해제" );

        return occupyService.leaveTeamToHttp(requestDto);
    }

    @GetMapping("/pitch")
    public ResultResponseDto viewGameStatus(@RequestParam Long gameId, @RequestParam Long teamId){
        logger.info("투구 결과 요청");

        return pitchService.pitchingResultToHttp(gameId, teamId);
    }
}
