package web.mj.baseballGameApi.web.dto;

import web.mj.baseballGameApi.domain.game.Game;

import java.util.List;

public class GameResponseDto {
    private static final int FIRST_TEAM = 0;
    private static final int SECOND_TEAM = 1;

    private final Long gameId;
    private final TeamResponseDto awayTeam;
    private final TeamResponseDto homeTeam;

    public GameResponseDto(Game game, List<TeamResponseDto> teams){
        this.gameId = game.getId();
        this.awayTeam = teams.get(FIRST_TEAM);
        this.homeTeam = teams.get(SECOND_TEAM);
    }

    public static int getFirstTeam() {
        return FIRST_TEAM;
    }

    public static int getSecondTeam() {
        return SECOND_TEAM;
    }

    public Long getGameId() {
        return gameId;
    }

    public TeamResponseDto getHomeTeam() {
        return homeTeam;
    }

    public TeamResponseDto getAwayTeam() {
        return awayTeam;
    }
}
