package web.mj.baseballGameApi.web.dto;

import web.mj.baseballGameApi.domain.player.Player;

public class PitcherDto {

    private final String name;
    private final Integer numOfThrowing;
    private final String imageUrl;

    public PitcherDto(Player player) {
        this.name = player.getName();
        this.numOfThrowing = player.getNumOfThrowing();
        this.imageUrl = player.getImageUrl();
    }

    public String getName() {
        return name;
    }

    public Integer getNumOfThrowing() {
        return numOfThrowing;
    }

    public String getImageUrl() {
        return imageUrl;
    }
}
