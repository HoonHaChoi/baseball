package web.mj.baseballGameApi.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
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
import web.mj.baseballGameApi.web.dto.*;
import web.mj.baseballGameApi.web.dto.GameResponseDto;
import web.mj.baseballGameApi.web.dto.TeamResponseDto;

import java.util.ArrayList;
import java.util.Comparator;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class GameService {
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
    private static final String STRIKE = "strike";
    private static final String BALL = "ball";
    private static final String HIT = "hit";

    private final ObjectMapper objectMapper;

    // TODO: 지역변수로 변환
    private Player pitcher;
    private Player batter;
    private Team defensingTeam;
    private Team hittingTeam;
    private Integer numOfBatters;
    private Inning inning;
    private Record lastRecord;

    public GameService(GameRepository gameRepository, TeamRepository teamRepository,
                       InningRepository inningRepository, RecordRepository recordRepository,
                       PlayerRepository playerRepository, ObjectMapper objectMapper) {
        this.gameRepository = gameRepository;
        this.teamRepository = teamRepository;
        this.inningRepository = inningRepository;
        this.recordRepository = recordRepository;
        this.playerRepository = playerRepository;
        this.objectMapper = objectMapper;
    }


    public <T> void sendMessage(WebSocketSession session, T message) {
        try {
            session.sendMessage(new TextMessage(objectMapper.writeValueAsString(message)));
        } catch (IOException e) {
            logger.error(e.getMessage(), e);
        }
    }

    public Game createGame() {
        Game game = new Game();
        return gameRepository.save(game);
    }

    public List<GameResponseDto> findAllGames() {
        return gameRepository.findAll().stream()
                .map(game -> new GameResponseDto(game, getTeamResponseDtos(game.getId())))
                .collect(Collectors.toList());
    }

    public GameResponseDto findOneGame(Long id) {
        return new GameResponseDto(findGameById(id), getTeamResponseDtos(id));
    }

    public Game findGameById(Long id) {
        return gameRepository.findById(id).orElseThrow(
                () -> new EntityNotFoundException(ErrorMessage.GAME_NOT_FOUND)
        );
    }

    public Team findTeamById(Long id) {
        return teamRepository.findById(id).orElseThrow(
                () -> new EntityNotFoundException(ErrorMessage.TEAM_NOT_FOUND)
        );
    }

    public GameStatusResponseDto findGameStatus(Long gameId) {
        Game game = findGameById(gameId);

        //TODO: 선택된 팀이 없는 경우 어떻게 처리할까?
        Team selectedTeam = (game.getSelectedTeamId() != null)
                ? findTeamById(game.getSelectedTeamId())
                : findTeamById(1L);

        GameResponseDto gameResponseDto = new GameResponseDto(game, getTeamResponseDtos(gameId));

        inning = getNowInning(gameId, game.getInning());

        hittingTeam = teamRepository.findByGameIdAndIsHittingTrue(gameId).orElseThrow(
                () -> new EntityNotFoundException(ErrorMessage.TEAM_NOT_FOUND)
        );

        defensingTeam = getDefensingTeam(gameId);

        pitcher = findPlayerByPosition(PITCHER, hittingTeam.getId(), gameId);
        PitcherDto pitcherDto = new PitcherDto(pitcher);

        List<Player> batters = getBatters(BATTER, defensingTeam.getId(), gameId);
        numOfBatters = batters.size();

        batter = getNowBatter(defensingTeam.getId(), gameId, hittingTeam.getNowBatterIndex(numOfBatters));

        BatterDto batterDto = new BatterDto(batters.get(hittingTeam.getNowBatterIndex(numOfBatters)));

        StatusBoardDto statusBoardDto = new StatusBoardDto(game, selectedTeam, inning, pitcherDto, batterDto);

        List<RecordDto> records = new ArrayList<>();

        for (Record record : recordRepository.findAllByInningGameId(gameId)) {

            RecordDto recordDto = new RecordDto(record);

            records.add(recordDto);
        }
        records.sort(Comparator.comparingLong(RecordDto::getRecordId).reversed());

        return new GameStatusResponseDto(gameResponseDto, statusBoardDto,
                records);
    }

    public SocketResponseDto occupyTeam(SocketRequestDto requestDto) {
        Team selectedTeam = teamRepository.findById(requestDto.getTeamId()).orElseThrow(
                () -> new EntityNotFoundException(ErrorMessage.TEAM_NOT_FOUND)
        );

        Game game = gameRepository.findById(requestDto.getGameId()).orElseThrow(
                () -> new EntityNotFoundException(ErrorMessage.GAME_NOT_FOUND)
        );

        // 이미 선점된 팀이라면 fail 반환
        // 선점되지 않은 팀이라면 isOccupied = true
        if (selectedTeam.isOccupied()) {
            return new SocketResponseDto(FAIL);
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
            return new SocketResponseDto(WAIT);
        }

        // 선점된 팀도 아니고 모든 팀이 다 선택되었다면 success 반환
        return new SocketResponseDto(SUCCESS);
    }

    public SocketResponseDto leaveTeam(SocketRequestDto requestDto) {
        Team selectedTeam = teamRepository.findById(requestDto.getTeamId()).orElseThrow(
                () -> new EntityNotFoundException(ErrorMessage.TEAM_NOT_FOUND)
        );

        Game game = gameRepository.findById(requestDto.getGameId()).orElseThrow(
                () -> new EntityNotFoundException(ErrorMessage.GAME_NOT_FOUND)
        );

        selectedTeam.leave();

        game.selectTeam(null);

        teamRepository.save(selectedTeam);

        //TODO: static 변수로 변경
        return new SocketResponseDto(SUCCESS);
    }

    public ResultResponseDto occupyTeamForHttp(OccupyTeamRequestDto requestDto) {
        Team selectedTeam = teamRepository.findById(requestDto.getTeamId()).orElseThrow(
                () -> new EntityNotFoundException(ErrorMessage.TEAM_NOT_FOUND)
        );

        Game game = gameRepository.findById(requestDto.getGameId()).orElseThrow(
                () -> new EntityNotFoundException(ErrorMessage.GAME_NOT_FOUND)
        );

        if (!selectedTeam.occupy()) {
            return new ResultResponseDto(FAIL);
        }

        game.selectTeam(selectedTeam.getId());

        teamRepository.save(selectedTeam);

        //TODO: static 변수로 변경
        return new ResultResponseDto(SUCCESS);
    }

    public SocketResponseDto pitch(Long gameId, Long teamId) {

        // TODO: 진행팀 지정은 하드코딩으로 시작, 추후 사용자에 의해 변경
        Game game = findGameById(gameId);
        Team team = findTeamById(teamId);
        inning = getNowInning(gameId, game.getInning());

        Pitching pitching = new Pitching();

        List<Record> records = recordRepository.findAllByInningGameId(gameId);
        lastRecord = records.get(records.size() - 1);

        if (!lastRecord.getBatterName().equals(batter.getName())) {
            lastRecord.updateName(batter.getName());
            recordRepository.save(lastRecord);
        }

        if (pitching.getResult().equals(STRIKE)) {
            handleStrike(gameId, teamId);
        }

        if (pitching.getResult().equals(BALL)) {
            handleBall(gameId, teamId);
        }

        if (pitching.getResult().equals(HIT)) {
            handleHit(gameId, teamId);
        }

        // TODO: 초->말 변경 로직 추후 도입
        // 공통: game_is_top = false
        // 수비팀: isHitting = true
        // 공격팀: isHitting = false

        return new SocketResponseDto(pitching);
    }

    public ResultResponseDto pitchForHttp(Long gameId, Long teamId) {

        // TODO: 진행팀 지정은 하드코딩으로 시작, 추후 사용자에 의해 변경
        Game game = findGameById(gameId);
        Team team = findTeamById(teamId);
        inning = getNowInning(gameId, game.getInning());

        Pitching pitching = new Pitching();

        List<Record> records = recordRepository.findAllByInningGameId(gameId);
        lastRecord = records.get(records.size() - 1);

        if (!lastRecord.getBatterName().equals(batter.getName())) {
            lastRecord.updateName(batter.getName());
            recordRepository.save(lastRecord);
        }

        if (pitching.getResult().equals(STRIKE)) {
            handleStrike(gameId, teamId);
        }

        if (pitching.getResult().equals(BALL)) {
            handleBall(gameId, teamId);
        }

        if (pitching.getResult().equals(HIT)) {
            handleHit(gameId, teamId);
        }

        // TODO: 초->말 변경 로직 추후 도입
        // 공통: game_is_top = false
        // 수비팀: isHitting = true
        // 공격팀: isHitting = false

        return new ResultResponseDto(pitching);
    }

    private void handleStrike(Long gameId, Long teamId) {

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

            batter = getNowBatter(teamId, gameId, hittingTeam.getNowBatterIndex(numOfBatters));
            Record newRecord = new Record(batter.getName(), lastRecord);

            recordRepository.save(newRecord);
        }


        saveGameStatus();
    }

    private void handleBall(Long gameId, Long teamId) {

        pitcher.increaseThrowing();
        pitcher.increaseBall();
        batter.increaseBatting();
        lastRecord.increaseBall();
        inning.increaseBall();
        lastRecord.addChar("b");

        if (inning.getBall() == 4) {
            lastRecord.setStatus("BB");

            changeStatusRunningToFirstBase();

            batter = getNowBatter(teamId, gameId, hittingTeam.getNowBatterIndex(numOfBatters));
            Record newRecord = new Record(batter.getName(), lastRecord);

            recordRepository.save(newRecord);
        }


        saveGameStatus();
    }

    private void handleHit(Long gameId, Long teamId) {

        lastRecord.setStatus(HIT);

        changeStatusRunningToFirstBase();

        saveGameStatus();
        teamRepository.save(hittingTeam);

        batter = getNowBatter(teamId, gameId, hittingTeam.getNowBatterIndex(numOfBatters));
        Record newRecord = new Record(batter.getName(), lastRecord);

        recordRepository.save(newRecord);
    }

    private void changeStatusRunningToFirstBase() {

        pitcher.increaseThrowing();
        batter.increaseBatting();
        batter.increaseHitting();

        if (inning.isThirdBase()) {
            hittingTeam.increaseScore();
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

    private void saveGameStatus() {
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

    // TODO: index가 11이 넘어가면 indexOutOfBounds 예외 발생
    private List<Player> getBatters(String position, Long teamId, Long gameId) {
        return playerRepository.findALLByPositionAndTeamId(position, teamId, gameId);
    }

    private Player getNowBatter(Long teamId, Long gameId, Integer nowBatter) {
        return getBatters(BATTER, teamId, gameId).get(nowBatter);
    }

    private Team getDefensingTeam(Long gameId) {
        return teamRepository.findByGameIdAndIsHittingFalse(gameId).orElseThrow(
                () -> new EntityNotFoundException(ErrorMessage.TEAM_NOT_FOUND)
        );
    }

    private Inning getNowInning(Long gameId, int nTh) {
        return inningRepository.findAllByGameId(gameId).get(nTh - 1);
    }

}
