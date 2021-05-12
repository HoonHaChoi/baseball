package web.mj.baseballGameApi.web.dto;

import java.util.List;

public class GameStatusResponseDto {
    private final Long gameId;
    private final Long selectedTeamId;
    private final TeamResponseDto homeTeam;
    private final TeamResponseDto awayTeam;
    private final StatusBoardDto statusBoard;
    private final List<RecordDto> recordOfPitching;


    public GameStatusResponseDto(GameResponseDto game, StatusBoardDto statusBoard,
                                 List<RecordDto> records) {
        this.gameId = game.getGameId();
        this.selectedTeamId = game.getSelectedTeamId();
        this.homeTeam = game.getHomeTeam();
        this.awayTeam = game.getAwayTeam();
        this.statusBoard = statusBoard;
        this.recordOfPitching = records;
    }

    public Long getGameId() {
        return gameId;
    }

    public Long getSelectedTeamId() {
        return selectedTeamId;
    }

    public TeamResponseDto getHomeTeam() {
        return homeTeam;
    }

    public TeamResponseDto getAwayTeam() {
        return awayTeam;
    }

    public StatusBoardDto getStatusBoard() {
        return statusBoard;
    }

    public List<RecordDto> getRecordOfPitching() {
        return recordOfPitching;
    }

}
