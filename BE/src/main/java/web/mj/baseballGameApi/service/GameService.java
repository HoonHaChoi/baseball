package web.mj.baseballGameApi.service;

import org.springframework.stereotype.Service;
import web.mj.baseballGameApi.domain.game.Game;
import web.mj.baseballGameApi.domain.game.GameRepository;
import web.mj.baseballGameApi.domain.inning.Inning;
import web.mj.baseballGameApi.domain.inning.InningRepository;
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

    public GameService(GameRepository gameRepository, TeamRepository teamRepository,
                       InningRepository inningRepository, RecordRepository recordRepository) {
        this.gameRepository = gameRepository;
        this.teamRepository = teamRepository;
        this.inningRepository = inningRepository;
        this.recordRepository = recordRepository;
    }

    public List<GameResponseDto> findAllGames() {
        return gameRepository.findAll().stream()
                .map(game -> new GameResponseDto(game, getTeamResponseDtos(game.getId())))
                .collect(Collectors.toList());
    }

    public GameResponseDto findOneGame(Long id) {
        return new GameResponseDto(findGameById(id), getTeamResponseDtos(id));
    }

    public OccupyTeamResponseDto occupyTeam(OccupyTeamRequestDto requestDto) {
        Team selectedTeam = requestDto.toEntity();

        Game game = findGameById(selectedTeam.getGameId());
        Team team = findTeamById(selectedTeam.getId());

        if (!team.occupy()) {
            throw new OccupyFailedException(ErrorMessage.OCCUPY_FAILED);
        }

        game.selectTeam(team.getId());

        teamRepository.save(team);

        return new OccupyTeamResponseDto(game, new TeamResponseDto(team));
    }

    public GameStatusResponseDto findGameStatus(Long gameId) {
        Game game = findGameById(gameId);

        //TODO: 선택된 팀이 없는 경우 어떻게 처리할까?
        Team selectedTeam = (game.getSelectedTeamId() != null)
                                ? findTeamById(game.getSelectedTeamId())
                                : findTeamById(1L);

        GameResponseDto gameResponseDto = new GameResponseDto(game, getTeamResponseDtos(gameId));

        Inning inning = inningRepository.findAllByGameId(gameId).get(game.getInning());
        StatusBoardDto statusBoardDto = new StatusBoardDto(game, selectedTeam, inning);

        List<RecordDto> records = recordRepository.findAllByInningGameId(gameId).stream()
                .map(RecordDto::new)
                .collect(Collectors.toList());

        return new GameStatusResponseDto(gameResponseDto, statusBoardDto, records);
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

}
