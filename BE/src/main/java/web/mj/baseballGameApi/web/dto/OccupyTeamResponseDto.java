package web.mj.baseballGameApi.web.dto;

import web.mj.baseballGameApi.domain.game.Game;

import java.util.List;

public class OccupyTeamResponseDto {
    private final Long gameId;
    private final TeamResponseDto modifiedTeam;

    public OccupyTeamResponseDto(Game game, TeamResponseDto team){
        this.gameId = game.getId();
        this.modifiedTeam = team;
    }

    public Long getGameId() {
        return gameId;
    }

    public TeamResponseDto getModifiedTeam() {
        return modifiedTeam;
    }
}
