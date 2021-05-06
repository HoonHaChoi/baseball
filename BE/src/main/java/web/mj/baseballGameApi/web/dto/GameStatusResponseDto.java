package web.mj.baseballGameApi.web.dto;

import web.mj.baseballGameApi.domain.game.Game;
import web.mj.baseballGameApi.domain.inning.Inning;
import web.mj.baseballGameApi.domain.team.Team;

public class GameStatusResponseDto {
    private final Long gameId;
    private final Long selectedTeamId;
    private final TeamResponseDto homeTeam;
    private final TeamResponseDto awayTeam;
    private final StatusBoardDto statusBoard;

    public GameStatusResponseDto(GameResponseDto game, StatusBoardDto statusBoard){
        this.gameId = game.getGameId();
        this.selectedTeamId = game.getSelectedTeamId();
        this.homeTeam = game.getHomeTeam();
        this.awayTeam = game.getAwayTeam();

        this.statusBoard = statusBoard;
    }

    public Long getGameId() {
        return gameId;
    }

    public Long getSelectedTeamId() {
        return selectedTeamId;
    }

    public TeamResponseDto getHomeTeam() {
        return homeTeam;
    }

    public TeamResponseDto getAwayTeam() {
        return awayTeam;
    }

    public StatusBoardDto getStatusBoard() {
        return statusBoard;
    }
}
