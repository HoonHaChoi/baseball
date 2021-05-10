package web.mj.baseballGameApi.web.dto;

public class PitchRequestDto {
    private Long gameId;
    private Long teamId;

    public PitchRequestDto(String result, Long gameId, Long teamId) {
        this.gameId = gameId;
        this.teamId = teamId;
    }


    public Long getTeamId() {
        return teamId;
    }

    public Long getGameId() {
        return gameId;
    }


    public void setTeamId(Long teamId) {
        this.teamId = teamId;
    }

    public void setGameId(Long gameId) {
        this.gameId = gameId;
    }
}
