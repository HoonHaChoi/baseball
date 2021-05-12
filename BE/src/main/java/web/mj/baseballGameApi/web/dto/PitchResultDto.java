package web.mj.baseballGameApi.web.dto;

import web.mj.baseballGameApi.domain.game.Pitching;

public class PitchResultDto {

    private final String result;

    public PitchResultDto(Pitching pitching) {
        this.result = pitching.getResult();
    }

    public String getResult() {
        return result;
    }
}
