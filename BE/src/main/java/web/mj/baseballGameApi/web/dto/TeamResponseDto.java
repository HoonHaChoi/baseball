package web.mj.baseballGameApi.web.dto;

import web.mj.baseballGameApi.domain.team.Team;

public class TeamResponseDto {
    private final Long teamId;
    private final String name;
    private final boolean isOccupied;

    public TeamResponseDto(Team team){
        this.teamId = team.getId();
        this.name = team.getName();
        this.isOccupied = team.isOccupied();
    }

    public Long getTeamId() {
        return teamId;
    }

    public String getName() {
        return name;
    }

    public boolean isOccupied() {
        return isOccupied;
    }
}
