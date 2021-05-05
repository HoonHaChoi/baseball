package web.mj.baseballGameApi.web.dto;

import web.mj.baseballGameApi.domain.game.Game;
import web.mj.baseballGameApi.domain.team.Team;

public class OccupyTeamRequestDto {

    private Long gameId;
    private Long teamId;

    public Team toEntity(){
        return new Team(teamId, gameId);
    }

    public Long getGameId() {
        return gameId;
    }

    public Long getTeamId() {
        return teamId;
    }
}
