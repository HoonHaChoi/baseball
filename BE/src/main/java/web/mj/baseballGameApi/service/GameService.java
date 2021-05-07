package web.mj.baseballGameApi.service;

import org.springframework.stereotype.Service;
import web.mj.baseballGameApi.domain.game.Game;
import web.mj.baseballGameApi.domain.game.GameRepository;
import web.mj.baseballGameApi.domain.game.Pitching;
import web.mj.baseballGameApi.domain.inning.Inning;
import web.mj.baseballGameApi.domain.inning.InningRepository;
import web.mj.baseballGameApi.domain.player.Player;
import web.mj.baseballGameApi.domain.player.PlayerRepository;
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

    public final GameRepository gameRepository;
    public final TeamRepository teamRepository;
    public final InningRepository inningRepository;
    public final RecordRepository recordRepository;
    public final PlayerRepository playerRepository;

    private static final String PITCHER = "pitcher";
    private static final String BATTER = "batter";
    private static final String SUCCESS = "success";

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


        PitcherDto pitcher = new PitcherDto(findPlayerByPosition(PITCHER, gameId));
        BatterDto batter = new BatterDto(findPlayerByPosition(BATTER, gameId));
        StatusBoardDto statusBoardDto = new StatusBoardDto(game, selectedTeam, inning, pitcher, batter);

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

    private Player findPlayerByPosition(String position, Long gameId) {
        return playerRepository.findByPositionAndTeamGameId(position, gameId).orElseThrow(
                () -> new EntityNotFoundException(ErrorMessage.PLAYER_NOT_FOUND)
        );
    }

    public PitchResultDto pitch(Long gameId, Long teamId) {
        Game game = findGameById(gameId);
        Team team = findTeamById(teamId);

        Pitching pitching = new Pitching();

        // case0) 선수
            // case0-1) 게임 시작
            // 공통
            // game_is_top = true
            // homeTeam별로 is_hitting false, away = true

            // 수비팀
            // team = Game::selectedTeamId로 지
            // Pitcher 지정, player 1

            // 공격팀정
            // team = List<Game>에서
            // Batter 지정, player 2
            // Batter는 순차적으로 변경됨
            // nowBatter 변수 필요(List<Player>의 인덱스)

            // case0-2) Batter 변경
            // 공격팀: nowBatter의 다음 인데스의 선수로 변경, nowBatter ++1

            // case0-3) 초->말 변경
            // 공통: game_is_top = false

        // case1) strike
            // case1-1) no out
            // 수비팀
            // Pitcher numOfThrowing +1
            // Pitcher numOfStrike +1

            // Record numOfStrike +1


            // case1-2) out

        // case2) ball
            // case2-1) no out
            // case2-2) out

        // case3) hit

        // 수비팀
        // Pitcher thrwoing +1
        // Pitching result를 Player table에 반영

        // Pitching result를 record에 반영

        // 공격팀
        // hit일 경우, batter의 base 상태 변경

        return new PitchResultDto(pitching);
    }
}
