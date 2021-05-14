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

    private final ObjectMapper objectMapper;

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

    public GameDetailResponseDto findGameDetail(Long gameId) {
        Game game = findGameById(gameId);

        List<ScoreDto> scores = teamRepository.findAllByGameId(gameId).stream()
                .map(ScoreDto::new)
                .collect(Collectors.toList());

        List<PlayerDto> homePlayers = playerRepository.findAllByTeamId(game.getHomeTeamId()).stream()
                .map(PlayerDto::new)
                .collect(Collectors.toList());

        List<PlayerDto> awayPlayers = playerRepository.findAllByTeamId(game.getAwayTeamId()).stream()
                .map(PlayerDto::new)
                .collect(Collectors.toList());

        Team awayTeam = teamRepository.findById(game.getAwayTeamId()).orElseThrow(
                () -> new EntityNotFoundException(ErrorMessage.TEAM_NOT_FOUND)
        );
        Team homeTeam = teamRepository.findById(game.getHomeTeamId()).orElseThrow(
                () -> new EntityNotFoundException(ErrorMessage.TEAM_NOT_FOUND)
        );

        DetailPlayersDto awayPlayersDto = new DetailPlayersDto(awayTeam, awayPlayers);
        DetailPlayersDto homePlayersDto = new DetailPlayersDto(homeTeam, homePlayers);

        List<DetailPlayersDto> playersByTeam = new ArrayList<>();
        playersByTeam.add(homePlayersDto);
        playersByTeam.add(awayPlayersDto);

        return new GameDetailResponseDto(gameId, scores, playersByTeam);
    }

    public <T> void sendMessage(WebSocketSession session, T message) {
        try {
            session.sendMessage(new TextMessage(objectMapper.writeValueAsString(message)));
        } catch (IOException e) {
            logger.error(e.getMessage(), e);
        }
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

        Inning inning = getNowInning(gameId, game.getInning());

        Team hittingTeam = teamRepository.findByGameIdAndIsHittingTrue(gameId).orElseThrow(
                () -> new EntityNotFoundException(ErrorMessage.TEAM_NOT_FOUND)
        );

        Team defensingTeam = getDefensingTeam(gameId);

        Player pitcher = findPlayerByPosition(PITCHER, hittingTeam.getId(), gameId);
        PitcherDto pitcherDto = new PitcherDto(pitcher);

        List<Player> batters = getBatters(BATTER, defensingTeam.getId());
        Integer numOfBatters = batters.size();

        Player batter = getNowPlayer(BATTER, hittingTeam.getId());

        BatterDto batterDto = new BatterDto(getNowPlayer(BATTER, hittingTeam.getId()));

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

}
