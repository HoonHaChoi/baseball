package web.mj.baseballGameApi.service;

import org.springframework.stereotype.Service;
import web.mj.baseballGameApi.domain.game.Game;
import web.mj.baseballGameApi.domain.game.GameRepository;
import web.mj.baseballGameApi.domain.team.Team;
import web.mj.baseballGameApi.domain.team.TeamRepository;
import web.mj.baseballGameApi.exception.EntityNotFoundException;
import web.mj.baseballGameApi.exception.ErrorMessage;
import web.mj.baseballGameApi.exception.OccupyFailedException;
import web.mj.baseballGameApi.web.dto.GameResponseDto;
import web.mj.baseballGameApi.web.dto.OccupyTeamRequestDto;
import web.mj.baseballGameApi.web.dto.OccupyTeamResponseDto;
import web.mj.baseballGameApi.web.dto.TeamResponseDto;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class GameService {

    public final GameRepository gameRepository;
    public final TeamRepository teamRepository;

    public GameService(GameRepository gameRepository, TeamRepository teamRepository) {
        this.gameRepository = gameRepository;
        this.teamRepository = teamRepository;
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
