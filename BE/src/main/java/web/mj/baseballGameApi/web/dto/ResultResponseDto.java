package web.mj.baseballGameApi.web.dto;

import web.mj.baseballGameApi.domain.game.Pitching;

public class ResultResponseDto {

    private final String result;

    public ResultResponseDto(String result) {
        this.result = result;
    }

    public ResultResponseDto(Pitching pitching) {
        this.result = pitching.getResult();
    }

    public String getResult() {
        return result;
    }
}
