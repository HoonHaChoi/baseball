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
import web.mj.baseballGameApi.exception.OccupyFailedException;
import web.mj.baseballGameApi.web.dto.*;
import web.mj.baseballGameApi.exception.OccupyFailedException;
import web.mj.baseballGameApi.web.dto.GameResponseDto;
import web.mj.baseballGameApi.web.dto.TeamResponseDto;

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

    private static final String PITCHER = "pitcher";
    private static final String BATTER = "batter";
    private static final String SUCCESS = "success";
    private static final String FAIL = "fail";

    private final ObjectMapper objectMapper;

    private Player pitcher;
    private Player batter;
    private Team defensingTeam;
    private Team hittingTeam;
    private Integer numOfBatters;

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

    public SocketResponseDto pitch(Pitching pitching) {

        return new SocketResponseDto(pitching);
    }

    public List<GameResponseDto> findAllGames() {
        return gameRepository.findAll().stream()
                .map(game -> new GameResponseDto(game, getTeamResponseDtos(game.getId())))
                .collect(Collectors.toList());
    }

    public GameResponseDto findOneGame(Long id) {
        return new GameResponseDto(findGameById(id), getTeamResponseDtos(id));
    }


    public GameStatusResponseDto findGameStatus(Long gameId) {
        Game game = findGameById(gameId);

        //TODO: 선택된 팀이 없는 경우 어떻게 처리할까?
        Team selectedTeam = (game.getSelectedTeamId() != null)
                ? findTeamById(game.getSelectedTeamId())
                : findTeamById(1L);

        GameResponseDto gameResponseDto = new GameResponseDto(game, getTeamResponseDtos(gameId));

        Inning inning = getNowInning(gameId, game.getInning());

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

        List<RecordDto> records = recordRepository.findAllByInningGameId(gameId).stream()
                .sorted(Comparator.comparingLong(Record::getId).reversed())
                .map(RecordDto::new)
                .collect(Collectors.toList());


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

        if (!selectedTeam.occupy()) {
            return new SocketResponseDto("fail");
        }

        game.selectTeam(selectedTeam.getId());

        teamRepository.save(selectedTeam);

        //TODO: Static으로 바꿀
        return new SocketResponseDto("success");
    }


    private List<TeamResponseDto> getTeamResponseDtos(Long id) {
        return teamRepository.findAllByGameId(id).stream()
                .map(TeamResponseDto::new)
                .collect(Collectors.toList());
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

    private Player findPlayerByPosition(String position, Long teamId, Long gameId) {
        return playerRepository.findByPositionAndTeamIdAndTeamGameId(position, teamId, gameId).orElseThrow(
                () -> new EntityNotFoundException(ErrorMessage.PLAYER_NOT_FOUND)
        );
    }

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

    public SocketResponseDto pitch(Long gameId, Long teamId) {
        Game game = findGameById(gameId);
        Team team = findTeamById(teamId);
        Inning inning = getNowInning(gameId, game.getInning());

        Pitching pitching = new Pitching();
        // TODO: pitching 개발 완료 후 삭제
        // TODO: 특정 게임 현황 조회 실행 후 pitch 결과 조회 실행되어야 함
        // 그렇지 않으면 batter == null

        List<Record> records = recordRepository.findAllByInningGameId(gameId);
        Record lastRecord = records.get(records.size() - 1);

        if (!lastRecord.getBatterName().equals(batter.getName())) {
            lastRecord.updateName(batter.getName());
            recordRepository.save(lastRecord);
        }

//        Record record = new Record(batter.getName(), gameId);
//        recordRepository.save(record);
        // **홈팀(수비팀 시작)으로 시작하는 경우만 생각한다**

        // ------ 1차 목표
        // 사전 완료 작업
        // TODO: 진행팀 지정은 하드코딩으로 시작, 추후 사용자에 의해 변경
        // 진행팀 지정: game.selectedTeamId V
        // Pitcher 지정: 수비팀 플레이어 중 position == 'pitcher' V
        // batters 불러오기: 공격팀 플레이어 중 position == 'batter' V
        // Batter 지정 V
        // Batter는 순차적으로 변경됨, index는 리스트의 크기를 기준으로 반복되어야 함 V
        // nowBatter 변수 필요(List<Player>의 인덱스) V
        // record 생성 V

        // ------ 2차 목표
        // case1) strike
        // 공통
        // 수비팀
        // Pitcher numOfThrowing +1
        // Pitcher numOfStrike +1
        // Record numOfStrike +1
        // 공격팀
        // Batter numOfBatting +1
        if (pitching.getResult().equals("strike")) {
//            Record foundRecord = recordRepository.findById(record.getId()).orElseThrow(
//                    () -> new EntityNotFoundException(ErrorMessage.RECORD_NOT_FOUND)
//            );

            pitcher.increaseThrowing();
            pitcher.increaseStrike();
            batter.increaseBatting();
            inning.increaseStrike();
            lastRecord.increaseStrike();

            // case1-2) out
            // 공통
            // Record status 변경 'doing' -> 'out' V
            // Inning increase out v
            // 수비팀
            // Pitcher numOfOut +1 V
            // 공격팀
            // batter 변경: hittingTeam, nowBatter ++1 V
            // out -> 공수전환 X
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

            playerRepository.save(pitcher);
            playerRepository.save(batter);
            recordRepository.save(lastRecord);
            inningRepository.save(inning);
        }

        // ------ 2차 목표
        // case2) ball
        // 공통
        // 수비팀
        // Pitcher numOfThrowing +1
        // Pitcher numOfBall +1
        // Record numOfBall +1
        // 공격팀
        // Batter numOfBatting +1
        // case2-1) no out

        if (pitching.getResult().equals("ball")) {
//            Record foundRecord = recordRepository.findById(record.getId()).orElseThrow(
//                    () -> new EntityNotFoundException(ErrorMessage.RECORD_NOT_FOUND)
//            );

            pitcher.increaseThrowing();
            pitcher.increaseBall();
            batter.increaseBatting();
            lastRecord.increaseBall();
            inning.increaseBall();


            // case2-2-1) ball 4
            // Record status 변경 'doing' -> 'BB'
            // 공격팀
            // if thirdBase == true, score +1
            // if secondBase == true, thirdBase = ture
            // if firstBase == true, secondBase = true
            // firstBase true
            // 기존 record 업데이트 및 새로운 record 생성
            if (inning.getBall() == 4) {
                lastRecord.setStatus("BB");
                pitcher.increaseThrowing();
                batter.increaseBatting();
                batter.increaseHitting();

                if (inning.isThirdBase()) {
                    hittingTeam.increaseScore();
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
                batter = getNowBatter(teamId, gameId, hittingTeam.getNowBatterIndex(numOfBatters));
                Record newRecord = new Record(batter.getName(), lastRecord);

                recordRepository.save(newRecord);
            }


            playerRepository.save(pitcher);
            playerRepository.save(batter);
            recordRepository.save(lastRecord);
            inningRepository.save(inning);
        }

        // ------ 3차 목표
        // case3) hit
        // 공통
        // 기존 record 업데이트 및 새로운 record 생성
        // Record status 변경 'doing' -> 'hit'
        // 수비팀
        // Pitcher numOfThrowing +1
        // 공격팀
        // Batter numOfBatting +1
        // Batter numOfHitting +1
        // if thirdBase == true, score +1
        // if secondBase == true, thirdBase = ture
        // if firstBase == true, secondBase = true
        // firstBase true
        if (pitching.getResult().equals("hit")) {
            lastRecord.setStatus("hit");
            pitcher.increaseThrowing();
            batter.increaseBatting();
            batter.increaseHitting();

            if (inning.isThirdBase()) {
                hittingTeam.increaseScore();
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

            inningRepository.save(inning);
            playerRepository.save(batter);
            playerRepository.save(pitcher);
            recordRepository.save(lastRecord);
            teamRepository.save(hittingTeam);

            batter = getNowBatter(teamId, gameId, hittingTeam.getNowBatterIndex(numOfBatters));
            Record newRecord = new Record(batter.getName(), lastRecord);

            recordRepository.save(newRecord);
        }

        // ------ 4차 목표
        // case4) 초->말 변경
        // 공통: game_is_top = false
        // 수비팀: isHitting = true
        // 공격팀: isHitting = false
        return new SocketResponseDto(pitching);
    }
}
