package web.mj.baseballGameApi.web.dto;

import org.springframework.data.relational.core.sql.In;
import web.mj.baseballGameApi.domain.player.Player;

public class PlayerDto {
    private final String name;
    private final Integer batting;
    private final Integer hitting;
    private final Integer out;
    private final boolean isNowOn;
//    private final Float average;

    public PlayerDto(Player player){
        this.name = player.getName();
        this.isNowOn = player.isNowOn();
        this.batting = player.getNumOfBatting();
        this.hitting = player.getNumOfHitting();
        this.out = player.getNumOfOut();
    }

    public String getName() {
        return name;
    }

    public boolean isNowOn() {
        return isNowOn;
    }

    public Integer getBatting() {
        return batting;
    }

    public Integer getHitting() {
        return hitting;
    }

    public Integer getOut() {
        return out;
    }
}
