package web.mj.baseballGameApi.web.dto;

import web.mj.baseballGameApi.domain.team.Team;

public class TeamResponseDto {
    private final Long teamId;
    private final String name;
    private final Integer score;

    private final boolean isOccupied;

    public TeamResponseDto(Team team) {
        this.teamId = team.getId();
        this.name = team.getName();
        this.score = team.getScore();
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

    public Integer getScore() {
        return score;
    }
}
