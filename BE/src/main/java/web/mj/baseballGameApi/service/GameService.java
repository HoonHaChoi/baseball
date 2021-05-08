package web.mj.baseballGameApi.service;

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
import web.mj.baseballGameApi.exception.OccupyFailedException;
import web.mj.baseballGameApi.web.dto.*;

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

    private Player pitcher;
    private Player batter;

    public GameService(GameRepository gameRepository, TeamRepository teamRepository,
                       InningRepository inningRepository, RecordRepository recordRepository, PlayerRepository playerRepository) {
        this.gameRepository = gameRepository;
        this.teamRepository = teamRepository;
        this.inningRepository = inningRepository;
        this.recordRepository = recordRepository;
        this.playerRepository = playerRepository;
    }

    public List<GameResponseDto> findAllGames() {
        return gameRepository.findAll().stream()
                .map(game -> new GameResponseDto(game, getTeamResponseDtos(game.getId())))
                .collect(Collectors.toList());
    }

    public GameResponseDto findOneGame(Long id) {
        return new GameResponseDto(findGameById(id), getTeamResponseDtos(id));
    }

    public OccupyResultDto occupyTeam(OccupyTeamRequestDto requestDto) {
        Team selectedTeam = requestDto.toEntity();

        Game game = findGameById(selectedTeam.getGameId());
        Team team = findTeamById(selectedTeam.getId());

        if (!team.occupy()) {
            throw new OccupyFailedException(ErrorMessage.OCCUPY_FAILED);
        }

        game.selectTeam(team.getId());
        team.select();

        gameRepository.save(game);
        teamRepository.save(team);

        return new OccupyResultDto(SUCCESS);
    }

    public GameStatusResponseDto findGameStatus(Long gameId) {
        Game game = findGameById(gameId);

        //TODO: 선택된 팀이 없는 경우 어떻게 처리할까?
        Team selectedTeam = (game.getSelectedTeamId() != null)
                ? findTeamById(game.getSelectedTeamId())
                : findTeamById(1L);

        GameResponseDto gameResponseDto = new GameResponseDto(game, getTeamResponseDtos(gameId));

        Inning inning = inningRepository.findAllByGameId(gameId).get(game.getInning());

        Team hittingTeam = teamRepository.findByGameIdAndIsHittingTrue(gameId).orElseThrow(
                () -> new EntityNotFoundException(ErrorMessage.TEAM_NOT_FOUND)
        );
        Team defensingTeam = teamRepository.findByGameIdAndIsHittingFalse(gameId).orElseThrow(
                () -> new EntityNotFoundException(ErrorMessage.TEAM_NOT_FOUND)
        );

        pitcher = findPlayerByPosition(PITCHER, hittingTeam.getId(), gameId);
        PitcherDto pitcherDto = new PitcherDto(pitcher);

        batter = getBatters(BATTER, defensingTeam.getId(), gameId).get(defensingTeam.getNowBatter());
        BatterDto batterDto = new BatterDto(getBatters(BATTER, defensingTeam.getId(), gameId).get(defensingTeam.getNowBatter()));

        StatusBoardDto statusBoardDto = new StatusBoardDto(game, selectedTeam, inning, pitcherDto, batterDto);

        List<RecordDto> records = recordRepository.findAllByInningGameId(gameId).stream()
                .map(RecordDto::new)
                .collect(Collectors.toList());


        return new GameStatusResponseDto(gameResponseDto, statusBoardDto,
                records);
    }


    private List<TeamResponseDto> getTeamResponseDtos(Long id) {
        return teamRepository.findAllByGameId(id).stream()
                .map(TeamResponseDto::new)
                .collect(Collectors.toList());
    }

    private Game findGameById(Long id) {
        return gameRepository.findById(id).orElseThrow(
                () -> new EntityNotFoundException(ErrorMessage.GAME_NOT_FOUND)
        );
    }

    private Team findTeamById(Long id) {
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

    public PitchResultDto pitch(Long gameId, Long teamId) {
        Game game = findGameById(gameId);
        Team team = findTeamById(teamId);

        Pitching pitching = new Pitching();
        // TODO: pitching 개발 완료 후 삭제
        // TODO: 특정 게임 현황 조회 실행 후 pitch 결과 조회 실행되어야 함
        // 그렇지 않으면 batter == null
        Record record = new Record(batter.getName(), gameId);

        // **홈팀(수비팀 시작)으로 시작하는 경우만 생각한다**

        // 사전 완료 작업
        // TODO: 진행팀 지정은 하드코딩으로 시작, 추후 사용자에 의해 변경
        // 진행팀 지정: game.selectedTeamId V
        // Pitcher 지정: 수비팀 플레이어 중 position == 'pitcher' V
        // batters 불러오기: 공격팀 플레이어 중 position == 'batter' V
        // Batter 지정 V
        // Batter는 순차적으로 변경됨, index는 리스트의 크기를 기준으로 반복되어야 함 V
        // nowBatter 변수 필요(List<Player>의 인덱스) V
        // record 생성 V

        // case0) 게임 시작

        // ------ 1차 목표

        // case1) strike
        // 공통
        // 수비팀
        // Pitcher numOfThrowing +1
        // Pitcher numOfStrike +1
        // Record numOfStrike +1
        // 공격팀
        // Batter numOfBatting +1
        pitcher.increaseThrowing();
        pitcher.increaseStrike();
        record.increaseStrike();
        batter.increaseBatting();

        playerRepository.save(pitcher);
        playerRepository.save(batter);
        recordRepository.save(record);
        // case1-1) no out

        // case1-2) out
        // 공통
        // Record status 변경 'doing' -> 'out'
        // 수비팀
        // Pitcher numOfOut +1
        // 공격팀
        // batter 변경: hittingTeam, nowBatter ++1

        // out -> 공수전환


        // case2) ball
        // 공통
        // 수비팀
        // Pitcher numOfThrowing +1
        // Pitcher numOfBall +1
        // Record numOfBall +1
        // 공격팀
        // Batter numOfBatting +1

        // case2-1) no out
        // case2-2-1) ball 4
        // 기존 record 업데이트 및 새로운 record 생성
        // 공격팀
        // if thirdBase == true, score +1
        // if secondBase == true, thirdBase = ture
        // if firstBase == true, secondBase = true
        // firstBase true
        // Record status 변경 'doing' -> 'BB'

        // case2-2-2) just ball


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

        // case4) 초->말 변경
        // 공통: game_is_top = false
        // 수비팀: isHitting = true
        // 공격팀: isHitting = false
        return new PitchResultDto(pitching);
    }
}
