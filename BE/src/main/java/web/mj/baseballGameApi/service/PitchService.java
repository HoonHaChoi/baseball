package web.mj.baseballGameApi.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import web.mj.baseballGameApi.domain.game.Game;
import web.mj.baseballGameApi.domain.game.GameRepository;
import web.mj.baseballGameApi.domain.game.Pitching;
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
import web.mj.baseballGameApi.web.dto.ResultResponseDto;
import web.mj.baseballGameApi.web.dto.SocketResponseDto;
import web.mj.baseballGameApi.web.dto.TeamResponseDto;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class PitchService {
    private Logger logger = LoggerFactory.getLogger(GameService.class);

    public final GameRepository gameRepository;
    public final TeamRepository teamRepository;
    public final InningRepository inningRepository;
    public final RecordRepository recordRepository;
    public final PlayerRepository playerRepository;

    private static final String STRIKE = "strike";
    private static final String BALL = "ball";
    private static final String HIT = "hit";

    private static final String BATTER = "batter";
    private static final String PITCHER = "pitcher";

    // TODO: 지역변수로 변환
    private Integer numOfBatters;

    public PitchService(GameRepository gameRepository, TeamRepository teamRepository,
                        InningRepository inningRepository, RecordRepository recordRepository,
                        PlayerRepository playerRepository) {
        this.gameRepository = gameRepository;
        this.teamRepository = teamRepository;
        this.inningRepository = inningRepository;
        this.recordRepository = recordRepository;
        this.playerRepository = playerRepository;
    }

    private Pitching pitch(Long gameId, Long teamId) {

        // TODO: 진행팀 지정은 하드코딩으로 시작, 추후 사용자에 의해 변경
        Game game = findGameById(gameId);
        Team hittingTeam = getHittingTeam(gameId);
        Team defensingTeam = getDefensingTeam(gameId);
        List<Record> records = recordRepository.findAllByInningGameId(gameId);

        Inning nowInning = getNowInning(gameId, game.getInning());
        Player nowBatter = getNowPlayer(BATTER, hittingTeam.getId());
        Player nowPitcher = getNowPlayer(PITCHER, defensingTeam.getId());
        Record lastRecord = records.get(records.size() - 1);
        List<Player> batters = getBatters(BATTER, hittingTeam.getId());

        Pitching pitching = new Pitching();

        if (!lastRecord.getBatterName().equals(nowBatter.getName())) {
            lastRecord.updateName(nowBatter.getName());
            recordRepository.save(lastRecord);
        }

        if (pitching.getResult().equals(STRIKE)) {
            handleStrike(nowInning, nowBatter, nowPitcher, lastRecord, batters, hittingTeam);
        }

        if (pitching.getResult().equals(BALL)) {
            handleBall(nowInning, nowBatter, nowPitcher, lastRecord, batters, hittingTeam);
        }

        if (pitching.getResult().equals(HIT)) {
            handleHit(nowInning, nowBatter, nowPitcher, lastRecord, batters, hittingTeam);
        }

        // TODO: 초->말 변경 로직 추후 도입
        // 공통: game_is_top = false
        // 수비팀: isHitting = true
        // 공격팀: isHitting = false

        return pitching;
    }

    public SocketResponseDto pitchingResultToSocket(Long gameId, Long teamId) {

        return new SocketResponseDto(pitch(gameId, teamId));
    }

    public ResultResponseDto pitchingResultToHttp(Long gameId, Long teamId) {

        return new ResultResponseDto(pitch(gameId, teamId));
    }

    private void handleStrike(Inning inning, Player batter, Player pitcher, Record lastRecord
            , List<Player> batters, Team hittingTeam) {

        pitcher.increaseThrowing();
        pitcher.increaseStrike();
        batter.increaseBatting();
        inning.increaseStrike();
        lastRecord.increaseStrike();
        lastRecord.addChar("s");

        if (inning.getStrike() == 3) {
            inning.increaseOut();
            lastRecord.setStatus("out");

            inning.increaseOut();
            pitcher.increaseOut();
            hittingTeam.increaseNowBatter();
            inning.resetStrikeAndBall();

            batter.setNowOnToFalse();
            playerRepository.save(batter);

            Integer nextBatterIndex = hittingTeam.getNextBatterIndex(batters.size());
            Player nextBatter = batters.get(nextBatterIndex);

            nextBatter.setNowOnToTrue();
            playerRepository.save(nextBatter);

            Record newRecord = new Record(nextBatter.getName(), lastRecord);

            recordRepository.save(newRecord);
        }

        saveGameStatus(inning, batter, pitcher, lastRecord);
    }

    private void handleBall(Inning inning, Player batter, Player pitcher, Record lastRecord, List<Player> batters, Team hittingTeam) {

        pitcher.increaseThrowing();
        pitcher.increaseBall();
        batter.increaseBatting();
        lastRecord.increaseBall();
        inning.increaseBall();
        lastRecord.addChar("b");

        if (inning.getBall() == 4) {
            lastRecord.setStatus("BB");

            changeStatusRunningToFirstBase(inning, batter, pitcher, hittingTeam);
            batter.setNowOnToFalse();
            playerRepository.save(batter);

            Integer nextBatterIndex = hittingTeam.getNextBatterIndex(batters.size());
            Player nextBatter = batters.get(nextBatterIndex);
            nextBatter.setNowOnToTrue();

            playerRepository.save(nextBatter);

            Record newRecord = new Record(nextBatter.getName(), lastRecord);

            recordRepository.save(newRecord);
        }

        saveGameStatus(inning, batter, pitcher, lastRecord);
    }

    private void handleHit(Inning inning, Player batter, Player pitcher, Record lastRecord, List<Player> batters, Team hittingTeam) {

        lastRecord.setStatus(HIT);

        changeStatusRunningToFirstBase(inning, pitcher, batter, hittingTeam);

        // TODO: inNowOn 건드려서 문제 해결하자
        batter.setNowOnToFalse();
        saveGameStatus(inning, batter, pitcher, lastRecord);
        teamRepository.save(hittingTeam);

        Integer nextBatterIndex = hittingTeam.getNextBatterIndex(batters.size());
        Player nextBatter = batters.get(nextBatterIndex);
        nextBatter.setNowOnToTrue();
        playerRepository.save(nextBatter);

        Record newRecord = new Record(nextBatter.getName(), lastRecord);

        recordRepository.save(newRecord);
    }

    private void changeStatusRunningToFirstBase(Inning inning, Player batter, Player pitcher, Team hittingTeam) {

        pitcher.increaseThrowing();
        batter.increaseBatting();
        batter.increaseHitting();

        if (inning.isThirdBase()) {
            hittingTeam.increaseScore();
            hittingTeam.updateScore(hittingTeam.getScore().toString());
            inning.setHomeBaseToTrue();
            inning.setThirdBaseToFalse();
        }

        if (inning.isSecondBase()) {
            inning.setThirdBaseToTrue();
            inning.setSecondBaseToFalse();
        }

        if (inning.isFirstBase()) {
            inning.setSecondBaseToTrue();
            inning.setFirstBaseToFalse();
        }

        inning.setFirstBaseToTrue();
        inning.resetStrikeAndBall();

        hittingTeam.increaseNowBatter();
    }

    private void saveGameStatus(Inning inning, Player batter, Player pitcher, Record lastRecord) {
        inningRepository.save(inning);
        playerRepository.save(batter);
        playerRepository.save(pitcher);
        recordRepository.save(lastRecord);
    }


    private List<TeamResponseDto> getTeamResponseDtos(Long id) {
        return teamRepository.findAllByGameId(id).stream()
                .map(TeamResponseDto::new)
                .collect(Collectors.toList());
    }

    private Player findPlayerByPosition(String position, Long teamId, Long gameId) {
        return playerRepository.findByPositionAndTeamIdAndTeamGameId(position, teamId, gameId).orElseThrow(
                () -> new EntityNotFoundException(ErrorMessage.PLAYER_NOT_FOUND)
        );
    }

    // TODO: index가 8 넘어가면 indexOutOfBounds 예외 발생
    private List<Player> getBatters(String position, Long teamId) {
        return playerRepository.findALLByPositionAndTeamId(position, teamId);
    }

    private Player getNowPlayer(String position, Long teamId) {
        return playerRepository.findByPositionAndTeamIdAndIsNowOnTrue(position, teamId).orElseThrow(
                () -> new EntityNotFoundException(ErrorMessage.PLAYER_NOT_FOUND)
        );
    }

    private Team getDefensingTeam(Long gameId) {
        return teamRepository.findByGameIdAndIsHittingFalse(gameId).orElseThrow(
                () -> new EntityNotFoundException(ErrorMessage.TEAM_NOT_FOUND)
        );
    }

    private Team getHittingTeam(Long gameId) {
        return teamRepository.findByGameIdAndIsHittingTrue(gameId).orElseThrow(
                () -> new EntityNotFoundException(ErrorMessage.TEAM_NOT_FOUND)
        );
    }

    private Inning getNowInning(Long gameId, int nTh) {
        return inningRepository.findAllByGameId(gameId).get(nTh - 1);
    }

    public Game findGameById(Long id) {
        return gameRepository.findById(id).orElseThrow(
                () -> new EntityNotFoundException(ErrorMessage.GAME_NOT_FOUND)
        );
    }
}
