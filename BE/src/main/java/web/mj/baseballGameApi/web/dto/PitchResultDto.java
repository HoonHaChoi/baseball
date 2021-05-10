package web.mj.baseballGameApi.web.dto;

import web.mj.baseballGameApi.domain.chat.ChatMessage;

public class PitchResultDto {
    public enum MessageType {
        ENTER, TALK
    }
    private ChatMessage.MessageType type; // 메시지 타입
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

    public ChatMessage.MessageType getType() {
        return type;
    }

    public void setResult(String result) {
        this.result = result;
    }

    public void setTeamId(Long teamId) {
        this.teamId = teamId;
    }

    public void setType(ChatMessage.MessageType type) {
        this.type = type;
    }

    public void setGameId(Long gameId) {
        this.gameId = gameId;
    }
}
