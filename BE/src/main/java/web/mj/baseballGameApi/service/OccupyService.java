package web.mj.baseballGameApi.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import web.mj.baseballGameApi.domain.game.Game;
import web.mj.baseballGameApi.domain.game.GameRepository;
import web.mj.baseballGameApi.domain.inning.Inning;
import web.mj.baseballGameApi.domain.inning.InningRepository;
import web.mj.baseballGameApi.domain.player.Player;
import web.mj.baseballGameApi.domain.player.PlayerRepository;
import web.mj.baseballGameApi.domain.record.Record;
import web.mj.baseballGameApi.domain.record.RecordRepository;
import web.mj.baseballGameApi.domain.team.Team;
import web.mj.baseballGameApi.domain.team.TeamRepository;
import web.mj.baseballGameApi.exception.EntityNotFoundException;
import web.mj.baseballGameApi.exception.ErrorMessage;
import web.mj.baseballGameApi.web.dto.OccupyTeamRequestDto;
import web.mj.baseballGameApi.web.dto.ResultResponseDto;
import web.mj.baseballGameApi.web.dto.SocketRequestDto;
import web.mj.baseballGameApi.web.dto.SocketResponseDto;

import java.util.List;

@Service
public class OccupyService {
    private Logger logger = LoggerFactory.getLogger(GameService.class);

    public final GameRepository gameRepository;
    public final TeamRepository teamRepository;
    public final InningRepository inningRepository;
    public final RecordRepository recordRepository;
    public final PlayerRepository playerRepository;

    // TODO: ENUM으로 정리, result, position, status
    private static final String PITCHER = "pitcher";
    private static final String BATTER = "batter";
    private static final String SUCCESS = "success";
    private static final String FAIL = "fail";
    private static final String WAIT = "wait";

    public OccupyService(GameRepository gameRepository, TeamRepository teamRepository,
                         InningRepository inningRepository, RecordRepository recordRepository,
                         PlayerRepository playerRepository) {
        this.gameRepository = gameRepository;
        this.teamRepository = teamRepository;
        this.inningRepository = inningRepository;
        this.recordRepository = recordRepository;
        this.playerRepository = playerRepository;
    }

    public SocketResponseDto occupyTeamToSocket(SocketRequestDto requestDto) {
        return new SocketResponseDto(occupyTeam(requestDto.getTeamId(), requestDto.getGameId()));
    }

    public ResultResponseDto occupyTeamToHttp(OccupyTeamRequestDto requestDto) {
        return new ResultResponseDto(occupyTeam(requestDto.getTeamId(), requestDto.getGameId()));
    }

    public SocketResponseDto leaveTeamToSocket(SocketRequestDto requestDto) {
        return new SocketResponseDto(leaveTeam(requestDto.getTeamId(), requestDto.getGameId()));
    }

    public ResultResponseDto leaveTeamToHttp(OccupyTeamRequestDto requestDto) {
        return new ResultResponseDto(leaveTeam(requestDto.getTeamId(), requestDto.getGameId()));
    }

    private String occupyTeam(Long teamId, Long gameId) {
        Team selectedTeam = teamRepository.findById(teamId).orElseThrow(
                () -> new EntityNotFoundException(ErrorMessage.TEAM_NOT_FOUND)
        );

        Game game = gameRepository.findById(gameId).orElseThrow(
                () -> new EntityNotFoundException(ErrorMessage.GAME_NOT_FOUND)
        );

        // 이미 선점된 팀이라면 fail 반환
        // 선점되지 않은 팀이라면 isOccupied = true
        if (selectedTeam.isOccupied()) {
            return FAIL;
        }

        // 이미 선점된 팀이 아니라면
        // 본 게임에서 해당 팀을 선택함
        game.selectTeam(selectedTeam.getId());
        selectedTeam.select();
        selectedTeam.occupy();
        logger.info("selectedTeam: {}", selectedTeam);
        gameRepository.save(game);
        teamRepository.save(selectedTeam);


        List<Team> teams = teamRepository.findAllByGameIdAndIsOccupiedFalse(game.getId());
        logger.info("teams: {}", teams);

        int leftTeamSize = teamRepository.findAllByGameIdAndIsOccupiedFalse(game.getId()).size();

        logger.info("leftTeamSize: {}", leftTeamSize);
        if (leftTeamSize == 1) {
            return WAIT;
        }

        // 선점된 팀도 아니고 모든 팀이 다 선택되었다면 success 반환
        return SUCCESS;
    }

    private String leaveTeam(Long teamId, Long gameId) {
        Team selectedTeam = teamRepository.findById(teamId).orElseThrow(
                () -> new EntityNotFoundException(ErrorMessage.TEAM_NOT_FOUND)
        );

        Game game = gameRepository.findById(gameId).orElseThrow(
                () -> new EntityNotFoundException(ErrorMessage.GAME_NOT_FOUND)
        );

        selectedTeam.leave();

        game.selectTeam(null);

        teamRepository.save(selectedTeam);

        return SUCCESS;
    }


}
