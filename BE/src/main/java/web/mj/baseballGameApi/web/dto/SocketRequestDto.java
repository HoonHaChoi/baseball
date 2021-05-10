package web.mj.baseballGameApi.web.dto;

public class SocketRequestDto {
    private String type;
    private Long gameId;
    private Long teamId;

    public SocketRequestDto(String type, Long gameId, Long teamId) {
        this.type = type;
        this.gameId = gameId;
        this.teamId = teamId;
    }

    public Long getTeamId() {
        return teamId;
    }

    public Long getGameId() {
        return gameId;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public void setTeamId(Long teamId) {
        this.teamId = teamId;
    }

    public void setGameId(Long gameId) {
        this.gameId = gameId;
    }
}
