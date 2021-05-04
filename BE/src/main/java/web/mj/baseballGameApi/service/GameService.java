package web.mj.baseballGameApi.service;

import org.springframework.stereotype.Service;
import web.mj.baseballGameApi.domain.game.GameRepository;
import web.mj.baseballGameApi.domain.team.TeamRepository;
import web.mj.baseballGameApi.web.dto.GameResponseDto;
import web.mj.baseballGameApi.web.dto.TeamResponseDto;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class GameService {

    public final GameRepository gameRepository;
    public final TeamRepository teamRepository;

    public GameService(GameRepository gameRepository, TeamRepository teamRepository){
        this.gameRepository = gameRepository;
        this.teamRepository = teamRepository;
    }

    public List<GameResponseDto> findAllGames(){
        return gameRepository.findAll().stream()
                .map(game -> new GameResponseDto(game, getTeamResponseDtos(game.getId())))
                .collect(Collectors.toList());
    }

    private List<TeamResponseDto> getTeamResponseDtos(Long id){
        return teamRepository.findAllByGameId(id).stream()
                .map(TeamResponseDto::new)
                .collect(Collectors.toList());
    }
}
