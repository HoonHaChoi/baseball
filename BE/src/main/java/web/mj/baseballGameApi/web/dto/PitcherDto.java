package web.mj.baseballGameApi.web.dto;

import web.mj.baseballGameApi.domain.player.Player;

public class PitcherDto {

    private final String name;
    private final Integer numOfThrowing;

    public PitcherDto(Player player) {
        this.name = player.getName();
        this.numOfThrowing = player.getNumOfThrowing();
    }

    public String getName() {
        return name;
    }

    public Integer getNumOfThrowing() {
        return numOfThrowing;
    }
}
