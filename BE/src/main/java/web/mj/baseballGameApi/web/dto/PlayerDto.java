package web.mj.baseballGameApi.web.dto;

import org.springframework.data.relational.core.sql.In;
import web.mj.baseballGameApi.domain.player.Player;

public class PlayerDto {
    private final String name;
//    private final boolean isOn;
    private final Integer batting;
    private final Integer hitting;
    private final Integer out;
//    private final Float average;

    public PlayerDto(Player player){
        this.name = player.getName();
        this.batting = player.getNumOfBatting();
        this.hitting = player.getNumOfHitting();
        this.out = player.getNumOfOut();
    }

    public String getName() {
        return name;
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
