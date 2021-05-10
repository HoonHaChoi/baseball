package web.mj.baseballGameApi.web.dto;

import web.mj.baseballGameApi.domain.chat.ChatMessage;

public class PitchResultDto {
    private String result;

    public PitchResultDto(String result) {
        this.result = result;
    }

    public String getResult() {
        return result;
    }


    public void setResult(String result) {
        this.result = result;
    }
}
