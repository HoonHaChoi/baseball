package web.mj.baseballGameApi.web.dto;

import web.mj.baseballGameApi.domain.team.Team;

public class TeamStatusResponseDto {
    private final Long teamId;
    private final String name;
    private final boolean isOccupied;
    private final boolean isHitting;


    public TeamStatusResponseDto(Team team) {
        this.teamId = team.getId();
        this.name = team.getName();
        this.isOccupied = team.isOccupied();
        this.isHitting = team.isHitting();
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

    public boolean isHitting() {
        return isHitting;
    }
}
