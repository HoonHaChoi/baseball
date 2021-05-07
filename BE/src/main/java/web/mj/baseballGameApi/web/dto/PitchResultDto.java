package web.mj.baseballGameApi.web.dto;

import web.mj.baseballGameApi.domain.game.Pitching;

public class PitchResultDto {

    private final String result;

    public PitchResultDto(Pitching pitching) {
        this.result = pitching.result();
    }

    public String getResult() {
        return result;
    }
}
