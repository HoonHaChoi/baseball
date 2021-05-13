package web.mj.baseballGameApi.web.dto;

import web.mj.baseballGameApi.domain.game.Game;

import java.util.List;

public class GameDetailResponseDto {
    private final Long gameId;
    private final List<ScoreDto> detailScore;
    private final List<DetailPlayersDto> detailPlayers;

    public GameDetailResponseDto(Game game, List<ScoreDto> detailScore, List<DetailPlayersDto> detailPlayers) {
        this.gameId = game.getId();
        this.detailScore = detailScore;
        this.detailPlayers = detailPlayers;
    }

    public Long getGameId() {
        return gameId;
    }

    public List<ScoreDto> getDetailScore() {
        return detailScore;
    }

    public List<DetailPlayersDto> getDetailPlayers() {
        return detailPlayers;
    }
}
