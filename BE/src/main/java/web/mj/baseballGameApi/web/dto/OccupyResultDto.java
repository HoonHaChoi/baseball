package web.mj.baseballGameApi.web.dto;

import web.mj.baseballGameApi.domain.game.Pitching;

public class OccupyResultDto {

    private final String result;

    public OccupyResultDto(String result) {
        this.result = result;

    }

    public String getResult() {
        return result;
    }
}
