package web.mj.baseballGameApi.web.dto;

import web.mj.baseballGameApi.domain.chat.ChatMessage;

public class PitchResultDto {
    private String result;
    private Long gameId;
    private Long teamId;

    public PitchResultDto(String result, Long gameId, Long teamId) {
        this.result = result;
        this.gameId = gameId;
        this.teamId = teamId;
    }

    public String getResult() {
        return result;
    }

    public Long getTeamId() {
        return teamId;
    }

    public Long getGameId() {
        return gameId;
    }


    public void setResult(String result) {
        this.result = result;
    }

    public void setTeamId(Long teamId) {
        this.teamId = teamId;
    }

    public void setGameId(Long gameId) {
        this.gameId = gameId;
    }
}
