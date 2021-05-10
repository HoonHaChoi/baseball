package web.mj.baseballGameApi.web.dto;

import web.mj.baseballGameApi.domain.player.Player;

public class BatterDto {

    private final String name;
    private final Integer numOfBatting;
    private final Integer numOfHitting;

    public BatterDto(Player player) {
        this.name = player.getName();
        this.numOfBatting = player.getNumOfBatting();
        this.numOfHitting = player.getNumOfHitting();
    }

    public String getName() {
        return name;
    }

    public Integer getNumOfBatting() {
        return numOfBatting;
    }

    public Integer getNumOfHitting() {
        return numOfHitting;
    }
}
