package web.mj.baseballGameApi.web.dto;

import web.mj.baseballGameApi.domain.team.Team;

public class ScoreDto {
    private final String teamName;
    private String scores;

    public ScoreDto(Team team){
        this.teamName = team.getName();
        this.scores = "";
    }

    public String getTeamName() {
        return teamName;
    }

    public String getScores() {
        return scores;
    }

    public void addScore(String score){
        scores += score;
    }
}
