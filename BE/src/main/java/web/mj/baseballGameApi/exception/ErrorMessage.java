package web.mj.baseballGameApi.exception;

public enum ErrorMessage {
    GAME_NOT_FOUND("해당 게임을 찾을 수 없습니다."),
    TEAM_NOT_FOUND("해당 팀을 찾을 수 없습니다."),
    PLAYER_NOT_FOUND("해당 선수를 찾을 수 없습니다."),
    RECORD_NOT_FOUND("해당 중계기록 찾을 수 없습니다."),
    INNING_NOT_FOUND("해당 이닝을 찾을 수 없습니다.");

    private final String message;

    ErrorMessage(String message) {
        this.message = message;
    }

    public String getErrorMessage() {
        return message;
    }
}
