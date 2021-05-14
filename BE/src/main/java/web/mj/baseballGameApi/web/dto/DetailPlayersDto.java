package web.mj.baseballGameApi.web.dto;

import web.mj.baseballGameApi.domain.player.Player;
import web.mj.baseballGameApi.domain.team.Team;

import java.util.List;

public class DetailPlayersDto {
    private final String teamName;
    private final List<PlayerDto> players;

    public DetailPlayersDto(Team team, List<PlayerDto> players) {
        this.teamName = team.getName();
        this.players = players;
    }

    public String getTeamName() {
        return teamName;
    }

    public List<PlayerDto> getPlayers() {
        return players;
    }
}
